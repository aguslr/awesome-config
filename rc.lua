-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Load Debian menu entries
require("debian.menu")

-- Shifty library
local shifty = require("shifty")

-- Widget libraries
local vicious = require("vicious")

-- Load awesome-lain
local lain = require("lain")

-- Load awesome-leaved
local leaved = require "awesome-leaved"

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- Themes define colours, icons, and wallpapers
beautiful.init( awful.util.getdir("config") .. "/themes/my.theme/theme.lua" )

-- Naughty notification properties
naughty.config.defaults.timeout                 = 5
naughty.config.defaults.screen                  = 1
naughty.config.defaults.position                = "bottom_right"
naughty.config.defaults.margin                  = 10
naughty.config.defaults.gap                     = 1
naughty.config.defaults.ontop                   = true
naughty.config.defaults.font                    = beautiful.font
naughty.config.defaults.icon                    = nil
naughty.config.defaults.icon_size               = 16
naughty.config.presets.low.fg                   = beautiful.fg_normal
naughty.config.presets.low.bg                   = beautiful.bg_normal
naughty.config.presets.low.border_color         = beautiful.border_normal
naughty.config.presets.normal.fg                = beautiful.fg_focus
naughty.config.presets.normal.bg                = beautiful.bg_focus
naughty.config.presets.normal.border_color      = beautiful.border_focus
naughty.config.presets.critical.fg              = beautiful.fg_urgent
naughty.config.presets.critical.bg              = beautiful.bg_urgent
naughty.config.presets.critical.border_color    = beautiful.border_marked
naughty.config.defaults.border_width            = 1
naughty.config.defaults.hover_timeout           = nil

-- COLORS
coldef  = "</span>"
colblk  = "<span color='" .. beautiful.color_black .. "'>"
colred  = "<span color='" .. beautiful.color_red .. "'>"
colgre  = "<span color='" .. beautiful.color_green .. "'>"
colyel  = "<span color='" .. beautiful.color_yellow .. "'>"
colblu  = "<span color='" .. beautiful.color_blue .. "'>"
colmag  = "<span color='" .. beautiful.color_magenta .. "'>"
colcya  = "<span color='" .. beautiful.color_cyan .. "'>"
colwhi  = "<span color='" .. beautiful.color_white .. "'>"
colbblk = "<span color='" .. beautiful.color_bblack .. "'>"
colbred = "<span color='" .. beautiful.color_bred .. "'>"
colbgre = "<span color='" .. beautiful.color_bgreen .. "'>"
colbyel = "<span color='" .. beautiful.color_byellow .. "'>"
colbblu = "<span color='" .. beautiful.color_bblue .. "'>"
colbmag = "<span color='" .. beautiful.color_bmagenta .. "'>"
colbcya = "<span color='" .. beautiful.color_bcyan .. "'>"
colbwhi = "<span color='" .. beautiful.color_bwhite .. "'>"

-- These are used later as the default programs
terminal    = "urxvtc -geometry 130x40"
miniterminal= "urxvtc -geometry 62x15"
browser     = "firefox"
editor      = "gvim"
editor_cmd  = editor

