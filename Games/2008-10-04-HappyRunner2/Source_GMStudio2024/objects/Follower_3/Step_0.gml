if !place_meeting(x+sped*sign(Player.x-x),y,Wall) && !place_meeting(x+sped*sign(Player.x-x),y,Follower_1){x+=+sped*sign(Player.x-x)}
if !place_meeting(x,y+1,Wall){moy+=1} else {moy=0}
y+=moy
while place_meeting(x,y,Wall){y-=1}

