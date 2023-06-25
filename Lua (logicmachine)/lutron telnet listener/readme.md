пример интеграции контроллера LogicMachine с контроллером Lutron Homework QS посредством Telnet.

реализована в 2016 году и выложена на международном форуме. описание сохраню на английском

I made function (with Admin's big help), which will show you what Lutron send by telnet
I have lutron Homework QS

create user libruary "lutron" (lutron.lua)

and resident script (resident.lua)


some additions for that case
Lutron message parser
For example I shall show you how to receive setpoint temperature from Lutron panel/switch
Let’s write all messages from Lutron to knx group address

From Lutron we receive a lot of messages when we change setpoint
For example, this 4 message we will receive twice, when we will change setpoint:
~HVAC,11,78,26,26 – i dont know what is it
~HVAC,11,18,79,0,0 – setpoint in Fahrenheit
~HVAC,11,19,26,0,0 -- setpoint in Celsius degree
~HVAC,11,10,26,26 -- i dont know what is it
 
Let’s see, what we have in  setpoint in Celsius degree
~HVAC,11,19,26,0,0
~HVAC – status from device
11 – device id, which send this message
19 – type of information (Celsius degree in this example)
26 - Celsius degree
0,0 – some other parameters
To parse this message and write temperature to knx address create event based script for message group address (15/1/1) (event_parser.lua)

To write value from LM to Lutron create event script for setpoint object (event_sender.lua)

to read some data from lutron use next script (resident in my case) (resident_request.lua)



