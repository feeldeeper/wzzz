package com.snake.game
{
    import flash.display.*;

    public class BJLCardLog 
    {

        private static var _instance:BJLCardLog;

        private var _daLuLie:uint = 0;
        private var _zhuZaiLuLie:uint = 0;
        private var _daYanLuLie:uint = 0;
        private var _xiaoLuLie:uint = 0;
        private var _zhangLuLie:uint = 0;
        private var _sanXinLuLie:uint = 0;
        private var _zhuZaiMc:Sprite;
        private var zhuZaiMcArr:Array;
        private var _daLuMc:Sprite;
        private var daLuMcArr:Array;
        private var _daYanMc:Sprite;
        private var daYanMcArr:Array;
        private var _xiaoLuMc:Sprite;
        private var xiaoLuMcArr:Array;
        private var _zhangLuMc:Sprite;
        private var zhangLuMcArr:Array;
        private var _sanXinMc:Sprite;
        private var sanXinMcArr:Array;
        private var daLuArr:Array;
        private var oldDaLuArr:Array;

        public function BJLCardLog()
        {
            this._zhuZaiMc = new Sprite();
            this.zhuZaiMcArr = [];
            this._daLuMc = new Sprite();
            this.daLuMcArr = [];
            this._daYanMc = new Sprite();
            this.daYanMcArr = [];
            this._xiaoLuMc = new Sprite();
            this.xiaoLuMcArr = [];
            this._zhangLuMc = new Sprite();
            this.zhangLuMcArr = [];
            this._sanXinMc = new Sprite();
            this.sanXinMcArr = [];
            this.daLuArr = [];
            this.oldDaLuArr = [];
            super();
        }

        public static function get instance():BJLCardLog
        {
            if (!_instance)
            {
                _instance = new (BJLCardLog)();
            };
            return (_instance);
        }

        public static function daLuShow(_arg1:Array, _arg2:Class, _arg3:Number=16, _arg4:Number=16):Sprite
        {
            BJLCardLog.instance.daLuShow(_arg1, _arg2, _arg3, _arg4);
            return (BJLCardLog.instance._daLuMc);
        }

        public static function get daLuLie():uint
        {
            return (BJLCardLog.instance.daLuLie);
        }


        public function get sanXinMc():Sprite
        {
            return (this._sanXinMc);
        }

        public function get sanXinLuLie():uint
        {
            return (this._sanXinLuLie);
        }

        public function get zhangLuMc():Sprite
        {
            return (this._zhangLuMc);
        }

        public function get xiaoLuMc():Sprite
        {
            return (this._xiaoLuMc);
        }

        public function get daYanMc():Sprite
        {
            return (this._daYanMc);
        }

        public function get daLuMc():Sprite
        {
            return (this._daLuMc);
        }

        public function get zhuZaiMc():Sprite
        {
            return (this._zhuZaiMc);
        }

        public function set daLuLie(_arg1:uint):void
        {
            this._daLuLie = _arg1;
        }

        public function get daLuLie():uint
        {
            return (this._daLuLie);
        }

        public function set zhuZaiLuLie(_arg1:uint):void
        {
            this._zhuZaiLuLie = _arg1;
        }

        public function get zhuZaiLuLie():uint
        {
            return (this._zhuZaiLuLie);
        }

        public function set daYanLuLie(_arg1:uint):void
        {
            this._daYanLuLie = _arg1;
        }

        public function get xiaoLuLie():uint
        {
            return (this._xiaoLuLie);
        }

        public function set xiaoLuLie(_arg1:uint):void
        {
            this._xiaoLuLie = _arg1;
        }

        public function get daYanLuLie():uint
        {
            return (this._daYanLuLie);
        }

        public function set zhangLuLie(_arg1:uint):void
        {
            this._zhangLuLie = _arg1;
        }

        public function get zhangLuLie():uint
        {
            return (this._zhangLuLie);
        }

        public function zxh_result(_arg1:uint):uint
        {
            return (((_arg1 / 4) >> 0));
        }

        public function dx_result(_arg1:uint):Boolean
        {
            if (_arg1 < 20)
            {
                return (false);
            };
            return (true);
        }

        public function zxh_arr(_arg1:Array):Object
        {
            var _local8:uint;
            var _local2:uint;
            var _local3:uint;
            var _local4:uint;
            var _local5:uint;
            var _local6:uint;
            var _local7:uint;
            while (_local7 < _arg1.length)
            {
                _local8 = uint(_arg1[_local7]);
                switch (_local8)
                {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                        _local2 = (_local2 + 1);
                        if ((((_local8 == 1)) || ((_local8 == 3))))
                        {
                            _local5 = (_local5 + 1);
                        };
                        if ((((_local8 == 2)) || ((_local8 == 3))))
                        {
                            _local6 = (_local6 + 1);
                        };
                        break;
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                        _local3 = (_local3 + 1);
                        if ((((_local8 == 5)) || ((_local8 == 7))))
                        {
                            _local5 = (_local5 + 1);
                        };
                        if ((((_local8 == 6)) || ((_local8 == 7))))
                        {
                            _local6 = (_local6 + 1);
                        };
                        break;
                    case 8:
                    case 9:
                    case 10:
                    case 11:
                        _local4 = (_local4 + 1);
                        if ((((_local8 == 9)) || ((_local8 == 11))))
                        {
                            _local5 = (_local5 + 1);
                        };
                        if ((((_local8 == 10)) || ((_local8 == 11))))
                        {
                            _local6 = (_local6 + 1);
                        };
                        break;
                };
                _local7++;
            };
            return ({
                "zhuan":_local2,
                "xian":_local3,
                "he":_local4,
                "zd":_local5,
                "xd":_local6
            });
        }

        public function zhuzaiLu(_arg1:Array, _arg2:Number, _arg3:Number):Array
        {
            var _local6:Object;
            var _local4:uint;
            var _local5:uint;
            var _local7:Array = new Array();
            var _local8:uint;
            while (_local8 < _arg1.length)
            {
                _local5 = (_local5 + 1);
                if ((_local8 % 6) == 0)
                {
                    _local4 = (_local4 + 1);
                    _local5 = 0;
                };
                _local6 = {
                    "num":(uint(_arg1[_local8]) + 1),
                    "x":(_arg2 * (_local4 - 1)),
                    "y":(_arg3 * _local5)
                };
                _local7.push(_local6);
                _local8++;
            };
            return (_local7);
        }

        public function zhuzaiLuShow(_arg1:Array, _arg2:Class, _arg3:Number, _arg4:Number):void
        {
            var _local6:MovieClip;
            var _local8:uint;
            var _local5:Array = this.zhuzaiLu(_arg1, _arg3, _arg4);
            var _local7:uint = _local5.length;
            Tools.removeAllChild(this._zhuZaiMc);
            _local8 = 0;
            while (_local8 < _local7)
            {
                if (this.zhuZaiMcArr[_local8] == undefined)
                {
                    _local6 = (new (_arg2)() as MovieClip);
                    _local6.width = _arg3;
                    _local6.height = _arg4;
                    this.zhuZaiMcArr[_local8] = _local6;
                }
                else
                {
                    _local6 = this.zhuZaiMcArr[_local8];
                };
                _local6.y = _local5[_local8].y;
                _local6.x = _local5[_local8].x;
                _local6.visible = true;
                _local6.gotoAndStop(_local5[_local8].num);
                this._zhuZaiMc.addChild(_local6);
                _local8++;
            };
            if (_local7 > 0)
            {
                this.zhuZaiLuLie = uint(((_local6.x / _arg3) + 1));
            };
        }

        public function sanXingShow(_arg1:Array, _arg2:Class, _arg3:Number=8, _arg4:Number=8):void
        {
            var _local5:MovieClip;
            var _local6:uint = this.daLuArr.length;
            var _local7:uint;
            var _local8:uint;
            Tools.removeAllChild(this._sanXinMc);
            var _local9:int;
            while (_local9 < _local6)
            {
                if (this.sanXinMcArr[_local9] == undefined)
                {
                    _local5 = (new (_arg2)() as MovieClip);
                    _local5.width = _arg3;
                    _local5.height = _arg4;
                    this.sanXinMcArr[_local9] = _local5;
                }
                else
                {
                    _local5 = this.sanXinMcArr[_local9];
                };
                if ((_local9 % 3) == 0)
                {
                    if (_local9 > 2)
                    {
                        _local7 = (_local7 + 1);
                    };
                    _local8 = 0;
                }
                else
                {
                    _local8 = (_local8 + 1);
                };
                _local5.y = (_arg4 * _local8);
                _local5.x = (_arg3 * _local7);
                _local5["heMc"].visible = this.daLuArr[_local9].heMc;
                _local5["heMc"]["numtxt"].text = this.daLuArr[_local9].heNum;
                _local5.visible = true;
                _local5.gotoAndStop((this.daLuArr[_local9].num + 1));
                this._sanXinMc.addChild(_local5);
                _local9++;
            };
            if (_local6 > 0)
            {
                this._sanXinLuLie = uint(((_local5.x / _arg3) + 1));
            };
        }

        public function daLuShow(_arg1:Array, _arg2:Class, _arg3:Number=16, _arg4:Number=16):void
        {
            var _local5:MovieClip;
            var _local7:uint;
            this.daLuArr = this.daLu(_arg1, _arg3, _arg4);
            var _local6:uint = this.daLuArr.length;
            Tools.removeAllChild(this._daLuMc);
            _local7 = 0;
            while (_local7 < _local6)
            {
                if (this.daLuMcArr[_local7] == undefined)
                {
                    _local5 = (new (_arg2)() as MovieClip);
                    _local5.width = _arg3;
                    _local5.height = _arg4;
                    this.daLuMcArr[_local7] = _local5;
                }
                else
                {
                    _local5 = this.daLuMcArr[_local7];
                };
                _local5.y = this.daLuArr[_local7].y;
                _local5.x = this.daLuArr[_local7].x;
                _local5["heMc"].visible = this.daLuArr[_local7].heMc;
                _local5["heMc"]["numtxt"].text = this.daLuArr[_local7].heNum;
                _local5.visible = true;
                _local5.gotoAndStop((uint(this.daLuArr[_local7].num) + 1));
                this._daLuMc.addChild(_local5);
                _local7++;
            };
            if (_local6 > 0)
            {
                this.daLuLie = uint(((_local5.x / _arg3) + 1));
            };
        }

        public function nextLuNum(_arg1:Array, _arg2:uint):uint
        {
            var _local3:Array;
            var _local4:uint;
            switch (_arg2)
            {
                case 1:
                    _local3 = this.dayan(_arg1);
                    break;
                case 2:
                    _local3 = this.xiaolu(_arg1);
                    break;
                case 3:
                    _local3 = this.zhanglu(_arg1);
                    break;
            };
            if (_local3.length == 0)
            {
                _local4 = 0;
            }
            else
            {
                _local4 = _local3[(_local3.length - 1)].num;
            };
            return (_local4);
        }

        public function daLu(_arg1:Array, _arg2:Number=16, _arg3:Number=16):Array
        {
            var _local4:Object;
            var _local8:uint;
            var _local9:uint;
            var _local16:int;
            var _local17:int;
            var _local5:Array = new Array();
            var _local6:Number = _arg2;
            var _local7:Number = _arg3;
            var _local10:uint;
            var _local11:uint;
            var _local12:uint;
            var _local13:uint;
            var _local14:Boolean;
            var _local15:Array = new Array();
            _local16 = 0;
            while (_local16 < 150)
            {
                _local15[_local16] = new Array();
                _local17 = 0;
                while (_local17 < 6)
                {
                    _local15[_local16][_local17] = true;
                    _local17++;
                };
                _local16++;
            };
            var _local18:Array = new Array();
            _local16 = 0;
            while (_local16 < 150)
            {
                _local18[_local16] = new Array();
                _local17 = 0;
                while (_local17 < 6)
                {
                    _local18[_local16][_local17] = 5;
                    _local17++;
                };
                _local16++;
            };
            var _local19:uint = this.daLuStart(_arg1);
            _local16 = _local19;
            while (_local16 < _arg1.length)
            {
                _local8 = this.zxh_result(uint(_arg1[_local16]));
                if (_local16 == _local19)
                {
                    _local15[_local10][_local11] = false;
                    _local4 = {
                        "num":_arg1[_local16],
                        "x":(_local6 * _local10),
                        "y":(_local7 * _local11),
                        "heMc":false,
                        "heNum":0
                    };
                    _local5.push(_local4);
                    _local5[((("z" + _local10) + "_") + _local11)] = _local4;
                    _local18[_local10][_local11] = _local8;
                    _local9 = _local8;
                }
                else
                {
                    if (_local8 == 2)
                    {
                        _local4 = _local5[((("z" + _local10) + "_") + _local11)];
                        _local4.heMc = true;
                        _local4.heNum = (_local4.heNum + 1);
                    }
                    else
                    {
                        if (_local8 != _local9)
                        {
                            _local10 = this.daLulei(_local15);
                            _local11 = 0;
                            _local15[_local10][_local11] = false;
                            _local4 = {
                                "num":_arg1[_local16],
                                "x":(_local6 * _local10),
                                "y":(_local7 * _local11),
                                "heMc":false,
                                "heNum":0
                            };
                            _local5.push(_local4);
                            _local5[((("z" + _local10) + "_") + _local11)] = _local4;
                            _local18[_local10][_local11] = _local8;
                            _local13 = 0;
                            _local14 = false;
                        }
                        else
                        {
                            _local13 = (_local13 + 1);
                            if (_local14 == true)
                            {
                                _local10 = (_local10 + 1);
                                _local15[_local10][_local11] = false;
                                _local4 = {
                                    "num":_arg1[_local16],
                                    "x":(_local6 * _local10),
                                    "y":(_local7 * _local11),
                                    "heMc":false,
                                    "heNum":0
                                };
                                _local5.push(_local4);
                                _local5[((("z" + _local10) + "_") + _local11)] = _local4;
                                _local18[_local10][_local11] = _local8;
                            }
                            else
                            {
                                if (_local15[_local10][(_local11 + 1)] == true)
                                {
                                    _local11 = (_local11 + 1);
                                    _local15[_local10][_local11] = false;
                                    _local4 = {
                                        "num":_arg1[_local16],
                                        "x":(_local6 * _local10),
                                        "y":(_local7 * _local11),
                                        "heMc":false,
                                        "heNum":0
                                    };
                                    _local5.push(_local4);
                                    _local5[((("z" + _local10) + "_") + _local11)] = _local4;
                                    _local18[_local10][_local11] = _local8;
                                }
                                else
                                {
                                    if (_local11 == 5)
                                    {
                                        _local10 = (_local10 + 1);
                                        _local15[_local10][_local11] = false;
                                        _local4 = {
                                            "num":_arg1[_local16],
                                            "x":(_local6 * _local10),
                                            "y":(_local7 * _local11),
                                            "heMc":false,
                                            "heNum":0
                                        };
                                        _local5.push(_local4);
                                        _local5[((("z" + _local10) + "_") + _local11)] = _local4;
                                        _local18[_local10][_local11] = _local8;
                                        _local14 = true;
                                    }
                                    else
                                    {
                                        _local10 = (_local10 + 1);
                                        _local15[_local10][_local11] = false;
                                        _local4 = {
                                            "num":_arg1[_local16],
                                            "x":(_local6 * _local10),
                                            "y":(_local7 * _local11),
                                            "heMc":false,
                                            "heNum":0
                                        };
                                        _local5.push(_local4);
                                        _local5[((("z" + _local10) + "_") + _local11)] = _local4;
                                        _local18[_local10][_local11] = _local8;
                                        _local14 = true;
                                    };
                                };
                            };
                        };
                        _local9 = _local8;
                    };
                };
                _local16++;
            };
            return (_local5);
        }

        private function daLuStart(_arg1:Array):uint
        {
            return (0);
        }

        private function daLulei(_arg1:Array):uint
        {
            var _local2:uint;
            while (_local2 < 150)
            {
                if (_arg1[_local2][0] == true)
                {
                    return (_local2);
                };
                _local2++;
            };
            return (0);
        }

        public function yuanDaLuArr(_arg1:Array):Array
        {
            var _local5:uint;
            var _local6:uint;
            var _local8:uint;
            var _local2:Array = new Array();
            var _local3:uint;
            var _local4:uint;
            var _local7:uint = this.daLuStart(_arg1);
            _local8 = _local7;
            while (_local8 < _arg1.length)
            {
                _local5 = this.zxh_result(uint(_arg1[_local8]));
                if (_local8 == _local7)
                {
                    _local2[_local3] = new Array();
                    _local2[_local3][_local4] = _local5;
                    _local6 = _local5;
                }
                else
                {
                    if ((((_local5 < 2)) && (!((_local5 == _local6)))))
                    {
                        _local3 = (_local3 + 1);
                        _local4 = 0;
                        _local2[_local3] = new Array();
                        _local2[_local3][_local4] = _local5;
                        _local6 = _local5;
                    }
                    else
                    {
                        if ((((_local5 < 2)) && ((_local5 == _local6))))
                        {
                            _local4 = (_local4 + 1);
                            _local2[_local3][_local4] = _local5;
                            _local6 = _local5;
                        };
                    };
                };
                _local8++;
            };
            this.oldDaLuArr = _local2;
            return (_local2);
        }

        public function dayan(_arg1:Array, _arg2:Number=8, _arg3:Number=8):Array
        {
            var _local4:Object;
            var _local8:uint;
            var _local9:uint;
            var _local5:Array = new Array();
            var _local6:Array = new Array();
            _local6 = this.yuanDaLuArr(_arg1);
            var _local7:uint = new uint(0);
            _local8 = 0;
            while (_local8 < _local6.length)
            {
                _local7 = Math.max(_local6[_local8].length, _local7);
                _local8++;
            };
            var _local10:int = new int(0);
            var _local11:int = new int(-1);
            var _local12:uint = new uint(0);
            var _local13:uint = new uint(0);
            var _local14:uint = new uint(0);
            if (_local6.length < 2)
            {
                return (_local5);
            };
            if (_local6[1][1] < 2)
            {
                _local10 = 1;
            }
            else
            {
                _local10 = 2;
            };
            var _local15:Array = new Array();
            _local8 = _local10;
            while (_local8 < 150)
            {
                if (_local6[_local8] == undefined) break;
                _local9 = 0;
                while (_local9 < _local6[_local8].length)
                {
                    if (_local10 != 1)
                    {
                        if ((((_local9 == 0)) && ((_local6[_local8][_local9] < 2))))
                        {
                            if (_local6[(_local8 - 2)][_local6[(_local8 - 1)].length] != undefined)
                            {
                                _local13 = 2;
                            }
                            else
                            {
                                if ((((_local6[(_local8 - 2)][(_local6[(_local8 - 1)].length - 1)] == undefined)) && ((_local6[(_local8 - 2)][_local6[(_local8 - 1)].length] == undefined))))
                                {
                                    _local13 = 2;
                                }
                                else
                                {
                                    _local13 = 1;
                                };
                            };
                            if (_local13 == 1)
                            {
                                if (_local13 != _local14)
                                {
                                    _local12 = 0;
                                    _local11 = (_local11 + 1);
                                    _local15[_local11] = new Array();
                                    _local15[_local11][_local12] = _local13;
                                }
                                else
                                {
                                    _local12 = (_local12 + 1);
                                    _local15[_local11][_local12] = _local13;
                                };
                                _local14 = _local13;
                            }
                            else
                            {
                                if (_local13 != _local14)
                                {
                                    _local12 = 0;
                                    _local11 = (_local11 + 1);
                                    _local15[_local11] = new Array();
                                    _local15[_local11][_local12] = _local13;
                                }
                                else
                                {
                                    _local12 = (_local12 + 1);
                                    _local15[_local11][_local12] = _local13;
                                };
                                _local14 = _local13;
                            };
                        }
                        else
                        {
                            if ((((_local9 > 0)) && ((_local6[_local8][_local9] < 2))))
                            {
                                if (_local6[(_local8 - 1)][_local9] != undefined)
                                {
                                    _local13 = 1;
                                }
                                else
                                {
                                    if ((((_local6[(_local8 - 1)][_local9] == undefined)) && ((_local6[(_local8 - 1)][(_local9 - 1)] == undefined))))
                                    {
                                        _local13 = 1;
                                    }
                                    else
                                    {
                                        _local13 = 2;
                                    };
                                };
                                if (_local13 == 1)
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                }
                                else
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                };
                            };
                        };
                    }
                    else
                    {
                        if (!(((_local8 == _local10)) && ((_local9 == 0))))
                        {
                            if ((((_local9 == 0)) && ((_local6[_local8][_local9] < 2))))
                            {
                                if (_local6[(_local8 - 2)][_local6[(_local8 - 1)].length] != undefined)
                                {
                                    _local13 = 2;
                                }
                                else
                                {
                                    if ((((_local6[(_local8 - 2)][(_local6[(_local8 - 1)].length - 1)] == undefined)) && ((_local6[(_local8 - 2)][_local6[(_local8 - 1)].length] == undefined))))
                                    {
                                        _local13 = 2;
                                    }
                                    else
                                    {
                                        _local13 = 1;
                                    };
                                };
                                if (_local13 == 1)
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                }
                                else
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                };
                            }
                            else
                            {
                                if ((((_local9 > 0)) && ((_local6[_local8][_local9] < 2))))
                                {
                                    if (_local6[(_local8 - 1)][_local9] != undefined)
                                    {
                                        _local13 = 1;
                                    }
                                    else
                                    {
                                        if ((((_local6[(_local8 - 1)][_local9] == undefined)) && ((_local6[(_local8 - 1)][(_local9 - 1)] == undefined))))
                                        {
                                            _local13 = 1;
                                        }
                                        else
                                        {
                                            _local13 = 2;
                                        };
                                    };
                                    if (_local13 == 1)
                                    {
                                        if (_local13 != _local14)
                                        {
                                            _local12 = 0;
                                            _local11 = (_local11 + 1);
                                            _local15[_local11] = new Array();
                                            _local15[_local11][_local12] = _local13;
                                        }
                                        else
                                        {
                                            _local12 = (_local12 + 1);
                                            _local15[_local11][_local12] = _local13;
                                        };
                                        _local14 = _local13;
                                    }
                                    else
                                    {
                                        if (_local13 != _local14)
                                        {
                                            _local12 = 0;
                                            _local11 = (_local11 + 1);
                                            _local15[_local11] = new Array();
                                            _local15[_local11][_local12] = _local13;
                                        }
                                        else
                                        {
                                            _local12 = (_local12 + 1);
                                            _local15[_local11][_local12] = _local13;
                                        };
                                        _local14 = _local13;
                                    };
                                };
                            };
                        };
                    };
                    _local9++;
                };
                _local8++;
            };
            var _local16:Array = new Array();
            _local10 = 0;
            var _local17:uint;
            var _local18:Boolean = new Boolean(false);
            var _local19:uint;
            var _local20:Number = _arg2;
            var _local21:Number = _arg3;
            _local8 = 0;
            while (_local8 < 150)
            {
                _local16[_local8] = new Array();
                _local9 = 0;
                while (_local9 < 6)
                {
                    _local16[_local8][_local9] = new Boolean(true);
                    _local9++;
                };
                _local8++;
            };
            _local8 = 0;
            while (_local8 < _local15.length)
            {
                _local10 = this.daLulei(_local16);
                _local18 = false;
                _local17 = 0;
                _local9 = 0;
                while (_local9 < _local15[_local8].length)
                {
                    _local19 = (_local19 + 1);
                    if ((((((_local16[_local10][_local9] == true)) && (!((_local9 == 5))))) && ((_local18 == false))))
                    {
                        _local4 = {
                            "num":_local15[_local8][_local9],
                            "x":(_local20 * _local10),
                            "y":(_local21 * _local17)
                        };
                        _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                        _local5.push(_local4);
                        _local16[_local10][_local17] = false;
                        _local17 = (_local17 + 1);
                    }
                    else
                    {
                        if ((((((_local16[_local10][_local9] == true)) && ((_local9 == 5)))) && ((_local18 == false))))
                        {
                            _local4 = {
                                "num":_local15[_local8][_local9],
                                "x":(_local20 * _local10),
                                "y":(_local21 * _local17)
                            };
                            _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                            _local5.push(_local4);
                            _local16[_local10][_local17] = false;
                            _local17 = 5;
                            _local18 = true;
                        }
                        else
                        {
                            if (_local18 == true)
                            {
                                _local10 = (_local10 + 1);
                                _local4 = {
                                    "num":_local15[_local8][_local9],
                                    "x":(_local20 * _local10),
                                    "y":(_local21 * _local17)
                                };
                                _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                                _local5.push(_local4);
                                _local16[_local10][_local17] = false;
                                _local18 = true;
                            };
                        };
                    };
                    _local9++;
                };
                _local8++;
            };
            return (_local5);
        }

        public function dayanShow(_arg1:Array, _arg2:Class, _arg3:Number=8, _arg4:Number=8):void
        {
            var _local6:MovieClip;
            var _local8:String;
            var _local5:Array = this.dayan(_arg1, _arg3, _arg4);
            var _local7:Sprite = new Sprite();
            var _local9:uint = _local5.length;
            Tools.removeAllChild(this._daYanMc);
            var _local10:int;
            while (_local10 < _local9)
            {
                if (this.daYanMcArr[_local10] == undefined)
                {
                    _local8 = (_local8 + _local5[_local10].num);
                    _local6 = (new (_arg2)() as MovieClip);
                    _local6.width = _arg3;
                    _local6.height = _arg4;
                    this.daYanMcArr[_local10] = _local6;
                }
                else
                {
                    _local6 = this.daYanMcArr[_local10];
                };
                _local6.y = _local5[_local10].y;
                _local6.x = _local5[_local10].x;
                _local6.visible = true;
                _local6.gotoAndStop(_local5[_local10].num);
                this._daYanMc.addChild(_local6);
                _local10++;
            };
            if (_local9 > 0)
            {
                this.daYanLuLie = uint(((_local6.x / _arg3) + 1));
            };
        }

        public function xiaolu(_arg1:Array, _arg2:Number=8, _arg3:Number=8):Array
        {
            var _local4:Object;
            var _local8:uint;
            var _local9:uint;
            var _local5:Array = new Array();
            var _local6:Array = new Array();
            _local6 = this.yuanDaLuArr(_arg1);
            var _local7:uint = new uint(0);
            _local8 = 0;
            while (_local8 < _local6.length)
            {
                _local7 = Math.max(_local6[_local8].length, _local7);
                _local8++;
            };
            var _local10:int;
            var _local11:int = -1;
            var _local12:int;
            var _local13:int;
            var _local14:int;
            if (_local6.length < 3)
            {
                return (_local5);
            };
            if (_local6[2][1] < 2)
            {
                _local10 = 2;
            }
            else
            {
                _local10 = 3;
            };
            var _local15:Array = new Array();
            _local8 = _local10;
            while (_local8 < 150)
            {
                if (_local6[_local8] == undefined) break;
                _local9 = 0;
                while (_local9 < _local6[_local8].length)
                {
                    if (_local10 != 2)
                    {
                        if ((((_local9 == 0)) && ((_local6[_local8][_local9] < 2))))
                        {
                            if (_local6[(_local8 - 3)][_local6[(_local8 - 1)].length] != undefined)
                            {
                                _local13 = 2;
                            }
                            else
                            {
                                if ((((_local6[(_local8 - 3)][(_local6[(_local8 - 1)].length - 1)] == undefined)) && ((_local6[(_local8 - 3)][_local6[(_local8 - 1)].length] == undefined))))
                                {
                                    _local13 = 2;
                                }
                                else
                                {
                                    _local13 = 1;
                                };
                            };
                            if (_local13 == 1)
                            {
                                if (_local13 != _local14)
                                {
                                    _local12 = 0;
                                    _local11 = (_local11 + 1);
                                    _local15[_local11] = new Array();
                                    _local15[_local11][_local12] = _local13;
                                }
                                else
                                {
                                    _local12 = (_local12 + 1);
                                    _local15[_local11][_local12] = _local13;
                                };
                                _local14 = _local13;
                            }
                            else
                            {
                                if (_local13 != _local14)
                                {
                                    _local12 = 0;
                                    _local11 = (_local11 + 1);
                                    _local15[_local11] = new Array();
                                    _local15[_local11][_local12] = _local13;
                                }
                                else
                                {
                                    _local12 = (_local12 + 1);
                                    _local15[_local11][_local12] = _local13;
                                };
                                _local14 = _local13;
                            };
                        }
                        else
                        {
                            if ((((_local9 > 0)) && ((_local6[_local8][_local9] < 2))))
                            {
                                if (_local6[(_local8 - 2)][_local9] != undefined)
                                {
                                    _local13 = 1;
                                }
                                else
                                {
                                    if ((((_local6[(_local8 - 2)][_local9] == undefined)) && ((_local6[(_local8 - 2)][(_local9 - 1)] == undefined))))
                                    {
                                        _local13 = 1;
                                    }
                                    else
                                    {
                                        _local13 = 2;
                                    };
                                };
                                if (_local13 == 1)
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                }
                                else
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                };
                            };
                        };
                    }
                    else
                    {
                        if (!(((_local8 == _local10)) && ((_local9 == 0))))
                        {
                            if ((((_local9 == 0)) && ((_local6[_local8][_local9] < 2))))
                            {
                                if (_local6[(_local8 - 3)][_local6[(_local8 - 1)].length] != undefined)
                                {
                                    _local13 = 2;
                                }
                                else
                                {
                                    if ((((_local6[(_local8 - 3)][(_local6[(_local8 - 1)].length - 1)] == undefined)) && ((_local6[(_local8 - 3)][_local6[(_local8 - 1)].length] == undefined))))
                                    {
                                        _local13 = 2;
                                    }
                                    else
                                    {
                                        _local13 = 1;
                                    };
                                };
                                if (_local13 == 1)
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                }
                                else
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                };
                            }
                            else
                            {
                                if ((((_local9 > 0)) && ((_local6[_local8][_local9] < 2))))
                                {
                                    if (_local6[(_local8 - 2)][_local9] != undefined)
                                    {
                                        _local13 = 1;
                                    }
                                    else
                                    {
                                        if ((((_local6[(_local8 - 2)][_local9] == undefined)) && ((_local6[(_local8 - 2)][(_local9 - 1)] == undefined))))
                                        {
                                            _local13 = 1;
                                        }
                                        else
                                        {
                                            _local13 = 2;
                                        };
                                    };
                                    if (_local13 == 1)
                                    {
                                        if (_local13 != _local14)
                                        {
                                            _local12 = 0;
                                            _local11 = (_local11 + 1);
                                            _local15[_local11] = new Array();
                                            _local15[_local11][_local12] = _local13;
                                        }
                                        else
                                        {
                                            _local12 = (_local12 + 1);
                                            _local15[_local11][_local12] = _local13;
                                        };
                                        _local14 = _local13;
                                    }
                                    else
                                    {
                                        if (_local13 != _local14)
                                        {
                                            _local12 = 0;
                                            _local11 = (_local11 + 1);
                                            _local15[_local11] = new Array();
                                            _local15[_local11][_local12] = _local13;
                                        }
                                        else
                                        {
                                            _local12 = (_local12 + 1);
                                            _local15[_local11][_local12] = _local13;
                                        };
                                        _local14 = _local13;
                                    };
                                };
                            };
                        };
                    };
                    _local9++;
                };
                _local8++;
            };
            var _local16:Array = new Array();
            _local10 = 0;
            var _local17:int;
            var _local18:Boolean = new Boolean(false);
            var _local19:int;
            var _local20:Number = _arg2;
            var _local21:Number = _arg3;
            _local8 = 0;
            while (_local8 < 150)
            {
                _local16[_local8] = new Array();
                _local9 = 0;
                while (_local9 < 6)
                {
                    _local16[_local8][_local9] = new Boolean(true);
                    _local9++;
                };
                _local8++;
            };
            _local8 = 0;
            while (_local8 < _local15.length)
            {
                _local10 = this.daLulei(_local16);
                _local18 = false;
                _local17 = 0;
                _local9 = 0;
                while (_local9 < _local15[_local8].length)
                {
                    _local19 = (_local19 + 1);
                    if ((((((_local16[_local10][_local9] == true)) && (!((_local9 == 5))))) && ((_local18 == false))))
                    {
                        _local4 = {
                            "num":_local15[_local8][_local9],
                            "x":(_local20 * _local10),
                            "y":(_local21 * _local17)
                        };
                        _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                        _local5.push(_local4);
                        _local16[_local10][_local17] = false;
                        _local17 = (_local17 + 1);
                    }
                    else
                    {
                        if ((((((_local16[_local10][_local9] == true)) && ((_local9 == 5)))) && ((_local18 == false))))
                        {
                            _local4 = {
                                "num":_local15[_local8][_local9],
                                "x":(_local20 * _local10),
                                "y":(_local21 * _local17)
                            };
                            _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                            _local5.push(_local4);
                            _local16[_local10][_local17] = false;
                            _local17 = 5;
                            _local18 = true;
                        }
                        else
                        {
                            if (_local18 == true)
                            {
                                _local10 = (_local10 + 1);
                                _local4 = {
                                    "num":_local15[_local8][_local9],
                                    "x":(_local20 * _local10),
                                    "y":(_local21 * _local17)
                                };
                                _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                                _local5.push(_local4);
                                _local16[_local10][_local17] = false;
                                _local18 = true;
                            };
                        };
                    };
                    _local9++;
                };
                _local8++;
            };
            return (_local5);
        }

        public function xiaoluShow(_arg1:Array, _arg2:Class, _arg3:Number=8, _arg4:Number=8):void
        {
            var _local6:MovieClip;
            var _local7:String;
            var _local5:Array = this.xiaolu(_arg1, _arg3, _arg4);
            var _local8:uint = _local5.length;
            Tools.removeAllChild(this._xiaoLuMc);
            var _local9:int;
            while (_local9 < _local8)
            {
                if (this.xiaoLuMcArr[_local9] == undefined)
                {
                    _local7 = (_local7 + _local5[_local9].num);
                    _local6 = (new (_arg2)() as MovieClip);
                    _local6.width = _arg3;
                    _local6.height = _arg4;
                    this.xiaoLuMcArr[_local9] = _local6;
                }
                else
                {
                    _local6 = this.xiaoLuMcArr[_local9];
                };
                _local6.y = _local5[_local9].y;
                _local6.x = _local5[_local9].x;
                _local6.visible = true;
                _local6.gotoAndStop(_local5[_local9].num);
                this._xiaoLuMc.addChild(_local6);
                _local9++;
            };
            if (_local8 > 0)
            {
                this.xiaoLuLie = uint(((_local6.x / _arg3) + 1));
            };
        }

        public function zhanglu(_arg1:Array, _arg2:Number=8, _arg3:Number=8):Array
        {
            var _local4:Object;
            var _local8:uint;
            var _local9:uint;
            var _local5:Array = new Array();
            var _local6:Array = new Array();
            _local6 = this.yuanDaLuArr(_arg1);
            var _local7:uint = new uint(0);
            _local8 = 0;
            while (_local8 < _local6.length)
            {
                _local7 = Math.max(_local6[_local8].length, _local7);
                _local8++;
            };
            var _local10:int;
            var _local11:int = -1;
            var _local12:int;
            var _local13:int;
            var _local14:int;
            if (_local6.length < 4)
            {
                return (_local5);
            };
            if (_local6[3][1] < 2)
            {
                _local10 = 3;
            }
            else
            {
                _local10 = 4;
            };
            var _local15:Array = new Array();
            _local8 = _local10;
            while (_local8 < 150)
            {
                if (_local6[_local8] == undefined) break;
                _local9 = 0;
                while (_local9 < _local6[_local8].length)
                {
                    if (_local10 != 3)
                    {
                        if ((((_local9 == 0)) && ((_local6[_local8][_local9] < 2))))
                        {
                            if (_local6[(_local8 - 4)][_local6[(_local8 - 1)].length] != undefined)
                            {
                                _local13 = 2;
                            }
                            else
                            {
                                if ((((_local6[(_local8 - 4)][(_local6[(_local8 - 1)].length - 1)] == undefined)) && ((_local6[(_local8 - 4)][_local6[(_local8 - 1)].length] == undefined))))
                                {
                                    _local13 = 2;
                                }
                                else
                                {
                                    _local13 = 1;
                                };
                            };
                            if (_local13 == 1)
                            {
                                if (_local13 != _local14)
                                {
                                    _local12 = 0;
                                    _local11 = (_local11 + 1);
                                    _local15[_local11] = new Array();
                                    _local15[_local11][_local12] = _local13;
                                }
                                else
                                {
                                    _local12 = (_local12 + 1);
                                    _local15[_local11][_local12] = _local13;
                                };
                                _local14 = _local13;
                            }
                            else
                            {
                                if (_local13 != _local14)
                                {
                                    _local12 = 0;
                                    _local11 = (_local11 + 1);
                                    _local15[_local11] = new Array();
                                    _local15[_local11][_local12] = _local13;
                                }
                                else
                                {
                                    _local12 = (_local12 + 1);
                                    _local15[_local11][_local12] = _local13;
                                };
                                _local14 = _local13;
                            };
                        }
                        else
                        {
                            if ((((_local9 > 0)) && ((_local6[_local8][_local9] < 2))))
                            {
                                if (_local6[(_local8 - 3)][_local9] != undefined)
                                {
                                    _local13 = 1;
                                }
                                else
                                {
                                    if ((((_local6[(_local8 - 3)][_local9] == undefined)) && ((_local6[(_local8 - 3)][(_local9 - 1)] == undefined))))
                                    {
                                        _local13 = 1;
                                    }
                                    else
                                    {
                                        _local13 = 2;
                                    };
                                };
                                if (_local13 == 1)
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                }
                                else
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                };
                            };
                        };
                    }
                    else
                    {
                        if (!(((_local8 == _local10)) && ((_local9 == 0))))
                        {
                            if ((((_local9 == 0)) && ((_local6[_local8][_local9] < 2))))
                            {
                                if (_local6[(_local8 - 4)][_local6[(_local8 - 1)].length] != undefined)
                                {
                                    _local13 = 2;
                                }
                                else
                                {
                                    if ((((_local6[(_local8 - 4)][(_local6[(_local8 - 1)].length - 1)] == undefined)) && ((_local6[(_local8 - 4)][_local6[(_local8 - 1)].length] == undefined))))
                                    {
                                        _local13 = 2;
                                    }
                                    else
                                    {
                                        _local13 = 1;
                                    };
                                };
                                if (_local13 == 1)
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                }
                                else
                                {
                                    if (_local13 != _local14)
                                    {
                                        _local12 = 0;
                                        _local11 = (_local11 + 1);
                                        _local15[_local11] = new Array();
                                        _local15[_local11][_local12] = _local13;
                                    }
                                    else
                                    {
                                        _local12 = (_local12 + 1);
                                        _local15[_local11][_local12] = _local13;
                                    };
                                    _local14 = _local13;
                                };
                            }
                            else
                            {
                                if ((((_local9 > 0)) && ((_local6[_local8][_local9] < 2))))
                                {
                                    if (_local6[(_local8 - 3)][_local9] != undefined)
                                    {
                                        _local13 = 1;
                                    }
                                    else
                                    {
                                        if ((((_local6[(_local8 - 3)][_local9] == undefined)) && ((_local6[(_local8 - 3)][(_local9 - 1)] == undefined))))
                                        {
                                            _local13 = 1;
                                        }
                                        else
                                        {
                                            _local13 = 2;
                                        };
                                    };
                                    if (_local13 == 1)
                                    {
                                        if (_local13 != _local14)
                                        {
                                            _local12 = 0;
                                            _local11 = (_local11 + 1);
                                            _local15[_local11] = new Array();
                                            _local15[_local11][_local12] = _local13;
                                        }
                                        else
                                        {
                                            _local12 = (_local12 + 1);
                                            _local15[_local11][_local12] = _local13;
                                        };
                                        _local14 = _local13;
                                    }
                                    else
                                    {
                                        if (_local13 != _local14)
                                        {
                                            _local12 = 0;
                                            _local11 = (_local11 + 1);
                                            _local15[_local11] = new Array();
                                            _local15[_local11][_local12] = _local13;
                                        }
                                        else
                                        {
                                            _local12 = (_local12 + 1);
                                            _local15[_local11][_local12] = _local13;
                                        };
                                        _local14 = _local13;
                                    };
                                };
                            };
                        };
                    };
                    _local9++;
                };
                _local8++;
            };
            var _local16:Array = new Array();
            _local10 = 0;
            var _local17:int;
            var _local18:Boolean = new Boolean(false);
            var _local19:int;
            var _local20:Number = _arg2;
            var _local21:Number = _arg3;
            _local8 = 0;
            while (_local8 < 150)
            {
                _local16[_local8] = new Array();
                _local9 = 0;
                while (_local9 < 6)
                {
                    _local16[_local8][_local9] = new Boolean(true);
                    _local9++;
                };
                _local8++;
            };
            _local8 = 0;
            while (_local8 < _local15.length)
            {
                _local10 = this.daLulei(_local16);
                _local18 = false;
                _local17 = 0;
                _local9 = 0;
                while (_local9 < _local15[_local8].length)
                {
                    _local19 = (_local19 + 1);
                    if ((((((_local16[_local10][_local9] == true)) && (!((_local9 == 5))))) && ((_local18 == false))))
                    {
                        _local4 = {
                            "num":_local15[_local8][_local9],
                            "x":(_local20 * _local10),
                            "y":(_local21 * _local17)
                        };
                        _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                        _local5.push(_local4);
                        _local16[_local10][_local17] = false;
                        _local17 = (_local17 + 1);
                    }
                    else
                    {
                        if ((((((_local16[_local10][_local9] == true)) && ((_local9 == 5)))) && ((_local18 == false))))
                        {
                            _local4 = {
                                "num":_local15[_local8][_local9],
                                "x":(_local20 * _local10),
                                "y":(_local21 * _local17)
                            };
                            _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                            _local5.push(_local4);
                            _local16[_local10][_local17] = false;
                            _local17 = 5;
                            _local18 = true;
                        }
                        else
                        {
                            if (_local18 == true)
                            {
                                _local10 = (_local10 + 1);
                                _local4 = {
                                    "num":_local15[_local8][_local9],
                                    "x":(_local20 * _local10),
                                    "y":(_local21 * _local17)
                                };
                                _local5[((("z" + _local8) + "_") + _local9)] = _local4;
                                _local5.push(_local4);
                                _local16[_local10][_local17] = false;
                                _local18 = true;
                            };
                        };
                    };
                    _local9++;
                };
                _local8++;
            };
            return (_local5);
        }

        public function zhangluShow(_arg1:Array, _arg2:Class, _arg3:Number=8, _arg4:Number=8):void
        {
            var _local6:MovieClip;
            var _local5:Array = this.zhanglu(_arg1, _arg3, _arg4);
            var _local7:uint = _local5.length;
            Tools.removeAllChild(this._zhangLuMc);
            var _local8:int;
            while (_local8 < _local7)
            {
                if (this.zhangLuMcArr[_local8] == undefined)
                {
                    _local6 = (new (_arg2)() as MovieClip);
                    _local6.width = _arg3;
                    _local6.height = _arg4;
                    this.zhangLuMcArr[_local8] = _local6;
                }
                else
                {
                    _local6 = this.zhangLuMcArr[_local8];
                };
                _local6.y = _local5[_local8].y;
                _local6.x = _local5[_local8].x;
                _local6.visible = true;
                _local6.gotoAndStop(_local5[_local8].num);
                this._zhangLuMc.addChild(_local6);
                _local8++;
            };
            if (_local7 > 0)
            {
                this.zhangLuLie = uint(((_local6.x / _arg3) + 1));
            };
        }

        public function clearTie(_arg1:Array):Array
        {
            var _local4:Boolean;
            var _local2:Array = _arg1.concat([]);
            var _local3:uint;
            var _local5:uint;
            while (_local5 < _local2.length)
            {
                if (false == _local4)
                {
                    if (_local2[_local5] > 7)
                    {
                        _local3++;
                    }
                    else
                    {
                        _local4 = true;
                        break;
                    };
                };
                _local5++;
            };
            _local2.splice(0, _local3);
            return (_local2);
        }


    }
}//package com.snake.game
