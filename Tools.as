package 
{
    import flash.events.*;
    import flash.net.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;
    import com.adobe.serialization.json.*;
    import flash.system.*;
    import com.snake.utils.*;
    import com.hurlant.util.*;
    import com.adobe.crypto.*;
    import flash.external.*;

    public class Tools 
    {


        public static function json_decode(value:String):Object
        {
            var obj:Object;
            try
            {
				//trace(value);
                obj = JSON10.decode(value);
            }
            catch(e)
            {
                DebugOutput.add(("JSON decodeError:" + value));
                obj = null;
            };
            return (obj);
        }

        public static function json_encode(value:Object):String
        {
            var srt:String = "";
            try
            {
                srt = JSON10.encode(value);
            }
            catch(e)
            {
                DebugOutput.add(("JSON encodeError:" + value));
                srt = "";
            };
            return (srt);
        }

        public static function setNoMouse(_arg1:MovieClip):void
        {
            ButtonUtil.setNoMouse(_arg1);
        }

        public static function setEmbedFonts(_arg1:TextField, _arg2:String, _arg3:Boolean=true):void
        {
            TextUtil.setEmbedFonts(_arg1, _arg2, _arg3);
        }

        public static function removeEmbedFonts(_arg1:TextField):void
        {
            TextUtil.removeEmbedFonts(_arg1);
        }

        public static function setEmbedFontsByCSS(_arg1:TextField, _arg2:StyleSheet, _arg3:String):void
        {
            TextUtil.setEmbedFontsByCSS(_arg1, _arg2, _arg3);
        }

        public static function setMaxChars(_arg1:TextField, _arg2:int):void
        {
            TextUtil.setMaxChars(_arg1, _arg2);
        }

        public static function setTxtInData(_arg1:TextField, _arg2:String="A-Z a-z 0-9"):void
        {
            TextUtil.setTxtInData(_arg1, _arg2);
        }

        public static function addTextMovieBg(_arg1:TextField, _arg2:MovieClip, _arg3:Boolean=false):void
        {
            TextUtil.addTextMovieBg(_arg1, _arg2, _arg3);
        }

        public static function removeTextMovieBg(_arg1:TextField):void
        {
            TextUtil.removeTextMovieBg(_arg1);
        }

        public static function addDefaultInfo(_arg1:TextField, _arg2:String, _arg3:Boolean=false):void
        {
            TextUtil.addDefaultInfo(_arg1, _arg2, _arg3);
        }

        public static function getDefaultBool(_arg1:TextField):Boolean
        {
            return (TextUtil.getDefaultBool(_arg1));
        }

        public static function setTimeOut(_arg1:Function, _arg2:Number, _arg3=null):uint
        {
            return (setTimeout(_arg1, _arg2, _arg3));
        }

        public static function clearTimeOut(_arg1:uint):void
        {
            clearTimeout(_arg1);
        }

        public static function randRange(_arg1:Number, _arg2:Number):Number
        {
            return ((Math.floor((Math.random() * ((_arg2 - _arg1) + 1))) + _arg1));
        }

        public static function setSelectArr(_arg1:Array, _arg2:Number=0):void
        {
            ButtonUtil.setSelectArr(_arg1, _arg2);
        }

        public static function setSelectArrByBtn(_arg1:MovieClip):void
        {
            ButtonUtil.setSelectArrByBtn(_arg1);
        }

        public static function setSelectBtn(_arg1:MovieClip, _arg2:Boolean=true):void
        {
            ButtonUtil.setSelectBtn(_arg1, _arg2);
        }

        public static function setButton(_arg1:MovieClip, _arg2:String=""):void
        {
            ButtonUtil.setButton(_arg1, _arg2);
        }

        public static function setHitArea(_arg1:Sprite, _arg2:Sprite):void
        {
            _arg2.mouseEnabled = false;
            _arg1.hitArea = _arg2;
        }

        public static function movieFrame(_arg1:MovieClip, _arg2, _arg3:Function=null):void
        {
            MovieUtils.movieFrame(_arg1, _arg2, _arg3);
        }

        public static function removeMovie(_arg1:MovieClip):void
        {
            MovieUtils.removeMovie(_arg1);
        }

        public static function toGBKUTF8(_arg1:Boolean):void
        {
            System.useCodePage = _arg1;
        }

        public static function callJs(_arg1:String, _arg2:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_arg1, _arg2);
            };
        }

        public static function callJs2(_arg1:String, _arg2:String, _arg3:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_arg1, _arg2, _arg3);
            };
        }

        public static function callJsArr(_arg1:String, ... _args):void
        {
            DebugOutput.add("callJsArr:", _arg1, _args);
            if (ExternalInterface.available)
            {
                if (_args.length == 0)
                {
                    ExternalInterface.call(_arg1);
                };
                if (_args.length == 1)
                {
                    ExternalInterface.call(_arg1, _args[0]);
                };
                if (_args.length == 2)
                {
                    ExternalInterface.call(_arg1, _args[0], _args[1]);
                };
                if (_args.length == 3)
                {
                    ExternalInterface.call(_arg1, _args[0], _args[1], _args[2]);
                };
                if (_args.length == 4)
                {
                    ExternalInterface.call(_arg1, _args[0], _args[1], _args[2], _args[3]);
                };
                if (_args.length == 5)
                {
                    ExternalInterface.call(_arg1, _args[0], _args[1], _args[2], _args[3], _args[4]);
                };
            };
        }

        public static function getDataUrl(url:String, barkFun:Function, errorFun:Function=null):URLLoader
        {
            var request:URLRequest = new URLRequest(url);
            var loader:URLLoader = new URLLoader();
            if (errorFun == null)
            {
                loader.addEventListener(IOErrorEvent.IO_ERROR, function ():void
                {
                });
            }
            else
            {
                loader.addEventListener(IOErrorEvent.IO_ERROR, errorFun);
            };
            loader.addEventListener(Event.COMPLETE, barkFun);
            loader.load(request);
            return (loader);
        }

        public static function getToURL(_arg1:String):void
        {
            sendToURL(new URLRequest(_arg1));
        }

        public static function postDataUrl(url:String, barkFun:Function, data:Object=null, errorFun:Function=null, contentType:String="application/x-www-form-urlencoded"):URLLoader
        {
            var variables:URLVariables;
            var prop:* = undefined;
            var request:URLRequest = new URLRequest(url);
            request.contentType = contentType;
            if (((data) && ((contentType == "application/x-www-form-urlencoded"))))
            {
                variables = new URLVariables();
                for (prop in data)
                {
                    variables[prop] = data[prop];
                };
                request.data = variables;
            }
            else
            {
                if (((data) && ((contentType == "application/octet-stream"))))
                {
                    request.data = data;
                };
            };
            request.method = URLRequestMethod.POST;
            var loader:URLLoader = new URLLoader();
            if (errorFun == null)
            {
                loader.addEventListener(IOErrorEvent.IO_ERROR, function ():void
                {
                });
            }
            else
            {
                loader.addEventListener(IOErrorEvent.IO_ERROR, errorFun);
            };
            loader.addEventListener(Event.COMPLETE, barkFun);
            loader.load(request);
            return (loader);
        }

        public static function postDataUrlByData(url:String, barkFun:Function, data:Object=null, errorFun:Function=null, contentType:String="application/x-www-form-urlencoded"):URLLoader
        {
            var variables:URLVariables;
            var prop:* = undefined;
            var request:URLRequest = new URLRequest(url);
            request.contentType = contentType;
            if (data)
            {
                variables = new URLVariables();
                for (prop in data)
                {
                    variables[prop] = data[prop];
                };
                request.data = variables;
            };
            request.method = URLRequestMethod.POST;
            var loader:URLLoader = new URLLoader();
            if (errorFun == null)
            {
                loader.addEventListener(IOErrorEvent.IO_ERROR, function ():void
                {
                });
            }
            else
            {
                loader.addEventListener(IOErrorEvent.IO_ERROR, errorFun);
            };
            loader.addEventListener(Event.COMPLETE, barkFun);
            loader.dataFormat = URLLoaderDataFormat.VARIABLES;
            loader.load(request);
            return (loader);
        }

        public static function getUrl(_arg1:String, _arg2:String="_blank"):void
        {
            navigateToURL(new URLRequest(_arg1), _arg2);
        }

        public static function getNetError(_arg1:String):String
        {
            var _local2:uint;
            if (_arg1.indexOf("Error") == 0)
            {
                _local2 = _arg1.indexOf(":");
                return (_arg1.slice((_local2 + 1)));
            };
            return ("true");
        }

        public static function GC():void
        {
            var _local1:LocalConnection;
            var _local2:LocalConnection;
            try
            {
                _local1 = new LocalConnection();
                _local2 = new LocalConnection();
                _local1.connect("name");
                _local2.connect("name");
            }
            catch(e:Error)
            {
            };
        }

        public static function getAuthCode(_arg1:String, _arg2:String="DECODE", _arg3:String="", _arg4:uint=0):String
        {
            var _local5:String;
            var _local6:String;
            var _local15:uint;
            var _local17:Number;
            _arg1 = utf16to8(_arg1);
            var _local7:uint = 4;
            _arg3 = MD5.hash(_arg3);
            var _local8:String = MD5.hash(_arg3.substr(0, 16));
            var _local9:String = MD5.hash(_arg3.substr(16, 16));
            var _local10:String = MD5.hash("0.78761100").substr(-(_local7));
            var _local11:String = (_local8 + MD5.hash((_local8 + _local10)));
            var _local12:uint = _local11.length;
            _arg1 = ((sprintf("%010d", ((_arg4) ? (_arg4 + 1387892882) : 0)) + MD5.hash((_arg1 + _local9)).substr(0, 16)) + _arg1);
            var _local13:uint = _arg1.length;
            var _local14:Array = new Array();
            _local15 = 0;
            while (_local15 <= 0xFF)
            {
                _local14.push(_local15);
                _local15++;
            };
            var _local16:Array = new Array();
            _local15 = 0;
            while (_local15 <= 0xFF)
            {
                _local16[_local15] = _local11.substr((_local15 % _local12), 1).charCodeAt(0);
                _local15++;
            };
            _local15 = 0;
            var _local18:uint = _local15;
            while (_local15 < 0x0100)
            {
                _local18 = (((_local18 + _local14[_local15]) + _local16[_local15]) % 0x0100);
                _local17 = _local14[_local15];
                _local14[_local15] = _local14[_local18];
                _local14[_local18] = _local17;
                _local15++;
            };
            var _local19 = "";
            _local15 = 0;
            _local18 = _local15;
            var _local20:uint = _local18;
            while (_local15 < _local13)
            {
                _local20 = ((_local20 + 1) % 0x0100);
                _local18 = ((_local18 + _local14[_local20]) % 0x0100);
                _local17 = _local14[_local20];
                _local14[_local20] = _local14[_local18];
                _local14[_local18] = _local17;
                _local19 = (_local19 + String.fromCharCode((_arg1.substr(_local15, 1).charCodeAt(0) ^ _local14[((_local14[_local20] + _local14[_local18]) % 0x0100)])));
                _local15++;
            };
            _local5 = (_local10 + Base64.encode(_local19).replace(/=/gi, ""));
            DebugOutput.add(_local5);
            return (_local6);
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

        public static function chr(_arg1):String
        {
            if (_arg1 > 0xFFFF)
            {
                _arg1 = (_arg1 - 65536);
                return (String.fromCharCode((0xD800 + (_arg1 >> 10)), (0xDC00 + (_arg1 & 1023))));
            };
            return (String.fromCharCode(_arg1));
        }

        public static function removeAllChild(_arg1):void
        {
            while (_arg1.numChildren > 0)
            {
                _arg1.removeChildAt(0);
            };
        }

        public static function getLiveAppName(_arg1:String):String
        {
            var _local2:RegExp = /\:[0-9]{4}\/.*\//ig;
            var _local3:Array = _arg1.match(_local2);
            return (_local3[0]);
        }

        public static function userNameMask(_arg1:String):String
        {
            var _local2:uint;
            if (_arg1.length > 4)
            {
                _local2 = Tools.randRange((_arg1.length - 2), _arg1.length);
            }
            else
            {
                _local2 = 2;
            };
            var _local3:String = _arg1.substr((_local2 - 2), 2);
            var _local4:String = _arg1.replace(_local3, "**");
            return (_local4);
        }

        public static function formatLimitFloor(_arg1:uint):uint
        {
            _arg1 = Math.floor((_arg1 / 100));
            return ((_arg1 * 100));
        }


    }
}//package 
