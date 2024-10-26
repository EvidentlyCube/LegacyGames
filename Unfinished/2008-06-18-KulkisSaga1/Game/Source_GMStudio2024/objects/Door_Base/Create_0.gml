image_speed=0
if (place_meeting(x+25,y,Door)){image_index=0}
if (place_meeting(x,y+25,Door)){image_index=1}
if (place_meeting(x-25,y,Door)){image_index=2}
if (place_meeting(x,y-25,Door)){image_index=3}
image_index+=4
