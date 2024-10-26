if place_meeting(x,y,mc_Color){
file=file_text_open_append("./bugs.txt")
file_text_write_string(file,"Type:Color  Name:"+object_get_name(object_index)+" XY: "+string(x)+":"+string(y))
file_text_close(file)
x=-random(99999)-100
y=-random(99999)-100
instance_destroy()
}

