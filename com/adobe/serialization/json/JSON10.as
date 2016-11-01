package com.adobe.serialization.json
{

    public class JSON10 extends Object
    {

        public function JSON10()
        {
            return;
        }// end function

        public static function encode(param1:Object) : String
        {
            var _loc_2:* = new JSONEncoder(param1);
            return _loc_2.getString();
        }// end function

        public static function decode(param1:String)
        {
            var _loc_2:* = new JSONDecoder(param1,true);
            return _loc_2.getValue();
        }// end function

    }
}
