function Block_Grouping() {
	/*
	Grouping BLocks in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Block_Grouping()
	*/

	if group>0{



	var tested;
	tested=1
	number=1
	ide[0]=id
	if place_meeting(x+25,y,Blocker){
	   with (instance_place(x+25,y,Blocker)){
	        if group=other.group && color=other.color && group>0{
	           other.ide[other.number]=id
	           other.number+=1
	        }
	   }
	}
	if place_meeting(x,y+25,Blocker){
	   with (instance_place(x,y+25,Blocker)){
	        if group=other.group && color=other.color && group>0{
	           other.ide[other.number]=id
	           other.number+=1
	        }
	   }
	}
	if place_meeting(x-25,y,Blocker){
	   with (instance_place(x-25,y,Blocker)){
	        if group=other.group && color=other.color && group>0{
	           other.ide[other.number]=id
	           other.number+=1
	        }
	   }
	}
	if place_meeting(x,y-25,Blocker){
	   with (instance_place(x,y-25,Blocker)){
	        if group=other.group && color=other.color && group>0{
	           other.ide[other.number]=id
	           other.number+=1
	        }
	   }
	}


	if number=1{group=0}
	while tested<number{
	      with (ide[tested]){
	           var testyr,testix,verer;
	           testyr=instance_place(x+25,y,Blocker)
	           if testyr!=noone{
	           if group=(testyr).group && color=(testyr).color && (testyr).group>0{
	           verer=1
	              for (testix=0;testix<other.number;testix+=1){
	                  if testyr=other.ide[testix]{verer=0;break}
	              }
	              if verer=1{
	                 other.ide[other.number]=testyr
	                 other.number+=1
	              }
	           }
	           }
	           testyr=instance_place(x-25,y,Blocker)
	           if testyr!=noone{
	           if group=(testyr).group && color=(testyr).color && (testyr).group>0{
	           verer=1
	              for (testix=0;testix<other.number;testix+=1){
	                  if testyr=other.ide[testix]{verer=0;break}
	              }
	              if verer=1{
	                 other.ide[other.number]=testyr
	                 other.number+=1
	              }
	           }
	           }
	           testyr=instance_place(x,y+25,Blocker)
	           if testyr!=noone{
	           if group=(testyr).group && color=(testyr).color && (testyr).group>0{
	           verer=1
	              for (testix=0;testix<other.number;testix+=1){
	                  if testyr=other.ide[testix]{verer=0;break}
	              }
	              if verer=1{
	                 other.ide[other.number]=testyr
	                 other.number+=1
	              }
	           }
	           }
	           testyr=instance_place(x,y-25,Blocker)
	           if testyr!=noone{
	           if group=(testyr).group && color=(testyr).color && (testyr).group>0{
	           verer=1
	              for (testix=0;testix<other.number;testix+=1){
	                  if testyr=other.ide[testix]{verer=0;break}
	              }
	              if verer=1{
	                 other.ide[other.number]=testyr
	                 other.number+=1
	              }
	           }
	           }
	      }
	      tested+=1
	}



	}

	file_bin_seek(global.save,10000+floor((x+201)/25)+global.level*1000+floor((y+9)/25)*32)
	if file_bin_read_byte(global.save)=0{Block_Hit()}



}
