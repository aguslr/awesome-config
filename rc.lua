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
require('calendar2')
-- Netinfo widget (from vicious wlan widget)
require("vicious.widgets.netinfo")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Variable definitions

-- Themes define colours, icons, and wallpapers
beautiful.init( awful.util.getdir("config") .. "/themes/my.theme/theme.lua" )

-- COLORS
coldef  = "</span>"
colblk  = "<span color='#1a1a1a'>"
colred  = "<span color='#b23535'>"
colgre  = "<span color='#60801f'>"
colyel  = "<span color='#be6e00'>"
colblu  = "<span color='#1f6080'>"
colmag  = "<span color='#8f46b2'>"
colcya  = "<span color='#73afb4'>"
colwhi  = "<span color='#b2b2b2'>"
colbblk = "<span color='#333333'>"
colbred = "<span color='#ff4b4b'>"
colbgre = "<span color='#9bcd32'>"
colbyel = "<span color='#d79b1e'>"
colbblu = "<span color='#329bcd'>"
colbmag = "<span color='#cd64ff'>"
colbcya = "<span color='#9bcdff'>"
colbwhi = "<span color='#ffffff'>"

-- These are used later as the default programs
terminal    = "urxvtc"
browser     = "firefox"
editor      = os.getenv("EDITOR") or "vim"
editor_cmd  = terminal .. " -e " .. editor

-- Other programs
cal     = terminal .. " -geometry 130x40 -e wyrd"               -- Calendar
chat    = terminal .. " -geometry 130x40 -e weechat-curses"     -- Chat client
fm      = terminal .. " -geometry 130x40 -e mc"                 -- File Manager
mail    = terminal .. " -geometry 130x40 -e mutt"               -- Mail client
mpd     = terminal .. " -geometry 130x40 -e ncmpcpp"            -- MPD client
rss     = terminal .. " -geometry 130x40 -e newsbeuter"         -- RSS reader

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
    awful.layout.suit.magnifier         -- 12
}
-- }}}

