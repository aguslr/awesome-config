-- Awesome WM configuration
-- pretty much copied from JackH79 config files:
-- http://github.com/JackH79/.dotfiles/tree/master/.config/awesome

-- Theme handling library
require("beautiful")
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Notification library
require("naughty")
-- Shifty library
require("shifty")

-- Widget libraries
require("vicious")
-- Calendar widget (http://awesome.naquadah.org/wiki/Calendar_widget)
require("calendar2")

-- Load Debian menu entries
require("debian.menu")

-- Load awesome-vain
require("vain")
vain.widgets.terminal = "urxvtc"

-- Load treesome
require("treesome")

-- {{{ Variable definitions

-- Themes define colours, icons, and wallpapers
beautiful.init( awful.util.getdir("config") .. "/themes/my.theme/theme.lua" )

-- Naughty notification properties
naughty.config.default_preset.timeout           = 5
naughty.config.default_preset.screen            = 1
naughty.config.default_preset.position          = "bottom_right"
naughty.config.default_preset.margin            = 10
naughty.config.default_preset.gap               = 1
naughty.config.default_preset.ontop             = true
naughty.config.default_preset.font              = beautiful.font
naughty.config.default_preset.icon              = nil
naughty.config.default_preset.icon_size         = 16
naughty.config.presets.low.fg                   = beautiful.fg_normal
naughty.config.presets.low.bg                   = beautiful.bg_normal
naughty.config.presets.low.border_color         = beautiful.border_normal
naughty.config.presets.normal.fg                = beautiful.fg_focus
naughty.config.presets.normal.bg                = beautiful.bg_focus
naughty.config.presets.normal.border_color      = beautiful.border_focus
naughty.config.presets.critical.fg              = beautiful.fg_urgent
naughty.config.presets.critical.bg              = beautiful.bg_urgent
naughty.config.presets.critical.border_color    = beautiful.border_marked
naughty.config.default_preset.border_width      = 1
naughty.config.default_preset.hover_timeout     = nil

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
terminal    = "urxvtc"
browser     = "firefox"
editor      = "gvim"
editor_cmd  = editor

-- Other programs
chat    = terminal .. " -geometry 130x40 -e weechat-curses"     -- Chat client
fm      = terminal .. " -geometry 130x40 -e mc"                 -- File Manager
mail    = terminal .. " -geometry 130x40 -e mutt"               -- Mail client
mpd     = terminal .. " -geometry 130x40 -e ncmpcpp"            -- MPD client

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
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
    vain.layout.termfair,               -- 13
    vain.layout.browse,                 -- 14
    vain.layout.cascade,                -- 15
    vain.layout.cascadebrowse,          -- 16
    vain.layout.centerwork,             -- 17
    treesome,                           -- 18
}

-- {{{ Tags

---- shifty: predefined tags
shifty.config.tags = {
    ["1:main"] = { position = 1, layout = layouts[3], mwfact = 0.60, init = true },
    ["2:www"] = { position = 2, layout = layouts[17], mwfact = 0.55 },
    ["3:dev"] = { position = 3, layout = layouts[18] },
    ["4:chat"] = { position = 4, layout = layouts[9] },
    ["5:graph"] = { position = 5, layout = layouts[6] },
    ["6:media"] = { position = 6, layout = layouts[1], leave_kills = true },
    ["7:office"] = { position = 7, layout = layouts[6] },
    ["8:virt"] = { position = 8, layout = layouts[1] },
    ["9"] = { position = 9, layout = layouts[1], leave_kills = true }
}

-- shifty: tags matching and client rules (use xprop to check window properties)
shifty.config.apps = {
    { match = { "Chromium", "ELinks", "Epiphany", "Firefox", "Filezilla", "Iceweasel", "luakit", "lynx.cur", "IEXPLORE.EXE", "Midori", "Speed Dial", "TorBrowser", "uzbl" }, tag = "2:www", },
    { match = { "Eclipse", "Gvim", "Python Shell", "Qtoctave", "Scilab" }, tag = "3:dev", },
    { match = { "irssi", "weechat", "xchat" }, tag = "4:chat", },
    { match = { "Adobe Illustrator*", "avidemux.*", "Blender", "cinelerra.*", "Darktable", "Gimp", "handbrake.*", "Inkscape", "openshot", "PencilMainWindow", "pitivi", "RawTherapee.*", "Simple Scan", "UFRaw" }, tag = "5:graph", },
    { match = { "clementine", "Popcorn Time", "Rhythmbox", "Steam", "Totem", "Vlc" }, tag = "6:media", },
    { match = { "abiword", "gnumeric", "LibreOffice.*" }, tag = "7:office", },
    { match = { "Administrador de Máquina Virtual", "virt-manager", "VirtualBox" }, tag = "8:virt", },
    -- Floating clients
    { match = { "alsamixer", "bash", "Empathy", "htop", "ImageMagick", "keepassx", "MPlayer", "mc", "mutt", "Nautilus", "ncmpcpp", "Pcmanfm", "ristretto", "sensors", "Sonata", "Thunar", "Transmission", "uGet", "Update Manager", "watch", "wyrd" }, float = true },
    -- client manipulation
    { match = { "" },
        honorsizehints = false
    }
}

-- shifty: defaults
shifty.config.defaults = {
    layout = awful.layout.suit.max,
}
shifty.config.layouts = layouts
shifty.init()


-- {{{ Menu

-- MENU
networkmenu = {
    { "&Chromium",  "chromium"},
    { "&Firefox",   browser},
    { "&Lynx",      terminal .. " -e lynx" },
    { "&Mutt",      mail},
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
    { "&Thunar",            "thunar"},
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
   { "&edit config",    editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "&restart",        awesome.restart },
   { "&quit",           awesome.quit },
   { "&Power",          powermenu }
}

mymainmenu = awful.menu({
    width = 150,
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
    }
})

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}


-- {{{ Wibox

-- Spacer widget
spacerwidget = widget({ type = "imagebox" })
spacerwidget.image = image(awful.util.getdir("config") .. "/themes/my.theme/spacer.png")
separatorwidget = widget({ type = "textbox" })
separatorwidget.text  = " "

-- {{{{  Top right widgets (Wibox)

-- Time widget
timewidget = widget({ type = "textbox" })
vicious.register(timewidget, vicious.widgets.date, "" .. colbyel .. "%a %e %b, %H:%M" .. coldef .. " ", 1)
calendar2.addCalendarToWidget(timewidget, "" .. colyel .. "%s" .. coldef .. "")

-- ToDo widget
todowidget = widget({ type = "textbox" })
todotimer = timer({ timeout = 10 })
todotimer:add_signal("timeout", function ()
    local c = 0
    for line in io.lines(os.getenv("HOME") .. "/todo.txt") do
        c = c + 1
    end
    todowidget.text = colyel .. "" .. c .. " tasks" .. coldef .. " "
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
todowidget:add_signal('mouse::enter', function () todo_n = { naughty.notify({ text = todo_list(), position = "top_right", border_color = "#000000", timeout = 0, hover_timeout = 0.5 }) } end)
todowidget:add_signal('mouse::leave', function () naughty.destroy(todo_n[1]) end)
todowidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( editor_cmd .. " -o " .. os.getenv("HOME") .. "/todo.txt " .. os.getenv("HOME") .. "/done.txt" ) end ) ) )


-- Weather widget
weatherwidget = widget({ type = "textbox" })
weatherwidget_t = awful.tooltip({ objects = { weatherwidget },})
vicious.register(weatherwidget, vicious.widgets.weather,
    function (widget, args)
        if args["{tempc}"] == "N/A" then
            return ""
        else
            weatherwidget_t:set_text("" .. colbblu .. string.upper(args["{city}"]) .. coldef .. "" .. colblu .. "\nWind    : " .. args["{windkmh}"] .. " km/h " .. args["{wind}"] .. "\nHumidity: " .. args["{humid}"] .. " %\nPressure: " .. args["{press}"] .. " hPa" .. coldef .. "")
            return "" .. colblu .. args["{sky}"] .. ": " .. args["{tempc}"] .. "°C" .. coldef .. " "
        end
    end, 1200, "LECO")
weatherwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( browser .. " http://weather.noaa.gov/weather/current/LECO.html" ) end ) ) )

-- Gmail widget
gmailicon = widget({ type = "textbox" })
gmailicon.text = "" .. colbblk .. "✉ " .. coldef .. ""
gmailwidget = widget({ type = "textbox" })
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
mpdwidget = widget({ type = 'textbox' })
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
cpuicon = widget({ type = "textbox" })
cpuicon.text = "" .. colbblk .. "⌚ " .. coldef .. ""
cpuwidget = widget({ type = "textbox" })
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
memicon = widget({ type = "textbox" })
memicon.text = "" .. colbblk .. "≣ " .. coldef .. ""
memwidget = widget({ type = "textbox" })
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
tempicon = widget({ type = "textbox" })
tempicon.text = "" .. colbblk .. "≈ " .. coldef .. ""
-- phys0
cputempwidget = widget({ type = "textbox" })
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
temp0widget = widget({ type = "textbox" })
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
temp1widget = widget({ type = "textbox" })
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
temp2widget = widget({ type = "textbox" })
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
fsricon = widget({ type = "textbox" })
fsricon.text = "" .. colbblk .. "/ " .. coldef .. ""
fsrwidget = widget({ type = "textbox" })
vicious.register(fsrwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/ used_p}"] >= 90 and args["{/ used_p}"] <= 100 then
            return "" .. colred .. args["{/ used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args["{/ used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)
-- /mnt/home
fshicon = widget({ type = "textbox" })
fshicon.text = "" .. colbblk .. "~ " .. coldef .. ""
fshwidget = widget({ type = "textbox" })
vicious.register(fshwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/mnt/home used_p}"] >= 90 and args["{/mnt/home used_p}"] < 100 then
            return "" .. colred .. args["{/mnt/home used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args["{/mnt/home used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)
-- /mntdata/
fsdicon = widget({ type = "textbox" })
fsdicon.text = "" .. colbblk .. "# " .. coldef .. ""
fsdwidget = widget({ type = "textbox" })
vicious.register(fsdwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/mnt/data used_p}"] >= 90 and args["{/mnt/data used_p}"] < 100 then
            return "" .. colred .. args["{/mnt/data used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colwhi .. args["{/mnt/data used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)

-- Net widgets
-- eth0
neteicon = widget({ type = "textbox" })
neteicon.text = "" .. colbblk .. "⇋ " .. coldef .. ""
netewidget = widget({ type = "textbox" })
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
netewidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e bash -c \"nm-tool 2>/dev/null && read -rsp $'Press any key to continue...\n' -n 1 key\"" ) end ) ) )

-- wlan0
netwicon = widget({ type = "textbox" })
netwicon.text = "" .. colbblk .. "⇋ " .. coldef .. ""
netwwidget = widget({ type = "textbox" })
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
netwwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e bash -c \"nm-tool 2>/dev/null && read -rsp $'Press any key to continue...\n' -n 1 key\"" ) end ) ) )

-- Keyboard Layout widget
kbdicon = widget({ type = "textbox" })
kbdicon.text = "" .. colbblk .. "⚑ " .. coldef .. ""
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "gb", "" }, { "us", "altgr-intl" }, { "es", "" } }
kbdcfg.current = 1  -- is our default layout
kbdwidget = widget({ type = "textbox", align = "right" })
kbdwidget.text = colwhi .. kbdcfg.layout[kbdcfg.current][1] .. coldef .. " "
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdwidget.text = colyel .. t[1] .. coldef .. " "
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
kbdwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))

