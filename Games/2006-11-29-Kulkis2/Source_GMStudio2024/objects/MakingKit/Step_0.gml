if keyboard_check(ord("1")){kibol=Blockers;}
if keyboard_check(ord("2")){kibol=Button;}
if mouse_check_button(mb_right){
a=instance_nearest(mouse_x,mouse_y,all)
b=object_get_name(a.object_index)
if b="Button"{type=1;exit}
type=2;exit
}
if mouse_check_button(mb_middle){
a=instance_nearest(mouse_x,mouse_y,kibol)
b=object_get_name(a.object_index)
if b="Button"{type=1;exit}
type=2;exit
}
if type=2{
if keyboard_check_pressed(vk_left){
with(a){image_index-=1}
}
if keyboard_check_pressed(vk_right){
with(a){image_index+=1}
}
if keyboard_check_pressed(vk_enter){
with(a){MakingKit.code+="("+string(MakingKit.a)+").image_single="+string(image_single)+";"}
}
}
if type=1{
if keyboard_check_pressed(vk_down){if c<5{c+=1}}
if keyboard_check_pressed(vk_up){if c>0{c-=1}}
if c=0{d="Number OF Actions"}
if c=1{d="Type Of Action"}
if c=2{d="Type of GFX/thing"}
if c=3{d="Position"}
if c=4{d="Button Type"}
if c=5{d="Current Action Number"}

if c=0{
if keyboard_check_pressed(vk_left) && e>2{e-=1}
if keyboard_check_pressed(vk_right) && e<11{e+=1}
}

if c=1{
if keyboard_check_pressed(vk_left) && f[act]>0{f[act]-=1}
if keyboard_check_pressed(vk_right) && f[act]<3{f[act]+=1}
if f[act]=0{g[act]="Create Wall"}
if f[act]=1{g[act]="Destroy Wall"}
if f[act]=2{g[act]="Toogle Wall"}
if f[act]=3{g[act]="Create Item"}
}

if c=2{
if f[act]=0{
if keyboard_check_pressed(vk_left) && h[act]>0{h[act]-=1}
if keyboard_check_pressed(vk_right) && h[act]<sprite_get_number(S_Blockers){h[act]+=1}
}
if f[act]=1{
h[act]=0
}
if f[act]=2{
if keyboard_check_pressed(vk_left) && h[act]>0{h[act]-=1}
if keyboard_check_pressed(vk_right) && h[act]<sprite_get_number(S_Blockers){h[act]+=1}
}
if f[act]=3{
if keyboard_check_pressed(vk_left) && h[act]>0{h[act]-=1}
if keyboard_check_pressed(vk_right) && h[act]<5{h[act]+=1}
if h[act]=0{i[act]=S_Crate;j[act]=Crate;}
if h[act]=1{i[act]=S_StellCrate;j[act]=StellCrate;}
if h[act]=2{i[act]=S_Barrel;j[act]=Barrel;}
if h[act]=3{i[act]=S_Bomb;j[act]=Bomb;}
if h[act]=4{i[act]=S_DiamondA;j[act]=DiamondA;}
if h[act]=5{i[act]=S_DiamomdB;j[act]=DiamondB;}
}
}

if c=3{
if mouse_check_button(mb_left){m[act]=floor(mouse_x/20)*20;n[act]=floor(mouse_y/20)*20}
}

if c=4{
if keyboard_check_pressed(vk_left) {k=0;l="Infinite"}
if keyboard_check_pressed(vk_right) {k=1;l="Disposable"}
}

if c=5{
if keyboard_check_pressed(vk_left) && act>1{act-=1}
if keyboard_check_pressed(vk_right) && act<e{act+=1}
}

if keyboard_check_pressed(vk_control){o*=-1}

if keyboard_check_pressed(vk_enter){
for(i=1;i<e;i+=1){
code+="("+string(a)+").type["+string(i)+"]="+string(f[i])+";"
code+="("+string(a)+").add["+string(i)+"]="+string(h[i])+";"
code+="("+string(a)+").ix["+string(i)+"]="+string(m[i])+";"
code+="("+string(a)+").iy["+string(i)+"]="+string(n[i])+";"
}
code+="("+string(a)+").numb="+string(e)+";"
if o<0{o=0}
code+="("+string(a)+").vis="+string(o)+";"
code+="("+string(a)+").buttyp="+string(k)+";"
o=1
}

}