-- {{{ Tags

---- shifty: predefined tags
shifty.config.tags = {
    ["1:main"] = { init = true, position = 1, layout = layouts[1] },
    ["2:www"] = { position = 2, layout = layouts[10] },
    ["3:dev"] = { position = 3, layout = layouts[2] },
    ["4:chat"] = { position = 4, layout = layouts[4] },
    ["5:graph"] = { position = 5, layout = layouts[1] },
    ["6:media"] = { position = 6, layout = layouts[10] },
    ["7"] = { position = 7, layout = layouts[4] },
    ["8"] = { position = 8, layout = layouts[8] },
    ["9"] = { position = 9, layout = layouts[12] }
}

-- shifty: tags matching and client rules
shifty.config.apps = {
    { match = { "Chromium", "ELinks", "Firefox", "Filezilla", "Iceweasel", "luakit", "uzbl" }, tag = "2:www", },
    { match = { "edwin", "Gvim" }, tag = "3:dev", },
    { match = { "irssi", "weechat", "xchat" }, tag = "4:chat", },
    { match = { "Dia", "Gimp", "Inkscape", "PencilMainWindow" }, tag = "5:graph", },
    { match = { "avidemux2_gtk", "clementine", "exaile.py", "handbrake-gtk", "quodlibet", "Rhythmbox", "Totem" }, tag = "6:media", },
    -- Floating clients
    { match = { "alsamixer", "htop", "MPlayer", "mc", "mutt", "ncmpcpp", "sensors", "Thunar", "wyrd" }, float = true },
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
    { "Chromium",   "chromium-browser", beautiful.system_icons .. "chromium-browser.png" },
    { "Iceweasel",  browser,            beautiful.system_icons .. "iceweasel.png" },
    { "Mutt",       mail,               beautiful.system_icons .. "mutt.xpm" },
    { "Newsbeuter", rss },
    { "Weechat",    chat,               beautiful.system_icons .. "weechat.xpm" }
}

officemenu = {
    { "Abiword",    "abiword",  beautiful.system_icons .. "abiword.xpm" },
    { "GNumeric",   "gnumeric", "/usr/share/icons/hicolor/16x16/apps/gnumeric.png" },
    { "Wyrd", cal }
}

editorsmenu = {
    { "GVIM",   "gvim",                 beautiful.system_icons .. "vim-16.xpm" },
    { "vim",    terminal .. " -e vim" }
}

graphicsmenu = {
    { "Inkscape",   "inkscape", beautiful.system_icons .. "inkscape.xpm" },
    { "The GIMP",   "gimp",     beautiful.system_icons .. "gimp.xpm" }
}

mediamenu = {
    { "ncmpcpp",    mpd },
    { "Rhythmbox",  "rhythmbox",    beautiful.system_icons .. "rhythmbox-small.xpm" },
    { "Video",      "totem",        beautiful.system_icons .. "totem.xpm" }
}

utilitiesmenu = {
    { "mc",                 fm,                 beautiful.system_icons .. "mc.xpm" },
    { "terminal",           terminal },
    { "Thunar",             "thunar" },
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
   { "quit",        awesome.quit }
}

mymainmenu = awful.menu({
    width = 150,
    items = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        { "Debian", debian.menu.Debian_menu.Debian, beautiful.debian_icon },
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
vicious.register(timewidget, vicious.widgets.date, "" .. colbyel .. "%H:%M:%S" .. coldef .. " ", 1)
function cal_gett()
    local fp = io.popen("remind " .. os.getenv("HOME") .. "/.reminders")
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
timewidget:add_signal('mouse::enter', function () cal_remt = { naughty.notify({ text = cal_gett(), timeout = 0, hover_timeout = 0.5 }) } end)
timewidget:add_signal('mouse::leave', function () naughty.destroy(cal_remt[1]) end)
timewidget:buttons(awful.util.table.join(awful.button({}, 3, function () awful.util.spawn( cal ) end ) ) )

-- Weather widget
weatherwidget = widget({ type = "textbox" })
vicious.register(weatherwidget, vicious.widgets.weather,
	function (widget, args)
		if args["{tempc}"] == "N/A" then
			return ""
		else
			weatherwidget:add_signal('mouse::enter', function () weather_n = { naughty.notify({ title = "" .. colblu .. "------------- Weather -------------" .. coldef .. "", text = "" .. colbblu .. "Wind    : " .. args["{windkmh}"] .. " km/h " .. args["{wind}"] .. "\nHumidity: " .. args["{humid}"] .. " %\nPressure: " .. args["{press}"] .. " hPa" .. coldef .. "", border_color = "#1a1a1a", timeout = 0, hover_timeout = 0.5 }) } end)
			weatherwidget:add_signal('mouse::leave', function () naughty.destroy(weather_n[1]) end)
			return "" .. colblu .. "weather " .. coldef .. colbblu .. string.lower(args["{sky}"]) .. ", " .. args["{tempc}"] .. "°C" .. coldef .. " "
		end
	end, 1200, "LECO")

-- Mbox widget
--mboxwidget = widget({ type = "textbox" })
--vicious.register(mboxwidget, vicious.widgets.mboxc,
--    function (widget, args)
--        if args[3] > 0 then
--            return "" .. colyel .. "mbox " .. coldef .. colbgre .. args[3] .. "/" .. args[1] .. coldef .. " "
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
            return "" .. colyel .. "gmail " .. coldef .. colbgre .. args["{count}"] .. coldef .. " "
        else
            return "" .. colblk .. "gmail " .. coldef .. colbblk .. args["{count}"] .. coldef .. " "
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
            return "" .. colblk .. "mpd " .. coldef .. colbblk .. args["{Artist}"] .. " - " .. args["{Title}"] .. " [" .. args["{Album}"] .. "]" .. coldef .. " "
        elseif args["{state}"] == "Pause" then
            return "" .. colblk .. "mpd " .. coldef .. colbyel .. "paused" .. coldef .. " "
        end
    end)
mpdwidget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function () awful.util.spawn( "mpc toggle", false ) end),
        awful.button({}, 3, function () awful.util.spawn( mpd )   end),
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
        if args[1] >= 20 and args[1] < 50 then
            return "" .. colyel .. "cpu " .. coldef .. colbyel .. args[1] .. "%" .. coldef .. " "
        elseif args[1] >= 50 then
            return "" .. colred .. "cpu " .. coldef .. colbred .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colblk .. "cpu " .. coldef .. colbblk .. args[1] .. "%" .. coldef .. " "
        end
    end, 20)
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e htop --sort-key PERCENT_CPU" ) end ) ) )

-- Ram widget
memwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.mem)
--vicious.register(memwidget, vicious.widgets.mem, "" .. colblk .. "ram " .. coldef .. colbblk .. "$1% ($2 MiB) " .. coldef .. "", 13)
vicious.register(memwidget, vicious.widgets.mem,
    function (widget, args)
        if args[1] >= 40 and args[1] < 80 then
            return "" .. colyel .. "ram " .. coldef .. colbyel .. args[1] .. "% (" .. args[2] .. " MiB)" .. coldef .. " "
        elseif args[1] >= 80 then
            return "" .. colred .. "ram " .. coldef .. colbred .. args[1] .. "% (" .. args[2] .. " MiB)" .. coldef .. " "
        else
            return "" .. colblk .. "ram " .. coldef .. colbblk .. args[1] .. "% (" .. args[2] .. " MiB)" .. coldef .. " "
        end
    end, 20)
memwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e htop --sort-key PERCENT_MEM" ) end ) ) )

-- CPU temp widgets
-- coretemp0
coretemp0widget = widget({ type = "textbox" })
vicious.register(coretemp0widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 55 and args[1] < 70 then
            return "" .. colblu .. "core0 " .. coldef .. colbblu .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 70 and args[1] < 85 then
            return "" .. colyel .. "core0 " .. coldef .. colbyel .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 85 then
            return "" .. colred .. "core0 " .. coldef .. colbred .. args[1] .. "°C" .. coldef .. " "
        else
            return "" .. colblk .. "core0 " .. coldef .. colbblk .. args[1] .. "°C" .. coldef .. " "
        end
    end, 20, { "coretemp.0", "core"} )
coretemp0widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- coretemp1
coretemp1widget = widget({ type = "textbox" })
vicious.register(coretemp1widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 55 and args[1] < 70 then
            return "" .. colblu .. "core1 " .. coldef .. colbblu .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 70 and args[1] < 85 then
            return "" .. colyel .. "core1 " .. coldef .. colbyel .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 85 then
            return "" .. colred .. "core1 " .. coldef .. colbred .. args[1] .. "°C" .. coldef .. " "
        else
            return "" .. colblk .. "core1 " .. coldef .. colbblk .. args[1] .. "°C" .. coldef .. " "
        end
    end, 20, { "coretemp.1", "core"} )
coretemp1widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- Thermal widgets
-- zone0
temp0widget = widget({ type = "textbox" })
vicious.register(temp0widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 55 and args[1] < 70 then
            return "" .. colblu .. "temp0 " .. coldef .. colbblu .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 70 and args[1] < 85 then
            return "" .. colyel .. "temp0 " .. coldef .. colbyel .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 85 then
            return "" .. colred .. "temp0 " .. coldef .. colbred .. args[1] .. "°C" .. coldef .. " "
        else
            return "" .. colblk .. "temp0 " .. coldef .. colbblk .. args[1] .. "°C" .. coldef .. " "
        end
    end, 20, "thermal_zone0" )
temp0widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- zone1
temp1widget = widget({ type = "textbox" })
vicious.register(temp1widget, vicious.widgets.thermal,
    function (widget, args)
        if args[1] >= 55 and args[1] < 70 then
            return "" .. colblu .. "temp1 " .. coldef .. colbblu .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 70 and args[1] < 90 then
            return "" .. colyel .. "temp1 " .. coldef .. colbyel .. args[1] .. "°C" .. coldef .. " "
        elseif args[1] >= 90 then
            return "" .. colred .. "temp1 " .. coldef .. colbred .. args[1] .. "°C" .. coldef .. " "
        else
            return "" .. colblk .. "temp1 " .. coldef .. colbblk .. args[1] .. "°C" .. coldef .. " "
        end
    end, 20, "thermal_zone1" )
temp1widget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn( terminal .. " -e watch sensors" ) end ) ) )

