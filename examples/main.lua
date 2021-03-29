local skynet = require "skynet"
local sprotoloader = require "sprotoloader"

local max_client = 64
skynet.start(function()
	skynet.error("Server start")
	skynet.uniqueservice("protoloader")
	if not skynet.getenv "daemon" then
		local console = skynet.newservice("console")
	end
	skynet.newservice("debug_console",8000)
	skynet.newservice("simpledb")
	--- 启用watchdog服务，其中启用了gate服务，gate注册了gateserver的handler
	local watchdog = skynet.newservice("watchdog")
	--- 调用watchdog中CMD.start，其中调用了gateserver的CMD.open函数
	--- 代表watchdog和gate开始工作，gate开始接受socket事件
	skynet.call(watchdog, "lua", "start", {
		port = 8888,
		maxclient = max_client,
		nodelay = true,
	})
	skynet.error("Watchdog listen on", 8888)
	skynet.exit()
end)
