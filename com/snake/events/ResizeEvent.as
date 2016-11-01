package com.snake.events
{
    import flash.events.*;

    public class ResizeEvent extends Event 
    {

        public static const RESIZE:String = "Resize";
        public static const WRESIZE:String = "WResize";
        public static const HRESIZE:String = "HResize";

        public var oldHeight:Number;
        public var oldWidth:Number;

        public function ResizeEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false, _arg4:Number=NaN, _arg5:Number=NaN)
        {
            super(_arg1, _arg2, _arg3);
            this.oldWidth = _arg4;
            this.oldHeight = _arg5;
        }

    }
}//package com.snake.events
