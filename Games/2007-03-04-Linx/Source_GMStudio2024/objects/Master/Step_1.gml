if global.pause=0{
if diss!=2{
mx=floor((mouse_x-16)/48)*48
my=floor((mouse_y-12)/48)*48
diss=0
if mx<96{mx=96;diss=1}
if mx>720{mx=720;diss=1}
if my<0{my=0;diss=1}
if my>528{my=528;diss=1}

global.path=instance_number(Path)
}

}
