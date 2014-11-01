---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Agus L. http://github.com/aguslopez
---------------------------------------------------

-- {{{ Grab environment
local tonumber = tonumber
local setmetatable = setmetatable
local io = {
    open = io.open,
    popen = io.popen
}
local string = {
    find = string.find,
    match = string.match
}
-- }}}


-- Netinfo: provides network information for a requested interface
module("vicious.widgets.netinfo")


-- Initialize function tables
local winfo = {
    ["{ip}"] = nil,
    ["{mac}"] = nil
}

-- {{{ Netinfo widget type
local function worker(format, warg)
    if not warg then return end

    -- Get data from ifconfig where available
    local ifconfig = "/sbin/ifconfig"
    local f = io.open(ifconfig, "rb")
    if not f then
        ifconfig = "/usr/sbin/ifconfig"
    else
        f:close()
    end
    local f = io.popen(ifconfig .." ".. warg .. " 2>&1")
    local iw = f:read("*all")
    f:close()

    -- ifconfig wasn't found, isn't executable, or no interface
    if iw == nil or string.find(iw, "Device not found") then
        return winfo
    end

    -- Output differs from system to system, some stats can be
    -- separated by =, and not all drivers report all stats
    winfo["{ip}"] =  -- IP address can only be digits
      string.match(iw, "inet addr[=:](%d+.%d+.%d+.%d+)") or winfo["{ip}"]
    winfo["{mac}"] =  -- MAC address
      string.match(iw, "HWaddr (%w+:%w+:%w+:%w+:%w+:%w+)") or winfo["{mac}"]

    return winfo
end
-- }}}

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
