package modules.gamePlatform.service.events
{
    import flash.events.*;

    public class VideoHallServiceEvent extends Event 
    {

        public static var LINK_START:String = "linkStart_hallVideo";
        public static var LINK_SUCCESS:String = "linkOK_hallVideo";
        public static var VIDEO_START:String = "videoStart_hallVideo";
        public static var VIDEO_PLAY:String = "videoPlay_hallVideo";
        public static var VIDEO_ERROR:String = "videoERROR_hallVideo";
        public static var LINK_CLOSE:String = "Close_hallVideo";

        public function VideoHallServiceEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            return (new VideoHallServiceEvent(type, bubbles, cancelable));
        }


    }
}//package modules.gamePlatform.service.events
