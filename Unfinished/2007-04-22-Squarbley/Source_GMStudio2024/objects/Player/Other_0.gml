global.move=1
global.pxmove=xmove
global.pymove=ymove
if x>room_width{
global.px=-10
global.py=y
}
if x<0{
global.px=room_width+10
global.py=y
}
if y>room_height{
global.px=x
global.py=-10
}
if y<0{
global.px=x
global.py=room_height+10
}

switch (room) {
case (Test_Room1):room_goto(Test_Room2);break;
case (Test_Room2):room_goto(Test_Room1);break;
}
