--Remove kernel functs
for k,v in pairs(_ENV) do
	if (string.sub(k,1,1)=="_") then
		_ENV[k]=nil
	end
end