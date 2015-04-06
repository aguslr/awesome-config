-- Awesome WM theme

theme = {}

theme.font          = "terminus 10"

-- COLORS
theme.colorfg           = "#ffffff"
theme.colorbg           = "#000000"
theme.color_black       = "#000000"
theme.color_bblack      = "#555555"
theme.color_red         = "#aa0000"
theme.color_bred        = "#ff0000"
theme.color_green       = "#00aa00"
theme.color_bgreen      = "#00ff00"
theme.color_yellow      = "#aa6600"
theme.color_byellow     = "#ffff00"
theme.color_blue        = "#000080"
theme.color_bblue       = "#0000ff"
theme.color_magenta     = "#aa00aa"
theme.color_bmagenta    = "#ff00ff"
theme.color_cyan        = "#00aaaa"
theme.color_bcyan       = "#00ffff"
theme.color_white       = "#aaaaaa"
theme.color_bwhite      = "#ffffff"

-- Optionally, parse ~/.xcolors file
for line in io.lines(os.getenv("HOME") .. "/.xcolors") do
    if string.find(line, "foreground%s*:") then
        theme.colorfg = string.match(line, '(#.+)$')
    elseif string.find(line, "background%s*:") then
        theme.colorbg = string.match(line, '(#.+)$')
    elseif string.find(line, "color0%s*:") then
        theme.color_black = string.match(line, '(#.+)$')
    elseif string.find(line, "color8%s*:") then
        theme.color_bblack = string.match(line, '(#.+)$')
    elseif string.find(line, "color1%s*:") then
        theme.color_red = string.match(line, '(#.+)$')
    elseif string.find(line, "color9%s*:") then
        theme.color_bred = string.match(line, '(#.+)$')
    elseif string.find(line, "color2%s*:") then
        theme.color_green = string.match(line, '(#.+)$')
    elseif string.find(line, "color10%s*:") then
        theme.color_bgreen = string.match(line, '(#.+)$')
    elseif string.find(line, "color3%s*:") then
        theme.color_yellow = string.match(line, '(#.+)$')
    elseif string.find(line, "color11%s*:") then
        theme.color_byellow = string.match(line, '(#.+)$')
    elseif string.find(line, "color4%s*:") then
        theme.color_blue = string.match(line, '(#.+)$')
    elseif string.find(line, "color12%s*:") then
        theme.color_bblue = string.match(line, '(#.+)$')
    elseif string.find(line, "color5%s*:") then
        theme.color_magenta = string.match(line, '(#.+)$')
    elseif string.find(line, "color13%s*:") then
        theme.color_bmagenta = string.match(line, '(#.+)$')
    elseif string.find(line, "color6%s*:") then
        theme.color_cyan = string.match(line, '(#.+)$')
    elseif string.find(line, "color14%s*:") then
        theme.color_bcyan = string.match(line, '(#.+)$')
    elseif string.find(line, "color7%s*:") then
        theme.color_white = string.match(line, '(#.+)$')
    elseif string.find(line, "color15%s*:") then
        theme.color_bwhite = string.match(line, '(#.+)$')
    end
end

theme.bg_normal     = theme.colorbg
theme.bg_focus      = theme.colorbg
theme.bg_urgent     = theme.color_bmagenta
theme.bg_minimize   = theme.colorbg
theme.bg_systray    = theme.colorbg

theme.fg_normal     = theme.color_bblack
theme.fg_focus      = theme.color_bwhite
theme.fg_urgent     = theme.color_magenta
theme.fg_minimize   = theme.color_black

theme.border_width  = 1
theme.border_normal = theme.color_black
theme.border_focus  = theme.color_white
theme.border_marked = theme.color_magenta

-- MENU
theme.menu_submenu_icon = awful.util.getdir("config") .. "/themes/my.theme/submenu.png"
theme.menu_height       = 14
theme.menu_width        = 100
theme.menu_bg_normal    = theme.color_bwhite
theme.menu_bg_focus     = theme.color_blue
theme.menu_fg_normal    = theme.color_black
theme.menu_fg_focus     = theme.color_bwhite
theme.menu_border_color = theme.color_bwhite
theme.menu_border_width = 1

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
theme.lain_icons           = os.getenv("HOME") .. "/.config/awesome/lain/icons/layout/default/"
theme.layout_termfair      = theme.lain_icons .. "termfairw.png"
theme.layout_cascade       = theme.lain_icons .. "cascadew.png"
theme.layout_cascadetile   = theme.lain_icons .. "cascadetilew.png"
theme.layout_centerwork    = theme.lain_icons .. "centerworkw.png"

-- WALLPAPER
--theme.wallpaper = { os.getenv("HOME") .. "/Imágenes/wallpaper" }

-- ICON
theme.awesome_icon  = "/usr/share/awesome/icons/awesome16.png"
theme.debian_icon   = "/usr/share/pixmaps/debian-logo.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- TASKLIST
-- http://awesome.naquadah.org/wiki/Remove_icons
theme.tasklist_disable_icon = true

-- GAPS
theme.useless_gap_width = "15"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
