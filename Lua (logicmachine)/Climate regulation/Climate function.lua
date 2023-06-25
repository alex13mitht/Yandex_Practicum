------------ терморегулятор с кондиционером

function tr(setpoint, current, heating_value, heating_manual, PID_heat_min, min_t, max_t, hist,
    ac_power, ac_mode, ac_speed , ac_heat_temp , ac_cool_temp, mode, set_split)
      
      
      ---- получаем текущие значения текущей, уставки, 
      
      set_t = grp.getvalue(setpoint)
      cur_t = grp.getvalue(current)
      --проверка аварийных режимов
      if cur_t < min_t then
        grp.write( heating_manual, true)
        grp.write( heating_value, 100)
        if ac_power then
          grp.write(ac_power, false)
          end
        return
        elseif cur_t > max_t then
        grp.write( heating_manual, true)
        grp.write( heating_value, 0)
        if ac_power then
          grp.write(ac_power, true)
          grp.write(ac_mode, 1)
          grp.write(ac_speed, 2)
          end
        return
        end
      
        
      
      delta = set_t - cur_t
      ac_heat_temp_v = 28
      ac_cool_temp_v = 19
      -- таблица преобразования скоростей вентилятора
      st={
        [33] = 1,
        [66] = 3,
        [99] = 2
        }
      -- смена значения режима или его запрос
      if delta > hist then
        mode_v = 'heat'
        grp.checkwrite(mode, mode_v)
        elseif delta <-hist then
        mode_v = 'cool'
        grp.checkwrite(mode, mode_v)
        else
        mode_v = grp.getvalue(mode)
        end
      if mode_v~='cool' and mode_v ~= 'heat' then
        if delta>0 then
          mode_v = 'heat'
          grp.checkwrite(mode, mode_v)
          else
          mode_v = 'cool'
          grp.checkwrite(mode, mode_v)
          end
        end
      if mode_v == 'heat' then
        heating_manual_v = false
        if ac_power then
          
          ac_mode_v = 2
          
          if fan_speed_auto then
            fan_speed_auto_v = grp.getvalue(fan_speed_auto)
              else 
            fan_speed_auto_v = true
            end
          if fan_speed_auto_v then
            if delta <1 then
              ac_power_v = false
              ac_mode_v = 3
              ac_speed_v = 1
              elseif delta >1 and delta <= 2 then
              ac_power_v = true
              ac_speed_v = 1
              elseif delta >2 and delta <= 3 then
              ac_power_v = true
              ac_speed_v = 3
              elseif delta >3 then
              ac_power_v = true
              ac_speed_v = 2
              end
            else
            fan_speed_setup_v = grp.getvalue(fan_speed_setup)
            fan_speed_setup_v = st[fan_speed_setup_v]
            end
          end
        -------------------------------------
        --по заданию  16 05 2022 отключаем кондиционеры из режима отопления
        ac_power_v = false
        --------------------------------------
        elseif mode_v == 'cool' then
        
        heating_manual_v = true
        heating_value_v = PID_heat_min
        if ac_power then
          ac_mode_v = 1
            if fan_speed_auto then
            fan_speed_auto_v = grp.getvalue(fan_speed_auto)
              else 
            fan_speed_auto_v = true
            end
          if fan_speed_auto_v then
            if delta >0 then
              ac_power_v = true
              ac_mode_v = 3
              ac_speed_v = 1
              
              ------------------ только в хозяйский спальнях кондей выключаем, а не переводим в вентиляцию, ибо воздух забирается из соседнего помещения--------
              if setpoint == '1.37 - setpoint + status' or setpoint =='1.36 - setpoint + status' then
                ac_power_v = false
                ac_speed_v = 1
                end
              
              elseif delta <0 and delta >= -1 then
              ac_power_v = true
              ac_speed_v = 1
              elseif delta <-1 and delta >= -2 then
              ac_power_v = true
              ac_speed_v = 3
              elseif delta <-2 then
              ac_power_v = true
              ac_speed_v = 2
              end
            else
            fan_speed_setup_v = grp.getvalue(fan_speed_setup)
            fan_speed_setup_v = st[fan_speed_setup_v]
            end
          end
        end
      --записываем получившиеся значения
      
        grp.write(heating_manual, heating_manual_v)
      if heating_manual_v then
        grp.write(heating_value, heating_value_v)
        end
      if ac_power then
        grp.write(ac_power , ac_power_v)
        grp.write(ac_mode, ac_mode_v)
        grp.write(ac_speed, ac_speed_v)
        if set_split then
          if mode_v == 'heat' then
            grp.write(ac_heat_temp, ac_heat_temp_v)
            elseif mode_v == 'cool' then
            grp.write(ac_cool_temp, ac_cool_temp_v)
            end
          else
          if mode_v == 'heat' then
            grp.write(ac_cool_temp, ac_heat_temp_v)
            elseif mode_v == 'cool' then
            grp.write(ac_cool_temp, ac_cool_temp_v)
            end
          end
        end
      end
    