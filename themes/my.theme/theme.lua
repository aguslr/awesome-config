-- Awesome WM theme

theme = {}

theme.font          = "terminus 9"

--theme.bg_normal     = "#1a1918"
--theme.bg_focus      = "#1a1918"
--theme.bg_urgent     = "#b23535"
--theme.bg_minimize   = "#1a1918"
theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#000000"
theme.bg_minimize   = "#000000"

theme.fg_normal     = "#807b76"
theme.fg_focus      = "#9acd32"
theme.fg_urgent     = "#b2b2b2"
theme.fg_minimize   = "#333231"

theme.border_width  = "1"
theme.border_normal = "#050505"
theme.border_focus  = "#333231"
--theme.border_marked = "#a4a4a4"
theme.border_marked = "#9acd32"

-- TAGLIST
--theme.taglist_bg_focus      = "#333333"
theme.taglist_squares_sel   = awful.util.getdir("config") .. "/themes/my.theme/taglist/squarefw.png"
theme.taglist_squares_unsel = awful.util.getdir("config") .. "/themes/my.theme/taglist/squarew.png"

-- LAYOUTS
theme.layout_tile       = awful.util.getdir("config") .. "/themes/my.theme/layouts/tile.png"
theme.layout_tileleft   = awful.util.getdir("config") .. "/themes/my.theme/layouts/tileleft.png"
theme.layout_tilebottom = awful.util.getdir("config") .. "/themes/my.theme/layouts/tilebottom.png"
theme.layout_tiletop    = awful.util.getdir("config") .. "/themes/my.theme/layouts/tiletop.png"
theme.layout_fairv      = awful.util.getdir("config") .. "/themes/my.theme/layouts/fairv.png"
theme.layout_fairh      = awful.util.getdir("config") .. "/themes/my.theme/layouts/fairh.png"
theme.layout_spiral     = awful.util.getdir("config") .. "/themes/my.theme/layouts/spiral.png"
theme.layout_dwindle    = awful.util.getdir("config") .. "/themes/my.theme/layouts/dwindle.png"
theme.layout_max        = awful.util.getdir("config") .. "/themes/my.theme/layouts/max.png"
theme.layout_fullscreen = awful.util.getdir("config") .. "/themes/my.theme/layouts/fullscreen.png"
theme.layout_magnifier  = awful.util.getdir("config") .. "/themes/my.theme/layouts/magnifier.png"
theme.layout_floating   = awful.util.getdir("config") .. "/themes/my.theme/layouts/floating.png"

-- MENU
theme.menu_submenu_icon = awful.util.getdir("config") .. "/themes/my.theme/submenu.png"
theme.menu_height       = "14"
theme.menu_width        = "100"

-- WALLPAPER
--theme.wallpaper_cmd = { "awsetbg -c " .. os.getenv("HOME") .. "/img/wallpaper.jpg" }

-- ICON
theme.awesome_icon  = "/usr/share/awesome/icons/awesome16.png"
theme.debian_icon   = "/usr/share/pixmaps/debian-logo.png"
theme.system_icons  = "/usr/share/pixmaps/"

return theme
