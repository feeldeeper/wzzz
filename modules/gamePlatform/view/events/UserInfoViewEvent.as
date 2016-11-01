package modules.gamePlatform.view.events
{
    import flash.events.*;

    public class UserInfoViewEvent extends Event 
    {

        public static var LANGUAGE:String = "language";
        public static var RULES:String = "rules";
        public static var RECORD:String = "record";
        public static var SERVER:String = "server";
        public static var OUT:String = "out";
        public static var EDITPASSWORD:String = "editPassword";
        public static var EDITNICKNAME:String = "editNickName";

        public function UserInfoViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            return (new UserInfoViewEvent(type, bubbles, cancelable));
        }


    }
}//package modules.gamePlatform.view.events
