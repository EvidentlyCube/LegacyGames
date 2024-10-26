var maux,mauy,rotlf;

repeat(global.walls){
do {maux=floor(random(400))
mauy=floor(random(380))} until (
!place_meeting(floor(maux/20)*20,floor(mauy/20)*20,i_wall) && !place_meeting(floor(maux/20)*20,floor(mauy/20)*20,i_toggler)) 
instance_create(floor(maux/20)*20,floor(mauy/20)*20,i_wall)}
repeat(global.togs){rotlf=0
do{
maux=floor(random(400))
mauy=floor(random(380)) 
rotlf+=1
if rotlf=2000{break}}
until (!place_meeting(floor(maux/20)*20,floor(mauy/20)*20,i_wall) && !place_meeting(floor(maux/20)*20,floor(mauy/20)*20,i_toggler))

instance_create(floor(maux/20)*20,floor(mauy/20)*20,i_creator)
global.maxclick+=1
}

global.maxclick+=ceil(global.maxclick/2)

instance_create(0,0,i_master)
instance_destroy()
