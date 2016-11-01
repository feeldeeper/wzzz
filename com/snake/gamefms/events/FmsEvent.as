package com.snake.gamefms.events
{
    import flash.events.*;

    public class FmsEvent extends Event 
    {

        public static var LINK_START:String = "linkStart";
        public static var LINK_SUCCESS:String = "Success";
        public static var LINK_FAILED:String = "Failed";
        public static var LINK_CLOSENO:String = "CloseNo";
        public static var LINK_CLOSED:String = "Closed";
        public static var LINK_REJECTED:String = "Rejected";
        public static var LINK_REJECTED_MSG:String = "Rejected_msg";
        public static var LINK_RETRY:String = "Retry";
        public static var LINK_CLOSE:String = "Close";
        public static var LINK_CLIENT_CLOSE:String = "clientClose";
        public static var LINK_SERVER_CLOSE:String = "serverClose";
        public static var FMS_CALL:String = "FmsCall";

        public var data;

        public function FmsEvent(_arg1:String, _arg2=null, _arg3:Boolean=false, _arg4:Boolean=false)
        {
            super(_arg1, _arg3, _arg4);
            this.data = _arg2;
        }

    }
}//package com.snake.gamefms.events
