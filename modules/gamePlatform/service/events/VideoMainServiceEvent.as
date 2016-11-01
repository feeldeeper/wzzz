package modules.gamePlatform.service.events
{
    import flash.events.*;

    public class VideoMainServiceEvent extends Event 
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
        public static var CALL_FMS_RESULT:String = "callFmsResult";
        public static var CALL_FMS_ERROR:String = "callFmsError";
        public static var FMS_CALL:String = "fmsCall";

        public var data:Object;
        public var funName:String;
        public var fmsData:Object;

        public function VideoMainServiceEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:VideoMainServiceEvent = new VideoMainServiceEvent(type, bubbles, cancelable);
            _local1.data = this.data;
            _local1.fmsData = this.fmsData;
            _local1.funName = this.funName;
            return (_local1);
        }


    }
}//package modules.gamePlatform.service.events