-- Other programs
chat    = terminal .. " -e weechat-curses"     -- Chat client
fm      = terminal .. " -e mc"                 -- File Manager
mail    = terminal .. " -e mutt"               -- Mail client
mpd     = terminal .. " -e ncmpcpp"            -- MPD client

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,         -- 1
    awful.layout.suit.tile,             -- 2
    awful.layout.suit.tile.left,        -- 3
    awful.layout.suit.tile.bottom,      -- 4
    awful.layout.suit.tile.top,         -- 5
    awful.layout.suit.fair,             -- 6
    awful.layout.suit.fair.horizontal,  -- 7
    awful.layout.suit.spiral,           -- 8
    awful.layout.suit.spiral.dwindle,   -- 9
    awful.layout.suit.max,              -- 10
    awful.layout.suit.max.fullscreen,   -- 11
    awful.layout.suit.magnifier,        -- 12
    lain.layout.termfair,               -- 13
    lain.layout.centerfair,             -- 14
    lain.layout.cascade,                -- 15
    lain.layout.cascadetile,            -- 16
    lain.layout.centerwork,             -- 17
    leaved.layout.suit.tile.right,      -- 18
    leaved.layout.suit.tile.left,       -- 19
    leaved.layout.suit.tile.bottom,     -- 20
    leaved.layout.suit.tile.top,        -- 21
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
---- shifty: predefined tags
shifty.config.tags = {
    ["1:main"] = { position = 1, layout = layouts[3], mwfact = 0.60, init = true },
    ["2:www"] = { position = 2, layout = layouts[17], mwfact = 0.55 },
    ["3:dev"] = { position = 3, layout = layouts[18] },
    ["4:chat"] = { position = 4, layout = layouts[9] },
    ["5:graph"] = { position = 5, layout = layouts[6] },
    ["6:media"] = { position = 6, layout = layouts[1] },
    ["7:office"] = { position = 7, layout = layouts[6] },
    ["8:virt"] = { position = 8, layout = layouts[1] },
    ["9:misc"] = { position = 9, layout = layouts[1], leave_kills = true },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    { match = { "Chromium", "ELinks", "Epiphany", "Firefox", "Filezilla", "Iceweasel", "luakit", "lynx.cur", "IEXPLORE.EXE", "Midori", "Speed Dial", "TorBrowser", "uzbl" }, tag = "2:www", },
    { match = { "Android *", "Arduino", "Atom", "Brackets", "Eclipse", "Gvim", "MySQL Workbench", "Python Shell", "Qtoctave", "Scilab" }, tag = "3:dev", },
    { match = { "irssi", "weechat", "xchat" }, tag = "4:chat", },
    { match = { "Adobe Illustrator*", "avidemux.*", "Blender", "cinelerra.*", "Darktable", "Gimp", "handbrake.*", "Inkscape", "openshot", "PencilMainWindow", "pitivi", "RawTherapee.*", "Simple Scan", "UFRaw" }, tag = "5:graph", },
    { match = { "clementine", "Desura", "Lmms", "Popcorn Time", "Rhythmbox", "Steam", "Totem", "Vlc" }, tag = "6:media", },
    { match = { "abiword", "gnumeric", "LibreOffice.*" }, tag = "7:office", },
    { match = { "Gestor de Máquina Virtual", "OpenXenManager", "VirtualBox", "Virtual Machine Manager" }, tag = "8:virt", },
    -- Minimized clients
    { match = { "grab_screen.sh" }, minimized = true },
    -- Slave clients
    { match = { "~" }, slave = true },
    -- Floating clients
    { match = { "alsamixer", "bash", "Empathy", "Eog", "grab_screen.sh", "htop", "ImageMagick", "keepassx", "mc", "MPlayer", "mpv", "mutt", "Nautilus", "ncmpcpp", "Pcmanfm", "ristretto", "sensors", "Sonata", "Thunar", "Transmission", "uGet", "Update Manager", "watch", "wyrd" }, float = true },
    -- client manipulation
    { match = { "" },
        honorsizehints = false
    }
}

-- shifty: defaults
shifty.config.defaults = {
    layout = awful.layout.suit.max,
    ncol = 1,
    mwfact = 0.60,
    floatBars = false,
    guess_name = false,
    guess_position = false,
}
shifty.config.layouts = layouts
-- }}}

