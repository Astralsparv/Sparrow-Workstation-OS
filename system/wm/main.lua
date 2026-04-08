--[[
	Sparrow Window Manager

	Renders programs; this process is what gets rendered by the executable
]]

--printh(";- WM Running")

--i need sprites oh my LORD

load(_read("/system/api/load.lua"))()

local mouseSprite=userdata("u8",5,5)
set_draw_target(mouseSprite)
cls(9)
reset_draw_target()

create_process("/system/apps/fontmaker.swc")
function _update()
	
end

local liveud=_get_dynamic_process_display(4)
function _draw()
	if (liveud) then
		spr(liveud,0,0)
	else
		printh("No Display UD")
	end
	local mx,my,mb=mouse()
	spr(mouseSprite,mx,my)
end