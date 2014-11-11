-- Awesome WM configuration
-- pretty much copied from JackH79 config files:
-- http://github.com/JackH79/.dotfiles/tree/master/.config/awesome

-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Shifty library
require("shifty")

-- Widget libraries
require("vicious")
-- Calendar widget (http://awesome.naquadah.org/wiki/Calendar_widget)
require("calendar2")
-- Netinfo widget (from vicious wlan widget)
require("vicious.widgets.netinfo")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Variable definitions

-- Themes define colours, icons, and wallpapers
beautiful.init( awful.util.getdir("config") .. "/themes/my.theme/theme.lua" )

-- COLORS
coldef  = "</span>"
colblk  = "<span color='#111313'>"
colred  = "<span color='#9e6b71'>"
colgre  = "<span color='#719e6b'>"
colyel  = "<span color='#9e986c'>"
colblu  = "<span color='#6c8b9e'>"
colmag  = "<span color='#986b9e'>"
colcya  = "<span color='#6b9e98'>"
colwhi  = "<span color='#b8baba'>"
colbblk = "<span color='#424446'>"
colbred = "<span color='#b69094'>"
colbgre = "<span color='#94b690'>"
colbyel = "<span color='#b5b18f'>"
colbblu = "<span color='#90a7b6'>"
colbmag = "<span color='#b290b6'>"
colbcya = "<span color='#90b6b3'>"
colbwhi = "<span color='#cdcfce'>"

-- These are used later as the default programs
terminal    = "urxvtc"
browser     = "firefox"
editor      = "vim"
editor_cmd  = terminal .. " -e " .. editor

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
}

