-- Awesome WM theme

theme = {}

theme.font          = "terminus 9"

-- COLORS
theme.colorfg           = "#cdcfce"
theme.colorbg           = "#111313"
theme.color_black       = "#111313"
theme.color_bblack      = "#424446"
theme.color_red         = "#9e6b71"
theme.color_bred        = "#b69094"
theme.color_green       = "#719e6b"
theme.color_bgreen      = "#94b690"
theme.color_yellow      = "#9e986c"
theme.color_byellow     = "#b5b18f"
theme.color_blue        = "#6c8b9e"
theme.color_bblue       = "#90a7b6"
theme.color_magenta     = "#986b9e"
theme.color_bmagenta    = "#b290b6"
theme.color_cyan        = "#6b9e98"
theme.color_bcyan       = "#90b6b3"
theme.color_white       = "#b8baba"
theme.color_bwhite      = "#cdcfce"

theme.bg_normal     = theme.colorbg
theme.bg_focus      = theme.color_black
theme.bg_urgent     = theme.color_black
theme.bg_minimize   = theme.color_black

theme.fg_normal     = theme.colorfg
theme.fg_focus      = theme.color_blue
theme.fg_urgent     = theme.color_bmagenta
theme.fg_minimize   = theme.color_bblack

theme.border_width  = "1"
theme.border_normal = theme.color_bblack
theme.border_focus  = theme.color_white
theme.border_marked = theme.color_magenta

-- MENU
theme.menu_submenu_icon = awful.util.getdir("config") .. "/themes/my.theme/submenu.png"
theme.menu_height       = "14"
theme.menu_width        = "100"
theme.menu_bg_normal    = theme.colorbg
theme.menu_bg_focus     = theme.color_black
theme.menu_fg_normal    = theme.color_white
theme.menu_fg_focus     = theme.color_blue
theme.menu_border_color = theme.colorbg
theme.menu_border_width = "1"

-- TAGLIST
theme.taglist_squares_sel   = awful.util.getdir("config") .. "/themes/my.theme/taglist/squarefw.png"
theme.taglist_squares_unsel = awful.util.getdir("config") .. "/themes/my.theme/taglist/squarew.png"

-- LAYOUTS
theme.layout_tile          = awful.util.getdir("config") .. "/themes/my.theme/layouts/tile.png"
theme.layout_tileleft      = awful.util.getdir("config") .. "/themes/my.theme/layouts/tileleft.png"
theme.layout_tilebottom    = awful.util.getdir("config") .. "/themes/my.theme/layouts/tilebottom.png"
theme.layout_tiletop       = awful.util.getdir("config") .. "/themes/my.theme/layouts/tiletop.png"
theme.layout_fairv         = awful.util.getdir("config") .. "/themes/my.theme/layouts/fairv.png"
theme.layout_fairh         = awful.util.getdir("config") .. "/themes/my.theme/layouts/fairh.png"
theme.layout_spiral        = awful.util.getdir("config") .. "/themes/my.theme/layouts/spiral.png"
theme.layout_dwindle       = awful.util.getdir("config") .. "/themes/my.theme/layouts/dwindle.png"
theme.layout_max           = awful.util.getdir("config") .. "/themes/my.theme/layouts/max.png"
theme.layout_fullscreen    = awful.util.getdir("config") .. "/themes/my.theme/layouts/fullscreen.png"
theme.layout_magnifier     = awful.util.getdir("config") .. "/themes/my.theme/layouts/magnifier.png"
theme.layout_floating      = awful.util.getdir("config") .. "/themes/my.theme/layouts/floating.png"
theme.layout_termfair      = awful.util.getdir("config") .. "/vain/themes/default/layouts/termfairw.png"
theme.layout_browse        = awful.util.getdir("config") .. "/vain/themes/default/layouts/browsew.png"
theme.layout_gimp          = awful.util.getdir("config") .. "/vain/themes/default/layouts/gimpw.png"
theme.layout_cascade       = awful.util.getdir("config") .. "/vain/themes/default/layouts/cascadew.png"
theme.layout_cascadebrowse = awful.util.getdir("config") .. "/vain/themes/default/layouts/cascadebrowsew.png"
theme.layout_centerwork    = awful.util.getdir("config") .. "/vain/themes/default/layouts/centerworkw.png"

-- WALLPAPER
--theme.wallpaper_cmd = { "awsetbg -c " .. os.getenv("HOME") .. "/Imágenes/wallpaper" }
theme.wallpaper_cmd = { "awsetbg -t " .. os.getenv("HOME") .. "/Imágenes/pattern" }

-- ICON
theme.awesome_icon  = "/usr/share/awesome/icons/awesome16.png"
theme.debian_icon   = "/usr/share/pixmaps/debian-logo.png"
theme.system_icons  = "/usr/share/pixmaps/"

-- GAPS
theme.useless_gap_width = "20"

return theme

-- vim: set ts=4 sw=4 tw=0 et :
