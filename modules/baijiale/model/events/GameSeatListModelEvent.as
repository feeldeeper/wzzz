package modules.baijiale.model.events
{
    import flash.events.*;
    import modules.baijiale.model.seat.*;

    public class GameSeatListModelEvent extends Event 
    {

        public static var SEAT_LIST:String = "seatList_baijiale";
        public static var SEAT_LIST_ADD:String = "seatList_add_baijiale";
        public static var SEAT_LIST_REMOVE:String = "seatList_remove_baijiale";
        public static var UP_GROUP:String = "upGroup_baijiale";
        public static var USER_INJECT_MONEY:String = "userInjectMoney_baijiale";
        public static var GROUP_INJECT_MONEY:String = "groupInjectMoney_baijiale";
        public static var CLEAR_ALL_USER_INJECTMONEY:String = "clearAllUserInjectMoney_baijiale";
        public static var REFERSH_ALL_USER_MONEY:String = "refreshAllUserMoney_baijiale";

        public var data:Object;
        public var seat:SeatModel;

        public function GameSeatListModelEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:GameSeatListModelEvent = new GameSeatListModelEvent(type, bubbles, cancelable);
            _local1.data = this.data;
            _local1.seat = this.seat;
            return (_local1);
        }


    }
}//package modules.baijiale.model.events
