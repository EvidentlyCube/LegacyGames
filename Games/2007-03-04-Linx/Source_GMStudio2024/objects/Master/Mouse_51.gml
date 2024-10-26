if global.pause=0 && !mouse_check_button(mb_left){
if global.editor!=1{
if diss=0{
if place_meeting(mx,my,Path) {
soundplay(Snd_Break)
with (instance_place(mx,my,Path)){instance_destroy()}
with (Path) {reBLAing()}
global.good=1
with (Base) {Basing()}
}
}
}

if global.editor=1{

if place_meeting(mx,my,Path) {
with (instance_place(mx,my,Path)){instance_destroy()}
global.good=0
}

if place_meeting(mx,my,Base) {
with (instance_place(mx,my,Base)){instance_destroy()}
global.good=0
}

if place_meeting(mx,my,Block) {
with (instance_place(mx,my,Block)){instance_destroy()}
global.good=0
}
}

}