-- {{{ Menu

-- Menus
networkmenu = {
    { "&Chromium",  "chromium"},
    { "&Firefox",   browser},
    { "&Lynx",      terminal .. " -e lynx" },
    { "&Midori",    "midori"},
    { "M&utt",      mail},
    { "&Weechat",   chat},
    { "&XChat",     "xchat"}
}

officemenu = {
    { "&Abiword",               "abiword"},
    { "&GNumeric",              "gnumeric"},
    { "LibreOffice &Base",      "lobase"},
    { "LibreOffice &Calc",      "localc"},
    { "LibreOffice &Draw",      "lodraw"},
    { "LibreOffice &Impress",   "loimpress"},
    { "LibreOffice &Math",      "lomath"},
    { "LibreOffice &Writer",    "lowriter"}
}

editorsmenu = {
    { "&GVIM",      "gvim"},
    { "&vim",       terminal .. " -e vim"}
}

graphicsmenu = {
    { "&GIMP",      "gimp"},
    { "&Inkscape",  "inkscape"}
}

mediamenu = {
    { "nc&mpcpp",   mpd },
    { "&VLC",       "vlc"}
}

utilitiesmenu = {
    { "&file manager",      terminal .. " -e mc" },
    { "&Nautilus",          "nautilus --no-desktop"},
    { "&terminal",          terminal },
    { "&VirtualBox",        "VirtualBox" },
    { "virtual &manager",   "virt-manager" }
}

systemmenu = {
    { "&htop",  terminal .. " -e htop" },
    { "x&kill", "xkill" }
}

powermenu = {
   { "&hibernate",  'dbus-send --system --print-reply --dest="org.freedesktop.DeviceKit.Power" /org/freedesktop/DeviceKit/Power org.freedesktop.DeviceKit.Power.Hibernate' },
   { "&suspend",    'dbus-send --system --print-reply --dest="org.freedesktop.DeviceKit.Power" /org/freedesktop/DeviceKit/Power org.freedesktop.DeviceKit.Power.Suspend' },
   { "&reboot",     'dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart' },
   { "&poweroff",   'dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop' }
}

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "&manual",         terminal .. " -e man awesome" },
   { "&edit config",    editor_cmd .. " " .. awesome.conffile },
   { "&restart",        awesome.restart },
   { "&quit",           awesome.quit },
   { "&Power",          powermenu }
}

mymainmenu = awful.menu({
    items = {
        { "&Awesome", myawesomemenu },
        { "&Debian", debian.menu.Debian_menu.Debian },
        { "&Editors", editorsmenu },
        { "&Graphics", graphicsmenu },
        { "&Multimedia", mediamenu },
        { "&Network", networkmenu },
        { "&Office", officemenu },
        { "&System", systemmenu },
        { "&Utilities", utilitiesmenu },
    },
    theme = { width = 150 }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- }}}


-- {{{ Wibox

-- Spacer widget
spacerwidget = wibox.widget.imagebox()
spacerwidget:set_image(awful.util.getdir("config") .. "/themes/my.theme/spacer.png")
separatorwidget = wibox.widget.textbox()
separatorwidget:set_markup(" ")

-- {{{{  Top right widgets (Wibox)

-- Time widget
timewidget = wibox.widget.textbox()
vicious.register(timewidget, vicious.widgets.date, "" .. colbyel .. "%a%e %b %H:%M" .. coldef .. " ", 1)

-- ToDo widget
todowidget = wibox.widget.textbox()
todotimer = timer({ timeout = 10 })
todotimer:connect_signal("timeout", function ()
    local c = 0
    for line in io.lines(os.getenv("HOME") .. "/todo.txt") do
        c = c + 1
    end
    todowidget:set_markup(colyel .. "" .. c .. " tasks" .. coldef .. " ")
end)
todotimer:start()
function todo_list()
    local fp = {}
    for line in io.lines(os.getenv("HOME") .. "/todo.txt") do
        table.insert(fp, line)
    end
    table.sort(fp)
    local todo = {}
    for i, value in pairs(fp) do
        if string.find(value, '^%(A%)') then
            table.insert(todo, "" .. colred .. value .. coldef .. "")
        elseif string.find(value, '^%(B%)') then
            table.insert(todo, "" .. colyel .. value .. coldef .. "")
        elseif string.find(value, '^%(C%)') then
            table.insert(todo, "" .. colblu .. value .. coldef .. "")
        else
            table.insert(todo, "" .. colwhi .. value .. coldef .. "")
        end
    end
    return table.concat(todo, "\n")
end
todowidget_t = awful.tooltip({ objects = { todowidget },})
todowidget_t:set_markup( todo_list() )
todowidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( editor_cmd .. " -o " .. os.getenv("HOME") .. "/todo.txt " .. os.getenv("HOME") .. "/done.txt" ) end ) ) )

-- Weather widget
weatherwidget = wibox.widget.textbox()
weatherwidget_t = awful.tooltip({ objects = { weatherwidget },})
vicious.register(weatherwidget, vicious.widgets.weather,
    function (widget, args)
        if args["{tempc}"] == "N/A" then
            return ""
        else
            weatherwidget_t:set_markup("" .. colbblu .. string.upper(args["{city}"]) .. coldef .. "" .. colblu .. "\nWind    : " .. args["{windkmh}"] .. " km/h " .. args["{wind}"] .. "\nHumidity: " .. args["{humid}"] .. " %\nPressure: " .. args["{press}"] .. " hPa" .. coldef .. "")
            return "" .. colblu .. args["{sky}"] .. ": " .. args["{tempc}"] .. "°C" .. coldef .. " "
        end
    end, 1200, "LECO")
weatherwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( browser .. " http://weather.noaa.gov/weather/current/LECO.html" ) end ) ) )

-- Gmail widget
gmailicon = wibox.widget.textbox()
gmailicon:set_markup("" .. colbblk .. "✉ " .. coldef .. "")
gmailwidget = wibox.widget.textbox()
vicious.register(gmailwidget, vicious.widgets.gmail,
    function (widget, args)
        if args["{count}"] > 0 then
            return "" .. colblu .. args["{count}"] .. coldef .. " "
        else
            return "" .. colwhi .. args["{count}"] .. coldef .. " "
        end
    end, 10)
gmailwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( mail ) end ) ) )

