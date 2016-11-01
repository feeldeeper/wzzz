package modules.baijiale.view.events
{
    import flash.events.*;
    import modules.baijiale.model.seat.*;

    public class UserSeatListViewEvent extends Event 
    {

        public static var SELECT_SEAT:String = "selectSeat";

        public var seat:SeatModel;

        public function UserSeatListViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:UserSeatListViewEvent = new UserSeatListViewEvent(type, bubbles, cancelable);
            _local1.seat = this.seat;
            return (_local1);
        }


    }
}//package modules.baijiale.view.events
