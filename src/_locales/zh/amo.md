**主要功能**

當閣下瀏覽網頁時，此擴充套件將更新 Firefox 佈景主題，使瀏覽器介面與正在瀏覽的網頁融為一體——正如 macOS Safari 變更其標題列顏色一樣。

**和此套件運作無間的有：**

- [Dark Reader](https://addons.mozilla.org/firefox/addon/darkreader/)
- [Stylus](https://addons.mozilla.org/firefox/addon/styl-us/)
- [Dark Mode Website Switcher](https://addons.mozilla.org/firefox/addon/dark-mode-website-switcher/)

**和此套件不相容的有：**

- 低於 [Version 112.0](https://www.mozilla.org/firefox/112.0/releasenotes/) 版本的 Firefox（於 2023 年四月發佈）
- [Adaptive Theme Creator](https://addons.mozilla.org/firefox/addon/adaptive-theme-creator/)
- [Chameleon Dynamic Theme](https://addons.mozilla.org/firefox/addon/chameleon-dynamic-theme-fixed/)
- [VivaldiFox](https://addons.mozilla.org/firefox/addon/vivaldifox/)
- [Envify](https://addons.mozilla.org/firefox/addon/envify/)
- 以及任何改變 Firefox 佈景主題的擴充套件

**若閣下想移除工具列下方的陰影：**

要移除網頁內容在瀏覽器工具列下方投射的細微陰影，請前往設定 (`about:preferences`) 並在「瀏覽器版面」部分關閉「顯示側邊欄」。另外，閣下亦可使用 CSS 主題。如需更多資訊，請參閱 [GitHub issue #155](https://github.com/easonwong-de/Adaptive-Tab-Bar-Colour/issues/155)。

**若閣下想開啟平滑顏色過渡：**

由於技術限制，標籤列的平滑顏色過渡無法原生支援。然而，閣下可以使用 CSS 主題來達到此效果。如需更多資訊，請參閱 [GitHub issue #43](https://github.com/easonwong-de/Adaptive-Tab-Bar-Colour/issues/43)。

**若閣下使用 CSS Theme：**

一個 CSS theme 若採用默認的顏色變數，則可以與 變色標題列 相容（例如，`--lwt-accent-color` 須用於標題列顏色）。譬如，[這](https://github.com/easonwong-de/Firefox-Adaptive-Sur-Theme)是一個與 變色標題列 相容的 CSS theme。

**若閣下使用帶有 GTK Theme 的 Linux：**

Firefox 的標題列按鈕或會重設為 Windows 風格。為免此發生，請開啟進階偏好設定（`about:config`），並將 `widget.gtk.non-native-titlebar-buttons.enabled` 設為 `false`。（感謝 [@anselstetter](https://github.com/anselstetter/)）

**安全提示：**

小心懷有惡意的網頁畫面：請注意區別瀏覽器介面和網頁畫面。如需更多資訊，請參閱 [The Line of Death](https://textslashplain.com/2017/01/14/the-line-of-death/)。（感謝 [u/KazaHesto](https://www.reddit.com/user/KazaHesto/)）

閣下可移步 GitHub 為此專案加星標：[https://github.com/easonwong-de/Adaptive-Tab-Bar-Colour](https://github.com/easonwong-de/Adaptive-Tab-Bar-Colour)