-- }}}}

-- {{{{ Bottom right widgets (Infobox)

-- MPD widget
mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then
            return "" .. colbblk .. "◾ " .. coldef
        elseif args["{state}"] == "Play" then
            local trackinfo = ""
            if args["{Artist}"] ~= "N/A" then
                trackinfo = trackinfo .. args["{Artist}"] .. " - "
            end
            if args["{Title}"] ~= "N/A" then
                trackinfo = trackinfo .. args["{Title}"]
            end
            if args["{Album}"] ~= "N/A" then
                trackinfo = trackinfo .. " [" .. args["{Album}"] .. "]"
            end
            return "" .. colbblk .. "▶ " .. coldef .. colblu .. trackinfo .. coldef .. " "
        elseif args["{state}"] == "Pause" then
            return "" .. colbblk .. "▶ " .. coldef .. colyel .. "paused" .. coldef .. " "
        end
    end)
mpdwidget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function () awful.util.spawn( mpd )   end),
        awful.button({}, 2, function () awful.util.spawn( "mpc toggle", false ) end),
        awful.button({}, 4, function () awful.util.spawn( "mpc prev", false ) end),
        awful.button({}, 5, function () awful.util.spawn( "mpc next", false ) end)
    )
)

-- }}}}

-- {{{{ Bottom right widgets (Infobox)

-- CPU widget
cpuicon = wibox.widget.textbox()
cpuicon:set_markup("" .. colbblk .. "⌚ " .. coldef .. "")
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu,
    function (widget, args)
        if args[1] >= 50 then
            return "" .. colred .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "%" .. coldef .. " "
        end
    end, 20)
cpuwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e htop --sort-key PERCENT_CPU" ) end ) ) )

-- Ram widget
memicon = wibox.widget.textbox()
memicon:set_markup("" .. colbblk .. "≣ " .. coldef .. "")
memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem,
    function (widget, args)
        if args[1] >= 80 then
            return "" .. colred .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "%" .. coldef .. " "
        end
    end, 20)
memwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e htop --sort-key PERCENT_MEM" ) end ) ) )

-- Temp widgets
tempicon = wibox.widget.textbox()
tempicon:set_markup("" .. colbblk .. "≈ " .. coldef .. "")
-- phys0
cputempwidget = wibox.widget.textbox()
vicious.register(cputempwidget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 85 then
            return "" .. colred .. args[1] .. "°" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "°" .. coldef .. " "
        end
    end, 20, { "coretemp.0/hwmon/hwmon1", "core"} )
cputempwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- zone0
temp0widget = wibox.widget.textbox()
vicious.register(temp0widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 85 then
            return "" .. colred .. args[1] .. "°" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "°" .. coldef .. " "
        end
    end, 20, "thermal_zone0" )
temp0widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- zone1
temp1widget = wibox.widget.textbox()
vicious.register(temp1widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 85 then
            return "" .. colred .. args[1] .. "°" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "°" .. coldef .. " "
        end
    end, 20, "thermal_zone1" )
temp1widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- zone2
temp2widget = wibox.widget.textbox()
vicious.register(temp2widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 85 then
            return "" .. colred .. args[1] .. "°" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "°" .. coldef .. " "
        end
    end, 20, "thermal_zone2" )
temp2widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- Filesystem widgets
-- root
fsricon = wibox.widget.textbox()
fsricon:set_markup("" .. colbblk .. "/ " .. coldef .. "")
fsrwidget = wibox.widget.textbox()
vicious.register(fsrwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/ used_p}"] >= 90 and args["{/ used_p}"] <= 100 then
            return "" .. colred .. args["{/ used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args["{/ used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)
-- /home
fshicon = wibox.widget.textbox()
fshicon:set_markup("" .. colbblk .. "~ " .. coldef .. "")
fshwidget = wibox.widget.textbox()
vicious.register(fshwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/home used_p}"] >= 90 and args["{/home used_p}"] < 100 then
            return "" .. colred .. args["{/home used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args["{/home used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)

-- Net widgets
-- eth0
neteicon = wibox.widget.textbox()
neteicon:set_markup("" .. colbblk .. "⇋ " .. coldef .. "")
netewidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.net)
vicious.register(netewidget, vicious.widgets.net,
    function (widget, args)
        if args["{eth0 carrier}"] ~= 1 then
            neteicon.visible = false
            netewidget.visible = false
            return ""
        else
            if args["{eth0 down_kb}"] == "0.0" and args["{eth0 up_kb}"] == "0.0" then
                return "" .. colblk .. args["{eth0 down_kb}"] .. "k " .. args["{eth0 up_kb}"] .. "k" .. coldef .. " "
            else
                return "" .. colcya .. args["{eth0 down_kb}"] .. "k " .. coldef .. colmag .. args["{eth0 up_kb}"] .. "k" .. coldef .. " "
            end
        end
    end)
netewidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e bash -c \"nmcli device show eth0 2>/dev/null && read -rsp $'Press any key to continue...\n' -n 1 key\"" ) end ) ) )

