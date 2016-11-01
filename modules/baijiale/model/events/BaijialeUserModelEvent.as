package modules.baijiale.model.events
{
    import flash.events.*;
    import modules.baijiale.model.*;

    public class BaijialeUserModelEvent extends Event 
    {

        public static var INIT_USER_DATA:String = "initUserData_baijiale";
        public static var INJECT_MONEY_OK:String = "injectMoneyOk_baijiale";
        public static var INJECT_MONEY_ERROR:String = "injectMoneyError_baijiale";
        public static var UP_SEAT:String = "upSeat_baijiale";
        public static var UP_USER_MONEY:String = "upUserMoney_baijiale";

        public var userData:BaijialeUserModel;
        public var data:Object;

        public function BaijialeUserModelEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:BaijialeUserModelEvent = new BaijialeUserModelEvent(type, bubbles, cancelable);
            _local1.userData = this.userData;
            _local1.data = this.data;
            return (_local1);
        }


    }
}//package modules.baijiale.model.events
