movx=0
movy=0
image_speed=0.4
oldx=x
oldy=y
draw=0
with (DoorOp){
var tile;
image_speed=0
tile=tile_layer_find(1100,x,y)
if tile_exists(tile){
type=floor(tile_get_left(tile)/20)
tile_layer_delete_at(1100,x,y)
} else {type=0}
gfx=-1}
with (DoorCl){
var tile;
image_speed=0
tile=tile_layer_find(1100,x,y)
if tile_exists(tile){
type=floor(tile_get_left(tile)/20)
tile_layer_delete_at(1100,x,y)
} else {type=0}
gfx=-1}
with (DoorOp){
var r,d,l,u,dr,dl,ur,ul,tile;
r=0
d=0
l=0
u=0
dr=0
dl=0
ur=0
ul=0

tile=instance_place(x+20,y,DoorOp)
if instance_exists(tile){if tile.type=type{r=1}}

tile=instance_place(x,y+20,DoorOp)
if instance_exists(tile){if tile.type=type{d=1}}

tile=instance_place(x-20,y,DoorOp)
if instance_exists(tile){if tile.type=type{l=1}}

tile=instance_place(x,y-20,DoorOp)
if instance_exists(tile){if tile.type=type{u=1}}

tile=instance_place(x+20,y-20,DoorOp)
if instance_exists(tile){if tile.type=type{ur=1}}

tile=instance_place(x+20,y+20,DoorOp)
if instance_exists(tile){if tile.type=type{dr=1}}

tile=instance_place(x-20,y+20,DoorOp)
if instance_exists(tile){if tile.type=type{dl=1}}

tile=instance_place(x-20,y-20,DoorOp)
if instance_exists(tile){if tile.type=type{ul=1}}

if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=19}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=20}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=25}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=26}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=35}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=36}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=37}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=38}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=39}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=40}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=41}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=42}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=43}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=44}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=45}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=46}
if u=1 && ur=1 && r=1 && d=0  && l=1 && ul=1 && gfx=-1{gfx=1}
if u=1 && ur=0 && r=1 && d=0  && l=1 && ul=1 && gfx=-1{gfx=2}
if u=1 && ur=1 && r=1 && d=0  && l=1 && ul=0 && gfx=-1{gfx=3}
if u=1 && ur=0 && r=1 && d=0  && l=1 && ul=0 && gfx=-1{gfx=4}
if u=1 && r=0  && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=6}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && l=0  && gfx=-1{gfx=11}
if u=1 && r=0  && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=12}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && l=0  && gfx=-1{gfx=17}
if u=1 && r=0  && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=18}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && l=0  && gfx=-1{gfx=23}
if u=1 && r=0  && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=24}
if u=0 && r=1 && dr=0 && d=1 && dl=0 && l=1  && gfx=-1{gfx=31}
if u=0 && r=1 && dr=0 && d=1 && dl=1 && l=1  && gfx=-1{gfx=32}
if u=0 && r=1 && dr=1 && d=1 && dl=0 && l=1  && gfx=-1{gfx=33}
if u=0 && r=1 && dr=1 && d=1 && dl=1 && l=1  && gfx=-1{gfx=34}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && l=0  && gfx=-1{gfx=29}
if u=1 && ur=1 && r=1 && d=0 && l=0   && gfx=-1{gfx=13}
if u=1 && r=0  && d=0 && l=1 && ul=1  && gfx=-1{gfx=14}
if u=1 && ur=0 && r=1 && d=0 && l=0   && gfx=-1{gfx=15}
if u=1 && r=0  && d=0 && l=1 && ul=0  && gfx=-1{gfx=16}
if u=0 && r=1 && dr=1 && d=1  && l=0  && gfx=-1{gfx=7}
if u=0 && r=0 && d=1  && dl=1 && l=1  && gfx=-1{gfx=8}
if u=0 && r=1 && dr=0 && d=1  && l=0  && gfx=-1{gfx=9}
if u=0 && r=0 && d=1  && dl=0 && l=1  && gfx=-1{gfx=10}
if u=0 && r=0 && d=0 && l=0 && gfx=-1 {gfx=0}
if u=1 && r=0 && d=1  && l=0 && gfx=-1 {gfx=5}
if u=0 && r=0  && d=1 && l=0 && gfx=-1 {gfx=21}
if u=0 && r=0 && d=0  && l=1 && gfx=-1 {gfx=22}
if u=0 && r=1 && d=0  && l=0 && gfx=-1 {gfx=27}
if u=1 && r=0 && d=0  && l=0 && gfx=-1 {gfx=28}
if u=0 && r=1  && d=0 && l=1 && gfx=-1 {gfx=30}
}
with (DoorCl){
var r,d,l,u,dr,dl,ur,ul,tile;
r=0
d=0
l=0
u=0
dr=0
dl=0
ur=0
ul=0

tile=instance_place(x+20,y,DoorCl)
if instance_exists(tile){if tile.type=type{r=1}}

tile=instance_place(x,y+20,DoorCl)
if instance_exists(tile){if tile.type=type{d=1}}

tile=instance_place(x-20,y,DoorCl)
if instance_exists(tile){if tile.type=type{l=1}}

tile=instance_place(x,y-20,DoorCl)
if instance_exists(tile){if tile.type=type{u=1}}

tile=instance_place(x+20,y-20,DoorCl)
if instance_exists(tile){if tile.type=type{ur=1}}

tile=instance_place(x+20,y+20,DoorCl)
if instance_exists(tile){if tile.type=type{dr=1}}

tile=instance_place(x-20,y+20,DoorCl)
if instance_exists(tile){if tile.type=type{dl=1}}

tile=instance_place(x-20,y-20,DoorCl)
if instance_exists(tile){if tile.type=type{ul=1}}

if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=19}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=20}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=25}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=26}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=35}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=36}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=37}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=38}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=39}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=40}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=41}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=42}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=43}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=44}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=45}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=46}
if u=1 && ur=1 && r=1 && d=0  && l=1 && ul=1 && gfx=-1{gfx=1}
if u=1 && ur=0 && r=1 && d=0  && l=1 && ul=1 && gfx=-1{gfx=2}
if u=1 && ur=1 && r=1 && d=0  && l=1 && ul=0 && gfx=-1{gfx=3}
if u=1 && ur=0 && r=1 && d=0  && l=1 && ul=0 && gfx=-1{gfx=4}
if u=1 && r=0  && d=1 && dl=1 && l=1 && ul=1 && gfx=-1{gfx=6}
if u=1 && ur=0 && r=1 && dr=0 && d=1 && l=0  && gfx=-1{gfx=11}
if u=1 && r=0  && d=1 && dl=0 && l=1 && ul=1 && gfx=-1{gfx=12}
if u=1 && ur=1 && r=1 && dr=0 && d=1 && l=0  && gfx=-1{gfx=17}
if u=1 && r=0  && d=1 && dl=1 && l=1 && ul=0 && gfx=-1{gfx=18}
if u=1 && ur=0 && r=1 && dr=1 && d=1 && l=0  && gfx=-1{gfx=23}
if u=1 && r=0  && d=1 && dl=0 && l=1 && ul=0 && gfx=-1{gfx=24}
if u=0 && r=1 && dr=0 && d=1 && dl=0 && l=1  && gfx=-1{gfx=31}
if u=0 && r=1 && dr=0 && d=1 && dl=1 && l=1  && gfx=-1{gfx=32}
if u=0 && r=1 && dr=1 && d=1 && dl=0 && l=1  && gfx=-1{gfx=33}
if u=0 && r=1 && dr=1 && d=1 && dl=1 && l=1  && gfx=-1{gfx=34}
if u=1 && ur=1 && r=1 && dr=1 && d=1 && l=0  && gfx=-1{gfx=29}
if u=1 && ur=1 && r=1 && d=0 && l=0   && gfx=-1{gfx=13}
if u=1 && r=0  && d=0 && l=1 && ul=1  && gfx=-1{gfx=14}
if u=1 && ur=0 && r=1 && d=0 && l=0   && gfx=-1{gfx=15}
if u=1 && r=0  && d=0 && l=1 && ul=0  && gfx=-1{gfx=16}
if u=0 && r=1 && dr=1 && d=1  && l=0  && gfx=-1{gfx=7}
if u=0 && r=0 && d=1  && dl=1 && l=1  && gfx=-1{gfx=8}
if u=0 && r=1 && dr=0 && d=1  && l=0  && gfx=-1{gfx=9}
if u=0 && r=0 && d=1  && dl=0 && l=1  && gfx=-1{gfx=10}
if u=0 && r=0 && d=0 && l=0 && gfx=-1 {gfx=0}
if u=1 && r=0 && d=1  && l=0 && gfx=-1 {gfx=5}
if u=0 && r=0  && d=1 && l=0 && gfx=-1 {gfx=21}
if u=0 && r=0 && d=0  && l=1 && gfx=-1 {gfx=22}
if u=0 && r=1 && d=0  && l=0 && gfx=-1 {gfx=27}
if u=1 && r=0 && d=0  && l=0 && gfx=-1 {gfx=28}
if u=0 && r=1  && d=0 && l=1 && gfx=-1 {gfx=30}
}

with(DoorOp){
image_index=gfx
image_speed=0
}
with(DoorCl){
image_index=gfx
image_speed=0
}
