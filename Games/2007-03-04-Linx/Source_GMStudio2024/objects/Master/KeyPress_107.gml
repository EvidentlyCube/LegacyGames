if global.pause=0 && global.editor>0{
if keyboard_check(vk_shift){
if global.pathx<global.path{global.pathx=global.path;soundplay(Snd_Click)} else {global.pathx+=10;soundplay(Snd_Click)}
} else {
if global.pathx<global.path{global.pathx=global.path;soundplay(Snd_Click)} else {global.pathx+=1;soundplay(Snd_Click)}
}

if global.pathx>168{global.pathx=168}
}
if global.editor=0 && room!=Level_40 and global.leveled=-1{
if registry_exists("Option_4"){
global.level+=1
room_goto_next()
}
}
