package modules.baijiale.model.events
{
    import flash.events.*;

    public class GameDataModelEvent extends Event 
    {

        public static var INIT_GAME_INFO:String = "initGameInfo_baijiale";
        public static var UP_TIME:String = "upTime_baijiale";
        public static var UP_GAMESTATE:String = "upGameState_baijiale";
        public static var UP_GAME_HISTORY:String = "upGameHistoty_baijiale";
        public static var UP_GAME_RESULTS:String = "upGameResults_baijiale";
        public static var UP_GAME_DEAL:String = "upGameDeal_baijiale";
        public static var UP_GAME_FARMER:String = "upGameFarmer_baijiale";
        public static var USER_INJECT_MONEY:String = "userInjectMoney_baijiale";
        public static var GAME_ERROR:String = "gameError_baijiale";
        public static var GAME_ALL_INJECT:String = "gameAllInject_baijiale";
        public static var UP_GAME_NOTICE:String = "upGameNotice_baijiale";
        public static var UP_LIMIT_INFO:String = "upLimitInfo_baijiale";

        public var data:Object;

        public function GameDataModelEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:GameDataModelEvent = new GameDataModelEvent(type, bubbles, cancelable);
            _local1.data = this.data;
            return (_local1);
        }


    }
}//package modules.baijiale.model.events
