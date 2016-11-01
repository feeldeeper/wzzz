package modules.gamePlatform.model.events
{
    import flash.events.*;

    public class UserInfoModelEvent extends Event 
    {

        public static var UP_USER_MONEY:String = "upUserMoney";
        public static var UP_USER_INFO:String = "upUserInfo";

        public var money:Number;
        public var data:Object;

        public function UserInfoModelEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:UserInfoModelEvent = new UserInfoModelEvent(type, bubbles, cancelable);
            _local1.money = this.money;
            _local1.data = this.data;
            return (_local1);
        }


    }
}//package modules.gamePlatform.model.events
