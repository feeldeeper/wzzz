package com.snake.utils
{
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import com.snake.net.*;
    import flash.utils.*;

    public class TextUtil 
    {

        private static var textInPutBgDic:Dictionary = new Dictionary();
        private static var defaultInfoDic:Dictionary = new Dictionary();
        private static var fontsLibrary:Dictionary = new Dictionary();


        public static function setMaxChars(_arg1:TextField, _arg2:int):void
        {
            _arg1.maxChars = _arg2;
        }

        public static function setTxtInData(_arg1:TextField, _arg2:String="A-Z a-z 0-9"):void
        {
            _arg1.restrict = _arg2;
        }

        public static function addTextMovieBg(_arg1:TextField, _arg2:MovieClip, _arg3:Boolean=false):void
        {
            if (textInPutBgDic[_arg1] == null)
            {
                textInPutBgDic[_arg1] = {
                    "text":_arg1,
                    "movie":_arg2,
                    "move":_arg3,
                    "focus":false
                };
            }
            else
            {
                textInPutBgDic[_arg1].text = _arg1;
                textInPutBgDic[_arg1].movie = _arg2;
                textInPutBgDic[_arg1].move = _arg3;
                textInPutBgDic[_arg1].focus = false;
            };
            _arg1.type = "input";
            _arg1.addEventListener(FocusEvent.FOCUS_IN, inPutFocusIn);
            _arg1.addEventListener(FocusEvent.FOCUS_OUT, inPutFocusOut);
            _arg1.addEventListener(MouseEvent.MOUSE_OVER, inPutFocusOVER);
            _arg1.addEventListener(MouseEvent.MOUSE_OUT, inPutFocusOUT);
        }

        private static function inPutFocusOUT(_arg1:MouseEvent):void
        {
            var _local3:MovieClip;
            var _local4:Boolean;
            var _local2:TextField = (_arg1.target as TextField);
            if (textInPutBgDic[_local2] != null)
            {
                _local3 = (textInPutBgDic[_local2].movie as MovieClip);
                _local4 = textInPutBgDic[_local2].move;
                if (_local4)
                {
                    if (_local3)
                    {
                        if (textInPutBgDic[_local2].focus)
                        {
                            _local3.gotoAndStop(2);
                        }
                        else
                        {
                            _local3.gotoAndStop(1);
                        };
                    }
                    else
                    {
                        removeTextMovieBg(_local2);
                    };
                };
            };
        }

        private static function inPutFocusOVER(_arg1:MouseEvent):void
        {
            var _local3:MovieClip;
            var _local4:Boolean;
            var _local2:TextField = (_arg1.target as TextField);
            if (textInPutBgDic[_local2] != null)
            {
                _local3 = (textInPutBgDic[_local2].movie as MovieClip);
                _local4 = textInPutBgDic[_local2].move;
                if (_local4)
                {
                    if (_local3)
                    {
                        _local3.gotoAndStop(2);
                    }
                    else
                    {
                        removeTextMovieBg(_local2);
                    };
                };
            };
        }

        public static function removeTextMovieBg(_arg1:TextField):void
        {
            if (textInPutBgDic[_arg1] != null)
            {
                textInPutBgDic[_arg1] = null;
            };
            _arg1.removeEventListener(FocusEvent.FOCUS_IN, inPutFocusIn);
            _arg1.removeEventListener(FocusEvent.FOCUS_OUT, inPutFocusOut);
            _arg1.removeEventListener(MouseEvent.MOUSE_OVER, inPutFocusOVER);
            _arg1.removeEventListener(MouseEvent.MOUSE_OUT, inPutFocusOUT);
        }

        private static function inPutFocusOut(_arg1:FocusEvent):void
        {
            var _local3:MovieClip;
            var _local2:TextField = (_arg1.target as TextField);
            if (textInPutBgDic[_local2] != null)
            {
                _local3 = (textInPutBgDic[_local2].movie as MovieClip);
                textInPutBgDic[_local2].focus = false;
                if (_local3)
                {
                    _local3.gotoAndStop(1);
                }
                else
                {
                    removeTextMovieBg(_local2);
                };
            };
        }

        private static function inPutFocusIn(_arg1:FocusEvent):void
        {
            var _local3:MovieClip;
            var _local2:TextField = (_arg1.target as TextField);
            if (textInPutBgDic[_local2] != null)
            {
                _local3 = (textInPutBgDic[_local2].movie as MovieClip);
                textInPutBgDic[_local2].focus = true;
                if (_local3)
                {
                    _local3.gotoAndStop(2);
                }
                else
                {
                    removeTextMovieBg(_local2);
                };
            };
        }

        public static function getDefaultInfo(_arg1:TextField):String
        {
            if (defaultInfoDic[_arg1] == null)
            {
                return (null);
            };
            return (defaultInfoDic[_arg1].value);
        }

        public static function getDefaultBool(_arg1:TextField):Boolean
        {
            if ((((_arg1.text == "")) || ((_arg1.text == getDefaultInfo(_arg1)))))
            {
                return (false);
            };
            if (StringUtil.ltrim(StringUtil.rtrim(_arg1.text)) != "")
            {
                return (true);
            };
            return (false);
        }

        public static function addDefaultInfo(_arg1:TextField, _arg2:String, _arg3:Boolean=false):void
        {
            if (defaultInfoDic[_arg1] == null)
            {
                defaultInfoDic[_arg1] = {
                    "text":_arg1,
                    "value":_arg2,
                    "password":_arg3
                };
            }
            else
            {
                defaultInfoDic[_arg1].value = _arg2;
            };
            _arg1.type = "input";
            _arg1.text = _arg2;
            _arg1.addEventListener(FocusEvent.FOCUS_IN, defaultFocusIn);
            _arg1.addEventListener(FocusEvent.FOCUS_OUT, defaultFocusOut);
        }

        private static function defaultFocusOut(_arg1:FocusEvent):void
        {
            var _local2:TextField = (_arg1.target as TextField);
            if (defaultInfoDic[_local2] != null)
            {
                if ((((_local2.text == defaultInfoDic[_local2].value)) || ((_local2.text == ""))))
                {
                    _local2.text = defaultInfoDic[_local2].value;
                    _local2.displayAsPassword = false;
                }
                else
                {
                    if (defaultInfoDic[_local2].password)
                    {
                        _local2.displayAsPassword = true;
                    };
                };
            }
            else
            {
                removeDefaultInfo(_local2);
            };
        }

        private static function defaultFocusIn(_arg1:FocusEvent):void
        {
            var _local2:TextField = (_arg1.target as TextField);
            if (defaultInfoDic[_local2] != null)
            {
                if ((((_local2.text == defaultInfoDic[_local2].value)) || ((_local2.text == ""))))
                {
                    if (defaultInfoDic[_local2].password)
                    {
                        _local2.displayAsPassword = true;
                    }
                    else
                    {
                        _local2.displayAsPassword = false;
                    };
                    _local2.text = "";
                };
            }
            else
            {
                removeDefaultInfo(_local2);
            };
        }

        public static function removeDefaultInfo(_arg1:TextField):void
        {
            if (defaultInfoDic[_arg1] != null)
            {
                _arg1.removeEventListener(FocusEvent.FOCUS_IN, defaultFocusIn);
                _arg1.removeEventListener(FocusEvent.FOCUS_OUT, defaultFocusOut);
                defaultInfoDic[_arg1] = null;
            };
        }

        public static function setEmbedFontsAndCSS(_arg1:TextField, _arg2:String):void
        {
            var _local3:StyleSheet = new StyleSheet();
            _local3.parseCSS(_arg2);
            _arg1.embedFonts = true;
            _arg1.styleSheet = _local3;
        }

        public static function setEmbedFonts(_arg1:TextField, _arg2:String, _arg3:Boolean=true):void
        {
            var _local4:TextFormat;
            if (_arg3)
            {
                _arg1.embedFonts = true;
                _local4 = new TextFormat();
                if (getFont(_arg2) != null)
                {
                    _local4.font = getFont(_arg2).fontName;
                };
                _arg1.setTextFormat(_local4);
            }
            else
            {
                removeEmbedFonts(_arg1);
            };
        }

        public static function setEmbedFontsByCSS(_arg1:TextField, _arg2:StyleSheet, _arg3:String):void
        {
            var _local4:TextFormat;
            _arg1.embedFonts = true;
            var _local5:Object = _arg2.getStyle(_arg3);
            _local4 = _arg2.transform(_local5);
            _arg1.setTextFormat(_local4);
        }

        public static function removeEmbedFonts(_arg1:TextField):void
        {
            _arg1.embedFonts = false;
            var _local2:TextFormat = new TextFormat();
            _arg1.setTextFormat(_local2);
        }

        public static function loadFonts(_arg1:String, _arg2:String):FontsLoader
        {
            var _local3:FontsLoader;
            if (fontsLibrary[_arg2] != null)
            {
                fontsLibrary[_arg2].destroy();
            };
            _local3 = new FontsLoader(_arg2);
            fontsLibrary[_arg2] = _local3;
            fontsLibrary[_local3] = _local3;
            _local3.load(_arg1);
            return (_local3);
        }

        public static function getFont(_arg1:String):Font
        {
            var _local2:Array = Font.enumerateFonts();
            var _local3:int;
            while (_local3 < _local2.length)
            {
                if (_local2[_local3].fontName == _arg1)
                {
                    return (_local2[_local3]);
                };
                _local3++;
            };
            return (null);
        }

        public static function getLoadFontByName(_arg1:String):FontsLoader
        {
            if (fontsLibrary[_arg1] != null)
            {
                return (fontsLibrary[_arg1]);
            };
            return (null);
        }

        public static function getLoadFontByLoader(_arg1:FontsLoader):FontsLoader
        {
            if (fontsLibrary[_arg1] != null)
            {
                return (fontsLibrary[_arg1]);
            };
            return (null);
        }


    }
}//package com.snake.utils
