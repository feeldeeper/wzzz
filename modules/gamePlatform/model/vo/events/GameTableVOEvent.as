package modules.gamePlatform.model.vo.events
{
    import flash.events.*;

    public class GameTableVOEvent extends Event 
    {

        public static var SET_CONFING:String = "setConfing";
        public static var SET_FMS_INIT_DATA:String = "setFMSInitData";
        public static var UP_GAMESTATE:String = "upGameState";
        public static var UP_GAME_HISTORY:String = "upGameHistory";
        public static var UP_GAME_USER_SEAT:String = "upGameUserSeat";
        public static var UP_TIME:String = "upTime";
        public static var UP_FARMER:String = "upFarmer";

        public function GameTableVOEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            return (new GameTableVOEvent(type, bubbles, cancelable));
        }


    }
}//package modules.gamePlatform.model.vo.events
