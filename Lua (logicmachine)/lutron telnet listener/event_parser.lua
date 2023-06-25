--lutron parser
-- get string
temp = event.getvalue()
-- convert sting to table
temp = string.split(temp, ',')
-- if comand type is ~HVAC let's move forward
if temp[1] == '~HVAC' then
    -- if device id = id of our panel let's move forward
    if temp[2] == '11' then -- be carefull, temp[2] is string, not number
        -- if in message is celsius degree
        if temp[3] == '19' then
            -- convert temperature from string to number
            temp = tonumber(temp[4])
            -- check current value of setpoint, to not to write the same value
            cur_temp = grp.getvalue('lutron_temp_setpoint')
            if temp~=cur_temp then
                -- write walue to temp address
                grp.write('lutron_temp_setpoint', temp)
            end
        end
    end
end