require('user.lutron')
  
tcp, err = lutron_login()
if not tcp then
  log('no connection to device', err)
end 
while tcp do
  res, err = lutron_receive(tcp)
  --log(res,err)
    if (res == nil) then
      return
    else
      grp.write('15/1/1', res)
    end
end