-- {{{ Tags

---- shifty: predefined tags
shifty.config.tags = {
    ["1:main"] = { init = true, position = 1, layout = layouts[2] },
    ["2:www"] = { position = 2, layout = layouts[6] },
    ["3:dev"] = { position = 3, layout = layouts[2] },
    ["4:chat"] = { position = 4, layout = layouts[3] },
    ["5:graph"] = { position = 5, layout = layouts[6] },
    ["6:media"] = { position = 6, layout = layouts[10] },
    ["7:office"] = { position = 7, layout = layouts[6] },
    ["8"] = { position = 8, layout = layouts[1] },
    ["9"] = { position = 9, layout = layouts[1] }
}

-- shifty: tags matching and client rules (use xprop to check window properties)
shifty.config.apps = {
    { match = { "Chromium", "ELinks", "Epiphany", "Firefox", "Filezilla", "Iceweasel", "luakit", "lynx.cur", "IEXPLORE.EXE", "Midori", "Speed Dial", "TorBrowser", "uzbl" }, tag = "2:www", },
    { match = { "Eclipse", "Gvim", "Python Shell" }, tag = "3:dev", },
    { match = { "irssi", "weechat", "xchat" }, tag = "4:chat", },
    { match = { "avidemux.*", "Blender", "cinelerra.*", "Darktable", "Gimp", "handbrake.*", "Inkscape", "openshot", "PencilMainWindow", "pitivi", "RawTherapee.*", "UFRaw" }, tag = "5:graph", },
    { match = { "clementine", "Popcorn Time", "Rhythmbox", "Totem", "Vlc" }, tag = "6:media", },
    { match = { "abiword", "gnumeric", "LibreOffice.*" }, tag = "7:office", },
    -- Floating clients
    { match = { "alsamixer", "bash", "Empathy", "htop", "keepassx", "MPlayer", "mc", "mutt", "Nautilus", "ncmpcpp", "Pcmanfm", "sensors", "Thunar", "Transmission", "uGet", "watch", "wyrd" }, float = true },
    -- Specific client properties
    { match = { "gimp%-image%-window" }, geometry = {175,15,930,770}, border_width = 0 },
    { match = { "^gimp%-toolbox$" }, geometry = {0,15,175,770}, slave = true, border_width = 0 },
    { match = { "^gimp%-dock$" }, geometry = {1105,15,175,770}, slave = true, border_width = 0 },
    -- client manipulation
    { match = { "" },
        honorsizehints = false,
        buttons = awful.util.table.join (
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize))
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
    { "Chromium",   "chromium"},
    { "Firefox",    browser},
    { "Luakit",     "luakit"},
    { "Lynx",       terminal .. " -e lynx" },
    { "Mutt",       mail},
    { "Weechat",    chat}
}

officemenu = {
    { "Abiword",    "abiword"},
    { "GNumeric",   "gnumeric"}
}

editorsmenu = {
    { "GVIM",   "gvim"},
    { "vim",    editor_cmd }
}

graphicsmenu = {
    { "Inkscape",   "inkscape"},
    { "The GIMP",   "gimp"}
}

mediamenu = {
    { "ncmpcpp",    mpd },
    { "VLC",        "vlc"}
}

utilitiesmenu = {
    { "file manager",       terminal .. " -e mc" },
    { "terminal",           terminal },
    { "VirtualBox",         "VirtualBox" },
    { "virtual manager",    "virt-manager" }
}

systemmenu = {
    { "htop",   terminal .. " -e htop" },
    { "kill",   "xkill" }
}

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual",      terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart",     awesome.restart },
   { "quit",        awesome.quit },
   { "reboot",      "dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart" },
   { "shutdown",    "dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop" }
}

mymainmenu = awful.menu({
    width = 150,
    items = {
        { "Awesome", myawesomemenu },
        { "Editors", editorsmenu },
        { "Graphics", graphicsmenu },
        { "Multimedia", mediamenu },
        { "Network", networkmenu },
        { "Office", officemenu },
        { "System", systemmenu },
        { "Utilities", utilitiesmenu },
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

-- Date widget
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "" .. colyel .. "%a,%e %b" .. coldef .. " ", 3600)
calendar2.addCalendarToWidget(datewidget, "" .. colyel .. "%s" .. coldef .. "")

-- Time widget
timewidget = widget({ type = "textbox" })
vicious.register(timewidget, vicious.widgets.date, "" .. colbyel .. "%H:%M" .. coldef .. " ", 1)
function cal_gett()
  local fp = io.popen("cat " .. os.getenv("HOME") .. "/todo.txt")
	local rem = fp:read("*a")
	fp:close()
	  rem = string.gsub(rem, "\027%[0m", coldef)
		rem = string.gsub(rem, "\027%[0;30m", colblk)  --black
		rem = string.gsub(rem, "\027%[0;31m", colred)  --red
		rem = string.gsub(rem, "\027%[0;32m", colgre)  --green
		rem = string.gsub(rem, "\027%[0;33m", colyel)  --yellow
		rem = string.gsub(rem, "\027%[0;34m", colblu)  --blue
		rem = string.gsub(rem, "\027%[0;35m", colmag)  --magenta
		rem = string.gsub(rem, "\027%[0;36m", colcya)  --cyan
		rem = string.gsub(rem, "\027%[0;37m", colwhi)  --white
		rem = string.gsub(rem, "\027%[1;30m", colbblk) --br-black
		rem = string.gsub(rem, "\027%[1;31m", colbred) --br-red
		rem = string.gsub(rem, "\027%[1;32m", colbgre) --br-green
		rem = string.gsub(rem, "\027%[1;33m", colbyel) --br-yellow
		rem = string.gsub(rem, "\027%[1;34m", colbblu) --br-blue
		rem = string.gsub(rem, "\027%[1;35m", colbmag) --br-magenta
		rem = string.gsub(rem, "\027%[1;36m", colbcya) --br-cyan
		rem = string.gsub(rem, "\027%[1;37m", colbwhi) --br-white
		return rem
end
timewidget:add_signal('mouse::enter', function () cal_remt = { naughty.notify({ text = cal_gett(), border_color = "#000000", timeout = 0, hover_timeout = 0.5 }) } end)
timewidget:add_signal('mouse::leave', function () naughty.destroy(cal_remt[1]) end)
timewidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( editor_cmd .. " -o " .. os.getenv("HOME") .. "/todo.txt " .. os.getenv("HOME") .. "/done.txt" ) end ) ) )

