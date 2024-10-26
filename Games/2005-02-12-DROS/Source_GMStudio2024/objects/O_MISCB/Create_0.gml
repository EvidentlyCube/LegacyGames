if place_meeting(x+16,y,O_MISCB){r=1} else {r=0}
if place_meeting(x,y+16,O_MISCB){d=1} else {d=0}
if place_meeting(x-16,y,O_MISCB){l=1} else {l=0}
if place_meeting(x,y-16,O_MISCB){u=1} else {u=0}

if r=0 && d=0 && l=0 && u=0 {image_single=15}
if r=1 && d=0 && l=0 && u=0 {image_single=12}
if r=0 && d=1 && l=0 && u=0 {image_single=14}
if r=1 && d=1 && l=0 && u=0 {image_single=0}
if r=0 && d=0 && l=1 && u=0 {image_single=11}
if r=1 && d=0 && l=1 && u=0 {image_single=9}
if r=0 && d=1 && l=1 && u=0 {image_single=2}
if r=1 && d=1 && l=1 && u=0 {image_single=1}
if r=0 && d=0 && l=0 && u=1 {image_single=13}
if r=1 && d=0 && l=0 && u=1 {image_single=6}
if r=0 && d=1 && l=0 && u=1 {image_single=10}
if r=1 && d=1 && l=0 && u=1 {image_single=3}
if r=0 && d=0 && l=1 && u=1 {image_single=8}
if r=1 && d=0 && l=1 && u=1 {image_single=7}
if r=0 && d=1 && l=1 && u=1 {image_single=5}
if r=1 && d=1 && l=1 && u=1 {image_single=4}
