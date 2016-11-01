package com.snake.utils
{
    import flash.utils.*;

    public class StringUtil 
    {


        public static function addStrOn1000(_arg1:Number, _arg2:String=","):String
        {
            var _local3 = "";
            if (_arg1 < 0)
            {
                _arg1 = -(_arg1);
                _local3 = "-";
            };
            var _local4 = "";
            if (_arg1 != (_arg1 >> 0))
            {
                _local4 = ("." + String(_arg1).split(".")[1]);
                _arg1 = (_arg1 >> 0);
            };
            var _local5:String = String(_arg1);
            var _local6 = "";
            while (_local5.length > 0)
            {
                if (_local6 == "")
                {
                    _local6 = _local5.substring((_local5.length - 3), _local5.length);
                }
                else
                {
                    _local6 = ((_local5.substring((_local5.length - 3), _local5.length) + _arg2) + _local6);
                };
                _local5 = _local5.substring(0, (_local5.length - 3));
            };
            _local6 = ((_local3 + _local6) + _local4);
            return (_local6);
        }

        public static function evaluatePwd(_arg1:String):int
        {
            return (_arg1.replace(/^(?:([a-z])|([A-Z])|([0-9])|(.)){5,}|(.)+$/g, "$1$2$3$4$5").length);
        }

        public static function equalsIgnoreCase(_arg1:String, _arg2:String):Boolean
        {
            return ((_arg1.toLowerCase() == _arg2.toLowerCase()));
        }

        public static function toLocaleLowerCase(_arg1:String):String
        {
            return (_arg1.toLocaleLowerCase());
        }

        public static function toLocaleUpperCase(_arg1:String):String
        {
            return (_arg1.toLocaleUpperCase());
        }

        public static function equals(_arg1:String, _arg2:String):Boolean
        {
            return ((_arg1 == _arg2));
        }

        public static function isEmail(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            _arg1 = String(trim(_arg1));
            var _local2:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function isNumber(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            return (!(isNaN(Number(_arg1))));
        }

        public static function isNumber2(_arg1:String, _arg2:int=-1):Boolean
        {
            if (_arg2 > 0)
            {
                return (new RegExp((("^-?(\\d|,)*\\.\\d{" + _arg2.toString()) + "}$")).test(_arg1));
            };
            return (/^-?(\d|,)*[\.]?\d*$/.test(_arg1));
        }

        public static function isDouble(_arg1:String):Boolean
        {
            _arg1 = trim(_arg1);
            var _local2:RegExp = /^[-\+]?\d+(\.\d+)?$/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function isInteger(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            _arg1 = trim(_arg1);
            var _local2:RegExp = /^[-\+]?\d+$/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function isEnglish(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            _arg1 = trim(_arg1);
            var _local2:RegExp = /^[A-Za-z]+$/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function isChinese(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            _arg1 = trim(_arg1);
            var _local2:RegExp = /^[Α-￥]+$/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function isDoubleChar(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            _arg1 = trim(_arg1);
            var _local2:RegExp = /^[^\x00-\xff]+$/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function hasChineseChar(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            _arg1 = trim(_arg1);
            var _local2:RegExp = /[^\x00-\xff]/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function hasAccountChar(_arg1:String, _arg2:uint=15):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            if (_arg2 < 10)
            {
                _arg2 = 15;
            };
            _arg1 = trim(_arg1);
            var _local3:RegExp = new RegExp((("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + _arg2) + "}$"), "");
            var _local4:Object = _local3.exec(_arg1);
            if (_local4 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function isURL(_arg1:String):Boolean
        {
            if (_arg1 == null)
            {
                return (false);
            };
            _arg1 = trim(_arg1).toLowerCase();
            var _local2:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
            var _local3:Object = _local2.exec(_arg1);
            if (_local3 == null)
            {
                return (false);
            };
            return (true);
        }

        public static function isWhitespace(_arg1:String):Boolean
        {
            switch (_arg1)
            {
                case "":
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                    return (true);
                default:
                    return (false);
            };
        }

        public static function isSpecial(_arg1:String):Boolean
        {
            if (((((((((((((((((!((_arg1.indexOf("\\") == -1))) || (!((_arg1.indexOf("/") == -1))))) || (!((_arg1.indexOf("<") == -1))))) || (!((_arg1.indexOf(">") == -1))))) || (!((_arg1.indexOf('"') == -1))))) || (!((_arg1.indexOf("*") == -1))))) || (!((_arg1.indexOf("?") == -1))))) || (!((_arg1.indexOf(":") == -1))))) || (!((_arg1.indexOf("|") == -1)))))
            {
                return (true);
            };
            return (false);
        }

        public static function trim(_arg1:String):String
        {
            if (_arg1 == null)
            {
                return (null);
            };
            return (rtrim(ltrim(_arg1)));
        }

        public static function ltrim(_arg1:String):String
        {
            if (_arg1 == null)
            {
                return (null);
            };
            var _local2:RegExp = /^\s*/;
            return (_arg1.replace(_local2, ""));
        }

        public static function rtrim(_arg1:String):String
        {
            if (_arg1 == null)
            {
                return (null);
            };
            var _local2:RegExp = /\s*$/;
            return (_arg1.replace(_local2, ""));
        }

        public static function beginsWith(_arg1:String, _arg2:String):Boolean
        {
            return ((_arg2 == _arg1.substring(0, _arg2.length)));
        }

        public static function endsWith(_arg1:String, _arg2:String):Boolean
        {
            return ((_arg2 == _arg1.substring((_arg1.length - _arg2.length))));
        }

        public static function remove(_arg1:String, _arg2:String):String
        {
            return (replace(_arg1, _arg2, ""));
        }

        public static function replace(_arg1:String, _arg2:String, _arg3:String):String
        {
            return (_arg1.split(_arg2).join(_arg3));
        }

        public static function utf16to8(_arg1:String):String
        {
            var _local5:int;
            var _local2:Array = new Array();
            var _local3:uint = _arg1.length;
            var _local4:uint;
            while (_local4 < _local3)
            {
                _local5 = _arg1.charCodeAt(_local4);
                if ((((_local5 >= 1)) && ((_local5 <= 127))))
                {
                    _local2[_local4] = _arg1.charAt(_local4);
                }
                else
                {
                    if (_local5 > 2047)
                    {
                        _local2[_local4] = String.fromCharCode((224 | ((_local5 >> 12) & 15)), (128 | ((_local5 >> 6) & 63)), (128 | ((_local5 >> 0) & 63)));
                    }
                    else
                    {
                        _local2[_local4] = String.fromCharCode((192 | ((_local5 >> 6) & 31)), (128 | ((_local5 >> 0) & 63)));
                    };
                };
                _local4++;
            };
            return (_local2.join(""));
        }

        public static function utf8to16(_arg1:String):String
        {
            var _local5:int;
            var _local6:int;
            var _local7:int;
            var _local2:Array = new Array();
            var _local3:uint = _arg1.length;
            var _local4:uint;
            while (_local4 < _local3)
            {
                _local7 = _arg1.charCodeAt(_local4++);
                switch ((_local7 >> 4))
                {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                        _local2[_local2.length] = _arg1.charAt((_local4 - 1));
                        break;
                    case 12:
                    case 13:
                        _local5 = _arg1.charCodeAt(_local4++);
                        _local2[_local2.length] = String.fromCharCode((((_local7 & 31) << 6) | (_local5 & 63)));
                        break;
                    case 14:
                        _local5 = _arg1.charCodeAt(_local4++);
                        _local6 = _arg1.charCodeAt(_local4++);
                        _local2[_local2.length] = String.fromCharCode(((((_local7 & 15) << 12) | ((_local5 & 63) << 6)) | ((_local6 & 63) << 0)));
                        break;
                };
            };
            return (_local2.join(""));
        }

        public static function InterceptString(_arg1:String, _arg2:Boolean=false, _arg3:String=","):String
        {
            var _local4:uint = _arg1.indexOf(_arg3);
            if (_arg2)
            {
                _arg1 = _arg1.slice((_local4 + 1));
            }
            else
            {
                _arg1 = _arg1.slice(0, _local4);
            };
            return (_arg1);
        }

        public static function encodeCharset(_arg1:String, _arg2:String):String
        {
            var _local3:ByteArray = new ByteArray();
            _local3.writeUTFBytes(_arg1);
            _local3.position = 0;
            return (_local3.readMultiByte(_local3.length, _arg2));
        }

        public static function addAt(_arg1:String, _arg2:String, _arg3:int):String
        {
            if (_arg3 > _arg1.length)
            {
                _arg3 = _arg1.length;
            };
            var _local4:String = _arg1.substring(0, _arg3);
            var _local5:String = _arg1.substring(_arg3, _arg1.length);
            return (((_local4 + _arg2) + _local5));
        }

        public static function replaceAt(_arg1:String, _arg2:String, _arg3:int, _arg4:int):String
        {
            _arg3 = Math.max(_arg3, 0);
            _arg4 = Math.min(_arg4, _arg1.length);
            var _local5:String = _arg1.substr(0, _arg3);
            var _local6:String = _arg1.substr(_arg4, _arg1.length);
            return (((_local5 + _arg2) + _local6));
        }

        public static function removeAt(_arg1:String, _arg2:int, _arg3:int):String
        {
            return (StringUtil.replaceAt(_arg1, "", _arg2, _arg3));
        }

        public static function fixNewlines(_arg1:String):String
        {
            return (_arg1.replace(/\r\n/gm, "\n"));
        }

        public static function Contains(_arg1:String, _arg2:String):Boolean
        {
            var _local3:Boolean = new Boolean();
            var _local4:Number = _arg1.lastIndexOf(_arg2);
            if (_local4 == -1)
            {
                _local3 = false;
            }
            else
            {
                _local3 = true;
            };
            return (_local3);
        }

        public static function toLowerCase(_arg1:String):String
        {
            return (_arg1.toLowerCase());
        }

        public static function toUpperCase(_arg1:String):String
        {
            return (_arg1.toUpperCase());
        }

        public static function matchAscii(_arg1:String):Array
        {
            return (_arg1.match(/[\x00-\xFF]*/g));
        }

        public static function splitUrl(_arg1:String):Array
        {
            return (_arg1.split(/\/+|\\+|\.|\?/ig));
        }

        public static function removeHTMLTag(_arg1:String):String
        {
            return (_arg1.replace(/<.*?>/g, ""));
        }


    }
}//package com.snake.utils
