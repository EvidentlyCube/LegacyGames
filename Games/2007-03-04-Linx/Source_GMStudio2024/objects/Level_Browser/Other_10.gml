if global.pause=0{
bunden=get_open_filename("Text File|*.txt",working_directory)
if file_exists(bunden){
Levels_Import(bunden)
Levels_Sort()
Levels_Base_Generate()
blibx=instance_create(0,0,LB_Note)
blibx.vara=numa
blibx.varb=numb
blibx.varc=numc
global.pause=1
}
}
