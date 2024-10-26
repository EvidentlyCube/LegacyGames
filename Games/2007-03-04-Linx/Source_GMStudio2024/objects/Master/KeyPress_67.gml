if global.pause=0 && global.editor>0{
global.pause=4;instance_create(0,0,L_Ed_Infer);soundplay(Snd_Click);
}
if global.editor=0{
with (Path){instance_destroy()}
}
