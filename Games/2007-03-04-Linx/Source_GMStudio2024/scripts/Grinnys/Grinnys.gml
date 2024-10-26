function Grinnys() {
	for (i=0;i<9;i+=1){
	ix[i,0]=0
	iy[i,0]=0
	num[i]=0
	}
	num[0]=0
	with (Base_Wht) {
	Master.ix[0,Master.num[0]]=x+30//floor((x-96)/48)
	Master.iy[0,Master.num[0]]=y+30//floor((y)/48)
	Master.num[0]+=1
	}
	num[1]=0
	with (Base_Blk) {
	Master.ix[1,Master.num[1]]=x+30//floor((x-96)/48)
	Master.iy[1,Master.num[1]]=y+30//floor((y)/48)
	Master.num[1]+=1
	}
	num[2]=0
	with (Base_Red) {
	Master.ix[2,Master.num[2]]=x+30//floor((x-96)/48)
	Master.iy[2,Master.num[2]]=y+30//floor((y)/48)
	Master.num[2]+=1
	}
	num[3]=0
	with (Base_Orn) {
	Master.ix[3,Master.num[3]]=x+30//floor((x-96)/48)
	Master.iy[3,Master.num[3]]=y+30//floor((y)/48)
	Master.num[3]+=1
	}

	num[4]=0
	with (Base_Yll) {
	Master.ix[4,Master.num[4]]=x+30//floor((x-96)/48)
	Master.iy[4,Master.num[4]]=y+30//floor((y)/48)
	Master.num[4]+=1
	}

	num[5]=0
	with (Base_Grn) {
	Master.ix[5,Master.num[5]]=x+30//floor((x-96)/48)
	Master.iy[5,Master.num[5]]=y+30//floor((y)/48)
	Master.num[5]+=1
	}

	num[6]=0
	with (Base_Trq) {
	Master.ix[6,Master.num[6]]=x+30//floor((x-96)/48)
	Master.iy[6,Master.num[6]]=y+30//floor((y)/48)
	Master.num[6]+=1
	}

	num[7]=0
	with (Base_Blu) {
	Master.ix[7,Master.num[7]]=x+30//floor((x-96)/48)
	Master.iy[7,Master.num[7]]=y+30//floor((y)/48)
	Master.num[7]+=1
	}

	num[8]=0
	with (Base_Vlt) {
	Master.ix[8,Master.num[8]]=x+30//floor((x-96)/48)
	Master.iy[8,Master.num[8]]=y+30//floor((y)/48)
	Master.num[8]+=1
	}




}
