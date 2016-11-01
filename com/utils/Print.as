package com.utils
{

    final public class Print extends Object
    {
        public static var Debug:Boolean = true;

        public function Print()
        {
            return;
        }// end function

        public static function printf(param1:Object) : void
        {
            var _loc_2:uint;
            if (Debug)
            {
            }// end if
            return;
        }// end function

        public static function printAll(param1:Object, param2:uint = 0) : String
        {
            var _loc_4:*;
            var _loc_5:*;
            var _loc_3:String;
            if (param1 == null)
            {
                _loc_3 = _loc_3 + "object=>null";
            }
            else if (param1 is Array)
            {
                _loc_3 = _loc_3 + "array=>[\n";
                param2 = param2 + 10;
                for (_loc_4 in param1)
                {
                    // label
                    _loc_3 = _loc_3 + (space(param2) + "[" + _loc_4 + "]:" + printAll(param1[_loc_4], param2) + "\n");
                }// end of for ... in
                _loc_3 = _loc_3 + (space(param2 - 10) + "]");
            }
            else if (param1 is Number || param1 is Boolean || param1 is XML || param1 is String)
            {
                _loc_3 = _loc_3 + param1.toString();
            }
            else if (param1 is Object)
            {
                _loc_3 = _loc_3 + "object =>{\n";
                param2 = param2 + 10;
                for (_loc_5 in param1)
                {
                    // label
                    _loc_3 = _loc_3 + (space(param2) + _loc_5 + ":" + printAll(param1[_loc_5], param2) + "\n");
                }// end of for ... in
                _loc_3 = _loc_3 + (space(param2 - 10) + "}\n");
            }
            else
            {
                _loc_3 = _loc_3 + param1.toString();
            }// end else if
            return _loc_3;
        }// end function

        public static function space(param1:uint) : String
        {
            var _loc_2:String;
            var _loc_3:int;
            while (_loc_3 < param1)
            {
                // label
                _loc_2 = _loc_2 + " ";
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

    }
}
