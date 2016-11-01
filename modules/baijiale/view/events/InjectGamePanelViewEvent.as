package modules.baijiale.view.events
{
    import flash.events.*;

    public class InjectGamePanelViewEvent extends Event 
    {

        public static var INJECT_MONEY:String = "injectMoney";

        public var data:Object;

        public function InjectGamePanelViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:InjectGamePanelViewEvent = new InjectGamePanelViewEvent(type, bubbles, cancelable);
            _local1.data = this.data;
            return (_local1);
        }


    }
}//package modules.baijiale.view.events
