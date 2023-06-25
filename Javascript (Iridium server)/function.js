function floor_heating(dtp, name, value) {
    base = name.split("-")[0];
    IR.Log(name);
    room = base.split(".")[1];
    write_name =  room + "-Relay_ctrl";
    IR.Log(write_name);
    en = IR.GetVariable("Drivers." + base + "-Enable");
    cur = IR.GetVariable("Drivers." + base + "-Current temp");
    set = IR.GetVariable("Drivers." + base + "-Setpoint");
    if (en) {
        IR.Log("разрешено, сравни температуру");
        if (cur < set) {
            IR.GetDevice("KNX").Set(write_name, true);
            IR.Log("уставка выше, включаем");
            } else {
            IR.GetDevice("KNX").Set(write_name, false);
            IR.Log("уставка ниже, вЫключаем");
            };
        } else {
        IR.Log("Запрещено, ВЫКЛЮЧАЕМ");
        IR.GetDevice("KNX").Set(write_name, false);
        
        };
    };
 