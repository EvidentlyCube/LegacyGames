if global.pause=0{
x-=spd
if x<0-sprite_width-20{
sprite_delete(sprite_index)
instance_destroy()
}}
