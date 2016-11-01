package com.snake.ui.core
{
    import flash.events.*;
    import flash.display.*;
    import com.snake.events.*;

    public class MSprite extends Sprite implements ISize, IDestory 
    {

        public static var AUTO_SIZE:String = "auto_resize";

        private var _autoSize:Boolean = false;
        protected var _width:Number = 0;
        protected var _height:Number = 0;
        private var _percentWidth:Number = 0;
        private var _percentHeight:Number = 0;
        protected var percentWidthBool:Boolean = false;
        protected var percentHeightBool:Boolean = false;

        public function MSprite(_arg1=null)
        {
            if (_arg1)
            {
                if (_arg1.x != null)
                {
                    x = _arg1.x;
                };
                if (_arg1.y != null)
                {
                    y = _arg1.y;
                };
                if (_arg1.autoSize != null)
                {
                    this.autoSize = _arg1.autoSize;
                };
                if (((!((_arg1.size == null))) && ((_arg1.size is Array))))
                {
                    this.width = _arg1.size[0];
                    this.height = _arg1.size[1];
                };
                if (_arg1.width != null)
                {
                    this.width = _arg1.width;
                };
                if (_arg1.height != null)
                {
                    this.height = _arg1.height;
                };
                if (_arg1.pWidth != null)
                {
                    this.percentWidth = _arg1.pWidth;
                };
                if (_arg1.pHeight != null)
                {
                    this.percentHeight = _arg1.pHeight;
                };
                if (_arg1.percentWidth != null)
                {
                    this.percentWidth = _arg1.percentWidth;
                };
                if (_arg1.percentHeight != null)
                {
                    this.percentHeight = _arg1.percentHeight;
                };
            };
            addEventListener(Event.ADDED_TO_STAGE, this.init);
        }

        protected function init(_arg1:Event=null):void
        {
            if (parent)
            {
                parent.addEventListener(Event.RESIZE, this.iniToStageSize);
            };
            this.ResetSize();
        }

        protected function iniToStageSize(e:Event):void
        {
            var d:DisplayObject;
            try
            {
                d = (e.target as DisplayObject);
                if (((parent) && ((d == parent))))
                {
                    this.ResetSize();
                }
                else
                {
                    d.removeEventListener(Event.RESIZE, this.iniToStageSize);
                };
            }
            catch(e:ArgumentError)
            {
            };
        }

        public function ResetSize():void
        {
            if (!parent)
            {
                return;
            };
            if (this.autoSize)
            {
                if ((parent is Stage))
                {
                    this.setSize(Stage(parent).stageWidth, Stage(parent).stageHeight);
                }
                else
                {
                    this.setSize(parent.width, parent.height);
                };
            }
            else
            {
                if (((this.percentHeightBool) && (this.percentWidthBool)))
                {
                    if ((parent is Stage))
                    {
                        this.setSize((Stage(parent).stageWidth * this.percentWidth), (Stage(parent).stageHeight * this.percentHeight));
                    }
                    else
                    {
                        this.setSize((parent.width * this.percentWidth), (parent.height * this.percentHeight));
                    };
                }
                else
                {
                    if (this.percentWidthBool)
                    {
                        if ((parent is Stage))
                        {
                            this.setSize((Stage(parent).stageWidth * this.percentWidth), this.height);
                        }
                        else
                        {
                            this.setSize((parent.width * this.percentWidth), this.height);
                        };
                    }
                    else
                    {
                        if (this.percentHeightBool)
                        {
                            if ((parent is Stage))
                            {
                                this.setSize(this.width, (Stage(parent).stageHeight * this.percentHeight));
                            }
                            else
                            {
                                this.setSize(this.width, (parent.height * this.percentHeight));
                            };
                        };
                    };
                };
            };
        }

        public function setSize(_arg1:Number, _arg2:Number):void
        {
            var _local3:ResizeEvent;
            var _local4:ResizeEvent;
            var _local5:ResizeEvent;
            if (((!((_arg1 == this._width))) || (!((_arg2 == this._height)))))
            {
                _local3 = new ResizeEvent(ResizeEvent.RESIZE);
                _local3.oldHeight = this._height;
                _local3.oldWidth = this._width;
                if (_arg1 != this._width)
                {
                    _local4 = new ResizeEvent(ResizeEvent.WRESIZE);
                    _local3.oldWidth = this._width;
                    this._width = _arg1;
                    dispatchEvent(_local4);
                };
                if (_arg2 != this._height)
                {
                    _local5 = new ResizeEvent(ResizeEvent.HRESIZE);
                    _local5.oldHeight = this._height;
                    this._height = _arg2;
                    dispatchEvent(_local5);
                };
                this.upSize();
                dispatchEvent(_local3);
                dispatchEvent(new Event(Event.RESIZE));
            };
        }

        public function get percentWidth():Number
        {
            return (this._percentWidth);
        }

        public function set percentWidth(_arg1:Number):void
        {
            if ((((_arg1 < 0)) && ((_arg1 > 1))))
            {
                return;
            };
            if (this.percentHeight != _arg1)
            {
                if (this.autoSize)
                {
                    this.autoSize = false;
                };
                this.percentWidthBool = true;
                this._percentWidth = _arg1;
                this.ResetSize();
            };
        }

        public function get percentHeight():Number
        {
            return (this._percentHeight);
        }

        public function set percentHeight(_arg1:Number):void
        {
            if ((((_arg1 < 0)) && ((_arg1 > 1))))
            {
                return;
            };
            if (this.percentHeight != _arg1)
            {
                if (this.autoSize)
                {
                    this.autoSize = false;
                };
                this.percentHeightBool = true;
                this._percentHeight = _arg1;
                this.ResetSize();
            };
        }

        override public function set height(_arg1:Number):void
        {
            if (_arg1 < 0)
            {
                return;
            };
            if (this.autoSize)
            {
                this.autoSize = false;
            };
            this.percentHeightBool = false;
            this.setSize(this._width, _arg1);
        }

        override public function get height():Number
        {
            return (this._height);
        }

        override public function set width(_arg1:Number):void
        {
            if (_arg1 < 0)
            {
                return;
            };
            if (this.autoSize)
            {
                this.autoSize = false;
            };
            this.percentWidthBool = false;
            this.setSize(_arg1, this._height);
        }

        override public function get width():Number
        {
            return (this._width);
        }

        public function set autoSize(_arg1:Boolean):void
        {
            if (this._autoSize == _arg1)
            {
                return;
            };
            this._autoSize = _arg1;
            if (this._autoSize)
            {
                this.dispatchEvent(new Event(MSprite.AUTO_SIZE));
                this.ResetSize();
            };
        }

        public function get autoSize():Boolean
        {
            return (this._autoSize);
        }

        public function upSize():void
        {
        }

        public function destory():void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            if (parent)
            {
                parent.removeEventListener(Event.RESIZE, this.iniToStageSize);
            };
        }


    }
}//package com.snake.ui.core
