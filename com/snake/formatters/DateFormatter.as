package com.snake.formatters
{
    public class DateFormatter 
    {

        private static const VALID_PATTERN_CHARS:String = "Y,M,D,E,t,H,h,K,k,m,s,S";
        public static const YEAR:String = "Y";
        public static const MONTH:String = "M";
        public static const DATE_IN_MONTH:String = "D";
        public static const DATE_OF_WEEK:String = "E";
        public static const TIME_OF_DAY:String = "t";
        public static const HOUR_OF_DAY0:String = "K";
        public static const HOUR_OF_DAY1:String = "H";
        public static const HOUR0:String = "k";
        public static const HOUR1:String = "h";
        public static const MINUTE:String = "m";
        public static const SECOND:String = "s";
        public static const MILLISECOND:String = "S";

        public var template:String;
        private var dateInfo:DateInfo;

        public function DateFormatter(_arg1:String="MM/DD/YYYY", _arg2:DateInfo=null)
        {
            this.template = _arg1;
            if (_arg2 != null)
            {
                this.dateInfo = _arg2;
            }
            else
            {
                this.dateInfo = new DateInfo();
            };
        }

        public static function formatSingle(_arg1:String, _arg2:Date=null, _arg3:DateInfo=null):String
        {
            if (_arg2 == null)
            {
                _arg2 = new Date();
            };
            return (new (DateFormatter)(_arg1, _arg3).format(_arg2));
        }

        public static function getTime(_arg1:Date=null, _arg2:DateInfo=null):String
        {
            if (_arg1 == null)
            {
                _arg1 = new Date();
            };
            if (_arg2 == null)
            {
                _arg2 = new DateInfo();
            };
            var _local3:DateFormatter = new (DateFormatter)(_arg2.time, _arg2);
            return (_local3.format(_arg1));
        }

        public static function getDateShort(_arg1:Date=null, _arg2:DateInfo=null):String
        {
            if (_arg1 == null)
            {
                _arg1 = new Date();
            };
            if (_arg2 == null)
            {
                _arg2 = new DateInfo();
            };
            var _local3:DateFormatter = new (DateFormatter)(_arg2.dateShort, _arg2);
            return (_local3.format(_arg1));
        }

        public static function getDateLong(_arg1:Date=null, _arg2:DateInfo=null):String
        {
            if (_arg1 == null)
            {
                _arg1 = new Date();
            };
            if (_arg2 == null)
            {
                _arg2 = new DateInfo();
            };
            var _local3:DateFormatter = new (DateFormatter)(_arg2.dateLong, _arg2);
            return (_local3.format(_arg1));
        }

        private static function setValue(_arg1:Object, _arg2:int):String
        {
            var _local5:int;
            var _local6:int;
            var _local3 = "";
            var _local4:int = _arg1.toString().length;
            if (_local4 < _arg2)
            {
                _local5 = (_arg2 - _local4);
                _local6 = 0;
                while (_local6 < _local5)
                {
                    _local3 = (_local3 + "0");
                    _local6++;
                };
            };
            return ((_local3 + _arg1.toString()));
        }


        public function format(_arg1:Date=null):String
        {
            var _local6:Number;
            var _local8:int;
            if (_arg1 == null)
            {
                _arg1 = new Date();
            };
            var _local2:String = this.template;
            var _local3:int = _local2.length;
            var _local4 = "";
            var _local5 = "";
            var _local7 = "";
            while (_local3 > 0)
            {
                _local3--;
                _local5 = _local2.charAt(_local3);
                _local6 = _local5.charCodeAt(0);
                if (((!((VALID_PATTERN_CHARS.indexOf(_local5) == -1))) && (!((_local5 == ",")))))
                {
                    _local8 = _local3;
                    do 
                    {
                    } while (_local2.charCodeAt(--_local3) == _local6);
                    _local7 = (this.extractTokenDate(_arg1, _local5, (_local8 - _local3++)) + _local7);
                }
                else
                {
                    _local7 = (_local5 + _local7);
                };
            };
            return (_local7);
        }

        private function extractTokenDate(_arg1:Date, _arg2:String, _arg3:uint):String
        {
            var _local5:int;
            var _local6:int;
            var _local7:String;
            var _local8:int;
            var _local9:int;
            var _local10:int;
            var _local11:int;
            var _local4 = "";
            switch (_arg2)
            {
                case YEAR:
                    _local7 = _arg1.getFullYear().toString();
                    if (_arg3 < 3)
                    {
                        return (_local7.substr(2));
                    };
                    if (_arg3 > 4)
                    {
                        return (setValue(Number(_local7), _arg3));
                    };
                    return (_local7);
                case MONTH:
                    _local8 = int(_arg1.getMonth());
                    if (_arg3 < 3)
                    {
                        _local4 = (_local4 + setValue(++_local8, _arg3));
                        return (_local4);
                    };
                    if (_arg3 == 3)
                    {
                        return (this.dateInfo.monthNamesShort[_local8]);
                    };
                    return (this.dateInfo.monthNamesLong[_local8]);
                case DATE_IN_MONTH:
                    _local5 = int(_arg1.getDate());
                    if (_arg3 < 3)
                    {
                        return (setValue(_local5, _arg3));
                    };
                    return (this.dateInfo.todayNames[_local5]);
                case DATE_OF_WEEK:
                    _local5 = int(_arg1.getDay());
                    if (_arg3 < 3)
                    {
                        _local4 = (_local4 + setValue(_local5, _arg3));
                        return (_local4);
                    };
                    if (_arg3 == 3)
                    {
                        return (this.dateInfo.dayNamesShort[_local5]);
                    };
                    return (this.dateInfo.dayNamesLong[_local5]);
                case TIME_OF_DAY:
                    _local6 = int(_arg1.getHours());
                    if (_local6 < 12)
                    {
                        return (this.dateInfo.timeOfDay[0]);
                    };
                    return (this.dateInfo.timeOfDay[1]);
                case HOUR_OF_DAY1:
                    _local6 = (int(_arg1.getHours()) + 1);
                    _local4 = (_local4 + setValue(_local6, _arg3));
                    return (_local4);
                case HOUR_OF_DAY0:
                    _local6 = int(_arg1.getHours());
                    _local4 = (_local4 + setValue(_local6, _arg3));
                    return (_local4);
                case HOUR0:
                    _local6 = int(_arg1.getHours());
                    if (_local6 >= 12)
                    {
                        _local6 = (_local6 - 12);
                    };
                    _local4 = (_local4 + setValue(_local6, _arg3));
                    return (_local4);
                case HOUR1:
                    _local6 = int(_arg1.getHours());
                    if (_local6 == 0)
                    {
                        _local6 = 12;
                    }
                    else
                    {
                        if (_local6 > 12)
                        {
                            _local6 = (_local6 - 12);
                        };
                    };
                    _local4 = (_local4 + setValue(_local6, _arg3));
                    return (_local4);
                case MINUTE:
                    _local9 = int(_arg1.getMinutes());
                    _local4 = (_local4 + setValue(_local9, _arg3));
                    return (_local4);
                case SECOND:
                    _local10 = int(_arg1.getSeconds());
                    _local4 = (_local4 + setValue(_local10, _arg3));
                    return (_local4);
                case MILLISECOND:
                    _local11 = int(_arg1.getMilliseconds());
                    _local4 = (_local4 + setValue(_local11, _arg3));
                    return (_local4);
            };
            return (_local4);
        }


    }
}//package com.snake.formatters
