package modules.gamePlatform.service.events
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.model.vo.*;
    import modules.*;

    public class GameLoadServiceEvent extends Event 
    {

        public static const GAME_LOAD_START:String = "gameLoadStart";
        public static const GAME_LOAD_COMPLETE:String = "gameLoadComplete";

        public static var UNLOAD_WAITLOAD:String = "unloadWaitload";
        public static var GAME_IO_ERROR:String = "gameIoError";
        public static var GAME_PROGRESS:String = "gameProgress";

        public var gameTableVO:GameTableVO;
        public var game:IGameModule;
        public var gameProgress:Number = 0;
        public var currentLoader:Loader;

        public function GameLoadServiceEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:GameLoadServiceEvent = new GameLoadServiceEvent(type, bubbles, cancelable);
            _local1.gameTableVO = this.gameTableVO;
            _local1.gameProgress = this.gameProgress;
            _local1.game = this.game;
            _local1.currentLoader = this.currentLoader;
            return (_local1);
        }

        override public function toString():String
        {
            return (formatToString("GameLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"));
        }


    }
}//package modules.gamePlatform.service.events