-- Weather widget
weatherwidget = widget({ type = "textbox" })
vicious.register(weatherwidget, vicious.widgets.weather,
	function (widget, args)
		if args["{tempc}"] == "N/A" then
			return ""
		else
			weatherwidget:add_signal('mouse::enter', function () weather_n = { naughty.notify({ title = "" .. colblu .. "------------- Weather -------------" .. coldef .. "", text = "" .. colbblu .. "Wind    : " .. args["{windkmh}"] .. " km/h " .. args["{wind}"] .. "\nHumidity: " .. args["{humid}"] .. " %\nPressure: " .. args["{press}"] .. " hPa" .. coldef .. "", border_color = "#000000", timeout = 0, hover_timeout = 0.5 }) } end)
			weatherwidget:add_signal('mouse::leave', function () naughty.destroy(weather_n[1]) end)
			return "" .. colbblu .. "☀ " .. coldef .. colblu .. string.lower(args["{sky}"]) .. ", " .. args["{tempc}"] .. "°C" .. coldef .. " "
		end
	end, 1200, "LECO")

-- Mbox widget
--mboxwidget = widget({ type = "textbox" })
--vicious.register(mboxwidget, vicious.widgets.mboxc,
--    function (widget, args)
--        if args[3] > 0 then
--            return "" .. colyel .. "mbox " .. coldef .. colbblu .. args[3] .. "/" .. args[1] .. coldef .. " "
--        else
--            return "" .. colblk .. "mbox " .. coldef .. colbblk .. args[3] .. "/" .. args[1] .. coldef .. " "
--        end
--    end, 5, { os.getenv("MAIL") } )
--mboxwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn(mail) end ) ) )

-- Gmail widget
gmailwidget = widget({ type = "textbox" })
vicious.register(gmailwidget, vicious.widgets.gmail,
    function (widget, args)
        if args["{count}"] > 0 then
            return "" .. colbyel .. "✉ " .. coldef .. colblu .. args["{count}"] .. coldef .. " "
        else
            return "" .. colbblk .. "✉ " .. coldef .. colwhi .. args["{count}"] .. coldef .. " "
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
            return ""
        elseif args["{state}"] == "Play" then
            return "" .. colbblk .. "♬ " .. coldef .. colblu .. args["{Artist}"] .. " - " .. args["{Title}"] .. " [" .. args["{Album}"] .. "]" .. coldef .. " "
        elseif args["{state}"] == "Pause" then
            return "" .. colbblk .. "♬ " .. coldef .. colyel .. "paused" .. coldef .. " "
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
cputwidget = widget({ type = "textbox" })
vicious.register(cputwidget, vicious.widgets.cpu,
    function (widget, args)
        if args[1] >= 50 then
            return "" .. colbred .. "⌚ " .. coldef .. colred .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colbblk .. "⌚ " .. coldef .. colwhi .. args[1] .. "%" .. coldef .. " "
        end
    end, 20)
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e htop --sort-key PERCENT_CPU" ) end ) ) )

-- Ram widget
memwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem,
    function (widget, args)
        if args[1] >= 80 then
            return "" .. colbred .. "≣ " .. coldef .. colred .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colbblk .. "≣ " .. coldef .. colwhi .. args[1] .. "%" .. coldef .. " "
        end
    end, 20)
memwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e htop --sort-key PERCENT_MEM" ) end ) ) )

-- CPU temp widgets
-- coretemp0
coretemp0widget = widget({ type = "textbox" })
vicious.register(coretemp0widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 85 then
            return "" .. colbred .. "≈ " .. coldef .. colred .. args[1] .. "°C" .. coldef .. " "
        else
            return "" .. colbblk .. "≈ " .. coldef .. colwhi .. args[1] .. "°C" .. coldef .. " "
        end
    end, 20, { "coretemp.0/hwmon/hwmon1", "core0"} )
coretemp0widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- Thermal widgets
-- zone0
temp0widget = widget({ type = "textbox" })
vicious.register(temp0widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 85 then
            return "" .. colred .. args[1] .. "°C" .. coldef .. " "
        else
            return "" .. colwhi .. args[1] .. "°C" .. coldef .. " "
        end
    end, 20, "thermal_zone0" )
