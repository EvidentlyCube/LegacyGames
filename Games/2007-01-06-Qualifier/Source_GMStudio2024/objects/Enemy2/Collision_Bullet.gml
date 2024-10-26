with (other) {
action_kill_object();
}
hit=1
hp-=1
global.acc+=1
if !sound_isplaying(pyk1){
sound_play(pyk1)
}
