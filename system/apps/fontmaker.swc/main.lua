--[[
	Sparrow Font Maker
]]

include("poker.lua")

chars={
	[32]=" ",
	[33]="!",
	[34]="\"",
	[35]="#",
	[36]="$",
	[37]="%",
	[38]="&",
	[39]="'",
	[40]="(",
	[41]=")",
	[42]="*",
	[43]="+",
	[44]=",",
	[45]="-",
	[46]=".",
	[47]="/",
	[48]="0",
	[49]="1",
	[50]="2",
	[51]="3",
	[52]="4",
	[53]="5",
	[54]="6",
	[55]="7",
	[56]="8",
	[57]="9",
	[58]=":",
	[59]=";",
	[60]="<",
	[61]="=",
	[62]=">",
	[63]="?",
	[64]="@",
	[65]="A",
	[66]="B",
	[67]="C",
	[68]="D",
	[69]="E",
	[70]="F",
	[71]="G",
	[72]="H",
	[73]="I",
	[74]="J",
	[75]="K",
	[76]="L",
	[77]="M",
	[78]="N",
	[79]="O",
	[80]="P",
	[81]="Q",
	[82]="R",
	[83]="S",
	[84]="T",
	[85]="U",
	[86]="V",
	[87]="W",
	[88]="X",
	[89]="Y",
	[90]="Z",
	[91]="[",
	[92]="\\",
	[93]="]",
	[94]="^",
	[95]="_",
	[96]="`",
	[97]="a",
	[98]="b",
	[99]="c",
	[100]="d",
	[101]="e",
	[102]="f",
	[103]="g",
	[104]="h",
	[105]="i",
	[106]="j",
	[107]="k",
	[108]="l",
	[109]="m",
	[110]="n",
	[111]="o",
	[112]="p",
	[113]="q",
	[114]="r",
	[115]="s",
	[116]="t",
	[117]="u",
	[118]="v",
	[119]="w",
	[120]="x",
	[121]="y",
	[122]="z",
	[123]="{",
	[124]="|",
	[125]="}",
	[126]="~"
}
sprites={}
for i=32, 126 do
	sprites[i]=userdata("u8",16,16)
end

poke_font_information(16,16,16,0)

function _update()
	local mx,my,mb=mouse()
	local x,y=2,24
	for i=32, 126 do
		if (mx>=x and mx<x+32) then
			if (my>=y and my<y+32) then
				local rx,ry=mx-x,my-y
				rx=flr(rx/2)
				ry=flr(ry/2)
				printh("Over char "..chars[i].." ("..i..")")
				if (rx>=0 and ry>=0 and rx<32 and ry<32) then
					if (mb&0x1~=0) then
						sprites[i]:set(rx,ry,9)
					elseif (mb&0x2~=0) then
						sprites[i]:set(rx,ry,0)
					end
					if (mb~=0) then --char has updated; poke
						poke_character_bmp(sprites[i], i)
					end
				end
			end
		end
		x=x+32+2
		if (x>480-32-4) then
			x=2
			y=y+32+2
		end
	end
end


function _draw()
	cls(1)
	local x,y=2,24
	for i=32, 126 do
		rect(x,y,x+31,y+31,14)
		sspr(sprites[i],0,0,16,16,x,y,32,32)

		x=x+32+2
		if (x>480-32-4) then
			x=2
			y=y+32+2
		end
	end
	
--	print("The quick brown fox jumps over the lazy dog",0,0,9)
	print("ABCDEFGHIJKLMNOPQRSTUVWXYZ",0,0,9)
end