-- Filesystem widgets
-- root
fsrwidget = widget({ type = "textbox" })
vicious.register(fsrwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/ used_p}"] >= 80 and args["{/ used_p}"] < 90 then
            return "" .. colyel .. "/ " .. coldef .. colbyel .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free)" .. coldef .. " "
        elseif args["{/ used_p}"] >= 90 and args["{/ used_p}"] < 95 then
            return "" .. colred .. "/ " .. coldef .. colbred .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free)" .. coldef .. " "
        elseif args["{/ used_p}"] >= 95 and args["{/ used_p}"] <= 100 then
            return "" .. colred .. "/ " .. coldef .. colbred .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free)" .. coldef .. " "
        else
            return "" .. colblk .. "/ " .. coldef .. colbblk .. args["{/ used_p}"] .. "% (" .. args["{/ avail_gb}"] .. " GiB free)" .. coldef .. " "
        end
    end, 620)
-- /home
fshwidget = widget({ type = "textbox" })
vicious.register(fshwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/home used_p}"] >= 80 and args["{/home used_p}"] < 90 then
            return "" .. colyel .. "/home " .. coldef .. colbyel .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free)" .. coldef .. " "
        elseif args["{/home used_p}"] >= 90 and args["{/home used_p}"] < 95 then
            return "" .. colred .. "/home " .. coldef .. colbred .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free)" .. coldef .. " "
        elseif args["{/home used_p}"] >= 95 and args["{/home used_p}"] <= 100 then
            return "" .. colred .. "/home " .. coldef .. colbred .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free)" .. coldef .. " "
        else
            return "" .. colblk .. "/home " .. coldef .. colbblk .. args["{/home used_p}"] .. "% (" .. args["{/home avail_gb}"] .. " GiB free)" .. coldef .. " "
        end
    end, 620)