temp0widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- Filesystem widgets
-- root
fsrwidget = widget({ type = "textbox" })
vicious.register(fsrwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/ used_p}"] >= 90 and args["{/ used_p}"] <= 100 then
            return "" .. colbred .. "/ " .. coldef .. colred .. args["{/ used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colbblk .. "/ " .. coldef .. colwhi .. args["{/ used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)
-- /mnt/home
fshwidget = widget({ type = "textbox" })
vicious.register(fshwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/mnt/home used_p}"] >= 90 and args["{/mnt/home used_p}"] < 100 then
            return "" .. colbred .. "~ " .. coldef .. colred .. args["{/mnt/home used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colbblk .. "~ " .. coldef .. colwhi .. args["{/mnt/home used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)
-- /mntdata/
fsdwidget = widget({ type = "textbox" })
vicious.register(fsdwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/mnt/data used_p}"] >= 90 and args["{/mnt/data used_p}"] < 100 then
            return "" .. colbred .. "# " .. coldef .. colred .. args["{/mnt/data used_p}"] .. "%" .. coldef .. " "
        else
            return "" .. colbblk .. "# " .. coldef .. colwhi .. args["{/mnt/data used_p}"] .. "%" .. coldef .. " "
        end
    end, 620)

-- Net widgets
-- eth0
netewidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.net)
vicious.register(netewidget, vicious.widgets.net,
    function (widget, args)
        if args["{eth0 down_kb}"] == "0.0" and args["{eth0 up_kb}"] == "0.0" then
            return "" .. colbblk .. "⇋ " .. coldef .. colwhi .. args["{eth0 down_kb}"] .. "k " .. args["{eth0 up_kb}"] .. "k" .. coldef .. " "
        else
            return "" .. colbblk .. "⇋ " .. coldef .. colcya .. args["{eth0 down_kb}"] .. "k " .. coldef .. colmag .. args["{eth0 up_kb}"] .. "k" .. coldef .. " "
        end
    end)

ethwidget = widget({ type = "textbox" })
vicious.register(ethwidget, vicious.widgets.netinfo,
    function (widget, args)
        if args["{ip}"] == nil then
            netewidget.visible = false
            return ""
        else
            netewidget.visible = true
            return "" .. colbblk .. "ℹ " .. coldef .. colwhi .. args["{ip}"] .. coldef .. " "
        end
    end, refresh_delay, "eth0")
ethwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e bash -c \"nm-tool 2>/dev/null && read -rsp $'Press any key to continue...\n' -n 1 key\"" ) end ) ) )

-- wlan0
netwwidget = widget({ type = "textbox" })
vicious.register(netwwidget, vicious.widgets.net,
    function (widget, args)
        if args["{wlan0 down_kb}"] == "0.0" and args["{wlan0 up_kb}"] == "0.0" then
            return "" .. colbblk .. "⇋ " .. coldef .. colwhi .. args["{wlan0 down_kb}"] .. "k " .. args["{wlan0 up_kb}"] .. "k" .. coldef .. " "
        else
            return "" .. colbblk .. "⇋ " .. coldef .. colcya .. args["{wlan0 down_kb}"] .. "k " .. coldef .. colmag .. args["{wlan0 up_kb}"] .. "k" .. coldef .. " "
        end
    end)

wifiwidget = widget({ type = "textbox" })
vicious.register(wifiwidget, vicious.widgets.wifi,
    function (widget, args)
        if args["{link}"] == 0 then
            netwwidget.visible = false
            return ""
        else
            netwwidget.visible = true
            return "" .. colbblk .. "ℹ " .. coldef .. colwhi .. string.format("%s [%i%%]", args["{ssid}"], args["{link}"]/70*100) .. coldef .. " "
        end
    end, 30, "wlan0" )
wifiwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e bash -c \"nm-tool 2>/dev/null && read -rsp $'Press any key to continue...\n' -n 1 key\"" ) end ) ) )

-- Keyboard Layout widget
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "gb", "" }, { "es", "" } }
kbdcfg.current = 1  -- is our default layout
kbdcfg.widget = widget({ type = "textbox", align = "right" })
kbdcfg.widget.text = colbblk .. "⚑ " .. coldef .. colwhi .. kbdcfg.layout[kbdcfg.current][1] .. coldef .. " "
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdcfg.widget.text = colbyel .. "⚑ " .. coldef .. colyel .. t[1] .. coldef .. " "
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))

