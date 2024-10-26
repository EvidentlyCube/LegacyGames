package{
    public class C{
        public static const eventPathNumberChanged:uint = 0;
        public static const eventDrawColorChanged:uint = 1;
		
		public static const eventSelectedColor:uint = 2;
		public static const eventDrawnPath:uint = 3;
		public static const eventUndo:uint = 4;
		public static const eventRemovedPath:uint = 5;
		public static const eventClearedColor:uint = 6;
		public static const eventConnectedBase:uint = 7;
		public static const eventExceededPaths:uint = 8;
        public static const eventRemovedAllPaths:uint = 9;
		
		public static const allowAll        :Array = [1, 2, 3, 4, 5, 6, 7];
		public static const disallowAll     :Array = [-1, -2, -3, -4, -5, -6, -7];
		
		public static const allowDrawPath   :int = 1;
		public static const allowGetColor   :int = 2;
		public static const allowUndo       :int = 3;
		public static const allowConnectBase:int = 4;
		public static const allowRemovePath :int = 5;
		public static const allowHud        :int = 6;
        public static const allowClearColor :int = 7;
		
		public static const disallowDrawPath   :int = -1;
		public static const disallowGetColor   :int = -2;
		public static const disallowUndo       :int = -3;
		public static const disallowConnectBase:int = -4;
		public static const disallowRemovePath :int = -5;
		public static const disallowHud        :int = -6;
		public static const disallowClearColor :int = -7;
    }
}