-- Net widgets
-- eth
netewidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.net)
--vicious.register(netewidget, vicious.widgets.net, "" .. colblk .. "eth0 " .. coldef .. colbgre .. "${eth0 down_kb}k " .. coldef .. colbred .. "${eth0 up_kb}k " .. coldef .. "")
vicious.register(netewidget, vicious.widgets.net,
    function (widget, args)
        if args["{eth0 down_kb}"] == "0.0" and args["{eth0 up_kb}"] == "0.0" then
            return "" .. colblk .. "eth0 " .. coldef .. colbblk .. args["{eth0 down_kb}"] .. "k " .. args["{eth0 up_kb}"] .. "k" .. coldef .. " "
        else
            return "" .. colblk .. "eth0 " .. coldef .. colbgre .. args["{eth0 down_kb}"] .. "k " .. coldef .. colbred .. args["{eth0 up_kb}"] .. "k" .. coldef .. " "
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
            return "" .. colblk .. "ip " .. coldef .. colbblk .. args["{ip}"] .. coldef .. " "
        end
    end, refresh_delay, "eth0")

-- wlan
netwwidget = widget({ type = "textbox" })
--vicious.register(netwwidget, vicious.widgets.net, "" .. colblk .. "wlan0 " .. coldef .. colbgre .. "${wlan0 down_kb}k " .. coldef .. colbred .. "${wlan0 up_kb}k " .. coldef .. "")
vicious.register(netwwidget, vicious.widgets.net,
    function (widget, args)
        if args["{wlan0 down_kb}"] == "0.0" and args["{wlan0 up_kb}"] == "0.0" then
            return "" .. colblk .. "wlan0 " .. coldef .. colbblk .. args["{wlan0 down_kb}"] .. "k " .. args["{wlan0 up_kb}"] .. "k" .. coldef .. " "
        else
            return "" .. colblk .. "wlan0 " .. coldef .. colbgre .. args["{wlan0 down_kb}"] .. "k " .. coldef .. colbred .. args["{wlan0 up_kb}"] .. "k" .. coldef .. " "
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
            return ""
            --return "" .. colblk .. "ssid " .. coldef .. colbblk .. string.format("%s [%i%%]", args["{ssid}"], args["{link}"]/70*100) .. coldef .. " "
        end
    end, 30, "wlan0" )

