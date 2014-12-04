-- Awesome WM theme

theme = {}

theme.font          = "terminus 9"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#111313"
theme.bg_urgent     = "#111313"
theme.bg_minimize   = "#111313"

theme.fg_normal     = "#b8baba"
theme.fg_focus      = "#6c8b9e"
theme.fg_urgent     = "#b290b6"
theme.fg_minimize   = "#424446"

theme.border_width  = "1"
theme.border_normal = "#424446"
theme.border_focus  = "#b8baba"
theme.border_marked = "#986b9e"

-- MENU
theme.menu_submenu_icon = awful.util.getdir("config") .. "/themes/my.theme/submenu.png"
theme.menu_height       = "14"
theme.menu_width        = "100"
theme.menu_bg_normal    = "#000000"
theme.menu_bg_focus     = "#111313"
theme.menu_fg_normal    = "#b8baba"
theme.menu_fg_focus     = "#6c8b9e"
theme.menu_border_color = "#000000"
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
