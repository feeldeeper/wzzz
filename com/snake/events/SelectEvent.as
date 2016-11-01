package com.snake.events
{
    import flash.events.*;

    public class SelectEvent extends Event 
    {

        public static const UPSELECT:String = "upSelect";
        public static const SELECT:String = "Select";
        public static const RESELECT:String = "ReSelect";
        public static const UP_SELECT:String = "DataUpSelect";

        public var data;
        public var select:Boolean;

        public function SelectEvent(_arg1:String, _arg2=null, _arg3:Boolean=false, _arg4:Boolean=false, _arg5:Boolean=false)
        {
            super(_arg1, _arg4, _arg5);
            this.data = _arg2;
            this.select = _arg3;
        }

    }
}//package com.snake.events
