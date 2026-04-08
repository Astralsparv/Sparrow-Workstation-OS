function poke_font_information(topcharwidth,bottomcharwidth,charheight,tabwidth)
	poke(0x120011,topcharwidth or 0)
	poke(0x120012,charheight or 0)
	poke(0x120013,bottomcharwidth or 0)
	poke(0x120014,tabwidth or 0) --currently defunct.
end

local function signed_nibble(val)
    val = val or 0
    if val < 0 then val = 0x10 + val end
    return val & 0xF
end

function poke_width_adjustments(chars)
    chars = chars or {}
    for i = 0, 255, 2 do
        local high = signed_nibble(chars[i])
        local low  = signed_nibble(chars[i+1])
        local byte = (low << 4) | high
        poke(0x120020 + (i >> 1), byte)
    end
end

--Pokes a 16x16 bitmap into character index
--starts 0x1200b0
--32 bytes per char
function poke_character_bmp(bmp, index)
    local addr = 0x1200B0 + index*32
    for y = 0, 15 do
        for x = 0, 15 do
            local byteIndex = y*2 + math.floor(x/8)
            local bit = 7 - (x % 8)
            local b = peek(addr + byteIndex) or 0
            if bmp:get(x,y) ~= 0 then
                b = b | (1 << bit)
            else
                b = b & ~(1 << bit)
            end
            poke(addr + byteIndex, b)
        end
    end
end