-- wlan0
netwicon = wibox.widget.textbox()
netwicon:set_markup("" .. colbblk .. "⇋ " .. coldef .. "")
netwwidget = wibox.widget.textbox()
vicious.register(netwwidget, vicious.widgets.net,
    function (widget, args)
        if args["{wlan0 carrier}"] ~= 1 then
            netwicon.visible = false
            netwwidget.visible = false
            return ""
        else
            if args["{wlan0 down_kb}"] == "0.0" and args["{wlan0 up_kb}"] == "0.0" then
                return "" .. colblk .. args["{wlan0 down_kb}"] .. "k " .. args["{wlan0 up_kb}"] .. "k" .. coldef .. " "
            else
                return "" .. colcya .. args["{wlan0 down_kb}"] .. "k " .. coldef .. colmag .. args["{wlan0 up_kb}"] .. "k" .. coldef .. " "
            end
        end
    end)
netwwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e bash -c \"nmcli device show wlan0 2>/dev/null && read -rsp $'Press any key to continue...\n' -n 1 key\"" ) end ) ) )

-- Keyboard Layout widget
-- https://awesome.naquadah.org/wiki/Change_keyboard_maps
kbdicon = wibox.widget.textbox()
kbdicon:set_markup("" .. colbblk .. "⚑ " .. coldef .. "")
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "gb", "" }, { "us", "altgr-intl" }, { "es", "" } }
kbdcfg.current = 1  -- is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_markup(colwhi .. kbdcfg.layout[kbdcfg.current][1] .. coldef .. " ")
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdcfg.widget:set_markup(colyel .. t[1] .. coldef .. " ")
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
kbdcfg.widget:buttons(
 awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)

