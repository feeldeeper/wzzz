package com.snake.utils
{
    import flash.events.*;
    import flash.display.*;

    public class ButtonUtil 
    {


        public static function setNoMouse(_arg1:MovieClip):void
        {
            _arg1.gotoAndStop(1);
            _arg1.mouseChildren = false;
            _arg1.mouseEnabled = false;
        }

        public static function hitAreaToOther(_arg1:Sprite, _arg2:Sprite):void
        {
            _arg1.hitArea = _arg2;
            _arg2.mouseChildren = false;
            _arg2.mouseEnabled = false;
        }

        public static function setButton(_arg1:MovieClip, _arg2:String=""):void
        {
            if (!_arg1)
            {
                return;
            };
            _arg1.gotoAndStop(1);
            _arg1.mouseChildren = false;
            _arg1.buttonMode = true;
            if (_arg2 != "")
            {
                _arg1.btn_mode = _arg2;
            };
            _arg1.addEventListener(MouseEvent.MOUSE_OVER, buttonOver);
            _arg1.addEventListener(MouseEvent.MOUSE_OUT, buttonOut);
        }

        private static function buttonOut(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.btn_mode == "label")
            {
                MovieUtils.movieFrame(_local2, "off");
            }
            else
            {
                MovieUtils.movieFrame(_local2, 1);
            };
        }

        private static function buttonOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.btn_mode == "label")
            {
                MovieUtils.movieFrame(_local2, "on");
            }
            else
            {
                MovieUtils.movieFrame(_local2, _local2.totalFrames);
            };
        }

        public static function setSelectBtn(_arg1:MovieClip, _arg2:Boolean=true):void
        {
            if (_arg2)
            {
                _arg1.gotoAndStop(_arg1.totalFrames);
            }
            else
            {
                _arg1.gotoAndStop(1);
            };
            _arg1.mouseChildren = false;
            _arg1.buttonMode = true;
            _arg1.select = _arg2;
            _arg1.addEventListener(MouseEvent.MOUSE_OVER, selectBtnOver);
            _arg1.addEventListener(MouseEvent.MOUSE_OUT, selectBtnOut);
            _arg1.addEventListener(MouseEvent.CLICK, selectBtnClick);
        }

        private static function selectBtnClick(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            _local2.select = !(_local2.select);
            if (_local2.select)
            {
                _local2.gotoAndStop(_local2.totalFrames);
            }
            else
            {
                _local2.gotoAndStop(1);
            };
            _local2.dispatchEvent(new Event("upSelect"));
        }

        private static function selectBtnOut(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.select)
            {
                _local2.gotoAndStop(_local2.totalFrames);
            }
            else
            {
                _local2.gotoAndStop(1);
            };
        }

        private static function selectBtnOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.select)
            {
                _local2.gotoAndStop(_local2.totalFrames);
            }
            else
            {
                MovieUtils.movieFrame(_local2, (_local2.totalFrames - 1));
            };
        }

        public static function setSelectArr(_arg1:Array, _arg2:Number=0):void
        {
            var _local3:MovieClip;
            var _local4:int;
            while (_local4 < _arg1.length)
            {
                _local3 = (_arg1[_local4] as MovieClip);
                _local3.gotoAndStop(1);
                _local3.selectButtonArr = _arg1;
                _local3.mouseChildren = false;
                _local3.buttonMode = true;
                _local3.select = false;
                _local3.id = _local4;
                _local3.addEventListener(MouseEvent.CLICK, selectArrClick);
                _local3.addEventListener(MouseEvent.MOUSE_OVER, selectArrOver);
                _local3.addEventListener(MouseEvent.MOUSE_OUT, selectArrOut);
                _local4++;
            };
            if (_arg2 >= 0)
            {
                _local3 = _arg1[_arg2];
                if (_local3)
                {
                    setSelectArrByBtn(_local3);
                };
            };
        }

        private static function selectArrOut(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.select)
            {
                MovieUtils.removeMovie(_local2);
                _local2.gotoAndStop(_local2.totalFrames);
            }
            else
            {
                MovieUtils.movieFrame(_local2, 1);
            };
        }

        private static function selectArrOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.select)
            {
                MovieUtils.removeMovie(_local2);
                _local2.gotoAndStop(_local2.totalFrames);
            }
            else
            {
                MovieUtils.movieFrame(_local2, (_local2.totalFrames - 1));
            };
        }

        private static function selectArrClick(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (!_local2.select)
            {
                setSelectArrByBtn(_local2);
            };
        }

        public static function setSelectArrByBtn(_arg1:MovieClip):void
        {
            var _local5:MovieClip;
            var _local2:MovieClip = (_arg1 as MovieClip);
            _local2.select = true;
            if (_local2.select)
            {
                _local2.gotoAndStop(_local2.totalFrames);
            };
            var _local3:Array = _local2.selectButtonArr;
            var _local4:int;
            while (_local4 < _local3.length)
            {
                _local5 = (_local3[_local4] as MovieClip);
                if (_local5 != _local2)
                {
                    _local5.select = false;
                    _local5.gotoAndStop(1);
                }
                else
                {
                    _local5.select = true;
                    _local5.gotoAndStop(_local2.totalFrames);
                };
                _local4++;
            };
            _local2.dispatchEvent(new Event("upSelect"));
        }

        public static function setSelectButton(_arg1:MovieClip, _arg2:Boolean=true):void
        {
            if (_arg2)
            {
                _arg1.gotoAndStop("on");
            }
            else
            {
                _arg1.gotoAndStop("off");
            };
            _arg1.mouseChildren = false;
            _arg1.buttonMode = true;
            _arg1.select = _arg2;
            _arg1.selectButtonType = "setSelectButton";
            _arg1.addEventListener(MouseEvent.MOUSE_OVER, selectButtonOver);
            _arg1.addEventListener(MouseEvent.MOUSE_OUT, selectButtonOut);
            _arg1.addEventListener(MouseEvent.CLICK, selectButtonClick);
        }

        private static function selectButtonClick(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.select)
            {
                _local2.select = false;
            }
            else
            {
                _local2.select = true;
            };
            if (_local2.select)
            {
                _local2.gotoAndStop("on");
            }
            else
            {
                _local2.gotoAndStop("off");
            };
            _local2.dispatchEvent(new Event("upSelect"));
        }

        public static function setSelectButtonArr2(_arg1:Array, _arg2:Number=0):void
        {
            var _local4:MovieClip;
            var _local3:int;
            while (_local3 < _arg1.length)
            {
                _local4 = (_arg1[_local3] as MovieClip);
                _local4.selectButtonArr = _arg1;
                _local4.selectButtonType = "select";
                ButtonUtil.setSelectButton(_local4);
                _local4.removeEventListener(MouseEvent.CLICK, selectButtonClick);
                _local4.addEventListener(MouseEvent.CLICK, selectButtonFun2);
                _local3++;
            };
            _local4 = _arg1[_arg2];
            setSelecItem2(_local4);
        }

        public static function setSelecItem2(_arg1:MovieClip):void
        {
            var _local4:MovieClip;
            var _local2:Array = _arg1.selectButtonArr;
            var _local3:int;
            while (_local3 < _local2.length)
            {
                _local4 = _local2[_local3];
                if (_local4 == _arg1)
                {
                    if (!_local4.select)
                    {
                        _arg1.dispatchEvent(new Event("upSelect"));
                    };
                    _local4.select = true;
                    _local4.gotoAndStop("select");
                }
                else
                {
                    _local4.select = false;
                    MovieUtils.movieFrame(_local4, "off");
                };
                _local3++;
            };
        }

        private static function selectButtonFun2(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            setSelecItem2(_local2);
        }

        public static function setSelectButtonArr(_arg1:Array, _arg2:Number=0, _arg3:Boolean=false):void
        {
            var _local5:MovieClip;
            var _local4:int;
            while (_local4 < _arg1.length)
            {
                _local5 = (_arg1[_local4] as MovieClip);
                _local5.selectButtonArr = _arg1;
                ButtonUtil.setSelectButton(_local5);
                if (_arg3)
                {
                    _local5.gotoAndStop("off");
                };
                _local5.removeEventListener(MouseEvent.CLICK, selectButtonClick);
                _local5.addEventListener(MouseEvent.CLICK, selectButtonFun);
                if (_arg2 != -1)
                {
                    setSelecItem(_arg1[_arg2]);
                };
                _local4++;
            };
        }

        public static function setSelecItem(_arg1:MovieClip):void
        {
            var _local4:MovieClip;
            var _local2:Array = _arg1.selectButtonArr;
            var _local3:int;
            while (_local3 < _local2.length)
            {
                _local4 = _local2[_local3];
                if (_local4 == _arg1)
                {
                    if (!_local4.select)
                    {
                        _arg1.dispatchEvent(new Event("upSelect"));
                    };
                    _local4.select = true;
                    MovieUtils.movieFrame(_local4, "on");
                }
                else
                {
                    _local4.select = false;
                    MovieUtils.movieFrame(_local4, "off");
                };
                _local3++;
            };
        }

        private static function selectButtonFun(_arg1:MouseEvent):void
        {
            var _local5:MovieClip;
            var _local2:MovieClip = (_arg1.target as MovieClip);
            var _local3:Array = _local2.selectButtonArr;
            setSelecItem(_local2);
            return;
        }

        public static function setSelectButtonArr3(_arg1:Array, _arg2:Number=0):void
        {
            var _local4:MovieClip;
            var _local3:int;
            while (_local3 < _arg1.length)
            {
                _local4 = (_arg1[_local3] as MovieClip);
                _local4.selectButtonArr = _arg1;
                _local4.selectButtonType = "select2";
                ButtonUtil.setSelectButton(_local4);
                _local4.removeEventListener(MouseEvent.CLICK, selectButtonClick);
                _local4.addEventListener(MouseEvent.CLICK, selectButtonFun3);
                _local3++;
            };
            _local4 = _arg1[_arg2];
            setSelecItem3(_local4);
        }

        public static function setSelecItem3(_arg1:MovieClip):void
        {
            var _local4:MovieClip;
            var _local2:Array = _arg1.selectButtonArr;
            var _local3:int;
            while (_local3 < _local2.length)
            {
                _local4 = _local2[_local3];
                if (_local4 == _arg1)
                {
                    if (_local4.select)
                    {
                        MovieUtils.movieFrame(_local4, "on");
                    }
                    else
                    {
                        _local4.gotoAndStop("off");
                        _local4.gotoAndStop("on");
                        MovieUtils.movieFrame(_local4, "on");
                        _arg1.dispatchEvent(new Event("upSelect"));
                    };
                    _local4.select = true;
                }
                else
                {
                    if (_local4.select != false)
                    {
                        _local4.gotoAndStop("on");
                        MovieUtils.movieFrame(_local4, "off");
                    }
                    else
                    {
                        if (_local4.currentFrameLabel == "on1")
                        {
                            MovieUtils.movieFrame(_local4, "off1");
                        }
                        else
                        {
                            _local4.gotoAndStop("off1");
                        };
                    };
                    _local4.select = false;
                };
                _local3++;
            };
        }

        private static function selectButtonFun3(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            setSelecItem3(_local2);
        }

        private static function selectButtonOut(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (((_local2.selectButtonType) && ((_local2.selectButtonType == "select"))))
            {
                if (_local2.select)
                {
                    _local2.gotoAndStop("select");
                }
                else
                {
                    MovieUtils.movieFrame(_local2, "off");
                };
            }
            else
            {
                if (((_local2.selectButtonType) && ((_local2.selectButtonType == "select2"))))
                {
                    if (_local2.select)
                    {
                        MovieUtils.movieFrame(_local2, "on");
                    }
                    else
                    {
                        _local2.gotoAndStop("on1");
                        MovieUtils.movieFrame(_local2, "off1");
                    };
                }
                else
                {
                    if (((_local2.selectButtonType) && ((_local2.selectButtonType == "setSelectButton"))))
                    {
                        if (_local2.select)
                        {
                            MovieUtils.movieFrame(_local2, "on");
                        }
                        else
                        {
                            MovieUtils.movieFrame(_local2, "off");
                        };
                    }
                    else
                    {
                        if (_local2.select)
                        {
                            _local2.gotoAndStop("on");
                        }
                        else
                        {
                            MovieUtils.movieFrame(_local2, "off");
                        };
                    };
                };
            };
        }

        private static function selectButtonOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (((_local2.selectButtonType) && ((_local2.selectButtonType == "select"))))
            {
                if (_local2.select)
                {
                    MovieUtils.movieFrame(_local2, "on");
                }
                else
                {
                    MovieUtils.movieFrame(_local2, "on");
                };
            }
            else
            {
                if (((_local2.selectButtonType) && ((_local2.selectButtonType == "select2"))))
                {
                    if (_local2.select)
                    {
                        MovieUtils.movieFrame(_local2, "on");
                    }
                    else
                    {
                        _local2.gotoAndStop("off1");
                        MovieUtils.movieFrame(_local2, "on1");
                    };
                }
                else
                {
                    if (((_local2.selectButtonType) && ((_local2.selectButtonType == "setSelectButton"))))
                    {
                        if (_local2.select)
                        {
                            MovieUtils.movieFrame(_local2, "on");
                        }
                        else
                        {
                            MovieUtils.movieFrame(_local2, "on");
                        };
                    }
                    else
                    {
                        if (_local2.select)
                        {
                            MovieUtils.movieFrame(_local2, "on");
                        }
                        else
                        {
                            MovieUtils.movieFrame(_local2, "off");
                        };
                    };
                };
            };
        }


    }
}//package com.snake.utils
