global.path=0
if global.editor=0 && global.leveled=-1{
game_save("./save.sav")
file=file_bin_open("./save.sav",2)
file_bin_write_byte(file,room)
file_bin_seek(file,20)
file_bin_write_byte(file,global.level)
file_bin_close(file)
}
if global.leveled!=-1{Generate()}
with (Path) {instance_destroy()}
diss=0
if global.editor=0 && global.op_tit=1 or global.leveled!=-1{
diss=2
instance_create(0,0,L_Starter)}
inst=-1
global.good=0

mx=0
my=0
mz=0

Grinnys()

if global.editor=1{
global.l_title=""
global.l_author=""
}

SXMS2_MC_SetMasterVolume(100)

edimod=0


itemmo=1
