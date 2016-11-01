package modules.gamePlatform.view.events
{
    import flash.events.*;

    public class MainContainersViewEvent extends Event 
    {

        public static var GOTO_GAME_END:String = "gotoGameEnd";
        public static var GOTO_PAGE_END:String = "gotoPageEnd";
        public static var RESIZE:String = "resize_main";

        public var scale:Number;

        public function MainContainersViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:MainContainersViewEvent = new MainContainersViewEvent(type, bubbles, cancelable);
            _local1.scale = this.scale;
            return (_local1);
        }


    }
}//package modules.gamePlatform.view.events
