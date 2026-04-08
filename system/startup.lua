--[[
	Runs on startup after boot.lua
]]

--printh(";; Creating files")

load(_read("/system/api/load.lua"))()

store("readme.txt","Heya! Welcome to the Sparrow Workstation OS.")

--printh(";; Starting PM & WM")

_create_process(_read("/system/pm/main.lua"))

_create_process(_read("/system/wm/main.lua"))

--printh(";; Startup complete")