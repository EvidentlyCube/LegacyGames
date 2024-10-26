itemmo-=1
if itemmo>9{itemmo-=10}
if itemmo<0{itemmo+=10}
switch(itemmo){
case(1):inst=Base_Blk;soundplay(Snd_Click);itemmo=1;break;
case(2):inst=Base_Wht;soundplay(Snd_Click);itemmo=2;break;
case(3):inst=Base_Red;soundplay(Snd_Click);itemmo=3;break;
case(4):inst=Base_Orn;soundplay(Snd_Click);itemmo=4;break;
case(5):inst=Base_Yll;soundplay(Snd_Click);itemmo=5;break;
case(6):inst=Base_Grn;soundplay(Snd_Click);itemmo=6;break;
case(7):inst=Base_Trq;soundplay(Snd_Click);itemmo=7;break;
case(8):inst=Base_Blu;soundplay(Snd_Click);itemmo=8;break;
case(9):inst=Base_Vlt;soundplay(Snd_Click);itemmo=9;break;
case(0):inst=Block;soundplay(Snd_Click);itemmo=0;break;
}
