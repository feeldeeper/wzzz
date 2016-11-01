package com.snake.game
{
    import flash.display.*;

    public class DaxiaoCardlog 
    {

        public static var injectTypeArr:Array = [{
            "type":"p1",
            "multiple":1
        }, {
            "type":"p2",
            "multiple":1
        }, {
            "type":"p3",
            "multiple":1
        }, {
            "type":"p4",
            "multiple":1
        }, {
            "type":"p5",
            "multiple":1
        }, {
            "type":"p6",
            "multiple":1
        }, {
            "type":"g12",
            "multiple":5
        }, {
            "type":"g13",
            "multiple":5
        }, {
            "type":"g14",
            "multiple":5
        }, {
            "type":"g15",
            "multiple":5
        }, {
            "type":"g16",
            "multiple":5
        }, {
            "type":"g23",
            "multiple":5
        }, {
            "type":"g24",
            "multiple":5
        }, {
            "type":"g25",
            "multiple":5
        }, {
            "type":"g26",
            "multiple":5
        }, {
            "type":"g34",
            "multiple":5
        }, {
            "type":"g35",
            "multiple":5
        }, {
            "type":"g36",
            "multiple":5
        }, {
            "type":"g45",
            "multiple":5
        }, {
            "type":"g46",
            "multiple":5
        }, {
            "type":"g56",
            "multiple":5
        }, {
            "type":"num4",
            "multiple":50
        }, {
            "type":"num5",
            "multiple":18
        }, {
            "type":"num6",
            "multiple":14
        }, {
            "type":"num7",
            "multiple":12
        }, {
            "type":"num8",
            "multiple":8
        }, {
            "type":"num9",
            "multiple":6
        }, {
            "type":"num10",
            "multiple":6
        }, {
            "type":"num11",
            "multiple":6
        }, {
            "type":"num12",
            "multiple":6
        }, {
            "type":"num13",
            "multiple":8
        }, {
            "type":"num14",
            "multiple":12
        }, {
            "type":"num15",
            "multiple":14
        }, {
            "type":"num16",
            "multiple":18
        }, {
            "type":"num17",
            "multiple":50
        }, {
            "type":"wei1",
            "multiple":150
        }, {
            "type":"wei2",
            "multiple":150
        }, {
            "type":"wei3",
            "multiple":150
        }, {
            "type":"wei4",
            "multiple":150
        }, {
            "type":"wei5",
            "multiple":150
        }, {
            "type":"wei6",
            "multiple":150
        }, {
            "type":"weiAll",
            "multiple":24
        }, {
            "type":"pair1",
            "multiple":8
        }, {
            "type":"pair2",
            "multiple":8
        }, {
            "type":"pair3",
            "multiple":8
        }, {
            "type":"pair4",
            "multiple":8
        }, {
            "type":"pair5",
            "multiple":8
        }, {
            "type":"pair6",
            "multiple":8
        }, {
            "type":"single",
            "multiple":1
        }, {
            "type":"double",
            "multiple":1
        }, {
            "type":"small",
            "multiple":1
        }, {
            "type":"big",
            "multiple":1
        }];
        private static var _instance:DaxiaoCardlog;

        private var _daLuLie:uint = 0;
        private var _zhuZaiLuLie:uint = 0;
        private var _daYanLuLie:uint = 0;
        private var _xiaoLuLie:uint = 0;
        private var _zhangLuLie:uint = 0;


        public static function get instance():DaxiaoCardlog
        {
            if (!_instance)
            {
                _instance = new (DaxiaoCardlog)();
            };
            return (_instance);
        }

        public static function showRoad(_arg1:Array, _arg2:Class, _arg3:Number, _arg4:Number):Sprite
        {
            var _local5:Sprite = DaxiaoCardlog.instance.showRoad(_arg1, _arg2, _arg3, _arg4);
            return (_local5);
        }

        public static function showBigOrSmall(_arg1:Array, _arg2:Class, _arg3:Number, _arg4:Number):Sprite
        {
            var _local5:Sprite = DaxiaoCardlog.instance.getDaLuShowBox(_arg1, _arg2, _arg3, _arg4, "BigSmall");
            return (_local5);
        }

        public static function get daLuLie():uint
        {
            return (DaxiaoCardlog.instance.daLuLie);
        }

        public static function getLastArr(_arg1:Array):Array
        {
            _arg1 = _arg1.concat(new Array());
            while (_arg1.length > 168)
            {
                _arg1.shift();
            };
            return (_arg1);
        }

        public static function getResult(_arg1):Object
        {
            var _local2:Array;
            if ((_arg1 is Array))
            {
                _local2 = _arg1;
            }
            else
            {
                _local2 = String(_arg1).split("");
            };
            var _local3:Object = {};
            var _local4:Number = ((Number(_local2[0]) + Number(_local2[1])) + Number(_local2[2]));
            _local3.num = _local4;
            _local3.resultsArr = _local2;
            _local3.wei = getWeiResult(_local2);
            _local3.big = getBigOrSmall(_local2);
            _local3.single = getSingleOrDouble(_local2);
            _local3.armedForces = getArmedForces(_local2);
            _local3.domino = getDomino(_local2);
            return (_local3);
        }

        public static function getAllResult(_arg1):Number
        {
            var _local2:Array;
            if ((_arg1 is Array))
            {
                _local2 = _arg1;
            }
            else
            {
                _local2 = String(_arg1).split("");
            };
            return (((Number(_local2[0]) + Number(_local2[1])) + Number(_local2[2])));
        }

        public static function getWeiResult(_arg1):Number
        {
            var _local2:Array;
            if ((_arg1 is Array))
            {
                _local2 = _arg1;
            }
            else
            {
                _local2 = String(_arg1).split("");
            };
            if ((((Number(_local2[0]) == Number(_local2[1]))) && ((Number(_local2[1]) == Number(_local2[2])))))
            {
                return (Number(_local2[0]));
            };
            return (0);
        }

        public static function getBigOrSmall(_arg1):Number
        {
            var _local2:Array;
            if ((_arg1 is Array))
            {
                _local2 = _arg1;
            }
            else
            {
                _local2 = String(_arg1).split("");
            };
            var _local3:Number = getAllResult(_local2);
            if (getWeiResult(_local2) != 0)
            {
                return (0);
            };
            if (_local3 < 4)
            {
                return (0);
            };
            if ((((_local3 >= 4)) && ((_local3 <= 10))))
            {
                return (1);
            };
            return (2);
        }

        public static function getSingleOrDouble(_arg1):Number
        {
            var _local2:Array;
            if ((_arg1 is Array))
            {
                _local2 = _arg1;
            }
            else
            {
                _local2 = String(_arg1).split("");
            };
            var _local3:Number = getAllResult(_local2);
            if (getWeiResult(_local2) != 0)
            {
                return (0);
            };
            if (_local3 < 4)
            {
                return (0);
            };
            if ((_local3 % 2) != 0)
            {
                return (1);
            };
            return (2);
        }

        public static function getArmedForces(_arg1):Object
        {
            var _local2:Array;
            var _local5:Number;
            if ((_arg1 is Array))
            {
                _local2 = _arg1;
            }
            else
            {
                _local2 = String(_arg1).split("");
            };
            var _local3:Object = {};
            var _local4:int = 1;
            while (_local4 < 7)
            {
                _local3[("p" + _local4)] = 0;
                _local4++;
            };
            _local4 = 0;
            while (_local4 < _local2.length)
            {
                _local5 = _local2[_local4];
                _local3[("p" + _local5)] = (_local3[("p" + _local5)] + 1);
                _local4++;
            };
            return (_local3);
        }

        public static function getDomino(_arg1):Object
        {
            var _local2:Array;
            if ((_arg1 is Array))
            {
                _local2 = _arg1;
            }
            else
            {
                _local2 = String(_arg1).split("");
            };
            _local2[0] = Number(_local2[0]);
            _local2[1] = Number(_local2[1]);
            _local2[2] = Number(_local2[2]);
            var _local3:Object = {};
            _local3.g12 = ((!((_local2.indexOf(1) == -1))) && (!((_local2.indexOf(2) == -1))));
            _local3.g13 = ((!((_local2.indexOf(1) == -1))) && (!((_local2.indexOf(3) == -1))));
            _local3.g14 = ((!((_local2.indexOf(1) == -1))) && (!((_local2.indexOf(4) == -1))));
            _local3.g15 = ((!((_local2.indexOf(1) == -1))) && (!((_local2.indexOf(5) == -1))));
            _local3.g16 = ((!((_local2.indexOf(1) == -1))) && (!((_local2.indexOf(6) == -1))));
            _local3.g23 = ((!((_local2.indexOf(2) == -1))) && (!((_local2.indexOf(3) == -1))));
            _local3.g24 = ((!((_local2.indexOf(2) == -1))) && (!((_local2.indexOf(4) == -1))));
            _local3.g25 = ((!((_local2.indexOf(2) == -1))) && (!((_local2.indexOf(5) == -1))));
            _local3.g26 = ((!((_local2.indexOf(2) == -1))) && (!((_local2.indexOf(6) == -1))));
            _local3.g34 = ((!((_local2.indexOf(3) == -1))) && (!((_local2.indexOf(4) == -1))));
            _local3.g35 = ((!((_local2.indexOf(3) == -1))) && (!((_local2.indexOf(5) == -1))));
            _local3.g36 = ((!((_local2.indexOf(3) == -1))) && (!((_local2.indexOf(6) == -1))));
            _local3.g45 = ((!((_local2.indexOf(4) == -1))) && (!((_local2.indexOf(5) == -1))));
            _local3.g46 = ((!((_local2.indexOf(4) == -1))) && (!((_local2.indexOf(6) == -1))));
            _local3.g56 = ((!((_local2.indexOf(5) == -1))) && (!((_local2.indexOf(6) == -1))));
            return (_local3);
        }

        public static function getInjectTypeArr():Array
        {
            var _local1:Array = new Array();
            return (_local1.concat(DaxiaoCardlog.injectTypeArr));
        }


        public function get zhangLuLie():uint
        {
            return (this._zhangLuLie);
        }

        public function set zhangLuLie(_arg1:uint):void
        {
            this._zhangLuLie = _arg1;
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

        public function set daYanLuLie(_arg1:uint):void
        {
            this._daYanLuLie = _arg1;
        }

        public function get zhuZaiLuLie():uint
        {
            return (this._zhuZaiLuLie);
        }

        public function set zhuZaiLuLie(_arg1:uint):void
        {
            this._zhuZaiLuLie = _arg1;
        }

        public function get daLuLie():uint
        {
            return (this._daLuLie);
        }

        public function set daLuLie(_arg1:uint):void
        {
            this._daLuLie = _arg1;
        }

        public function getDaLuShowBox(_arg1:Array, _arg2:Class, _arg3:Number=16, _arg4:Number=16, _arg5:String="BigSmall"):Sprite
        {
            var _local7:MovieClip;
            var _local12:uint;
            var _local6:Array = this.daxiaoLu(_arg1, _arg3, _arg4, _arg5);
            var _local8:Sprite = new Sprite();
            var _local9 = "";
            var _local10:uint = _local6.length;
            var _local11:int;
            while (_local11 < _local10)
            {
                _local9 = (_local9 + _local6[_local11].num);
                _local12 = uint(_local6[_local11].num);
                _local7 = (new (_arg2)() as MovieClip);
                if (_local12 == 0)
                {
                    _local7.gotoAndStop(3);
                }
                else
                {
                    if (_local12 == 1)
                    {
                        _local7.gotoAndStop(1);
                    }
                    else
                    {
                        _local7.gotoAndStop(2);
                    };
                };
                _local7.y = _local6[_local11].y;
                _local7.x = _local6[_local11].x;
                _local7.width = _arg3;
                _local7.height = _arg4;
                _local8.addChild(_local7);
                _local11++;
            };
            if (_local10 > 0)
            {
                if (_arg5 == "BigSmall")
                {
                    this.daLuLie = Math.ceil(((_local7.x / _arg3) + 1));
                }
                else
                {
                    this.daYanLuLie = Math.ceil(((_local7.x / _arg3) + 1));
                };
            };
            return (_local8);
        }

        public function daLu(_arg1:Array, _arg2:Number=16, _arg3:Number=16, _arg4:String="BigSmall"):Array
        {
            var _local5:Object;
            var _local9:uint;
            var _local10:uint;
            var _local17:int;
            var _local18:int;
            var _local6:Array = new Array();
            var _local7:Number = _arg2;
            var _local8:Number = _arg3;
            var _local11:uint;
            var _local12:uint;
            var _local13:uint;
            var _local14:uint;
            var _local15:Boolean;
            var _local16:Array = new Array();
            _local17 = 0;
            while (_local17 < 150)
            {
                _local16[_local17] = new Array();
                _local18 = 0;
                while (_local18 < 6)
                {
                    _local16[_local17][_local18] = true;
                    _local18++;
                };
                _local17++;
            };
            var _local19:Array = new Array();
            _local17 = 0;
            while (_local17 < 150)
            {
                _local19[_local17] = new Array();
                _local18 = 0;
                while (_local18 < 6)
                {
                    _local19[_local17][_local18] = 5;
                    _local18++;
                };
                _local17++;
            };
            var _local20:uint = this.daLuStart(_arg1);
            var _local21:uint;
            _local17 = _local20;
            while (_local17 < _arg1.length)
            {
                if (_arg4 == "BigSmall")
                {
                    _local9 = this.getBigOrSmall(_arg1[_local17]);
                    _local21 = DaxiaoCardlog.getBigOrSmall(_arg1[_local17]);
                }
                else
                {
                    if (_arg4 == "SingleDouble")
                    {
                        _local9 = this.getSingleOrDouble(_arg1[_local17]);
                        _local21 = DaxiaoCardlog.getSingleOrDouble(_arg1[_local17]);
                    }
                    else
                    {
                        _local9 = 2;
                    };
                };
                if (_local17 == _local20)
                {
                    _local16[_local11][_local12] = false;
                    _local5 = {
                        "num":_local21,
                        "x":(_local7 * _local11),
                        "y":(_local8 * _local12),
                        "heMc":false,
                        "heNum":0
                    };
                    _local6.push(_local5);
                    _local6[((("z" + _local11) + "_") + _local12)] = _local5;
                    _local19[_local11][_local12] = _local9;
                    _local10 = _local9;
                }
                else
                {
                    if (_local9 == 2)
                    {
                        _local5 = _local6[((("z" + _local11) + "_") + _local12)];
                        _local5.heMc = true;
                        _local5.heNum = (_local5.heNum + 1);
                    }
                    else
                    {
                        if (_local9 != _local10)
                        {
                            _local11 = this.daLulei(_local16);
                            _local12 = 0;
                            _local16[_local11][_local12] = false;
                            _local5 = {
                                "num":_local21,
                                "x":(_local7 * _local11),
                                "y":(_local8 * _local12),
                                "heMc":false,
                                "heNum":0
                            };
                            _local6.push(_local5);
                            _local6[((("z" + _local11) + "_") + _local12)] = _local5;
                            _local19[_local11][_local12] = _local9;
                            _local14 = 0;
                            _local15 = false;
                        }
                        else
                        {
                            _local14 = (_local14 + 1);
                            if (_local15 == true)
                            {
                                _local11 = (_local11 + 1);
                                _local16[_local11][_local12] = false;
                                _local5 = {
                                    "num":_local21,
                                    "x":(_local7 * _local11),
                                    "y":(_local8 * _local12),
                                    "heMc":false,
                                    "heNum":0
                                };
                                _local6.push(_local5);
                                _local6[((("z" + _local11) + "_") + _local12)] = _local5;
                                _local19[_local11][_local12] = _local9;
                            }
                            else
                            {
                                if (_local16[_local11][(_local12 + 1)] == true)
                                {
                                    _local12 = (_local12 + 1);
                                    _local16[_local11][_local12] = false;
                                    _local5 = {
                                        "num":_local21,
                                        "x":(_local7 * _local11),
                                        "y":(_local8 * _local12),
                                        "heMc":false,
                                        "heNum":0
                                    };
                                    _local6.push(_local5);
                                    _local6[((("z" + _local11) + "_") + _local12)] = _local5;
                                    _local19[_local11][_local12] = _local9;
                                }
                                else
                                {
                                    if (_local12 == 5)
                                    {
                                        _local11 = (_local11 + 1);
                                        _local16[_local11][_local12] = false;
                                        _local5 = {
                                            "num":_local21,
                                            "x":(_local7 * _local11),
                                            "y":(_local8 * _local12),
                                            "heMc":false,
                                            "heNum":0
                                        };
                                        _local6.push(_local5);
                                        _local6[((("z" + _local11) + "_") + _local12)] = _local5;
                                        _local19[_local11][_local12] = _local9;
                                        _local15 = true;
                                    }
                                    else
                                    {
                                        _local11 = (_local11 + 1);
                                        _local16[_local11][_local12] = false;
                                        _local5 = {
                                            "num":_local21,
                                            "x":(_local7 * _local11),
                                            "y":(_local8 * _local12),
                                            "heMc":false,
                                            "heNum":0
                                        };
                                        _local6.push(_local5);
                                        _local6[((("z" + _local11) + "_") + _local12)] = _local5;
                                        _local19[_local11][_local12] = _local9;
                                        _local15 = true;
                                    };
                                };
                            };
                        };
                        _local10 = _local9;
                    };
                };
                _local17++;
            };
            return (_local6);
        }

        private function daLuStart(_arg1:Array):uint
        {
            return (0);
        }

        public function daxiaoLu(_arg1:Array, _arg2:Number=16, _arg3:Number=16, _arg4:String="BigSmall"):Array
        {
            var _local10:int;
            var _local11:Object;
            var _local5:Array = new Array();
            var _local6:int = -1;
            var _local7:int = -1;
            var _local8:int = -1;
            var _local9:int = -1;
            _local10 = 0;
            while (_local10 < _arg1.length)
            {
                if (_arg4 == "BigSmall")
                {
                    _local8 = DaxiaoCardlog.getBigOrSmall(_arg1[_local10]);
                }
                else
                {
                    if (_arg4 == "SingleDouble")
                    {
                        _local8 = DaxiaoCardlog.getSingleOrDouble(_arg1[_local10]);
                    }
                    else
                    {
                        _local8 = 2;
                    };
                };
                if (_local8 != _local9)
                {
                    _local6++;
                    _local7 = 0;
                }
                else
                {
                    if (++_local7 > 5)
                    {
                        _local6++;
                        _local7 = 0;
                    };
                };
                _local11 = {
                    "num":_local8,
                    "x":(_arg2 * _local6),
                    "y":(_arg3 * _local7)
                };
                _local5.push(_local11);
                _local9 = _local8;
                _local10++;
            };
            return (_local5);
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

        public function getBigOrSmall(_arg1):uint
        {
            var _local4:uint;
            var _local2:Array = String(_arg1).split("");
            var _local3:uint = DaxiaoCardlog.getBigOrSmall(_local2);
            if (_local3 == 0)
            {
                _local4 = 2;
            }
            else
            {
                if (_local3 == 1)
                {
                    _local4 = 0;
                }
                else
                {
                    if (_local3 == 2)
                    {
                        _local4 = 1;
                    };
                };
            };
            return (_local4);
        }

        public function getSingleOrDouble(_arg1):uint
        {
            var _local4:uint;
            var _local2:Array = String(_arg1).split("");
            var _local3:uint = DaxiaoCardlog.getSingleOrDouble(_local2);
            if (_local3 == 0)
            {
                _local4 = 2;
            }
            else
            {
                if (_local3 == 1)
                {
                    _local4 = 0;
                }
                else
                {
                    if (_local3 == 2)
                    {
                        _local4 = 1;
                    };
                };
            };
            return (_local4);
        }

        public function showRoad(_arg1:Array, _arg2:Class, _arg3:Number, _arg4:Number):Sprite
        {
            var _local6:MovieClip;
            var _local5:Sprite = new Sprite();
            var _local7:uint = _arg1.length;
            var _local8:int;
            while (_local8 < _arg1.length)
            {
                _local6 = (new (_arg2)() as MovieClip);
                if (_local6.label)
                {
                    _local6.label.text = (_arg1[_local8] + "");
                };
                _local6.width = _arg3;
                _local6.height = _arg4;
                _local6.y = ((_local8 % 5) * _arg4);
                _local6.x = (((_local8 / 5) >> 0) * _arg3);
                _local5.addChild(_local6);
                _local8++;
            };
            if (_local7 > 0)
            {
                this.zhuZaiLuLie = uint(((_local6.x / _arg3) + 1));
            };
            return (_local5);
        }

        public function showSingleOrDouble(_arg1:Array, _arg2:Class, _arg3:Number, _arg4:Number):Sprite
        {
            var _local5:Sprite = DaxiaoCardlog.instance.getDaLuShowBox(_arg1, _arg2, _arg3, _arg4, "SingleDouble");
            return (_local5);
        }

        public function showAllResult(_arg1:Array, _arg2:Class, _arg3:Number, _arg4:Number):Sprite
        {
            var _local6:MovieClip;
            var _local8:Array;
            var _local9:Number;
            var _local5:Sprite = new Sprite();
            var _local7:int;
            while (_local7 < _arg1.length)
            {
                _local6 = (new (_arg2)() as MovieClip);
                _local8 = String(_arg1[_local7]).split("");
                _local9 = getAllResult(_local8);
                if (_local6.label)
                {
                    _local6.label.text = (_local9 + "");
                };
                _local9 = this.getBigOrSmall(_local8);
                if (_local9 == 0)
                {
                    _local6.gotoAndStop(3);
                }
                else
                {
                    if (_local9 == 1)
                    {
                        _local6.gotoAndStop(1);
                    }
                    else
                    {
                        _local6.gotoAndStop(2);
                    };
                };
                _local6.width = _arg3;
                _local6.height = _arg4;
                _local6.y = ((_local7 % 6) * _arg4);
                _local6.x = (((_local7 / 6) >> 0) * _arg3);
                _local5.addChild(_local6);
                _local7++;
            };
            return (_local5);
        }

        public function getLastArr(_arg1:Array):Array
        {
            _arg1 = _arg1.concat(new Array());
            while (_arg1.length > 168)
            {
                _arg1.shift();
            };
            return (_arg1);
        }


    }
}//package com.snake.game
