require('user.lutron')
value = event.getvalue()
-- round setmoint to integer
value = math.floor(value)  
tcp, err = lutron_login()
if not tcp then
  log('no connection to device', err)
end 
tcp:send('#HVAC,11,19,'..value..',0,0\r\n')