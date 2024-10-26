package net.retrocade.camel.effects{
	public class rEasing{
		//private static const
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Quad 
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Start slow and accelerate
		 */
		public static function quadIn(pos:Number):Number{
			return pos * pos;
		}
		
		/**
		 * Start fast and decelerate
		 */
		public static function quadOut(pos:Number):Number{
			pos -= 1;
			return 1 - pos * pos;
		}
		
		/**
		 * Start slow and accelerate, then decelerate from the middle
		 */
		public static function quadInOut(pos:Number):Number{
			if (pos < 0.5) 
				return 0.5 * pos * pos;
			
			pos -= 2;
			
			return 0.5 * (2 - pos * pos);
		}
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Cubic 
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Start very slow and accelerate
		 */
		public static function cubicIn(pos:Number):Number{
			return pos * pos * pos;
		}
		
		/**
		 * Start very fast and decelerate
		 */
		public static function cubicOut(pos:Number):Number{
			pos -= 1;
			return pos * pos * pos + 1;
		}
		
		/**
		 * Start very slow and accelerate, then decelerate from the middle
		 */
		public static function cubicInOut(pos:Number):Number{
			if (pos < 0.5) 
				return 0.5 * pos * pos * pos;
			
			pos -= 2;
			
			return 0.5 * (pos * pos * pos + 2);
		}
		
		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Quartic 
		// ::::::::::::::::::::::::::::::::::::::::::::::
		
		/**
		 * Start very slow and accelerate
		 */
		public static function quartIn(pos:Number):Number{
			return pos * pos * pos;
		}
		
		/**
		 * Start very fast and decelerate
		 */
		public static function quartOut(pos:Number):Number{
			pos -= 1;
			return pos * pos * pos + 1;
		}
		
		/**
		 * Start very slow and accelerate, then decelerate from the middle
		 */
		public static function quartInOut(pos:Number):Number{
			if (pos < 0.5) 
				return 0.5 * pos * pos * pos;
			
			pos -= 2;
			
			return 0.5 * (pos * pos * pos + 2);
		}
	}
}