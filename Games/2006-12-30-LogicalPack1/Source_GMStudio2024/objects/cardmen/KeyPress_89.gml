global.wid=get_integer("How wide(max 20):",global.wid)
if global.wid<1{global.wid=1}
if global.wid>20{global.wid=20}
global.hei=get_integer("How high(Max 19):",global.hei)
if global.hei<0{global.hei=0}
if global.hei>19{global.hei=19}
global.maxclick=0
global.click=0
room_goto(ii_RLG)
