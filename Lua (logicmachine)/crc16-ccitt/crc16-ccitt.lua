data = ('njhyTFGV')
init = 0xffff
crc = init
function crc16_ccitt(crc, data)
  msb = bit.rshift(crc , 8)
  lsb = bit.band(crc , 255)
  --log(msb, lsb)
  for i = 1, #data do
    strb = string.byte(data, i, i)
    x = bit.bxor(strb, msb)
    --log(strb,msb, x)
    x = bit.bxor(x,  bit.rshift(x,4))
    --log(x)
    msb = bit.band(bit.bxor(lsb , bit.rshift(x , 3) , bit.lshift(x , 4)) , 255)
    lsb = bit.band(bit.bxor(x , bit.lshift(x , 5)) , 255)
    log(msb, lsb, x)
    end
  res = lsb + bit.lshift(msb, 8)
  return res , string.format('%x', res)
end
  
log(crc16_ccitt(crc, data))