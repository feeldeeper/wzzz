package com.snake.utils
{
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;

    public class MovieUtils 
    {

        private static var dic:Dictionary = new Dictionary();


        public static function removeMovie(_arg1:MovieClip):void
        {
            if (dic[_arg1] != null)
            {
                _arg1.removeEventListener(Event.ENTER_FRAME, enterFrame);
                dic[_arg1] = null;
            };
        }

        public static function movieFrame(_arg1:MovieClip, _arg2, _arg3:Function=null):void
        {
            var _local4:Object;
            var _local5:Array;
            var _local6:uint;
            var _local7:uint;
            var _local8:FrameLabel;
            if (dic[_arg1] == null)
            {
                _local4 = new Object();
                dic[_arg1] = _local4;
            }
            else
            {
                _arg1.removeEventListener(Event.ENTER_FRAME, enterFrame);
                _local4 = dic[_arg1];
            };
            _local4.movie = _arg1;
            if ((_arg2 is String))
            {
                _local5 = _arg1.currentLabels;
                _local6 = 1;
                _local7 = 0;
                while (_local7 < _local5.length)
                {
                    _local8 = _local5[_local7];
                    if (_local8.name == _arg2)
                    {
                        _local6 = _local8.frame;
                        break;
                    };
                    _local7++;
                };
                _local4.end = _local6;
            }
            else
            {
                _local4.end = _arg2;
            };
            if (_local4.end > _arg1.totalFrames)
            {
                _local4.end = _arg1.totalFrames;
            };
            if (_arg1.currentFrame < _local4.end)
            {
                _local4.aspect = true;
            }
            else
            {
                _local4.aspect = false;
            };
            _local4.start = _arg1.currentFrame;
            _local4.endFun = _arg3;
            _arg1.addEventListener(Event.ENTER_FRAME, enterFrame);
        }

        private static function enterFrame(_arg1:Event):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            var _local3:Object = dic[_local2];
            if (_local3 == null)
            {
                return;
            };
            if (_local2.currentFrame == _local3.end)
            {
                _local2.removeEventListener(Event.ENTER_FRAME, enterFrame);
            };
            if (_local3.aspect)
            {
                if (_local2.currentFrame >= _local3.end)
                {
                    _local2.gotoAndStop(_local3.end);
                    _local2.removeEventListener(Event.ENTER_FRAME, enterFrame);
                    if (_local3.endFun != null)
                    {
                        _local3.endFun();
                    };
                }
                else
                {
                    _local2.gotoAndStop((_local2.currentFrame + 1));
                    if (_local2.currentFrame == _local3.end)
                    {
                        _local2.gotoAndStop(_local3.end);
                        _local2.removeEventListener(Event.ENTER_FRAME, enterFrame);
                        if (_local3.endFun != null)
                        {
                            _local3.endFun();
                        };
                    };
                };
            }
            else
            {
                if (_local2.currentFrame <= _local3.end)
                {
                    _local2.gotoAndStop(_local3.end);
                    _local2.removeEventListener(Event.ENTER_FRAME, enterFrame);
                    if (_local3.endFun != null)
                    {
                        _local3.endFun();
                    };
                }
                else
                {
                    _local2.gotoAndStop((_local2.currentFrame - 1));
                    if (_local2.currentFrame == _local3.end)
                    {
                        _local2.removeEventListener(Event.ENTER_FRAME, enterFrame);
                        if (_local3.endFun != null)
                        {
                            _local3.endFun();
                        };
                    };
                };
            };
        }


    }
}//package com.snake.utils
