package 
{
    public function sprintf(_arg1:String, ... _args):String
    {
        var _local5:*;
        var _local6:String;
        var _local8:String;
        var _local9:Boolean;
        var _local10:Boolean;
        var _local11:Boolean;
        var _local12:Boolean;
        var _local13:Boolean;
        var _local14:Boolean;
        var _local15:Boolean;
        var _local16:String;
        var _local17:String;
        var _local18:Boolean;
        var _local19:Boolean;
        var _local3 = "";
        var _local4:int = _arg1.length;
        var _local7:int;
        while (_local7 < _local4)
        {
            _local8 = _arg1.charAt(_local7);
            if (_local8 == "%")
            {
                _local9 = false;
                _local10 = false;
                _local11 = false;
                _local12 = false;
                _local13 = false;
                _local14 = false;
                _local15 = false;
                _local16 = "";
                _local17 = "";
                _local8 = _arg1.charAt(++_local7);
                while (((((((((((((((((((((!((_local8 == "d"))) && (!((_local8 == "i"))))) && (!((_local8 == "o"))))) && (!((_local8 == "u"))))) && (!((_local8 == "x"))))) && (!((_local8 == "X"))))) && (!((_local8 == "f"))))) && (!((_local8 == "F"))))) && (!((_local8 == "c"))))) && (!((_local8 == "s"))))) && (!((_local8 == "%")))))
                {
                    if (!_local10)
                    {
                        if (((!(_local11)) && ((_local8 == "#"))))
                        {
                            _local11 = true;
                        }
                        else
                        {
                            if (((!(_local12)) && ((_local8 == "0"))))
                            {
                                _local12 = true;
                            }
                            else
                            {
                                if (((!(_local13)) && ((_local8 == "-"))))
                                {
                                    _local13 = true;
                                }
                                else
                                {
                                    if (((!(_local14)) && ((_local8 == " "))))
                                    {
                                        _local14 = true;
                                    }
                                    else
                                    {
                                        if (((!(_local15)) && ((_local8 == "+"))))
                                        {
                                            _local15 = true;
                                        }
                                        else
                                        {
                                            _local10 = true;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (((!(_local9)) && ((_local8 == "."))))
                    {
                        _local10 = true;
                        _local9 = true;
                        _local8 = _arg1.charAt(++_local7);
                    }
                    else
                    {
                        if (_local10)
                        {
                            if (!_local9)
                            {
                                _local16 = (_local16 + _local8);
                            }
                            else
                            {
                                _local17 = (_local17 + _local8);
                            };
                        };
                        _local8 = _arg1.charAt(++_local7);
                    };
                };
                switch (_local8)
                {
                    case "d":
                    case "i":
                        _local5 = _args.shift();
                        _local6 = String(Math.abs(int(_local5)));
                        if (_local17 != "")
                        {
                            _local6 = leftPad(_local6, int(_local17), "0");
                        };
                        if (int(_local5) < 0)
                        {
                            _local6 = ("-" + _local6);
                        }
                        else
                        {
                            if (((_local15) && ((int(_local5) >= 0))))
                            {
                                _local6 = ("+" + _local6);
                            };
                        };
                        if (_local16 != "")
                        {
                            if (_local13)
                            {
                                _local6 = rightPad(_local6, int(_local16));
                            }
                            else
                            {
                                if (((_local12) && ((_local17 == ""))))
                                {
                                    _local6 = leftPad(_local6, int(_local16), "0");
                                }
                                else
                                {
                                    _local6 = leftPad(_local6, int(_local16));
                                };
                            };
                        };
                        _local3 = (_local3 + _local6);
                        break;
                    case "o":
                        _local5 = _args.shift();
                        _local6 = uint(_local5).toString(8);
                        if (((_local11) && (!((_local6 == "0")))))
                        {
                            _local6 = ("0" + _local6);
                        };
                        if (_local17 != "")
                        {
                            _local6 = leftPad(_local6, int(_local17), "0");
                        };
                        if (_local16 != "")
                        {
                            if (_local13)
                            {
                                _local6 = rightPad(_local6, int(_local16));
                            }
                            else
                            {
                                if (((_local12) && ((_local17 == ""))))
                                {
                                    _local6 = leftPad(_local6, int(_local16), "0");
                                }
                                else
                                {
                                    _local6 = leftPad(_local6, int(_local16));
                                };
                            };
                        };
                        _local3 = (_local3 + _local6);
                        break;
                    case "u":
                        _local5 = _args.shift();
                        _local6 = uint(_local5).toString(10);
                        if (_local17 != "")
                        {
                            _local6 = leftPad(_local6, int(_local17), "0");
                        };
                        if (_local16 != "")
                        {
                            if (_local13)
                            {
                                _local6 = rightPad(_local6, int(_local16));
                            }
                            else
                            {
                                if (((_local12) && ((_local17 == ""))))
                                {
                                    _local6 = leftPad(_local6, int(_local16), "0");
                                }
                                else
                                {
                                    _local6 = leftPad(_local6, int(_local16));
                                };
                            };
                        };
                        _local3 = (_local3 + _local6);
                        break;
                    case "X":
                        _local18 = true;
                    case "x":
                        _local5 = _args.shift();
                        _local6 = uint(_local5).toString(16);
                        if (_local17 != "")
                        {
                            _local6 = leftPad(_local6, int(_local17), "0");
                        };
                        _local19 = ((_local11) && (!((uint(_local5) == 0))));
                        if (((((((!((_local16 == ""))) && (!(_local13)))) && (_local12))) && ((_local17 == ""))))
                        {
                            _local6 = leftPad(_local6, ((_local19) ? (int(_local16) - 2) : int(_local16)), "0");
                        };
                        if (_local19)
                        {
                            _local6 = ("0x" + _local6);
                        };
                        if (_local16 != "")
                        {
                            if (_local13)
                            {
                                _local6 = rightPad(_local6, int(_local16));
                            }
                            else
                            {
                                _local6 = leftPad(_local6, int(_local16));
                            };
                        };
                        if (_local18)
                        {
                            _local6 = _local6.toUpperCase();
                        };
                        _local3 = (_local3 + _local6);
                        break;
                    case "f":
                    case "F":
                        _local5 = _args.shift();
                        _local6 = Math.abs(Number(_local5)).toFixed((((_local17)!="") ? Number(_local17) : 6));
                        if (Number(_local5) < 0)
                        {
                            _local6 = ("-" + _local6);
                        }
                        else
                        {
                            if (((_local15) && ((int(_local5) >= 0))))
                            {
                                _local6 = ("+" + _local6);
                            };
                        };
                        if (((_local11) && ((_local6.indexOf(".") == -1))))
                        {
                            _local6 = (_local6 + ".");
                        };
                        if (_local16 != "")
                        {
                            if (_local13)
                            {
                                _local6 = rightPad(_local6, int(_local16));
                            }
                            else
                            {
                                if (((_local12) && ((_local17 == ""))))
                                {
                                    _local6 = leftPad(_local6, int(_local16), "0");
                                }
                                else
                                {
                                    _local6 = leftPad(_local6, int(_local16));
                                };
                            };
                        };
                        _local3 = (_local3 + _local6);
                        break;
                    case "c":
                        _local5 = _args.shift();
                        _local6 = String.fromCharCode(int(_local5));
                        if (_local16 != "")
                        {
                            if (_local13)
                            {
                                _local6 = rightPad(_local6, int(_local16));
                            }
                            else
                            {
                                _local6 = leftPad(_local6, int(_local16));
                            };
                        };
                        _local3 = (_local3 + _local6);
                        break;
                    case "s":
                        _local5 = _args.shift();
                        _local6 = String(_local5);
                        if (_local17 != "")
                        {
                            _local6 = _local6.substring(0, int(_local17));
                        };
                        if (_local16 != "")
                        {
                            if (_local13)
                            {
                                _local6 = rightPad(_local6, int(_local16));
                            }
                            else
                            {
                                _local6 = leftPad(_local6, int(_local16));
                            };
                        };
                        _local3 = (_local3 + _local6);
                        break;
                    case "%":
                        _local3 = (_local3 + "%");
                };
            }
            else
            {
                _local3 = (_local3 + _local8);
            };
            _local7++;
        };
        return (_local3);
    }

}//package 

const leftPad:Function = function (_arg1:String, _arg2:int, _arg3:String=" "):String
    {
        var _local4:String;
        if (_arg1.length < _arg2)
        {
            _local4 = "";
            while ((_local4.length + _arg1.length) < _arg2)
            {
                _local4 = (_local4 + _arg3);
            };
            return ((_local4 + _arg1));
        };
        return (_arg1);
    };
const rightPad:Function = function (_arg1:String, _arg2:int, _arg3:String=" "):String
    {
        while (_arg1.length < _arg2)
        {
            _arg1 = (_arg1 + _arg3);
        };
        return (_arg1);
    };