-- Volume widget
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume,
    function (widget, args)
        if args[1] == 0 or args[2] == "♩" then
            return "" .. colbblk .. "♪ " .. coldef .. colyel .. "muted" .. coldef .. " "
        elseif args[1] > 60 then
            return "" .. colbred .. "♪ " .. coldef .. colred .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colbblk .. "♪ " .. coldef .. colwhi .. args[1] .. "%" .. coldef .. " "
        end
    end, 2, "Master" )
volwidget:buttons(
    awful.util.table.join(
        awful.button({ }, 1, function () awful.util.spawn( terminal .. " -e alsamixer" ) end),
        awful.button({ }, 2, function () awful.util.spawn( "amixer -q sset Master toggle" ) end),
        awful.button({ }, 4, function () awful.util.spawn( "amixer -q sset Master 5%+" ) end),
        awful.button({ }, 5, function () awful.util.spawn( "amixer -q sset Master 5%-" ) end)
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
    mywibox[s] = awful.wibox({ position = "top", height = "14", bg = "#000000", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            spacerwidget,
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        -- Time widget
        timewidget,
        -- Date widget
        datewidget,
        -- Weather widget
        weatherwidget,
        -- Tasks
        mytasklist[s],
        spacerwidget,
        layout = awful.widget.layout.horizontal.rightleft
    }

    -- Create the infobox
    infobox[s] = awful.wibox({ position = "bottom", height = "14", bg = "#000000", screen = s })
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
        volwidget,
        -- Battery widget
        batwidget,
        -- Gmail widget
        gmailwidget,
        -- Keyboard Layout widget
        kbdcfg.widget,
        -- Net widgets
        wifiwidget, netwwidget,
        ethwidget, netewidget,
        -- Filesystem widgets
        fsdwidget, fshwidget, fsrwidget,
        -- Thermal widgets
        temp0widget,
        -- CPU temp widgets
        coretemp0widget,
        -- Ram widgets
        memwidget,
        -- CPU widget
        cputwidget,
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
    awful.key({ modkey, "Control" }, "Escape", awful.tag.history.restore),


    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Launchers
    awful.key({ altkey,           }, "F1",  function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j",   function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k",   function () awful.client.swap.byidx( -1)    end),
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

    awful.key({ modkey,           }, "l",       function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",       function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",       function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",       function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",       function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",       function () awful.tag.incncol(-1)         end),
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
              end)

    -- Modules
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",       function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ altkey },            "F4",      function (c) c:kill()                         end),
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
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

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
                     -- Avoid maximized windows
                     maximized_vertical   = false,
                     maximized_horizontal = false,
                     buttons = clientbuttons } },
    -- Set this programs to float
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    -- Set Flash to float
    { rule = { instance = "plugin-container" },
      properties = { floating = true } },
    { rule = { class = "Exe"},
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    --awful.titlebar.add(c, { modkey = modkey })

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

--client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.add_signal("focus",
    function(c)
        c.border_color = beautiful.border_focus
        c.opacity = 1
    end)
client.add_signal("unfocus",
    function(c)
        c.border_color = beautiful.border_normal
        c.opacity = 0.9
    end)
-- }}}

-- {{{ Startup programs

-- Function to run programs once
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

-- Set background color
--awful.util.spawn_with_shell("hsetroot -solid '#1a1a1a'")
-- Set X Server properties
awful.util.spawn_with_shell("xrdb .Xdefaults")
-- Change resolution for external monitor
awful.util.spawn_with_shell("xrandr --output VGA1 --auto")
-- Start ScreenSaver daemon
run_once("xscreensaver","-no-splash")
-- Start Terminal daemon
run_once("urxvtd","--quiet --opendisplay --fork")
-- Run composite manager
--run_once("xcompmgr")
-- Start Empathy
run_once("empathy", "-h")
-- Start Music Player Daemon
run_once("mpd")
-- Start ownCloud client
run_once("owncloud")
-- Start clipboard manager
run_once("parcellite")


-- }}}
