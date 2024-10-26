package game.objects {
	import flash.geom.Point;

	import game.global.Game;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.utils.UtilsObjects;

	/**
	 * ...
	 * @author
	 */
	public class TSpikesPingPong extends TGameObject {
		[Embed(source="../../../assets/gfx/by_cage/sprites/spikes.png")]
		public static var _gfx_spikes_:Class;

		private var _nodes:Array;
		private var _nodeNow:uint = 1;

		private var _nodeDir:int = 1;

		private var _speed:Number;
		private var _turnWait:uint;
		private var _waiter:uint;


		public function TSpikesPingPong(x:Number, y:Number, nodes:XML, speed:Number, turnWait:uint) {
			_x = x;
			_y = y;

			_speed = speed;
			_turnWait = turnWait;

			_width = 16;
			_height = 16;

			_nodes = [];
			_nodes[0] = new Point(x, y);

			for each(var xml:XML in nodes.children()) {
				_nodes.push(new Point(xml.@x, xml.@y));
			}

			_gfx = RetrocamelBitmapManager.getBD(_gfx_spikes_);

			addDefault();

			update();
		}

		override public function update():void {
			if (player && !player.started) {
				Game.lGame.draw(_gfx, x, y);
				return;
			}

			if (_waiter) {
				_waiter--;
			} else {
				if (Math.abs(_nodes[_nodeNow].y - _y) <= 1 && Math.abs(_nodes[_nodeNow].x - _x) <= 1) {
					x = _nodes[_nodeNow].x;
					y = _nodes[_nodeNow].y;

					if (_nodeNow == 0 && _nodeDir == -1)
						_nodeDir = 1;
					else if (_nodeNow == _nodes.length - 1 && _nodeDir == 1)
						_nodeDir = -1;

					_nodeNow += _nodeDir;
					_waiter = _turnWait;

				} else {
					var dir:Number = Math.atan2(_nodes[_nodeNow].y - _y, _nodes[_nodeNow].x - x);
					x += Math.cos(dir) * _speed;
					y += Math.sin(dir) * _speed;
				}
			}


			Game.lGame.draw(_gfx, x, y);

			if (!player)
				return;

			if (UtilsObjects.distanceSquaredFromCenter(this, player) < 12 * 12) {
				player.kill();
			}
		}
	}
}