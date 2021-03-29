---@class protocol
local protocol = {}
protocol.name = "text"
protocol.id = skynet.PTYPE_TEXT

protocol.pack = function(m) return tostring(m) end
protocol.unpack = skynet.tostring
---@param msg userdata
---@param sz number
---@return userdata, "data"|"more"
protocol.unpack = function(msg, sz)
    local queue
    local type = "data" or "more" or "error" or "open" or "close" or "warning"
    local id = 0
    -- result指针
    local ptr
    -- size可能有改动，不一定与sz一致
    local size = 0
    return queue, type, id, ptr, size
end
-- proto[prototype].dispatch(
--    session,
--    source,
--    proto[prototype].unpack(msg,sz))
--    queue,"data",id,ptr,size
protocol.dispatch = function(session, source, q, type, ...)

end

---@class c.skynet_socket_message
---@field type number @the type of message
---@field id number
---@field ud number
---@field buffer any

---@class c.skynet_message
---@field source any
---@field session any
---@field data any
---@field sz any

---@class lua.gate_server_handler
---@field connect function
---@field disconnect function
---@field error function
---@field command function
---@field message function
---@field open function | nil


--[[
skynet.register_protocol {
  name = "text",
  id = skynet.PTYPE_TEXT,
  pack = function(m) return tostring(m) end,
  unpack = skynet.tostring,
}
]]

--[[
local CMD = {}

skynet.dispatch("lua", function(session, source, cmd, ...)
  local f = assert(CMD[cmd])
  f(...)
end)
]]
---@alias c.dispatch_func fun(session:any, source:any, cmd:string, subcmd:string, ...):void
