package modules.gamePlatform.view.events
{
    import flash.events.*;

    public class AlertDefaultViewEvent extends Event 
    {

        public static var CLOSE:String = "close";

        public function AlertDefaultViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            return (new AlertDefaultViewEvent(type, bubbles, cancelable));
        }


    }
}//package modules.gamePlatform.view.events
