-- Awesome WM theme

theme = {}

theme.font          = "terminus 10"

-- COLORS
theme.colorfg               = "#ffffff"
theme.colorbg               = "#000000"
theme.color_black           = "#000000"
theme.color_lightblack      = "#555555"
theme.color_red             = "#aa0000"
theme.color_lightred        = "#ff0000"
theme.color_green           = "#00aa00"
theme.color_lightgreen      = "#00ff00"
theme.color_yellow          = "#aa6600"
theme.color_lightyellow     = "#ffff00"
theme.color_blue            = "#000080"
theme.color_lightblue       = "#0000ff"
theme.color_magenta         = "#aa00aa"
theme.color_lightmagenta    = "#ff00ff"
theme.color_cyan            = "#00aaaa"
theme.color_lightcyan       = "#00ffff"
theme.color_white           = "#aaaaaa"
theme.color_lightwhite      = "#ffffff"

-- Optionally, parse ~/.xcolors file
for line in io.lines(os.getenv("HOME") .. "/.xcolors") do
    if string.find(line, "foreground%s*:") then
        theme.colorfg = string.match(line, '(#.+)$')
    elseif string.find(line, "background%s*:") then
        theme.colorbg = string.match(line, '(#.+)$')
    elseif string.find(line, "color0%s*:") then
        theme.color_black = string.match(line, '(#.+)$')
    elseif string.find(line, "color8%s*:") then
        theme.color_lightblack = string.match(line, '(#.+)$')
    elseif string.find(line, "color1%s*:") then
        theme.color_red = string.match(line, '(#.+)$')
    elseif string.find(line, "color9%s*:") then
        theme.color_lightred = string.match(line, '(#.+)$')
    elseif string.find(line, "color2%s*:") then
        theme.color_green = string.match(line, '(#.+)$')
    elseif string.find(line, "color10%s*:") then
        theme.color_lightgreen = string.match(line, '(#.+)$')
    elseif string.find(line, "color3%s*:") then
        theme.color_yellow = string.match(line, '(#.+)$')
    elseif string.find(line, "color11%s*:") then
        theme.color_lightyellow = string.match(line, '(#.+)$')
    elseif string.find(line, "color4%s*:") then
        theme.color_blue = string.match(line, '(#.+)$')
    elseif string.find(line, "color12%s*:") then
        theme.color_lightblue = string.match(line, '(#.+)$')
    elseif string.find(line, "color5%s*:") then
        theme.color_magenta = string.match(line, '(#.+)$')
    elseif string.find(line, "color13%s*:") then
        theme.color_lightmagenta = string.match(line, '(#.+)$')
    elseif string.find(line, "color6%s*:") then
        theme.color_cyan = string.match(line, '(#.+)$')
    elseif string.find(line, "color14%s*:") then
        theme.color_lightcyan = string.match(line, '(#.+)$')
    elseif string.find(line, "color7%s*:") then
        theme.color_white = string.match(line, '(#.+)$')
    elseif string.find(line, "color15%s*:") then
        theme.color_lightwhite = string.match(line, '(#.+)$')
    end
end

theme.bg_normal     = theme.colorbg
theme.bg_focus      = theme.colorbg
theme.bg_urgent     = theme.color_lightmagenta
theme.bg_minimize   = theme.colorbg
theme.bg_systray    = theme.colorbg

theme.fg_normal     = theme.color_lightblack
theme.fg_focus      = theme.color_lightwhite
theme.fg_urgent     = theme.color_magenta
theme.fg_minimize   = theme.color_black

theme.border_width  = 1
theme.border_normal = theme.color_black
theme.border_focus  = theme.color_white
theme.border_marked = theme.color_magenta

-- MENU
theme.menu_submenu_icon = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/submenu.png"
theme.menu_height       = 14
theme.menu_width        = 100
theme.menu_bg_normal    = theme.color_lightwhite
theme.menu_bg_focus     = theme.color_blue
theme.menu_fg_normal    = theme.color_black
theme.menu_fg_focus     = theme.color_lightwhite
theme.menu_border_color = theme.color_lightwhite
theme.menu_border_width = 1

-- LAYOUTS
theme.layout_tile          = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/tile.png"
theme.layout_tileleft      = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/tileleft.png"
theme.layout_tilebottom    = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/tilebottom.png"
theme.layout_tiletop       = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/tiletop.png"
theme.layout_fairv         = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/fairv.png"
theme.layout_fairh         = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/fairh.png"
theme.layout_spiral        = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/spiral.png"
theme.layout_dwindle       = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/dwindle.png"
theme.layout_max           = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/max.png"
theme.layout_fullscreen    = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/fullscreen.png"
theme.layout_magnifier     = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/magnifier.png"
theme.layout_floating      = os.getenv("HOME") .. "/.config/awesome/themes/my.theme/layouts/floating.png"
theme.lain_icons           = os.getenv("HOME") .. "/.config/awesome/lain/icons/layout/default/"
theme.layout_termfair      = theme.lain_icons .. "termfairw.png"
theme.layout_cascade       = theme.lain_icons .. "cascadew.png"
theme.layout_cascadetile   = theme.lain_icons .. "cascadetilew.png"
theme.layout_centerfair    = theme.lain_icons .. "centerfairw.png"
theme.layout_centerwork    = theme.lain_icons .. "centerworkw.png"
theme.layout_leaved        = os.getenv("HOME") .. "/.config/awesome/awesome-leaved/leaved.png"

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