-- Volume widget
volicon = wibox.widget.textbox()
volicon:set_markup("" .. colbblk .. "♬ " .. coldef .. "")
volwidget = wibox.widget.textbox()
vicious.register(volwidget, vicious.widgets.volume,
    function (widget, args)
        if args[1] == 0 or args[2] == "♩" then
            return "" .. colyel .. "muted" .. coldef .. " "
        elseif args[1] > 60 then
            return "" .. colred .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "%" .. coldef .. " "
        end
    end, 2, "Master" )
volwidget:buttons(
    awful.util.table.join(
        awful.button({ }, 1, function () awful.util.spawn( terminal .. " -e alsamixer" ) end),
        awful.button({ }, 2, function () awful.util.spawn( "amixer -q sset Master toggle" ) end),
        awful.button({ }, 4, function () awful.util.spawn( "amixer -q sset Master 2%+" ) end),
        awful.button({ }, 5, function () awful.util.spawn( "amixer -q sset Master 2%-" ) end)
    )
)

-- }}}}

-- Create a wibox for each screen and add it
mywibox = {}
myinfobox = {}
mypromptbox = {}
mylayoutbox = {}

-- taglist
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )

-- tasklist
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 500 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- SHIFTY: initialize shifty
    -- the assignment of shifty.taglist must always be after its actually
    -- initialized with awful.widget.taglist.new()
    shifty.taglist = mytaglist
    shifty.init()

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "16", bg = "" .. beautiful.colorbg .. "", screen = s })
    -- Widgets that are aligned to the left
    local top_left_layout = wibox.layout.fixed.horizontal()
    top_left_layout:add(mytaglist[s])
    -- Widgets that are aligned to the right
    local top_right_layout = wibox.layout.fixed.horizontal()
    top_right_layout:add(weatherwidget)
    top_right_layout:add(todowidget)
    top_right_layout:add(timewidget)
    top_right_layout:add(mylayoutbox[s])
    -- Now bring it all together (with the tasklist in the middle)
    local top_layout = wibox.layout.align.horizontal()
    top_layout:set_left(top_left_layout)
    top_layout:set_middle(mytasklist[s])
    top_layout:set_right(top_right_layout)
    mywibox[s]:set_widget(top_layout)

    -- Create the infobox
    myinfobox[s] = awful.wibox({ position = "bottom", height = "16", bg = "" .. beautiful.colorbg .. "", screen = s })
    -- Widgets that are aligned to the left
    local bottom_left_layout = wibox.layout.fixed.horizontal()
    bottom_left_layout:add(mypromptbox[s])
    bottom_left_layout:add(separatorwidget)
    bottom_left_layout:add(mpdwidget)
    -- Widgets that are aligned to the right
    local bottom_right_layout = wibox.layout.fixed.horizontal()
    -- CPU widget
    bottom_right_layout:add(cpuicon)
    bottom_right_layout:add(cpuwidget)
    -- RAM widget
    bottom_right_layout:add(memicon)
    bottom_right_layout:add(memwidget)
    -- Thermal widget
    bottom_right_layout:add(tempicon)
    bottom_right_layout:add(cputempwidget)
    bottom_right_layout:add(temp0widget)
    bottom_right_layout:add(temp1widget)
    bottom_right_layout:add(temp2widget)
    -- Filesystem widget
    bottom_right_layout:add(fsricon)
    bottom_right_layout:add(fsrwidget)
    bottom_right_layout:add(fshicon)
    bottom_right_layout:add(fshwidget)
    -- Net widget
    bottom_right_layout:add(neteicon)
    bottom_right_layout:add(netewidget)
    bottom_right_layout:add(netwicon)
    bottom_right_layout:add(netwwidget)
    -- Gmail widget
    bottom_right_layout:add(gmailicon)
    bottom_right_layout:add(gmailwidget)
    -- Keyboard widget
    bottom_right_layout:add(kbdicon)
    bottom_right_layout:add(kbdcfg.widget)
    -- Volume widget
    bottom_right_layout:add(volicon)
    bottom_right_layout:add(volwidget)
    -- Systray
    if s == 1 then bottom_right_layout:add(wibox.widget.systray()) end
    -- Now bring it all together
    local bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_right(bottom_right_layout)
    myinfobox[s]:set_widget(bottom_layout)

