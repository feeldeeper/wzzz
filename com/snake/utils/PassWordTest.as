package com.snake.utils
{
    public class PassWordTest 
    {

        private static var arr:Array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];


        public static function randomPassWore():String
        {
            var _local2:uint;
            var _local3:String;
            var _local1 = "";
            while (_local1.length < 8)
            {
                _local2 = Math.floor((Math.random() * arr.length));
                _local3 = arr[_local2];
                _local1 = (_local1 + _local3);
            };
            return (_local1);
        }

        public static function getStrength(_arg1:String):uint
        {
            var _local2:uint;
            if (_arg1.match(/[a-z]/))
            {
                _local2 = (_local2 + 1);
            };
            if (_arg1.match(/[A-Z]/))
            {
                _local2 = (_local2 + 5);
            };
            if (_arg1.match(/\d+/))
            {
                _local2 = (_local2 + 5);
            };
            if (_arg1.match(/(\d.*\d.*\d)/))
            {
                _local2 = (_local2 + 5);
            };
            if (_arg1.match(/[!,@#$%^&*?_~]/))
            {
                _local2 = (_local2 + 5);
            };
            if (_arg1.match(/([!,@#$%^&*?_~].*[!,@#$%^&*?_~])/))
            {
                _local2 = (_local2 + 5);
            };
            if (((_arg1.match(/[a-z]/)) && (_arg1.match(/[A-Z]/))))
            {
                _local2 = (_local2 + 2);
            };
            if (((_arg1.match(/\d/)) && (_arg1.match(/\D/))))
            {
                _local2 = (_local2 + 2);
            };
            if (((((((_arg1.match(/[a-z]/)) && (_arg1.match(/[A-Z]/)))) && (_arg1.match(/\d/)))) && (_arg1.match(/[!,@#$%^&*?_~]/))))
            {
                _local2 = (_local2 + 2);
            };
            return (_local2);
        }


    }
}//package com.snake.utils
