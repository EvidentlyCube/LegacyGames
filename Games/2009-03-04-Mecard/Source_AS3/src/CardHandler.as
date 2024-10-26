package{
	import flash.events.Event;

	public class CardHandler{
		private static var action:uint=0
		private static var waiter:uint=0
		private static var card1:Card
		private static var card2:Card
		private static var toCompare:uint
		public function CardHandler(){
			toCompare=20
			action=0
			var i:uint=0
			var j:uint=0
			var ar2:Array=new Array
			for (i=0;i<20;i++){
				ar2.push(i)
				ar2.push(i)
			}
			while (Mecard.layer.numChildren>0){
				var g:Card=Mecard.layer.getChildAt(0) as Card
				g.Kill()
			}

			for (i=0;i<10;i++){
				for (j=0;j<4;j++){
					var t:uint=Math.floor(Math.random()*ar2.length)
					new Card(i,j,ar2[t])
					ar2.splice(t,1)
				}
			}
		}
		public function update(e:Event):void{
			waiter++
			switch(action){
				case(1):
					if (card1.scaleX>0.01){
						card1.scaleX*=0.60
					} else {
						card1.fore.visible=true
						card1.back.visible=false
						action=2
					}
					break
				case(2):
					if (card1.scaleX<1){
						card1.scaleX*=1.5
						if (card1.scaleX>1){card1.scaleX=1}
					} else {
						card1.scaleX=1
						action=3
					}break
				case(4):
					if (card2.scaleX>0.01){
						card2.scaleX*=0.60
					} else {
						card2.fore.visible=true
						card2.back.visible=false
						action=5
					}break
				case(5):
					if (card2.scaleX<1){
						card2.scaleX*=1.5
						if (card2.scaleX>1){card2.scaleX=1}
					} else {
						card2.scaleX=1
						action=6
						waiter=0
					}break
				case(6):
					if (waiter==30){
						waiter=0
						if (card1.type==card2.type){
							action=7
							Mecard.playx(2)
						} else {
							action=8
							Mecard.playx(3)
						}
					}break
				case(7):
					if (card1.alpha>0){
						card1.alpha-=0.05
						card2.alpha-=0.05
					} else {
						card1.Kill()
						card2.Kill()
						card1=null
						card2=null
						action=0
						toCompare--
					}break
				case(8):
					if (card1.scaleX>0.01){
						card1.scaleX*=0.60
						card2.scaleX*=0.60
					} else {
						card1.fore.visible=false
						card2.fore.visible=false
						card1.back.visible=true
						card2.back.visible=true
						action=9
					}
					break
				case(9):
					if (card1.scaleX<1){
						card1.scaleX*=1.5
						card2.scaleX*=1.5
						if (card1.scaleX>1){card1.scaleX=1;card2.scaleX=1}
					} else {
						card1.scaleX=1
						card2.scaleX=1
						action=0
					}break
				case(10):
					var o:Object = { n: [6, 0, 3, 0, 13, 9, 0, 10, 10, 6, 4, 9, 10, 10, 5, 9], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
					var boardID:String = o.f(0,"");
					action=11
					Mecard.stoped=true
					Mecard.rem();
					return
				case(11):
					return
			}
			if (toCompare==0){
				action=10
			}
		}
		public static function Flip(id:Card):void{
			if (Mecard.time==0){Mecard.time=1}
			 if (action==0){
			 	action=1
			 	card1=id
			 	Mecard.playx(1)
			 } else if(action==3 && id!=card1){
			 	card2=id
			 	waiter=0
			 	action=4
				Mecard.playx(1)
			 }
		}
	}
}