instance_destroy()
instance_create(x+10,y+10,Explosion)
a=instance_create(x,y,Bomber)
a.direction=0
a.sprite_index=S_BomberB
a=instance_create(x,y,Bomber)
a.direction=90
a.sprite_index=S_BomberA
a=instance_create(x,y,Bomber)
a.direction=180
a.sprite_index=S_BomberC
a=instance_create(x,y,Bomber)
a.direction=270
a.sprite_index=S_BomberD
sonpla(5)
with(other) instance_destroy()

