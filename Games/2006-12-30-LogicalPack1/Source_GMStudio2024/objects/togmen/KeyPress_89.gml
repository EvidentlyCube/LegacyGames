global.togs=get_integer("Type how many clicks you want to start with (Max 250):",global.togs)
if global.togs<1{global.togs=1}
if global.togs>250{global.togs=250}
global.walls=get_integer("Type how many walls you want to have (Max 250):",global.walls)
if global.walls<0{global.walls=0}
if global.walls>250{global.walls=250}
global.maxclick=0
global.click=0
room_goto(i_RLG)
