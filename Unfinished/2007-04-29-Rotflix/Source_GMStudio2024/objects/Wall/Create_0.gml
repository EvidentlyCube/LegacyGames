image_speed=0
u=sign(place_meeting(x,y-20,Wall))
d=sign(place_meeting(x,y+20,Wall))
l=sign(place_meeting(x-20,y,Wall))
r=sign(place_meeting(x+20,y,Wall))
if u=0 && r=0 && d=0 && l=0 {image_index=0}

if u=0 && r=1 && d=0 && l=0 {image_index=1}

if u=0 && r=0 && d=1 && l=0 {image_index=2}

if u=0 && r=0 && d=0 && l=1 {image_index=3}

if u=1 && r=0 && d=0 && l=0 {image_index=4}

if u=0 && r=1 && d=1 && l=0 {image_index=5}

if u=0 && r=0 && d=1 && l=1 {image_index=6}

if u=1 && r=0 && d=0 && l=1 {image_index=7}

if u=1 && r=1 && d=0 && l=0 {image_index=8}

if u=0 && r=1 && d=1 && l=1 {image_index=9}

if u=1 && r=0 && d=1 && l=1 {image_index=10}

if u=1 && r=1 && d=0 && l=1 {image_index=11}

if u=1 && r=1 && d=1 && l=0 {image_index=12}

if u=1 && r=1 && d=1 && l=1 {image_index=13}

if u=0 && r=1 && d=0 && l=1 {image_index=14}

if u=1 && r=0 && d=1 && l=0 {image_index=15}

