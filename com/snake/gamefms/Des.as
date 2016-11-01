package com.snake.gamefms
{
    import flash.utils.*;
    import com.hurlant.util.*;
    import com.hurlant.crypto.prng.*;

    public class Des 
    {

        private var spfunction1:Array;
        private var spfunction2:Array;
        private var spfunction3:Array;
        private var spfunction4:Array;
        private var spfunction5:Array;
        private var spfunction6:Array;
        private var spfunction7:Array;
        private var spfunction8:Array;
        private var pc2bytes0:Array;
        private var pc2bytes1:Array;
        private var pc2bytes2:Array;
        private var pc2bytes3:Array;
        private var pc2bytes4:Array;
        private var pc2bytes5:Array;
        private var pc2bytes6:Array;
        private var pc2bytes7:Array;
        private var pc2bytes8:Array;
        private var pc2bytes9:Array;
        private var pc2bytes10:Array;
        private var pc2bytes11:Array;
        private var pc2bytes12:Array;
        private var pc2bytes13:Array;

        public function Des()
        {
            this.spfunction1 = new Array(16843776, 0, 65536, 16843780, 16842756, 66564, 4, 65536, 0x0400, 16843776, 16843780, 0x0400, 16778244, 16842756, 16777216, 4, 0x0404, 16778240, 16778240, 66560, 66560, 16842752, 16842752, 16778244, 65540, 16777220, 16777220, 65540, 0, 0x0404, 66564, 16777216, 65536, 16843780, 4, 16842752, 16843776, 16777216, 16777216, 0x0400, 16842756, 65536, 66560, 16777220, 0x0400, 4, 16778244, 66564, 16843780, 65540, 16842752, 16778244, 16777220, 0x0404, 66564, 16843776, 0x0404, 16778240, 16778240, 0, 65540, 66560, 0, 16842756);
            this.spfunction2 = new Array(2148565024, 0x80008000, 0x8000, 1081376, 0x100000, 32, 0x80100020, 0x80008020, 0x80000020, 2148565024, 0x80108000, 0x80000000, 0x80008000, 0x100000, 32, 0x80100020, 0x108000, 0x100020, 0x80008020, 0, 0x80000000, 0x8000, 1081376, 0x80100000, 0x100020, 0x80000020, 0, 0x108000, 32800, 0x80108000, 0x80100000, 32800, 0, 1081376, 0x80100020, 0x100000, 0x80008020, 0x80100000, 0x80108000, 0x8000, 0x80100000, 0x80008000, 32, 2148565024, 1081376, 32, 0x8000, 0x80000000, 32800, 0x80108000, 0x100000, 0x80000020, 0x100020, 0x80008020, 0x80000020, 0x100020, 0x108000, 0, 0x80008000, 32800, 0x80000000, 0x80100020, 2148565024, 0x108000);
            this.spfunction3 = new Array(520, 134349312, 0, 134348808, 134218240, 0, 131592, 134218240, 131080, 134217736, 134217736, 131072, 134349320, 131080, 134348800, 520, 134217728, 8, 134349312, 0x0200, 131584, 134348800, 134348808, 131592, 134218248, 131584, 131072, 134218248, 8, 134349320, 0x0200, 134217728, 134349312, 134217728, 131080, 520, 131072, 134349312, 134218240, 0, 0x0200, 131080, 134349320, 134218240, 134217736, 0x0200, 0, 134348808, 134218248, 131072, 134217728, 134349320, 8, 131592, 131584, 134217736, 134348800, 134218248, 520, 134348800, 131592, 8, 134348808, 131584);
            this.spfunction4 = new Array(8396801, 8321, 8321, 128, 8396928, 0x800081, 0x800001, 8193, 0, 0x802000, 0x802000, 8396929, 129, 0, 0x800080, 0x800001, 1, 0x2000, 0x800000, 8396801, 128, 0x800000, 8193, 8320, 0x800081, 1, 8320, 0x800080, 0x2000, 8396928, 8396929, 129, 0x800080, 0x800001, 0x802000, 8396929, 129, 0, 0, 0x802000, 8320, 0x800080, 0x800081, 1, 8396801, 8321, 8321, 128, 8396929, 129, 1, 0x2000, 0x800001, 8193, 8396928, 0x800081, 8193, 8320, 0x800000, 8396801, 128, 0x800000, 0x2000, 8396928);
            this.spfunction5 = new Array(0x0100, 34078976, 34078720, 0x42000100, 524288, 0x0100, 0x40000000, 34078720, 0x40080100, 524288, 33554688, 0x40080100, 0x42000100, 0x42080000, 524544, 0x40000000, 33554432, 0x40080000, 0x40080000, 0, 0x40000100, 0x42080100, 0x42080100, 33554688, 0x42080000, 0x40000100, 0, 0x42000000, 34078976, 33554432, 0x42000000, 524544, 524288, 0x42000100, 0x0100, 33554432, 0x40000000, 34078720, 0x42000100, 0x40080100, 33554688, 0x40000000, 0x42080000, 34078976, 0x40080100, 0x0100, 33554432, 0x42080000, 0x42080100, 524544, 0x42000000, 0x42080100, 34078720, 0, 0x40080000, 0x42000000, 524544, 33554688, 0x40000100, 524288, 0, 0x40080000, 34078976, 0x40000100);
            this.spfunction6 = new Array(0x20000010, 0x20400000, 0x4000, 541081616, 0x20400000, 16, 541081616, 0x400000, 0x20004000, 4210704, 0x400000, 0x20000010, 0x400010, 0x20004000, 0x20000000, 16400, 0, 0x400010, 0x20004010, 0x4000, 0x404000, 0x20004010, 16, 0x20400010, 0x20400010, 0, 4210704, 0x20404000, 16400, 0x404000, 0x20404000, 0x20000000, 0x20004000, 16, 0x20400010, 0x404000, 541081616, 0x400000, 16400, 0x20000010, 0x400000, 0x20004000, 0x20000000, 16400, 0x20000010, 541081616, 0x404000, 0x20400000, 4210704, 0x20404000, 0, 0x20400010, 16, 0x4000, 0x20400000, 4210704, 0x4000, 0x400010, 0x20004010, 0, 0x20404000, 0x20000000, 0x400010, 0x20004010);
            this.spfunction7 = new Array(0x200000, 69206018, 67110914, 0, 0x0800, 67110914, 2099202, 69208064, 69208066, 0x200000, 0, 67108866, 2, 67108864, 69206018, 2050, 67110912, 2099202, 0x200002, 67110912, 67108866, 69206016, 69208064, 0x200002, 69206016, 0x0800, 2050, 69208066, 0x200800, 2, 67108864, 0x200800, 67108864, 0x200800, 0x200000, 67110914, 67110914, 69206018, 69206018, 2, 0x200002, 67108864, 67110912, 0x200000, 69208064, 2050, 2099202, 69208064, 2050, 67108866, 69208066, 69206016, 0x200800, 0, 2, 69208066, 0, 2099202, 69206016, 0x0800, 67108866, 67110912, 0x0800, 0x200002);
            this.spfunction8 = new Array(0x10001040, 0x1000, 262144, 268701760, 0x10000000, 0x10001040, 64, 0x10000000, 262208, 0x10040000, 268701760, 266240, 0x10041000, 266304, 0x1000, 64, 0x10040000, 0x10000040, 0x10001000, 4160, 266240, 262208, 0x10040040, 0x10041000, 4160, 0, 0, 0x10040040, 0x10000040, 0x10001000, 266304, 262144, 266304, 262144, 0x10041000, 0x1000, 64, 0x10040040, 0x1000, 266304, 0x10001000, 64, 0x10000040, 0x10040000, 0x10040040, 0x10000000, 262144, 0x10001040, 0, 268701760, 262208, 0x10000040, 0x10040000, 0x10001000, 0x10001040, 0, 268701760, 266240, 266240, 4160, 4160, 262208, 0x10000000, 0x10041000);
            this.pc2bytes0 = new Array(0, 4, 0x20000000, 0x20000004, 65536, 65540, 0x20010000, 0x20010004, 0x0200, 516, 0x20000200, 0x20000204, 66048, 66052, 0x20010200, 536936964);
            this.pc2bytes1 = new Array(0, 1, 0x100000, 0x100001, 67108864, 67108865, 68157440, 68157441, 0x0100, 0x0101, 0x100100, 1048833, 67109120, 67109121, 68157696, 68157697);
            this.pc2bytes2 = new Array(0, 8, 0x0800, 0x0808, 16777216, 16777224, 16779264, 16779272, 0, 8, 0x0800, 0x0808, 16777216, 16777224, 16779264, 16779272);
            this.pc2bytes3 = new Array(0, 0x200000, 134217728, 136314880, 0x2000, 0x202000, 134225920, 136323072, 131072, 0x220000, 134348800, 136445952, 139264, 0x222000, 134356992, 136454144);
            this.pc2bytes4 = new Array(0, 262144, 16, 262160, 0, 262144, 16, 262160, 0x1000, 266240, 0x1010, 266256, 0x1000, 266240, 0x1010, 266256);
            this.pc2bytes5 = new Array(0, 0x0400, 32, 1056, 0, 0x0400, 32, 1056, 33554432, 33555456, 33554464, 33555488, 33554432, 33555456, 33554464, 33555488);
            this.pc2bytes6 = new Array(0, 0x10000000, 524288, 0x10080000, 2, 0x10000002, 524290, 0x10080002, 0, 0x10000000, 524288, 0x10080000, 2, 0x10000002, 524290, 0x10080002);
            this.pc2bytes7 = new Array(0, 65536, 0x0800, 67584, 0x20000000, 0x20010000, 0x20000800, 0x20010800, 131072, 196608, 133120, 198656, 0x20020000, 0x20030000, 0x20020800, 0x20030800);
            this.pc2bytes8 = new Array(0, 262144, 0, 262144, 2, 262146, 2, 262146, 33554432, 33816576, 33554432, 33816576, 33554434, 33816578, 33554434, 33816578);
            this.pc2bytes9 = new Array(0, 0x10000000, 8, 0x10000008, 0, 0x10000000, 8, 0x10000008, 0x0400, 0x10000400, 1032, 0x10000408, 0x0400, 0x10000400, 1032, 0x10000408);
            this.pc2bytes10 = new Array(0, 32, 0, 32, 0x100000, 0x100020, 0x100000, 0x100020, 0x2000, 0x2020, 0x2000, 0x2020, 0x102000, 1056800, 0x102000, 1056800);
            this.pc2bytes11 = new Array(0, 16777216, 0x0200, 16777728, 0x200000, 18874368, 0x200200, 18874880, 67108864, 83886080, 67109376, 83886592, 69206016, 85983232, 69206528, 85983744);
            this.pc2bytes12 = new Array(0, 0x1000, 134217728, 134221824, 524288, 528384, 134742016, 134746112, 16, 0x1010, 134217744, 134221840, 524304, 528400, 134742032, 134746128);
            this.pc2bytes13 = new Array(0, 4, 0x0100, 260, 0, 4, 0x0100, 260, 1, 5, 0x0101, 261, 1, 5, 0x0101, 261);
            super();
        }

        private function desMain(_arg1:String, _arg2:String, _arg3:int, _arg4:int=0, _arg5:String=""):String
        {
            var _local8:int;
            var _local9:int;
            var _local10:Number;
            var _local11:Number;
            var _local12:Number;
            var _local13:Number;
            var _local14:Number;
            var _local15:Number;
            var _local16:Array;
            var _local17:Number;
            var _local18:Number;
            var _local19:Number;
            var _local20:Number;
            var _local21:int;
            var _local22:int;
            var _local6:Array = this.des_createKeys(_arg1);
            var _local7:int;
            var _local23:int = _arg2.length;
            var _local24:int;
            var _local25:int = (((_local6.length == 32)) ? 3 : 9);
            if (_local25 == 3)
            {
                _local16 = ((_arg3) ? new Array(0, 32, 2) : new Array(30, -2, -2));
            }
            else
            {
                _local16 = ((_arg3) ? new Array(0, 32, 2, 62, 30, -2, 64, 96, 2) : new Array(94, 62, -2, 32, 64, 2, 30, -2, -2));
            };
            var _local26 = "";
            var _local27 = "";
            if (_arg4 == 1)
            {
                _local17 = ((((_arg5.charCodeAt(_local7++) << 24) | (_arg5.charCodeAt(_local7++) << 16)) | (_arg5.charCodeAt(_local7++) << 8)) | _arg5.charCodeAt(_local7++));
                _local19 = ((((_arg5.charCodeAt(_local7++) << 24) | (_arg5.charCodeAt(_local7++) << 16)) | (_arg5.charCodeAt(_local7++) << 8)) | _arg5.charCodeAt(_local7++));
                _local7 = 0;
            };
            while (_local7 < _local23)
            {
                _local14 = ((((_arg2.charCodeAt(_local7++) << 24) | (_arg2.charCodeAt(_local7++) << 16)) | (_arg2.charCodeAt(_local7++) << 8)) | _arg2.charCodeAt(_local7++));
                _local15 = ((((_arg2.charCodeAt(_local7++) << 24) | (_arg2.charCodeAt(_local7++) << 16)) | (_arg2.charCodeAt(_local7++) << 8)) | _arg2.charCodeAt(_local7++));
                if (_arg4 == 1)
                {
                    if (_arg3)
                    {
                        _local14 = (_local14 ^ _local17);
                        _local15 = (_local15 ^ _local19);
                    }
                    else
                    {
                        _local18 = _local17;
                        _local20 = _local19;
                        _local17 = _local14;
                        _local19 = _local15;
                    };
                };
                _local10 = (((_local14 >>> 4) ^ _local15) & 252645135);
                _local15 = (_local15 ^ _local10);
                _local14 = (_local14 ^ (_local10 << 4));
                _local10 = (((_local14 >>> 16) ^ _local15) & 0xFFFF);
                _local15 = (_local15 ^ _local10);
                _local14 = (_local14 ^ (_local10 << 16));
                _local10 = (((_local15 >>> 2) ^ _local14) & 0x33333333);
                _local14 = (_local14 ^ _local10);
                _local15 = (_local15 ^ (_local10 << 2));
                _local10 = (((_local15 >>> 8) ^ _local14) & 0xFF00FF);
                _local14 = (_local14 ^ _local10);
                _local15 = (_local15 ^ (_local10 << 8));
                _local10 = (((_local14 >>> 1) ^ _local15) & 0x55555555);
                _local15 = (_local15 ^ _local10);
                _local14 = (_local14 ^ (_local10 << 1));
                _local14 = ((_local14 << 1) | (_local14 >>> 31));
                _local15 = ((_local15 << 1) | (_local15 >>> 31));
                _local9 = 0;
                while (_local9 < _local25)
                {
                    _local21 = _local16[(_local9 + 1)];
                    _local22 = _local16[(_local9 + 2)];
                    _local8 = _local16[_local9];
                    while (_local8 != _local21)
                    {
                        _local12 = (_local15 ^ _local6[_local8]);
                        _local13 = (((_local15 >>> 4) | (_local15 << 28)) ^ _local6[(_local8 + 1)]);
                        _local10 = _local14;
                        _local14 = _local15;
                        _local15 = (_local10 ^ (((((((this.spfunction2[((_local12 >>> 24) & 63)] | this.spfunction4[((_local12 >>> 16) & 63)]) | this.spfunction6[((_local12 >>> 8) & 63)]) | this.spfunction8[(_local12 & 63)]) | this.spfunction1[((_local13 >>> 24) & 63)]) | this.spfunction3[((_local13 >>> 16) & 63)]) | this.spfunction5[((_local13 >>> 8) & 63)]) | this.spfunction7[(_local13 & 63)]));
                        _local8 = (_local8 + _local22);
                    };
                    _local10 = _local14;
                    _local14 = _local15;
                    _local15 = _local10;
                    _local9 = (_local9 + 3);
                };
                _local14 = ((_local14 >>> 1) | (_local14 << 31));
                _local15 = ((_local15 >>> 1) | (_local15 << 31));
                _local10 = (((_local14 >>> 1) ^ _local15) & 0x55555555);
                _local15 = (_local15 ^ _local10);
                _local14 = (_local14 ^ (_local10 << 1));
                _local10 = (((_local15 >>> 8) ^ _local14) & 0xFF00FF);
                _local14 = (_local14 ^ _local10);
                _local15 = (_local15 ^ (_local10 << 8));
                _local10 = (((_local15 >>> 2) ^ _local14) & 0x33333333);
                _local14 = (_local14 ^ _local10);
                _local15 = (_local15 ^ (_local10 << 2));
                _local10 = (((_local14 >>> 16) ^ _local15) & 0xFFFF);
                _local15 = (_local15 ^ _local10);
                _local14 = (_local14 ^ (_local10 << 16));
                _local10 = (((_local14 >>> 4) ^ _local15) & 252645135);
                _local15 = (_local15 ^ _local10);
                _local14 = (_local14 ^ (_local10 << 4));
                if (_arg4 == 1)
                {
                    if (_arg3)
                    {
                        _local17 = _local14;
                        _local19 = _local15;
                    }
                    else
                    {
                        _local14 = (_local14 ^ _local18);
                        _local15 = (_local15 ^ _local20);
                    };
                };
                _local27 = (_local27 + String.fromCharCode((_local14 >>> 24), ((_local14 >>> 16) & 0xFF), ((_local14 >>> 8) & 0xFF), (_local14 & 0xFF), (_local15 >>> 24), ((_local15 >>> 16) & 0xFF), ((_local15 >>> 8) & 0xFF), (_local15 & 0xFF)));
                _local24 = (_local24 + 8);
                if (_local24 == 0x0200)
                {
                    _local26 = (_local26 + _local27);
                    _local27 = "";
                    _local24 = 0;
                };
            };
            return ((_local26 + _local27));
        }

        private function des_createKeys(_arg1:String):Array
        {
            var _local5:Number;
            var _local6:Number;
            var _local9:Number;
            var _local11:Number;
            var _local12:Number;
            var _local13:int;
            var _local2:int = (((_arg1.length >= 24)) ? 3 : 1);
            var _local3:Array = new Array((32 * _local2));
            var _local4:Array = new Array(0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0);
            var _local7:int;
            var _local8:int;
            var _local10:int;
            while (_local10 < _local2)
            {
                _local11 = ((((_arg1.charCodeAt(_local7++) << 24) | (_arg1.charCodeAt(_local7++) << 16)) | (_arg1.charCodeAt(_local7++) << 8)) | _arg1.charCodeAt(_local7++));
                _local12 = ((((_arg1.charCodeAt(_local7++) << 24) | (_arg1.charCodeAt(_local7++) << 16)) | (_arg1.charCodeAt(_local7++) << 8)) | _arg1.charCodeAt(_local7++));
                _local9 = (((_local11 >>> 4) ^ _local12) & 252645135);
                _local12 = (_local12 ^ _local9);
                _local11 = (_local11 ^ (_local9 << 4));
                _local9 = (((_local12 >>> -16) ^ _local11) & 0xFFFF);
                _local11 = (_local11 ^ _local9);
                _local12 = (_local12 ^ (_local9 << -16));
                _local9 = (((_local11 >>> 2) ^ _local12) & 0x33333333);
                _local12 = (_local12 ^ _local9);
                _local11 = (_local11 ^ (_local9 << 2));
                _local9 = (((_local12 >>> -16) ^ _local11) & 0xFFFF);
                _local11 = (_local11 ^ _local9);
                _local12 = (_local12 ^ (_local9 << -16));
                _local9 = (((_local11 >>> 1) ^ _local12) & 0x55555555);
                _local12 = (_local12 ^ _local9);
                _local11 = (_local11 ^ (_local9 << 1));
                _local9 = (((_local12 >>> 8) ^ _local11) & 0xFF00FF);
                _local11 = (_local11 ^ _local9);
                _local12 = (_local12 ^ (_local9 << 8));
                _local9 = (((_local11 >>> 1) ^ _local12) & 0x55555555);
                _local12 = (_local12 ^ _local9);
                _local11 = (_local11 ^ (_local9 << 1));
                _local9 = ((_local11 << 8) | ((_local12 >>> 20) & 240));
                _local11 = ((((_local12 << 24) | ((_local12 << 8) & 0xFF0000)) | ((_local12 >>> 8) & 0xFF00)) | ((_local12 >>> 24) & 240));
                _local12 = _local9;
                _local13 = 0;
                while (_local13 < _local4.length)
                {
                    if (_local4[_local13])
                    {
                        _local11 = ((_local11 << 2) | (_local11 >>> 26));
                        _local12 = ((_local12 << 2) | (_local12 >>> 26));
                    }
                    else
                    {
                        _local11 = ((_local11 << 1) | (_local11 >>> 27));
                        _local12 = ((_local12 << 1) | (_local12 >>> 27));
                    };
                    _local11 = (_local11 & 0xFFFFFFF0);
                    _local12 = (_local12 & 0xFFFFFFF0);
                    _local5 = ((((((this.pc2bytes0[(_local11 >>> 28)] | this.pc2bytes1[((_local11 >>> 24) & 15)]) | this.pc2bytes2[((_local11 >>> 20) & 15)]) | this.pc2bytes3[((_local11 >>> 16) & 15)]) | this.pc2bytes4[((_local11 >>> 12) & 15)]) | this.pc2bytes5[((_local11 >>> 8) & 15)]) | this.pc2bytes6[((_local11 >>> 4) & 15)]);
                    _local6 = ((((((this.pc2bytes7[(_local12 >>> 28)] | this.pc2bytes8[((_local12 >>> 24) & 15)]) | this.pc2bytes9[((_local12 >>> 20) & 15)]) | this.pc2bytes10[((_local12 >>> 16) & 15)]) | this.pc2bytes11[((_local12 >>> 12) & 15)]) | this.pc2bytes12[((_local12 >>> 8) & 15)]) | this.pc2bytes13[((_local12 >>> 4) & 15)]);
                    _local9 = (((_local6 >>> 16) ^ _local5) & 0xFFFF);
                    var _local14 = _local8++;
                    _local3[_local14] = (_local5 ^ _local9);
                    var _local15 = _local8++;
                    _local3[_local15] = (_local6 ^ (_local9 << 16));
                    _local13++;
                };
                _local10++;
            };
            return (_local3);
        }

        public function genIV(_arg1:int):String
        {
            var _local2:Random = new Random();
            var _local3:ByteArray = new ByteArray();
            _local2.nextBytes(_local3, (_arg1 / 8));
            return (Hex.fromArray(_local3));
        }

        public function encrypt(_arg1:String, _arg2:String, _arg3:String):String
        {
            var _local4:String = this.desMain(_arg1, _arg2, 1, 1, _arg3);
            return (Base64.encode(_local4));
        }


    }
}//package com.snake.gamefms
