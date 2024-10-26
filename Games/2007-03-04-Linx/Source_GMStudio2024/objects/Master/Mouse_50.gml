if global.pause=0 && !mouse_check_button(mb_right){
    if global.editor!=1{
        if place_meeting(mx,my,Base){
            if mz!=mx+my{soundplay(Snd_Click);mz=mx+my}
            inst=(instance_place(mx,my,Base)).shmai
        }
        if global.path<global.pathx or global.pathx=0{
            if diss=0{
                if place_meeting(mx,my,Path) && global.du=1{
                    with (instance_place(mx,my,Path)){instance_destroy()}
                }               

                if !place_meeting(mx,my,Block) && !place_meeting(mx,my,Base) && !place_meeting(mx,my,Path)&& inst!=-1{
                    if mz!=mx+my{soundplay(Snd_Place);mz=mx+my}
                    instance_create(mx,my,inst)
                    with (Path) {reBLAing()}
                    global.good=1
                    with (Base) {Basing()}
                    if global.good=1 && global.editor=0{
                        diss=2
                        if !instance_exists(L_Ender){instance_create(0,0,L_Ender)}
                    }                   
                }
            }
        }
    }

    if global.editor=1{
        if diss=0 &&inst!=-1{
            if place_meeting(mx,my,Base) && global.du=1{
                with (instance_place(mx,my,Base)){instance_destroy()}
            }

            if place_meeting(mx,my,Block) && global.du=1{
                with (instance_place(mx,my,Block)){instance_destroy()}
            }
    
            if place_meeting(mx,my,Path) && global.du=1{
                with (instance_place(mx,my,Path)){instance_destroy()}
            }

            if !place_meeting(mx,my,Block) && !place_meeting(mx,my,Base) && !place_meeting(mx,my,Path){
                if mz!=mx+my{soundplay(Snd_Place);mz=mx+my}
                instance_create(mx,my,inst)
                global.good=0
            }
        }
    }
}
