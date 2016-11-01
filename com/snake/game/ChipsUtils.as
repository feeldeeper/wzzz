package com.snake.game
{
    public class ChipsUtils 
    {


        public static function getChipsArr(_arg1:uint, _arg2:String="1,2,5,10,20,30,50,100,150,200,300,500,1000,2000,3000,5000,10000,20000,50000,100000,500000,1000000"):Array
        {
            if (_arg1 == 0)
            {
                return (new Array());
            };
            var _local3:Array = getChips(_arg1, _arg2);
            var _local4:Array = new Array();
            var _local5:int;
            while (_local5 < _local3.length)
            {
                _local4 = _local4.concat(ChipsUtils.dataToArr(_local3[_local5]));
                _local5++;
            };
            return (_local4);
        }

        public static function containChips(_arg1:uint, _arg2:String="1,2,5,10,20,30,50,100,150,200,300,500,1000,2000,3000,5000,10000,20000,50000,100000,500000,1000000"):Boolean
        {
            var _local3:Array = _arg2.split(",");
            var _local4:int;
            while (_local4 < _local3.length)
            {
                if (_arg1 >= uint(_local3[_local4]))
                {
                    return (true);
                };
                _local4++;
            };
            return (false);
        }

        public static function computeChips(_arg1:uint, _arg2:String):Object
        {
            var _local3:uint;
            var _local5:Object;
            var _local4:uint;
            var _local6:Array = _arg2.split(",");
            _local3 = (_local6.length - 1);
            while (_local3 >= 0)
            {
                if (_arg1 >= uint(_local6[_local3]))
                {
                    _local4 = uint(_local6[_local3]);
                    break;
                };
                _local3--;
            };
            _local5 = {
                "chip":_local4,
                "num":uint((_arg1 / _local4)),
                "surplu":(_arg1 % _local4)
            };
            return (_local5);
        }

        public static function getChips(_arg1:uint, _arg2:String="1,2,5,10,20,30,50,100,150,200,300,500,1000,2000,3000,5000,10000,20000,50000,100000,500000,1000000"):Array
        {
            if (_arg1 == 0)
            {
                return ([]);
            };
            var _local3:Array = new Array();
            var _local4:Number = Number(_arg2.split(",")[0]);
            _local4 = (_arg1 % _local4);
            if (_local4 != 0)
            {
                _arg1 = (_arg1 - _local4);
            };
            if (_arg1 == 0)
            {
                var _local5:Object = {
                    "chip":_local4,
                    "num":1,
                    "surplu":0
                };
                _local3.push(_local5);
                return (_local3);
            };
            _local5 = computeChips(_arg1, _arg2);
            _local3.push(_local5);
            while (_local5.surplu != 0)
            {
                _local5 = computeChips(_local5.surplu, _arg2);
                _local3.push(_local5);
            };
            if (_local4 != 0)
            {
                _local5 = {
                    "chip":_local4,
                    "num":1,
                    "surplu":0
                };
                _local3.push(_local5);
            };
            return (_local3);
        }

        public static function dataToArr(_arg1:Object):Array
        {
            var _local2:Array = new Array();
            if (((!(_arg1.num)) && (!(_arg1.chip))))
            {
                return (_local2);
            };
            var _local3:int;
            while (_local3 < _arg1.num)
            {
                _local2.push(_arg1.chip);
                _local3++;
            };
            return (_local2);
        }


    }
}//package com.snake.game
