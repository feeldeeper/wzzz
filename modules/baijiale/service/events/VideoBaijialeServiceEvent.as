package modules.baijiale.service.events
{
    import flash.events.*;

    public class VideoBaijialeServiceEvent extends Event 
    {

        public static var LINK_START:String = "linkStart_baijialeVideo";
        public static var LINK_SUCCESS:String = "linkOK_baijialeVideo";
        public static var VIDEO_START:String = "videoStart_baijialeVideo";
        public static var VIDEO_PLAY:String = "videoPlay_baijialeVideo";
        public static var VIDEO_ERROR:String = "videoERROR_baijialeVideo";
        public static var VIDEO_BUFFER_FULL:String = "video_buffer_full_baijialeVideo";
        public static var LINK_CLOSE:String = "Close_baijialeVideo";

        public function VideoBaijialeServiceEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            return (new VideoBaijialeServiceEvent(type, bubbles, cancelable));
        }


    }
}//package modules.baijiale.service.events
