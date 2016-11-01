package com.snake.utils
{
    import flash.filters.*;

    public class MFilters 
    {


        public static function gray():ColorMatrixFilter
        {
            var _local1:Array = new Array();
            _local1 = [0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local1));
        }

        public static function brightness(_arg1:Number):ColorMatrixFilter
        {
            var _local2:Array = new Array();
            _local2 = [1, 0, 0, 0, _arg1, 0, 1, 0, 0, _arg1, 0, 0, 1, 0, _arg1, 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local2));
        }

        public static function contrast(_arg1:Number):ColorMatrixFilter
        {
            var _local2:Array = new Array();
            _local2 = [_arg1, 0, 0, 0, ((1 - _arg1) * 128), 0, _arg1, 0, 0, ((1 - _arg1) * 128), 0, 0, _arg1, 0, ((1 - _arg1) * 128), 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local2));
        }

        public static function oppositionHue():ColorMatrixFilter
        {
            var _local1:Array = new Array();
            _local1 = [-1, 0, 0, 0, 0xFF, 0, -1, 0, 0, 0xFF, 0, 0, -1, 0, 0xFF, 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local1));
        }

        public static function limen(_arg1:Number):ColorMatrixFilter
        {
            var _local2:Array = new Array();
            _local2 = [(0.3086 * 0x0100), (0.6094 * 0x0100), (0.082 * 0x0100), 0, (-256 * _arg1), (0.3086 * 0x0100), (0.6094 * 0x0100), (0.082 * 0x0100), 0, (-256 * _arg1), (0.3086 * 0x0100), (0.6094 * 0x0100), (0.082 * 0x0100), 0, (-256 * _arg1), 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local2));
        }

        public static function saturation(_arg1:Number):ColorMatrixFilter
        {
            var _local2:Array = new Array();
            _local2 = [((0.3086 * (1 - _arg1)) + _arg1), (0.6094 * (1 - _arg1)), (0.082 * (1 - _arg1)), 0, 0, (0.3086 * (1 - _arg1)), ((0.6094 * (1 - _arg1)) + _arg1), (0.082 * (1 - _arg1)), 0, 0, (0.3086 * (1 - _arg1)), (0.6094 * (1 - _arg1)), ((0.082 * (1 - _arg1)) + _arg1), 0, 0, 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local2));
        }

        public static function colorChannels(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):ColorMatrixFilter
        {
            var _local5:Array = new Array();
            _local5 = [_arg1, 0, 0, 0, 0, 0, _arg2, 0, 0, 0, 0, 0, _arg3, 0, 0, 0, 0, 0, _arg4, 0];
            var _local6:ColorMatrixFilter = new ColorMatrixFilter(_local5);
            return (_local6);
        }

        public static function Stroke(_arg1:Number=0, _arg2:Number=0.1, _arg3:Number=2, _arg4:Number=2, _arg5:Number=6, _arg6:Boolean=false, _arg7:Boolean=false, _arg8:Number=3):BitmapFilter
        {
            return (new GlowFilter(_arg1, _arg2, _arg3, _arg4, _arg5, _arg8, _arg6, _arg7));
        }

        public static function getShadowFilter(_arg1:Number=0, _arg2:Number=0.5, _arg3:Number=5, _arg4:Number=5, _arg5:Number=2, _arg6:Boolean=false, _arg7:Boolean=false, _arg8:Number=3):BitmapFilter
        {
            return (new GlowFilter(_arg1, _arg2, _arg3, _arg4, _arg5, _arg8, _arg6, _arg7));
        }

        public static function getBlurFilter(_arg1:uint=5, _arg2:uint=5, _arg3:uint=3):BlurFilter
        {
            return (new BlurFilter(_arg1, _arg2, _arg3));
        }


    }
}//package com.snake.utils
