--[[
	Sparrow Workstation
	
	Runs first thing and handles boot
]]

--printh("** Boot Sequence **")

--printh("** Startup.lua **")

printh(_serialise({1,2,3}))

load(_read("/system/startup.lua"))()

--printh("** Boot Complete **")

function _update()
	local processes=_get_processes()
	--printh("--Process Loop      --")
	for i=2, #processes do --proc 1 == boot
		local p=processes[i]
        --printh("Process: "..p.id)
        --printh("MEM: "..p.memory)
        --printh("CPU (INST): "..p.cpu)
        --printh("CPU: "..p.cpu/16000)
        --printh("")
		_run_process_slice(p.id,1) --all cpu 1 (100%/16K instructions)
	end
	--printh("--Process Loop Over --")
end