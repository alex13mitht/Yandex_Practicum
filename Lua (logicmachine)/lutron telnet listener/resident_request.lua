require('user.lutron')

--Подключаемся и делаем запрос
tcp, err = lutron_login()
if not tcp then
  log('no connection to device', err)
else
  -- send some request
  tcp:send('?HVAC,11,15\r\n')
  -- and receive answer
  x = tcp:receive()
  -- log answer, or write it to message address
  log(x)
  tcp:close()
end