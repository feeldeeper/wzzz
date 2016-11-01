package modules.baijiale.view.events
{
    import flash.events.*;

    public class GotoGameTableListViewEvent extends Event 
    {

        public static var UP_TABLE:String = "upTable_baijiale";
        public static var GOTO_TABLE:String = "goto_Table_baijiale";

        public function GotoGameTableListViewEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            return (new GotoGameTableListViewEvent(type, bubbles, cancelable));
        }


    }
}//package modules.baijiale.view.events
