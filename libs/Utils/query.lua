--will send ReQL queries to the server
local encode=require('./encode.lua')
local intlib=require('./intlib.lua')
local bytes=intlib.int_to_bytes
return function(reql)
	local token=reql.conn._getToken()
	local validEncode=encode(reql)
	local length=#validEncode
	local data=table.concat({bytes(token,8),bytes(length,4),validEncode})
	reql.conn._socket.write(data)
end