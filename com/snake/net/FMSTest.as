package com.snake.net
{
    import flash.events.*;
    import flash.utils.*;

    public class FMSTest extends EventDispatcher 
    {

        public static const TEST_FINISH:String = "test_finish";

        public var index:int = -1;
        public var fmsList:Array;
        public var list:Array;
        public var bestFMS:FmsInf;
        private var timer:Timer;


        private function get fmsURL():String
        {
            return (this.fmsList[this.index].url);
        }

        public function setFmsList(_arg1:Array):void
        {
            var _local2:ClientBW;
            this.list = _arg1;
            this.fmsList = new Array();
            var _local3:uint;
            while (_local3 < this.list.length)
            {
                _local2 = new ClientBW((_local3 + 1), ("rtmp://" + this.list[_local3]));
                this.fmsList.push(_local2);
                _local3++;
            };
        }

        public function reset():void
        {
            var _local1:* = 0;
            var _local2:* = null;
            while (_local1 < this.fmsList.length)
            {
                _local2 = this.fmsList[_local1];
                _local2.reset();
                _local1++;
            };
        }

        public function test():void
        {
            var _local1:* = 0;
            var _local2:* = null;
            var _local3:* = this;
            var _local4:* = (this.index + 1);
            var _local5:uint;
            _local3.index = _local4;
            this.reset();
            while (_local1 < this.fmsList.length)
            {
                _local2 = this.fmsList[_local1];
                setTimeout(_local2.test, _local5);
                _local5 = 1500;
                _local1++;
            };
            if (this.timer)
            {
                this.timer.reset();
                this.timer.start();
            }
            else
            {
                this.timer = new Timer(1000, 8);
                this.timer.addEventListener(TimerEvent.TIMER, this.checkTestResult);
                this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.testFinish);
                this.timer.start();
            };
        }

        public function getBest():FmsInf
        {
            var _local1:* = null;
            var _local2:* = this.fmsList[0];
            var _local3:* = 1;
            while (_local3 < this.fmsList.length)
            {
                _local1 = this.fmsList[_local3];
                if (_local2.bw < _local1.bw)
                {
                    _local2 = _local1;
                };
                _local3++;
            };
            return (_local2);
        }

        public function checkTestResult(_arg1:TimerEvent):void
        {
            var _local2:* = null;
            var _local3:* = 0;
            var _local4:* = 0;
            while (_local4 < this.fmsList.length)
            {
                _local2 = this.fmsList[_local4];
                if (_local2.bw > 0)
                {
                    _local3++;
                };
                _local4++;
            };
            if (_local3 == this.fmsList.length)
            {
                this.timer.stop();
                this.testFinish();
            };
        }

        public function stopTest():void
        {
            var _local1:* = null;
            var _local2:* = 0;
            while (_local2 < this.fmsList.length)
            {
                _local1 = this.fmsList[_local2];
                _local1.stop();
                _local2++;
            };
        }

        public function testFinish(_arg1:TimerEvent=null):void
        {
            this.stopTest();
            this.bestFMS = this.getBest();
            dispatchEvent(new Event(TEST_FINISH));
        }


    }
}//package com.snake.net
