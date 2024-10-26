package com.mauft.PlatformerEngine{
	public class TNode	{
		private var _next:TNode
		private var _prev:TNode
		
		public var endX:Number
		public var endY:Number
		private var spd:Number
		private var startX:Number
		private var startY:Number
		private var step:Number=0
		
		public function TNode(_endX:Number, _endY:Number, _spd:Number){
			endX=_endX
			endY=_endY
			spd=_spd
		}
		public function update():TNode{
			step+=spd
			if (step>=1){
				step=0
				return _next
			} else {
				return this
			}
		}
		public function fuse(_p:TPath):void{
			heads(_p.first)
			tails(_p.last)
			_next.tails(this)
			_prev.heads(this)
		}
		public function tails(_n:TNode):void{
			_prev=_n
			startX=_prev.endX
			startY=_prev.endY
		}
		public function heads(_n:TNode):void{
			_next=_n
		}
		public function get next():TNode{return _next}
		public function get prev():TNode{return _prev}
		public function get x():Number{return startX+(endX-startX)*step}
		public function get y():Number{return startY+(endY-startY)*step}
	}
}