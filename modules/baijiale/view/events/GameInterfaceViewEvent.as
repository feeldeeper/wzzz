package modules.baijiale.view.events
{
    import flash.events.*;

    public class GameInterfaceViewEvent extends Event 
    {

        public static var UP_SIMULATIONS_PANEL:String = "upSimulationsPanel";
        public static var BACK_ROOM:String = "backRoom";
        public static var SEAT_SELECT:String = "seatSelect";
        public static var GAME_RECORD:String = "gameRecord";
        public static var GAME_RULES:String = "rules";
        public static var SYSTEM:String = "system";

        public var data:Object;

        public function GameInterfaceViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:GameInterfaceViewEvent = new GameInterfaceViewEvent(type, bubbles, cancelable);
            _local1.data = this.data;
            return (_local1);
        }


    }
}//package modules.baijiale.view.events
