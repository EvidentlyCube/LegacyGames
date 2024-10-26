if global.limit<=0{
      with (all){
           if object_index!=Main{instance_destroy()}
      }
      global.scr=ceil(global.scr*100)
      global.scr2=global.scr
      global.accper=round(global.accper)
      global.time=round(global.time)
      global.kill=round(global.kill)
      global.scr*=global.accper*global.accper+global.time+global.kill
      instance_create(0,0,Ender)
      instance_destroy()
}





zupa+=1
if zupa=60{zupa=0;global.time+=1}


if global.limit>100{global.limit=100}
timer+=1
if timer>600{global.pow+=1;timer=0;flash=1}
if global.limit>0{
if global.pow=0{
ran=floor(random(100))
if ran=1{
instance_create(1050,125+random(480),Enemy1)
}
}

if global.pow=1{
ran=floor(random(100))
if ran=1{
instance_create(1050,125+random(480),Enemy1)
}
if ran=2{
instance_create(1050,125+random(480),Enemy2)
}
}

if global.pow=2{
ran=floor(random(100))
if ran=1{
instance_create(1050,125+random(480),Enemy1)
}
if ran=2{
instance_create(1050,125+random(480),Enemy2)
}

if ran=3{
instance_create(1050,125+random(480),Enemy3)
}
}

if global.pow=3{
ran=floor(random(100))
if ran=1{
instance_create(1050,125+random(480),Enemy1)
}
if ran=2{
instance_create(1050,125+random(480),Enemy2)
}

if ran=3{
instance_create(1050,125+random(480),Enemy3)
}

if ran=4{
instance_create(1050,125+random(480),Enemy4)
}
}

if global.pow=4{
ran=floor(random(100))
if ran=1{
instance_create(1050,125+random(480),Enemy1)
}
if ran=2{
instance_create(1050,125+random(480),Enemy2)
}

if ran=3{
instance_create(1050,125+random(480),Enemy3)
}

if ran=4{
instance_create(1050,125+random(480),Enemy4)
}

if ran=5{
ran=choose(0,1,2,3)
if ran=0{
instance_create(1050,125+random(480),Blyczk)
}}
}

if global.pow>4{
ran=floor(random(100-global.pow*5))
if ran=1{
instance_create(1050,125+random(480),Enemy1)
}
if ran=2{
instance_create(1050,125+random(480),Enemy2)
}

if ran=3{
instance_create(1050,125+random(480),Enemy3)
}

if ran=4{
instance_create(1050,125+random(480),Enemy4)
}

if ran=5{
ran=choose(0,1,2,3)
if ran=0{
instance_create(1050,125+random(480),Blyczk)
}
}
}
}
if global.pow>18{global.pow=18}
