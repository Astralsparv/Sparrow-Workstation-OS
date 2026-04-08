--[[
	head.lua
]]

--- Stores serialised data at the given path.
--- @param   path string     The location of the file 
--- @param   data any        The data to store
--- @param   meta table|nil  The metadata to store in the file
--- @returns err? string     Error if failed
function store(path,data,meta)
	if (type(meta)~="table") then
		meta={}
	end
	if (not data) then
		return "Data is nil"
	end
	local proc_data=data
	if (not meta.no_serialise) then --{no_serialise=true} to write as raw text file
		proc_data=_serialise(proc_data)
	end
	local res=proc_data
	if (meta.format~="none") then --{format="none"} to write without metadata
		meta.type=type(data) --for unserialising
		local meta=_serialise(meta) --metadata serialised
		res="--[metadata]"..meta.."[metadata]\n"..res
	end
	_write(path,res)
	return nil
end

--- Reads serialised data from the given path.
--- @param  path    string          The location of the file 
--- @param  options table|nil       Optional settings for fetching
--- @returns data?  any             File data if found, otherwise nil
--- @returns meta?  table           Metadata of the file, if present
--- @returns err?   string          Error if failed, otherwise nil
function fetch(path,options)
	if (type(options)~="table") then
		options={}
	end
	local raw=_read(path)
	if (not raw) then
		return nil,nil,"No data"
	end
	if (options.raw) then
		return raw,nil
	end
	--process it
	local meta_end=string.find(raw,"[metadata]\n",1,true)
	local meta
	local data
	if (not meta_end) then
		-- no meta found, return string
		meta={}
		data=raw
	else
		local meta_str=string.sub(raw,13,meta_end-1) --[metadata] is 12 chars, offset by this
		local data_str=string.sub(raw,meta_end+11)
		--convert meta to table
		local ok
		ok,meta=pcall(load("return "..meta_str))
		if (not ok) then
			meta=nil
		end
		--convert data to its actual format
		--(e.g: serialised table to {}, userdata to real userdata)
		ok,data=pcall(load("return "..data_str))
		if (not ok) then
			return nil,nil,"Failed to acquire data: "..tostring(data)
		end
	end

	return data,meta,nil
end

--- Runs the code from the file located at path and returns it
--- @param   path   string  The location of the file
--- @returns result any?    The result of the code; if there is one
function include(path)
	local code=fetch(path)
	if (not code) then
		error("Failed to include "..path,2)
	else
		local func,err=load(code)
		if (not func) then
			error("Failed to include "..path..", error: "..tostring(err))
		end
		return func()
	end
end

function is_cart(path)
	local ext=file_extension(path)
	return (ext=="swc")
end

function file_extension(path)
	local ext=path
	local e=string.find(ext,"%.")
	if (not e) then
		return nil
	end
	while (e) do
		ext=string.sub(ext,e+1)
		e=string.find(ext,"%.")
	end
	return ext
end

--- Creates a new process from a file containing Lua code
--- @param   path string   The location of the file
--- @returns pid  integer  The process id of the newly made process
function create_process(path)
	local root=path
	if (is_cart(path)) then
		path=path.."/main.lua"
	else
		root=root --add support for this my dear friend.
				  --scheisse, tis no one to do it for me.
	end
	local rawcode=fetch(path)
	if (not rawcode) then
		error("Failed to fetch file contents")
	else
		local code=[[load(_read("/system/api/load.lua"))()
--include("/system/api/safety.lua")
cd("]]..root..[[")
include("]]..path..[[")]]
		return _create_process(code)
	end
end