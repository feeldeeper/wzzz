package modules.baijiale.model.seat.events
{
    import flash.events.*;

    public class SeatModelEvent extends Event 
    {

        public static var USER_INJECT_MONEY:String = "userInjectMoney_baijiale";
        public static var ADD_USER:String = "addUser_baijiale";
        public static var REMOVE_USER:String = "removeUser_baijiale";
        public static var CLEAR_INJECT_MOMEY:String = "clearUserInjectMoney_baijiale";

        public function SeatModelEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            return (new SeatModelEvent(type, bubbles, cancelable));
        }


    }
}//package modules.baijiale.model.seat.events
