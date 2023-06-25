
-- адреса переменных, инициализирующих скрипт. должны быть объединены одним тегом
setpoint = '0.05 - setpoint + status'
current = '0.05 - current temp'

--fan_speed_auto =  

-- прочие адреса
--fan_speed_setup =
mode = '0.05 - room mode'
heating_value = '0.05 - heating value'
heating_manual = '0.05 - heating manual'

ac_power = '0.05 - OnOffSetup_0105'
ac_mode = '0.05 - OperationModeSetup_0105'
ac_speed = '0.05 - FanSpeedSetup_0105'
ac_heat_temp = '0.05 - SetTempHeat_0105'
ac_cool_temp = '0.05 - SetTemp_0105'


--константы (значения), их можно записать в common function, чтобы они стали глобальными переменными и не указывать их в каждом скрипте)
PID_heat_min = 0
min_t = 10
max_t = 27
hist = 1.5 -- гистерезис
set_split = false

tr(setpoint, current, heating_value, heating_manual, PID_heat_min, min_t, max_t, hist,
ac_power, ac_mode, ac_speed , ac_heat_temp , ac_cool_temp, mode, set_split)
