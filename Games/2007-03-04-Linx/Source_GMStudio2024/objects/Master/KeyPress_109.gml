if global.pause=0 && global.editor>0{
if keyboard_check(vk_shift){
global.pathx-=10
soundplay(Snd_Click)
} else {
global.pathx-=1
soundplay(Snd_Click)
}

if global.pathx<0 or global.pathx<global.path{global.pathx=0}
}

if global.editor=0 && room!=Level_00 and global.leveled=-1{
if registry_exists("Option_4"){
global.level-=1
room_goto_previous()
}
}

