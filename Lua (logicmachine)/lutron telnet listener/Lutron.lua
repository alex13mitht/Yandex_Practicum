local socket = require("socket")

local user = 'default'
local password = 'default'
 
function lutron_connect()
    local tcp = assert(socket.tcp())
  tcp:settimeout(31)
    local res, err = tcp:connect('192.168.0.105', 23) 
  if res then
    return tcp
  else
    tcp:close()
    return nil, err
  end
end

function lutron_login()
  local tcp, tcp_err = lutron_connect()
  if not tcp then
    return nil,  tcp_err
  end
  tcp:receive(7)
  tcp:send(user..'\r\n')
    tcp:receive(10)
  tcp:send(password..'\r\n')
  local res = tcp:receive(9)
  if res == nil or res == 'bad login' then 
    tcp:close()
    return nil, res
  end
  return tcp
end
  
function lutron_receive(tcp)
 res, err = tcp:receive()
  if not res then
    tcp:close()
    return nil, err
  end
  return res
end