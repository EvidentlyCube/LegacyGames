if instance_exists(Body){if Body.x=x && Body.y=y && global.key<19{
global.keys[global.key]=7
global.key+=1
k=instance_create(x,y,SmallExploder)
k.sprite_index=sprite_index
instance_destroy()}

}
