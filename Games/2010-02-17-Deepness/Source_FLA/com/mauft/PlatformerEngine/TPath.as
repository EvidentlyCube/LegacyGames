package com.mauft.PlatformerEngine{
	public class TPath	{
		private var _first:TNode
		private var _current:TNode
		private var _last:TNode
		public function TPath(){}
		public function update():void{
			_current=_current.update()
		}
		public function addNode(_n:TNode):void{
			if (_last==null){
				_current=_first=_n
				_last=_n
			}
			_n.fuse(this)
			_last=_n
		}
		public function get first():TNode{return _first}
		public function get last():TNode{return _last}
		public function get x():Number{return _current.x}
		public function get y():Number{return _current.y}
	}
}