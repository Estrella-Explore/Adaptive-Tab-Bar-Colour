#!/bin/bash

set -euo pipefail
source "$(dirname "$0")/utils.sh"
cd "$(dirname "$0")/.."

header=$(echo -n '{"alg":"HS256","typ":"JWT"}' | base64url)
issued_at=$(date +%s)
expires_at=$((issued_at + 300))
nonce=$(openssl rand -hex 16)

payload=$(
	printf '{"iss":"%s","jti":"%s","iat":%d,"exp":%d}' \
		"$FIREFOX_JWT_ISSUER" \
		"$nonce" \
		"$issued_at" \
		"$expires_at" |
		base64url
)

signature=$(
	echo -n "${header}.${payload}" |
		openssl dgst -sha256 -hmac "$FIREFOX_JWT_SECRET" -binary |
		base64url
)
token="${header}.${payload}.${signature}"

shopt -s nullglob
files=(amo/amo-*.md)
[ ${#files[@]} -eq 0 ] && print_error "Error: No amo/amo-*.md files found."

description=$(
	for file in "${files[@]}"; do
		locale="${file#amo/amo-}"
		locale="${locale%.md}"
		jq -n --arg loc "$locale" --rawfile content "$file" '{($loc): $content}'
	done | jq -s 'add'
)

skipped_locales=()
response_file=$(mktemp)
trap 'rm -f "$response_file"' EXIT

while true; do
	body=$(jq -n --argjson desc "$description" '{"description": $desc}')
	http_code=$(
		curl -s -o "$response_file" -w "%{http_code}" -X PATCH \
			"https://addons.mozilla.org/api/v5/addons/addon/adaptive-tab-bar-colour/" \
			-H "Authorization: JWT ${token}" \
			-H "Content-Type: application/json" \
			-d "$body"
	)

	[ "$http_code" -ge 200 ] && [ "$http_code" -lt 300 ] && break

	invalid_locales=$(
		jq -r '.. | strings' "$response_file" 2>/dev/null |
			sed -n -E 's/.*The language code "([^"]+)".*/\1/p'
	)

	if [ -z "$invalid_locales" ]; then
		cat "$response_file" >&2
		print_error "Error: Failed to synchronise AMO descriptions (HTTP ${http_code})."
	fi

	for loc in $invalid_locales; do
		skipped_locales+=("$loc")
		description=$(jq --arg loc "$loc" 'del(.[$loc])' <<<"$description")
	done

	[ "$(jq 'keys | length' <<<"$description")" -eq 0 ] &&
		print_error "Error: No valid locales remaining to synchronise."
done

if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
	{
		echo "### AMO Descriptions Synchronisation"
		echo ""
		echo "| Locale | Status | AMO Page |"
		echo "| :--- | :--- | :--- |"
		for file in "${files[@]}"; do
			loc="${file#amo/amo-}"
			loc="${loc%.md}"
			status="Synchronised"
			if [[ " ${skipped_locales[*]:-} " =~ [[:space:]]"${loc}"[[:space:]] ]]; then
				status="Skipped (unsupported)"
			fi
			echo "| \`${loc}\` | ${status} | [View](https://addons.mozilla.org/${loc}/firefox/addon/adaptive-tab-bar-colour/) |"
		done
	} >>"$GITHUB_STEP_SUMMARY"
fi

print_success "Success: AMO descriptions synchronised."