-- Battery widget
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat,
    function (widget, args)
        if args[2] >= 50 and args[2] < 75 then
            return "" .. colyel .. "bat " .. coldef .. colbyel .. args[2] .. "%" .. coldef .. " "
        elseif args[2] >= 20 and args[2] < 50 then
            return "" .. colred .. "bat " .. coldef .. colbred .. args[2] .. "%" .. coldef .. " "
        elseif args[2] < 20 and args[1] == "-" then
            naughty.notify({ title = "Battery Warning", text = "Battery low! "..args[2].."% left!\nBetter get some power.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
            return "" .. colred .. "bat " .. coldef .. colbred .. args[2] .. "%" .. coldef .. " "
        elseif args[2] < 20 then
            return "" .. colred .. "bat " .. coldef .. colbred .. args[2] .. "%" .. coldef .. " "
        else
            return "" .. colblk .. "bat " .. coldef .. colbblk .. args[2] .. "%" .. coldef .. " "
        end
    end, 20, "BAT0" )

-- Volume widget
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume,
    function (widget, args)
        if args[1] == 0 or args[2] == "♩" then
            return "" .. colred .. "vol " .. coldef .. colbred .. "mute" .. coldef .. " "
        elseif args[1] >= 40 and args[1] < 80 then
            return "" .. colyel .. "vol " .. coldef .. colbyel .. args[1] .. "%" .. coldef .. " "
        elseif args[1] > 80 then
            return "" .. colgre .. "vol " .. coldef .. colbgre .. args[1] .. "%" .. coldef .. " "
        else
            return "" .. colblk .. "vol " .. coldef .. colbblk .. args[1] .. "%" .. coldef .. " "
        end
    end, 2, "Master" )
volwidget:buttons(
    awful.util.table.join(
        awful.button({ }, 1, function () awful.util.spawn( "amixer -q sset Master toggle" ) end),
        awful.button({ }, 3, function () awful.util.spawn( terminal .. " -e alsamixer" ) end),
        awful.button({ }, 4, function () awful.util.spawn( "amixer -q sset Master 2dB+" ) end),
        awful.button({ }, 5, function () awful.util.spawn( "amixer -q sset Master 2dB-" ) end)
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
                                              return awful.widget.tasklist.label.currenttags(c, s)
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
        --weatherwidget,
        -- Gmail widget
        gmailwidget,
        separatorwidget,
        -- Systray
        s == 1 and mysystray or nil,
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
        -- Volume widget
        volwidget,
        -- Battery widget
        batwidget,
        -- Net widgets
        wifiwidget, netwwidget,
        ethwidget, netewidget,
        -- Filesystem widgets
        fshwidget, fsrwidget,
        -- Thermal widgets
        temp1widget,
        temp0widget,
        -- CPU temp widgets
        coretemp1widget,
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
    awful.key({ altkey,           }, "F1",              function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j",   function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k",   function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j",   function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k",   function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u",   awful.client.urgent.jumpto),
    -- Changed from Win+Tab to Alt+Tab
    awful.key({ altkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
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
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
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
function run_once(prg)
    if not prg then
        do return nil end
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

-- Run composite manager
--run_once("xcompmgr")
-- Run clipboard manager
--run_once("parcellite")

-- }}}
