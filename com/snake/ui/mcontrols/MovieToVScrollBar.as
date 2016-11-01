package com.snake.ui.mcontrols
{
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import com.snake.ui.core.*;
    import flash.geom.*;
    import com.greensock.*;

    public class MovieToVScrollBar extends MSprite 
    {

        public static const HITAll:String = "all_hit";
        public static const HITSSLIDER:String = "slider_hit";

        public static var UPDATA:String = Event.SCROLL;//"scroll"

        protected var _allowTrackClick:Boolean = true;
        protected var _maxScrollPosition:Number = 0;
        protected var _minScrollPosition:Number = 0;
        protected var _lineScrollSize:Number = 10;
        protected var _wheelScrollSize:Number = 10;
        protected var _nextScroll:Number;
        protected var _previousScroll:Number;
        protected var _hideType:String = "slider_hit";
        protected var _hideBool:Boolean = false;
        protected var _wheelBool:Boolean = true;
        public var coordinateBool:Boolean = true;
        public var tweenerBool:Boolean = false;
        public var tweenerTime:Number = 0.2;
        protected var _mouseDownBool:Boolean = false;
        protected var _scrollSense:Boolean = false;
        public var scrollDelay:uint = 350;
        protected var _oldDelayTime:uint;
        protected var _content:DisplayObject;
        protected var _mask:DisplayObject;
        protected var _skin:Sprite;
        protected var _slider:MovieToCheck2;
        protected var _sliderRect:Rectangle;
        protected var _sliderBtn:MovieClip;
        protected var _nextBtn:SimpleButton;
        protected var _previousBtn:SimpleButton;
        protected var _scrollBg:DisplayObject;
        public var sliderAutoSize:Boolean = true;
        protected var sliderPot:Point;

        public function MovieToVScrollBar(_arg1:Sprite, _arg2=null, _arg3:Boolean=false, _arg4:Boolean=false)
        {
            var _local5:DisplayObjectContainer;
            this._sliderRect = new Rectangle();
            this.sliderPot = new Point();
            super();
            var _local6:uint = 100;
            if (_arg3)
            {
                this.x = _arg1.x;
                this.y = _arg1.y;
                _local6 = _arg1.getChildByName("_scrollBg").height;
                this.height = _local6;
            };
            if (((_arg1.parent) && (_arg4)))
            {
                _local5 = _arg1.parent;
            };
            if (_arg1)
            {
                this.skin = _arg1;
            }
            else
            {
                return;
            };
            if (_local5)
            {
                _local5.addChild(this);
            };
            if (_arg2)
            {
                if (_arg2.x != null)
                {
                    x = _arg2.x;
                };
                if (_arg2.y != null)
                {
                    y = _arg2.y;
                };
                if (_arg2.autoSize != null)
                {
                    autoSize = _arg2.autoSize;
                };
                if (((!((_arg2.size == null))) && ((_arg2.size is Array))))
                {
                    width = _arg2.size[0];
                    height = _arg2.size[1];
                };
                if (_arg2.width != null)
                {
                    width = _arg2.width;
                };
                if (_arg2.height != null)
                {
                    height = _arg2.height;
                };
                if (_arg2.hideType != null)
                {
                    this.hideType = _arg2.hideType;
                };
                if (_arg2.scrollDelay)
                {
                    this.scrollDelay = _arg2.scrollDelay;
                };
                if (_arg2.wheelBool != null)
                {
                    this.wheelBool = _arg2.wheelBool;
                };
                if (_arg2.hideBool != null)
                {
                    this.hideBool = _arg2.hideBool;
                };
                if (_arg2.scrollDelay)
                {
                    this.scrollDelay = _arg2.scrollDelay;
                };
                if (_arg2.allowTrackClick != null)
                {
                    this.allowTrackClick = _arg2.allowTrackClick;
                };
                if (_arg2.tweenerBool != null)
                {
                    this.tweenerBool = _arg2.tweenerBool;
                };
                if (_arg2.tweenerTime)
                {
                    this.tweenerTime = _arg2.tweenerTime;
                };
                if (_arg2.coordinateBool != null)
                {
                    this.coordinateBool = _arg2.coordinateBool;
                };
                if (_arg2.content != null)
                {
                    this.content = _arg2.content;
                };
            };
            if (height <= 0)
            {
                this.height = _local6;
            };
        }

        public static function found(_arg1:Sprite, _arg2=null, _arg3:Boolean=false, _arg4:Boolean=false):MovieToVScrollBar
        {
            var _local5:MovieToVScrollBar = new (MovieToVScrollBar)(_arg1, _arg2, _arg3, _arg4);
            return (_local5);
        }


        public function get skin():Sprite
        {
            return (this._skin);
        }

        public function set skin(value:Sprite):void
        {
            var skin1:Sprite;
            try
            {
                if (((this._skin) && (this.contains(this._skin))))
                {
                    removeChild(this._skin);
                };
                this._skin = value;
                skin1 = Sprite(this._skin);
                addChild(skin1);
                skin1.x = (skin1.y = 0);
                if (this._previousBtn)
                {
                    this._previousBtn.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnDown);
                };
                this._previousBtn = (Sprite(this._skin).getChildByName("_previousBtn") as SimpleButton);
                this._previousBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.btnDown);
                if (this._nextBtn)
                {
                    this._nextBtn.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnDown);
                };
                this._nextBtn = (Sprite(this._skin).getChildByName("_nextBtn") as SimpleButton);
                this._nextBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.btnDown);
                this._sliderBtn = (Sprite(this._skin).getChildByName("_sliderBtn") as MovieClip);
                this._sliderRect.width = this._sliderBtn.width;
                this._sliderRect.height = this._sliderBtn.height;
                this._slider = new MovieToCheck2(this._sliderBtn);
                addChild(this._slider);
                this._slider.addEventListener(MouseEvent.MOUSE_DOWN, this.sliderDown);
                if (this._scrollBg)
                {
                    this._scrollBg.removeEventListener(MouseEvent.MOUSE_DOWN, this.scrollDown);
                };
                this._scrollBg = Sprite(this._skin).getChildByName("_scrollBg");
                this._scrollBg.y = 0;
                this._scrollBg.addEventListener(MouseEvent.MOUSE_DOWN, this.scrollDown);
                _width = Math.max(this._scrollBg.width, this._sliderBtn.width);
                this.upSize();
            }
            catch(e:TypeError)
            {
            };
        }

        public function set content(_arg1:DisplayObject):void
        {
            if (this._content == _arg1)
            {
                return;
            };
            if (_arg1.mask == null)
            {
                return;
            };
            if (((this._content) && (this._content.hasEventListener(Event.RESIZE))))
            {
                this._content.removeEventListener(Event.RESIZE, this.contentResize);
            };
            this._content = _arg1;
            this._mask = this._content.mask;
            if ((this._content is InteractiveObject))
            {
                this._content.addEventListener(Event.RESIZE, this.contentResize);
            };
            if (this.wheelBool)
            {
                if ((this._content is InteractiveObject))
                {
                    InteractiveObject(this._content).addEventListener(MouseEvent.MOUSE_WHEEL, this.MOUSE_WHEEL);
                }
                else
                {
                    if ((this._content is InteractiveObject))
                    {
                        InteractiveObject(this._content).removeEventListener(MouseEvent.MOUSE_WHEEL, this.MOUSE_WHEEL);
                    };
                };
            };
            this.upSlider();
        }

        public function get content():DisplayObject
        {
            return (this._content);
        }

        private function contentResize(_arg1:Event):void
        {
            this.upSlider();
        }

        public function set wheelBool(_arg1:Boolean):void
        {
            if (this._wheelBool == _arg1)
            {
                return;
            };
            this._wheelBool = _arg1;
            if (this._wheelBool)
            {
                if ((this._content is InteractiveObject))
                {
                    InteractiveObject(this._content).addEventListener(MouseEvent.MOUSE_WHEEL, this.MOUSE_WHEEL);
                }
                else
                {
                    if ((this._content is InteractiveObject))
                    {
                        InteractiveObject(this._content).removeEventListener(MouseEvent.MOUSE_WHEEL, this.MOUSE_WHEEL);
                    };
                };
            };
        }

        public function get wheelBool():Boolean
        {
            return (this._wheelBool);
        }

        public function set hideBool(_arg1:Boolean):void
        {
            if (this._hideBool == _arg1)
            {
                return;
            };
            this._hideBool = _arg1;
            if (this._slider)
            {
                this.upSlider();
            };
        }

        public function get hideBool():Boolean
        {
            return (this._hideBool);
        }

        private function MOUSE_WHEEL(_arg1:MouseEvent):void
        {
            if (!this.content)
            {
                return;
            };
            if (_arg1.delta < 0)
            {
                if (this.content)
                {
                    this.wheelScrollSize = Number(((this.content.height * 0.1) >> 0));
                };
                this.scrollToValue(this.wheelScrollSize, true);
            }
            else
            {
                if (this.content)
                {
                    this.wheelScrollSize = Number(((this.content.height * 0.1) >> 0));
                };
                this.scrollToValue(this.wheelScrollSize, false);
            };
        }

        private function scrollDown(e:MouseEvent):void
        {
            var num:Number;
            if (((this._scrollBg) && (!((e.target == this._scrollBg)))))
            {
                return;
            };
            if (!this.allowTrackClick)
            {
                return;
            };
            if (this.content == null)
            {
                return;
            };
            if ((((this.mouseY > this._previousBtn.height)) && ((this.mouseY <= ((this._previousBtn.height + this.pageSize) + this._slider.height)))))
            {
                num = mouseY;
                if (mouseY >= (this._previousBtn.height + this.pageSize))
                {
                    num = (this._previousBtn.height + this.pageSize);
                };
                TweenLite.to(this._slider, this.tweenerTime, {
                    "y":num,
                    "onUpdate":function ():void
                    {
                        computeContentValue(computeNumFormSlider());
                        dispatchEvent(new Event(Event.SCROLL));
                    }
                });
            };
        }

        public function gotoTheTop():void
        {
            TweenLite.to(this._slider, this.tweenerTime, {
                "y":this._previousBtn.height,
                "onUpdate":function ():void
                {
                    computeContentValue(computeNumFormSlider());
                    dispatchEvent(new Event(Event.SCROLL));
                }
            });
        }

        private function btnDown(_arg1:MouseEvent):void
        {
            if (this.content == null)
            {
                return;
            };
            this._mouseDownBool = true;
            if (_arg1.target == this._nextBtn)
            {
                this._scrollSense = true;
            }
            else
            {
                this._scrollSense = false;
            };
            this.scrollToValue(this.lineScrollSize, this._scrollSense);
            this._oldDelayTime = getTimer();
            stage.addEventListener(MouseEvent.MOUSE_UP, this.stageUp);
            addEventListener(Event.ENTER_FRAME, this.ENTER_FRAME);
        }

        private function stageUp(_arg1:MouseEvent):void
        {
            this._mouseDownBool = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.stageUp);
            removeEventListener(Event.ENTER_FRAME, this.ENTER_FRAME);
        }

        private function sliderDown(_arg1:MouseEvent):void
        {
            if (this.content == null)
            {
                return;
            };
            this.sliderPot.x = this._slider.mouseX;
            this.sliderPot.y = this._slider.mouseY;
            this._slider.selectLock = false;
            this._slider.select = true;
            this._slider.selectLock = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.sliderUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.sliderMove);
        }

        private function sliderUp(_arg1:MouseEvent):void
        {
            this._slider.selectLock = false;
            this._slider.select = false;
            this._slider.selectLock = true;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.sliderUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.sliderMove);
            if (this.content == null)
            {
                return;
            };
        }

        private function sliderMove(_arg1:MouseEvent):void
        {
            var _local2:Point = new Point(0, this.mouseY);
            if (_local2.y < (this._previousBtn.height + this.sliderPot.y))
            {
                _local2.y = this._previousBtn.height;
            }
            else
            {
                if (_local2.y > ((this.pageSize + this._previousBtn.height) + this.sliderPot.y))
                {
                    _local2.y = (this.pageSize + this._previousBtn.height);
                }
                else
                {
                    _local2.y = (_local2.y - this.sliderPot.y);
                };
            };
            this._slider.y = _local2.y;
            this.computeContentValue(this.computeNumFormSlider());
        }

        private function ENTER_FRAME(_arg1:Event):void
        {
            if ((getTimer() - this._oldDelayTime) > this.scrollDelay)
            {
                this.scrollToValue(this.lineScrollSize, this._scrollSense);
            };
        }

        public function scrollToValue(value:Number, sense:Boolean):void
        {
            var num:Number;
            if (!this.computeCMBool())
            {
                return;
            };
            if (sense)
            {
                if ((-((this.content.y - this._mask.y)) + value) >= this.computeContentSize())
                {
                    num = (this._mask.y - this.computeContentSize());
                }
                else
                {
                    num = (this.content.y - value);
                };
                if (this.tweenerBool)
                {
                    TweenLite.to(this.content, this.tweenerTime, {
                        "y":num,
                        "onUpdate":function ():void
                        {
                            upSlider();
                            dispatchEvent(new Event(Event.SCROLL));
                        }
                    });
                }
                else
                {
                    this.content.y = num;
                    this.upSlider();
                    dispatchEvent(new Event(Event.SCROLL));
                };
            }
            else
            {
                if ((this.content.y + value) >= this._mask.y)
                {
                    num = this._mask.y;
                }
                else
                {
                    num = (this.content.y + value);
                };
                if (this.tweenerBool)
                {
                    TweenLite.to(this.content, this.tweenerTime, {
                        "y":num,
                        "onUpdate":function ():void
                        {
                            upSlider();
                            dispatchEvent(new Event(Event.SCROLL));
                        }
                    });
                }
                else
                {
                    this.content.y = num;
                    this.upSlider();
                    dispatchEvent(new Event(Event.SCROLL));
                };
            };
        }

        private function computeContentValue(value:Number):void
        {
            if (!this.computeCMBool())
            {
                return;
            };
            if (this.content.height <= this.content.mask.height)
            {
                this.content.y = this.content.mask.y;
                dispatchEvent(new Event(Event.SCROLL));
                return;
            };
            if ((((value > 1)) || ((value < 0))))
            {
                return;
            };
            var __y:Number = ((-(value) * this.computeContentSize()) + this.content.mask.y);
            if (this.tweenerBool)
            {
                TweenLite.to(this.content, this.tweenerTime, {
                    "y":__y,
                    "onUpdate":function ():void
                    {
                        upSlider();
                        dispatchEvent(new Event(Event.SCROLL));
                    }
                });
            }
            else
            {
                this.content.y = __y;
                this.upSlider();
                dispatchEvent(new Event(Event.SCROLL));
            };
        }

        private function computeNumFormSlider():Number
        {
            return (((this._slider.y - this._previousBtn.height) / this.pageSize));
        }

        public function upSlider():void
        {
            if (this.computeCMBool())
            {
                this.visible = true;
                this._slider.visible = true;
                this._slider.y = (this._previousBtn.height + (this.pageSize * this.computeNumFormContent()));
            }
            else
            {
                this._slider.y = this._previousBtn.height;
                if (this.hideBool)
                {
                    if (this.hideType == HITAll)
                    {
                        this._slider.visible = true;
                        this.visible = false;
                    }
                    else
                    {
                        this._slider.visible = false;
                        this.visible = true;
                    };
                }
                else
                {
                    this._slider.visible = true;
                    this.visible = true;
                };
            };
        }

        public function computeNumFormContent():Number
        {
            this.computeCMBool();
            return (((this._mask.y - this.content.y) / this.computeContentSize()));
        }

        public function computeContentSize():Number
        {
            var _local1:Number = 0;
            if (this.computeCMBool())
            {
                return ((this.content.height - this.content.mask.height));
            };
            return (_local1);
        }

        private function computeCMBool():Boolean
        {
            var _local1:Boolean;
            if (((!((this.content == null))) && (!((this.content.mask == null)))))
            {
                if (this.content.height > this.content.mask.height)
                {
                    _local1 = true;
                };
                if (((this.coordinateBool) && ((this.content.x > this.content.mask.x))))
                {
                    this.content.x = this.content.mask.x;
                };
                if (this.content.y > this.content.mask.y)
                {
                    this.content.y = this.content.mask.y;
                };
                if (((((_local1) && ((this.content.y < this.content.mask.y)))) && (((this.content.mask.y - this.content.y) > (this.content.height - this.content.mask.height)))))
                {
                    this.content.y = (this.content.mask.y - (this.content.height - this.content.mask.height));
                };
            };
            if (!_local1)
            {
                this._slider.y = this._previousBtn.height;
                if (((!((this.content == null))) && (!((this.content.mask == null)))))
                {
                    this.content.y = this.content.mask.y;
                };
                if (this.hideBool)
                {
                    if (this.hideType == HITAll)
                    {
                        this._slider.visible = true;
                        this.visible = false;
                    }
                    else
                    {
                        this._slider.visible = false;
                        this.visible = true;
                    };
                }
                else
                {
                    this._slider.visible = true;
                    this.visible = true;
                };
            };
            return (_local1);
        }

        public function set scrollPosition(_arg1:Number):void
        {
            if ((((_arg1 < 0)) && ((_arg1 > 1))))
            {
                return;
            };
            this.computeContentValue(_arg1);
        }

        public function get scrollPosition():Number
        {
            return (this.computeNumFormSlider());
        }

        public function get nextScroll():Number
        {
            var _local1:Number;
            if (!this.computeCMBool())
            {
                return (this._nextScroll);
            };
            if ((-((this.content.y - this._mask.y)) + this.lineScrollSize) >= this.computeContentSize())
            {
                _local1 = (this._mask.y - this.computeContentSize());
            }
            else
            {
                _local1 = (this.content.y - this.lineScrollSize);
            };
            return (_local1);
        }

        public function get previousScroll():Number
        {
            var _local1:Number;
            if (!this.computeCMBool())
            {
                return (this._previousScroll);
            };
            if ((this.content.y + this.lineScrollSize) >= this._mask.y)
            {
                _local1 = this._mask.y;
            }
            else
            {
                _local1 = (this.content.y + this.lineScrollSize);
            };
            return (_local1);
        }

        public function set lineScrollSize(_arg1:Number):void
        {
            this._lineScrollSize = _arg1;
        }

        public function get lineScrollSize():Number
        {
            return (this._lineScrollSize);
        }

        public function set wheelScrollSize(_arg1:Number):void
        {
            this._wheelScrollSize = _arg1;
        }

        public function get wheelScrollSize():Number
        {
            return (this._wheelScrollSize);
        }

        public function get pageSize():Number
        {
            return (((this._maxScrollPosition - this._minScrollPosition) - this._slider.height));
        }

        public function get minScrollPosition():Number
        {
            return (this._minScrollPosition);
        }

        public function get maxScrollPosition():Number
        {
            return (this._maxScrollPosition);
        }

        public function set allowTrackClick(_arg1:Boolean):void
        {
            if (this._allowTrackClick == _arg1)
            {
                return;
            };
            this._allowTrackClick = _arg1;
        }

        public function get allowTrackClick():Boolean
        {
            return (this._allowTrackClick);
        }

        public function get hideType():String
        {
            return (this._hideType);
        }

        public function set hideType(_arg1:String):void
        {
            if (this._hideType == _arg1)
            {
                return;
            };
            this._hideType = _arg1;
            this.upSlider();
        }

        override public function upSize():void
        {
            if (this._previousBtn)
            {
                if (height < ((this._previousBtn.height + this._nextBtn.height) + this._sliderRect.height))
                {
                    setSize(this._scrollBg.width, (((this._previousBtn.height + this._nextBtn.height) + this._sliderRect.height) + 10));
                    return;
                };
                this._maxScrollPosition = (this.height - this._nextBtn.height);
                this._minScrollPosition = this._previousBtn.height;
                this._scrollBg.x = (this._scrollBg.y = 0);
                this._previousBtn.x = (this._previousBtn.y = 0);
                this._previousBtn.x = ((this._scrollBg.width - this._previousBtn.width) / 2);
                this._slider.x = 0;
                this._slider.x = ((this._scrollBg.width - this._slider.width) / 2);
                this._slider.y = this._previousBtn.height;
                this._scrollBg.height = this.height;
                this._nextBtn.x = 0;
                this._nextBtn.x = ((this._scrollBg.width - this._nextBtn.width) / 2);
                this._nextBtn.y = (this.height - this._nextBtn.height);
                this.upSlider();
            };
        }

        override public function destory():void
        {
            super.destory();
            if (this._scrollBg)
            {
                this._scrollBg.removeEventListener(MouseEvent.MOUSE_DOWN, this.scrollDown);
            };
            if (this._slider)
            {
                this._slider.removeEventListener(MouseEvent.MOUSE_DOWN, this.sliderDown);
            };
            if (this._nextBtn)
            {
                this._nextBtn.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnDown);
            };
            if (this._previousBtn)
            {
                this._previousBtn.removeEventListener(MouseEvent.MOUSE_DOWN, this.btnDown);
            };
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.stageUp);
            removeEventListener(Event.ENTER_FRAME, this.ENTER_FRAME);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.sliderUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.sliderMove);
            if (((!((this._content == null))) && ((this._content is InteractiveObject))))
            {
                InteractiveObject(this._content).removeEventListener(MouseEvent.MOUSE_WHEEL, this.MOUSE_WHEEL);
            };
            this._content = null;
            this._mask = null;
        }


    }
}//package com.snake.ui.mcontrols
