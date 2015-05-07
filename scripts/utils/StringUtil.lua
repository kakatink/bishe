--[[--

Split a string by string to map, string format like "123=2 222=3"

@param string str
@param string delimiter
@return map(note: type(key) == "string")

]]
function string.tomap(str, delimiter)
	delimiter = delimiter or " "
	local map = {}
	local array = string.split(string.trim(str), delimiter)
	for _, value in ipairs(array) do
		value = string.split(string.trim(value), "=")
		if #value == 2 then
			map[value[1]] = value[2]
		end
	end

	return map
end

--以数字形式存储
function string.toNumMap(str, delimiter)
	delimiter = delimiter or " "
	local map = {}
	local array = string.split(string.trim(str), delimiter)
	for _, value in ipairs(array) do
		value = string.split(string.trim(value), "=")
		if #value == 2 then
			map[tonum(value[1])] = tonum(value[2])
		end
	end

	return map
end

-- Format(xxx=xxx=xxx=xxx)
function string.toArray(str, delimiter)
	delimiter = delimiter or " "
	local array = {}
	local tempArray = string.split(string.trim(str), delimiter)
	for _, value in ipairs(tempArray) do
		if string.trim(value) ~= "" then
			table.insert(array, value)
		end
	end

	return array
end

-- Format(xxx=xxx=xxx=xxx xxx=xxx=xxx=xxx)
function string.toTableArray(str, delimiter)
	delimiter = delimiter or " "
	local array = {}
	local tempArray = string.split(string.trim(str), delimiter)
	for _, value in ipairs(tempArray) do
		local trimValue = string.trim(value)
		if trimValue ~= "" then
			value = string.split(trimValue, "=")
			table.insert(array, value)
		end
	end

	return array
end

-- 将string转化为多行
function string.toLineArray(s)
	local ts = {}
	local posa = 1
	while 1 do
		local pos, chars = s:match('()([\r\n].?)', posa)
		if pos then
			local line = s:sub(posa, pos - 1)
			ts[#ts + 1] = line
			if chars == '\r\n' then pos = pos + 1 end
			posa = pos + 1
		else
			local line = s:sub(posa)
			if line ~= '' then ts[#ts + 1] = line end
			break
		end
	end
	return ts
end
