package com.snake.utils
{
    public final class ObjectUtil 
    {


        public static function ObjtoString(_arg1:Object):String
        {
            var _local3:*;
            var _local2 = "[ ";
            for (_local3 in _arg1)
            {
                _local2 = (_local2 + (((_local3 + "=") + _arg1[_local3]) + " "));
            };
            return ((_local2 + "]"));
        }

        public static function objOneObj(_arg1:Object)
        {
            var _local2:*;
            var _local3:*;
            for (_local3 in _arg1)
            {
                _local2 = _arg1[_local3];
                break;
            };
            return (_local2);
        }

        public static function objOneStr(_arg1:Object):String
        {
            var _local2:String;
            var _local3:*;
            for (_local3 in _arg1)
            {
                _local2 = String(_arg1[_local3]);
                break;
            };
            return (_local2);
        }

        public static function value2toString(_arg1:Object, _arg2:String):String
        {
            var _local3 = "no data";
            if (_arg1[_arg2] != null)
            {
                _local3 = String(_arg1[_arg2]);
            };
            return (_local3);
        }

        public static function combinedData(_arg1:Object, _arg2:Object, _arg3:Boolean=true):Object
        {
            var _local4:*;
            if (!_arg3)
            {
                for (_local4 in _arg2)
                {
                    _arg1[_local4] = _arg2[_local4];
                };
            }
            else
            {
                for (_local4 in _arg2)
                {
                    if (!_arg1.hasOwnProperty(_local4))
                    {
                        _arg1[_local4] = _arg2[_local4];
                    };
                };
            };
            return (_arg1);
        }

        public static function upData(_arg1:Object, _arg2:Object, _arg3:Boolean=true):Object
        {
            var _local4:*;
            if (!_arg3)
            {
                for (_local4 in _arg2)
                {
                    _arg1[_local4] = _arg2[_local4];
                };
            }
            else
            {
                for (_local4 in _arg2)
                {
                    if (_arg1.hasOwnProperty(_local4))
                    {
                        _arg1[_local4] = _arg2[_local4];
                    };
                };
            };
            return (_arg1);
        }

        public static function copyObj(_arg1:Object):Object
        {
            var _local3:*;
            var _local2:Object = new Object();
            for (_local3 in _arg1)
            {
                _local2[_local3] = _arg1[_local3];
            };
            return (_local2);
        }


    }
}//package com.snake.utils
