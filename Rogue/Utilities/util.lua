function output(data)
	file = love.filesystem.newFile("log.txt")
	file:open("w")
	file:write(data)
end

local function serializeImpl( t, tTracking )
	local sType = type(t)
	if sType == "table" then
		if tTracking[t] ~= nil then
			error( "Cannot serialize table with recursive entries" )
		end
		tTracking[t] = true
		local result = "{"
		for k,v in pairs(t) do
			result = result..("["..serializeImpl(k, tTracking).."]="..serializeImpl(v, tTracking)..",")
		end
		result = result.."}"
		return result
	elseif sType == "string" then
		return string.format( "%q", t )
	elseif sType == "number" or sType == "boolean" or sType == "nil" then
		return tostring(t)
	else
		error( "Cannot serialize type "..sType )
	end
end

function serialize( t )
	local tTracking = {}
	return serializeImpl( t, tTracking )
end

function unserialize( s )
	local func, e = loadstring( "return "..s, "serialize" )
	if not func then
		return s
	else
		setfenv( func, {} )
		return func()
	end
end