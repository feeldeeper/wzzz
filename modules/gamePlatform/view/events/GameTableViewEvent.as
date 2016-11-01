package modules.gamePlatform.view.events
{
    import flash.events.*;

    public class GameTableViewEvent extends Event 
    {

        public static var ADD_TABLEVO:String = "addTableVO";
        public static var TABLE_GOTO_GAME:String = "tableGotoGame";
        public static var TABLE_WAIT_GOTO_GAME:String = "tableWaitGoToGame";
        public static var GOTO_GAME_MONEYGROUP:String = "gotoGameMoneyGroup";

        public var moneyTypeGroup:String;

        public function GameTableViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:GameTableViewEvent = new GameTableViewEvent(type, bubbles, cancelable);
            _local1.moneyTypeGroup = this.moneyTypeGroup;
            return (_local1);
        }


    }
}//package modules.gamePlatform.view.events
