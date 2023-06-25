--log(getmetatable(db))

y = 120
y_step = 75
start_id = knxlib.encodega('3/0/1')
floor_num = 2
for i = 1, 38 do
id = start_id +i -1

log(grp.alias(knxlib.decodega(id)))
res, err = db:insert('visobjects', {
  object = nil,
  statusobject = nil,
  type = 6,
  floor = floor_num,
  locx = 6,
  locy = y + 15,
  nobg = 1,
  notouch = 0,
  readonly = 0,
  sortorder = 4*i-3,      
  name = grp.alias(knxlib.decodega(id)):split('_')[1],
  params = '{"size":14,"color":"","font":"","bold":0,"italic":0,"underline":0}',
})
--кнопка управления
res, err = db:insert('visobjects', {
  object = id,
  statusobject = id,
  type = 0,
  floor = floor_num,
  locx = 311,
  locy = y,
  nobg = 1,
  notouch = 0,
  readonly = 0,
  sortorder = 4*i-2,
  name = grp.alias(knxlib.decodega(id)):split('_')[1],
  params = '{"size":"","bold":0,"italic":0,"underline":0,"width":50,"height":50,"icon_on":"control-play.svg","icon_off":"control-play.svg","icon_touch":"","icons_add":[],"displaymode":"icon","showcontrol":0,"fixedvalue":"1","update":false,"widget":null,"backdrop":0}',
})

--кнопка статуса реле
res, err = db:insert('visobjects', {
  object = id+256,
  statusobject = id+256,
  type = 0,
  floor = floor_num,
  locx = 386,
  locy = y,
  nobg = 1,
  notouch = 0,
  readonly = 1,
  sortorder = 4*i-1,
  name = grp.alias(knxlib.decodega(id+256)):split('_')[1],
  params = '{"size":"","bold":0,"italic":0,"underline":0,"width":50,"height":50,"icon_on":"bulb-active.svg","icon_off":"bulb.svg","icon_touch":"","icons_add":[],"displaymode":"icon","showcontrol":0,"fixedvalue":"1","update":false,"widget":null,"backdrop":0}',
})

--кнопка статуса автомата
res, err = db:insert('visobjects', {
  object = id+512,
  statusobject = id+512,
  type = 0,
  floor = floor_num,
  locx = 461,
  locy = y,
  nobg = 1,
  notouch = 0,
  readonly = 1,
  sortorder = 4*i,
  name = grp.alias(knxlib.decodega(id+512)):split('_')[1],
  params ='{"size":"","bold":0,"italic":0,"underline":0,"width":50,"height":50,"icon_on":"ok.svg","icon_off":"cancel-active.svg","icon_touch":"","icons_add":[],"displaymode":"icon","showcontrol":0,"fixedvalue":"1","update":false,"widget":null,"backdrop":0}',
})

y = y + y_step
end
log('Максимальная высота = '..y)