-- Volume widget
volicon = widget({ type = "textbox" })
volicon.text = "" .. colbblk .. "♬ " .. coldef .. ""
volwidget = widget({ type = "textbox" })
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

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
infobox = {}
mypromptbox = {}
mylayoutbox = {}

-- taglist
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
shifty.taglist = mytaglist
-- tasklist
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=500 })
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
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                           --remove tasklist-icon without modifying the original tasklist.lua
                           --http://awesome.naquadah.org/wiki/Remove_icons
                           local tmptask = { awful.widget.tasklist.label.currenttags(c, s) }
                           return tmptask[1], tmptask[2], tmptask[3], nil
                           end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "16", bg = "" .. beautiful.colorbg .. "", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        -- Time widget
        timewidget,
        -- ToDo widget
        todowidget,
        -- Weather widget
        weatherwidget,
        -- Tasks
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

    -- Create the infobox
    infobox[s] = awful.wibox({ position = "bottom", height = "16", bg = "" .. beautiful.colorbg .. "", screen = s })
    -- Add widgets to the infobox - order matters
    infobox[s].widgets = {
        {
            --mylauncher,
            mypromptbox[s],
            separatorwidget,
            -- MPD widget
            mpdwidget,
            layout = awful.widget.layout.horizontal.leftright
        },
        -- Systray
        s == 1 and mysystray or nil,
        -- Volume widget
        volwidget, volicon,
        -- Gmail widget
        gmailwidget, gmailicon,
        -- Keyboard Layout widget
        kbdwidget, kbdicon,
        -- Net widgets
        netwwidget, netwicon,
        netewidget, neteicon,
        -- Filesystem widgets
        fsdwidget, fsdicon,
        fshwidget, fshicon,
        fsrwidget, fsricon,
        -- Thermal widgets
        temp2widget, temp1widget, temp0widget,
        cputempwidget, tempicon,
        -- Ram widgets
        memwidget, memicon,
        -- CPU widget
        cpuwidget, cpuicon,
        separatorwidget,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
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
    awful.key({ modkey,           }, "Return",  function () awful.util.spawn( terminal ) end),
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
    -- treesome
    awful.key({ modkey            }, "s",       treesome.horizontal), -- split next horizontal
    awful.key({ modkey            }, "v",       treesome.vertical),   -- split next vertical

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

-- WORKSPACES
-- shifty:
for i=1,9 do
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, i, function ()
        local t = awful.tag.viewonly(shifty.getpos(i))
    end))
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, i, function ()
        local t = shifty.getpos(i)
        t.selected = not t.selected
    end))
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, i, function ()
        if client.focus then
            awful.client.toggletag(shifty.getpos(i))
        end
    end))
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, i, function ()
        if client.focus then
            local t = shifty.getpos(i)
            awful.client.movetotag(t)
            awful.tag.viewonly(t)
        end
    end))
end

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
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
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    --awful.titlebar.add(c, { modkey = modkey })

    -- Add border
    c.border_color = beautiful.border_focus

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
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
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Startup programs

-- Functions to run programs once
-- http://awesome.naquadah.org/wiki/Autostart#The_native_lua_way
require("lfs")
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
awful.util.spawn_with_shell("hsetroot -solid '" .. beautiful.color_black .. "'")
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
-- Start Music Player Daemon
run_once("mpd")
-- Start ownCloud client
run_once("owncloud")
-- Start clipboard manager
run_once("parcellite")
-- Start RSI prevention tool
run_once("workrave")
-- Start lightsOn script
run_once("lightsOn.sh", os.getenv("HOME") .. "/bin/lightsOn.sh 300")


-- }}}
-- vim: set ts=4 sw=4 tw=0 et :
