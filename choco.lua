-- choco.lua
require("essentials")

local function getPackageList()
	local fh = io.popen("choco list --local-only")
	local str = fh:read("*a")
	fh:close()
	return str
end

local function parsePackageList(str)
	local tbl = string.split(str, "\n")
	
	-- remove Choco itself
	table.remove(tbl, 1)
	
	local numPackages = 0
	for k, prog in pairs(tbl) do
		if (prog:find("packages installed")) then
			numPackages = k
			break
		end
	end
	
	while (#tbl >= numPackages) do
		table.remove(tbl, k)
	end

	return tbl
end

local function getLocalPackages()
	local list = getPackageList()
	local tbl = parsePackageList(list)
	
	for k, prog in pairs(tbl) do
		local info = string.split(prog, " ")
		print(info[1])	
	end
end

getLocalPackages()