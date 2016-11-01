package com.snake.net
{
    public class FmsInf 
    {

        public var id:int = 0;
        public var url:String;
        public var psw:String;
        public var bw:Number = -1;
        public var delay:Number = -1;

        public function FmsInf(_arg1:int, _arg2:String=null, _arg3:String=null)
        {
            this.id = _arg1;
            this.url = _arg2;
            this.psw = _arg3;
        }

        public function toString():String
        {
            return ((((((((this.id + "  ") + this.url) + "\n  |---bw：") + this.bw) + "Kbps") + "  delay:") + this.delay));
        }

        public function reset():void
        {
            this.bw = -1;
            this.delay = -1;
        }


    }
}//package com.snake.net
