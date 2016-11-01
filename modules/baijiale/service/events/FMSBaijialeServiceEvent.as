package modules.baijiale.service.events
{
    import flash.events.*;

    public class FMSBaijialeServiceEvent extends Event 
    {

        public static var LINK_START:String = "linkStart_baijiale";
        public static var LINK_DELAY_START:String = "linkDelayStart_baijiale";
        public static var LINK_SUCCESS:String = "Success_baijiale";
        public static var LINK_FAILED:String = "Failed_baijiale";
        public static var LINK_CLOSENO:String = "CloseNo_baijiale";
        public static var LINK_CLOSED:String = "Closed_baijiale";
        public static var LINK_REJECTED:String = "Rejected_baijiale";
        public static var LINK_REJECTED_MSG:String = "Rejected_msg_baijiale";
        public static var LINK_RETRY:String = "Retry_baijiale";
        public static var LINK_CLOSE:String = "Close_baijiale";
        public static var LINK_CLIENT_CLOSE:String = "clientClose_baijiale";
        public static var LINK_SERVER_CLOSE:String = "serverClose_baijiale";
        public static var CALL_FMS_RESULT:String = "callFmsResult_baijiale";
        public static var CALL_FMS_ERROR:String = "callFmsError_baijiale";
        public static var FMS_CALL:String = "fmsCall_baijiale";

        public var data:Object;
        public var funName:String;
        public var fmsData:Object;

        public function FMSBaijialeServiceEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(type, bubbles, cancelable);
            _local1.data = this.data;
            _local1.fmsData = this.fmsData;
            _local1.funName = this.funName;
            return (_local1);
        }


    }
}//package modules.baijiale.service.events
