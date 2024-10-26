package submuncher.ingame.core {
    import net.retrocade.signal.Signal;

    public class GameCommunication {
        public var onStageResized:Signal = new Signal();
        public var onLevelCompleted:Signal = new Signal();
        public var onLevelLoaded:Signal = new Signal();
        public var onLevelStarted:Signal = new Signal();
        public var onLevelFailed:Signal = new Signal();
        public var onDoorOpened:Signal = new Signal();
        public var onTileChanged:Signal = new Signal();
        public var onBonusCollected:Signal = new Signal();
        public var onGameObjectCreated:Signal = new Signal();
        public var onGameObjectRemoved:Signal = new Signal();
        public var onGameObjectDestroyed:Signal = new Signal();
        public var onEffectCreated:Signal = new Signal();
        public var onEffectRemoved:Signal = new Signal();
        public var onSpikesEjected:Signal = new Signal();
        public var onCratePushed:Signal = new Signal();
        public var onGameObjectRendererCreated:Signal = new Signal();
        public var onGameObjectRendererRemoved:Signal = new Signal();
        public var onGameObjectImageCreated:Signal = new Signal();
        public var onGameObjectImageRemoved:Signal = new Signal();
        public var onFakeWallInitialized:Signal = new Signal();
        public var afterLevelLoaded:Signal = new Signal();
        public var afterLevelRendered:Signal = new Signal();
        public var onGhostDataCommited:Signal = new Signal();
        public var onPlayerDamagedBy:Signal = new Signal();
        public var onEvent:Signal = new Signal();

        public function dispose():void{
            onStageResized.dispose();
            onLevelCompleted.dispose();
            onLevelLoaded.dispose();
            onLevelStarted.dispose();
            onLevelFailed.dispose();
            onDoorOpened.dispose();
            onTileChanged.dispose();
            onGameObjectCreated.dispose();
            onGameObjectRemoved.dispose();
            onGameObjectDestroyed.dispose();
            onEffectCreated.dispose();
            onEffectRemoved.dispose();
            onSpikesEjected.dispose();
            onCratePushed.dispose();
            onBonusCollected.dispose();
            onGameObjectRendererCreated.dispose();
            onGameObjectRendererRemoved.dispose();
            onGameObjectImageCreated.dispose();
            onGameObjectImageRemoved.dispose();
            onFakeWallInitialized.dispose();
            afterLevelLoaded.dispose();
            afterLevelRendered.dispose();
            onGhostDataCommited.dispose();
            onPlayerDamagedBy.dispose();
            onEvent.dispose();
        }
    }
}