end
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}


-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Tags
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ altkey, "Control" }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ altkey, "Control" }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Tab",    awful.tag.history.restore),

    -- Vi-like client movement
    awful.key({ modkey,           }, "h",
        function ()
            awful.client.focus.bydirection( "left" )
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.bydirection( "down" )
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),

    -- Launchers
    awful.key({ altkey,           }, "F1",  function () mymainmenu:show({keygrabber=true}) end),

    -- Vi-like layout manipulation
    awful.key({ modkey, "Shift"   }, "h",   function () awful.client.swap.bydirection( "left" )  end),
    awful.key({ modkey, "Shift"   }, "l",   function () awful.client.swap.bydirection( "right" ) end),
    awful.key({ modkey, "Shift"   }, "j",   function () awful.client.swap.bydirection( "down" )  end),
    awful.key({ modkey, "Shift"   }, "k",   function () awful.client.swap.bydirection( "up" )    end),
    awful.key({ modkey, "Control" }, "j",   function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k",   function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u",   awful.client.urgent.jumpto),
    -- Changed from Win+Tab to Alt+Tab and also cycle through all windows
    awful.key({ altkey,           }, "Tab",
        function ()
            --awful.client.focus.history.previous()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ altkey, "Control" }, "l",       function () awful.util.spawn( "xscreensaver-command -lock" ) end),
    awful.key({ modkey,           }, "Return",  function () awful.util.spawn( miniterminal ) end),
    awful.key({ modkey, "Shift"   }, "r",       awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",       awesome.quit),

    -- Vi-like resizing
    awful.key({ modkey,           }, "Up",      function () awful.client.incwfact( 0.01)  end),
    awful.key({ modkey,           }, "Down",    function () awful.client.incwfact(-0.01)  end),
    awful.key({ modkey,           }, "=",       function () awful.tag.incmwfact( 0.01)    end),
    awful.key({ modkey,           }, "-",       function () awful.tag.incmwfact(-0.01)    end),
    awful.key({ modkey, "Shift"   }, "=",       function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "-",       function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "=",       function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "-",       function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space",   function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space",   function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",   function () mypromptbox[mouse.screen]:run() end),
    awful.key({ altkey },            "F2",  function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Multimedia keys
    -- requires: mmkeys.sh (https://gist.github.com/8538bd7adb15b734e085)
    awful.key({}, "XF86AudioPrev", function () awful.util.spawn_with_shell(os.getenv("HOME") .. "/bin/mmkeys.sh --prev", false) end),
    awful.key({}, "XF86AudioNext", function () awful.util.spawn_with_shell(os.getenv("HOME") .. "/bin/mmkeys.sh --next", false) end),
    awful.key({}, "XF86AudioStop", function () awful.util.spawn_with_shell(os.getenv("HOME") .. "/bin/mmkeys.sh --stop", false) end),
    awful.key({}, "XF86AudioPlay", function () awful.util.spawn_with_shell(os.getenv("HOME") .. "/bin/mmkeys.sh --play", false) end),

    -- Modules
    -- awesome-leaved
    awful.key({ modkey            }, "s",       leaved.keys.splitH),        -- split next horizontal
    awful.key({ modkey            }, "v",       leaved.keys.splitV),        -- split next vertical
    awful.key({ modkey, "Shift"   }, "o",       leaved.keys.splitOpp),      -- split in opposing direction
    awful.key({ modkey, "Shift"   }, "t",       leaved.keys.shiftStyle),    -- switch: notabs-tabs-stack

    -- Print info on current client
    awful.key({ modkey }, "i",
              function ()
                  local c = client.focus
                  if not c then
                      return
                  end

                  local geom = c:geometry()

                  local t = ""
                  if c.class then t = t .. "Class: " .. c.class .. "\n" end
                  if c.instance then t = t .. "Instance: " .. c.instance .. "\n" end
                  if c.role then t = t .. "Role: " .. c.role .. "\n" end
                  if c.name then t = t .. "Name: " .. c.name .. "\n" end
                  if c.type then t = t .. "Type: " .. c.type .. "\n" end
                  if geom.width and geom.height and geom.x and geom.y then
                      t = t .. "Dimensions: " .. "x:" .. geom.x .. " y:" .. geom.y .. " w:" .. geom.width .. " h:" .. geom.height
                  end

                  naughty.notify({
                      text = t,
                      timeout = 10,
                  })
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",       function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ altkey            }, "F4",      function (c) c:kill()                         end),
    awful.key({ modkey, "Shift"   }, "c",       function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",   awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return",  function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",       awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",       function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",       function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",       function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    -- Allow moving and resizing maximized clients
    -- https://stackoverflow.com/a/22970288
    awful.button({ altkey }, 1,
        function (c)
            c.maximized_horizontal = false
            c.maximized_vertical   = false
            awful.mouse.client.move(c)
        end),
    awful.button({ altkey }, 3,
        function (c)
            c.maximized_horizontal = false
            c.maximized_vertical   = false
            awful.mouse.client.resize(c)
    end))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                      awful.tag.viewonly(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      awful.tag.viewtoggle(shifty.getpos(i))
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local t = shifty.getpos(i)
                          awful.client.movetotag(t)
                          awful.tag.viewonly(t)
                       end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          awful.client.toggletag(shifty.getpos(i))
                      end
                  end))
end

-- Set keys
root.keys(globalkeys)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey
-- }}}


-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     -- Avoid maximized windows
                     maximized_vertical   = false,
                     maximized_horizontal = false } },
    -- Float dialogs
    { rule = { type = "dialog" },
      properties = { floating = true } },
    -- Set Flash to float
    { rule = { instance = "plugin-container" },
      properties = { floating = true } },
    { rule = { class = "Exe"},
      properties = { floating = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Startup programs

-- Functions to run programs once
-- http://awesome.naquadah.org/wiki/Autostart#The_native_lua_way
local lfs = require("lfs")
local function processwalker()
    local function yieldprocess()
        for dir in lfs.dir("/proc") do
            -- All directories in /proc containing a number, represent a process
            if tonumber(dir) ~= nil then
                local f, err = io.open("/proc/"..dir.."/cmdline")
                if f then
                    local cmdline = f:read("*all")
                    f:close()
                    if cmdline ~= "" then
                        coroutine.yield(cmdline)
                    end
                end
            end
        end
    end
    return coroutine.wrap(yieldprocess)
end
local function run_once(process, cmd)
    assert(type(process) == "string")
    local regex_killer = {
      ["+"]  = "%+", ["-"] = "%-",
      ["*"]  = "%*", ["?"]  = "%?" }

    for p in processwalker() do
        if p:find(process:gsub("[-+?*]", regex_killer)) then
            return
        end
    end
    return awful.util.spawn(cmd or process)
end

-- Set background color
awful.util.spawn_with_shell("hsetroot -solid '" .. beautiful.colorbg .. "'")
-- Change resolution for external monitor
awful.util.spawn_with_shell("xrandr --output VGA1 --auto")
-- Start ScreenSaver daemon
run_once("xscreensaver","xscreensaver -no-splash")
-- Start Terminal daemon
run_once("urxvtd","urxvtd --quiet --opendisplay --fork")
-- Start Udisks-glue for device automonting
run_once("udisks-glue")
-- Start Update-notifier
run_once("update-notifier")
-- Start Empathy
run_once("empathy", "empathy -h")
-- Start ownCloud client
run_once("owncloud")
-- Start clipboard manager
run_once("parcellite")
-- Start RSI prevention tool
run_once("workrave")
-- Start lightsOn script
run_once("lightsOn.sh", os.getenv("HOME") .. "/bin/lightsOn.sh 300")


-- }}}
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
