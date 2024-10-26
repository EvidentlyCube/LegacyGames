var maux,mauy;
repeat (global.wid*global.hei){
 do {
  maux=(floor(random(global.wid)))*20+floor((400-global.wid*20)/40)*20
  mauy=(floor(random(global.hei)))*20+floor((380-global.wid*20)/40)*20+20
 } 
 until 
 (
  !place_meeting(maux,mauy+380,ii_objectivers)
 )
 instance_create(maux,mauy+380,ii_objplaces)
}

instance_create(0,0,ii_master)
instance_destroy()
