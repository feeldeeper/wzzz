package com.snake.ui.mcontrols
{
    import flash.events.*;
    import flash.display.*;
    import com.snake.ui.core.*;
    import com.snake.events.*;

    public class MovieToCheck2 extends Sprite implements Iselect, IDestory, ISkinComponent 
    {

        public static var UPSELECT:String = SelectEvent.UPSELECT;
        public static var SELECT:String = SelectEvent.SELECT;
        public static var RESELECT:String = SelectEvent.RESELECT;

        protected var _btn:MovieClip;
        public var data;
        protected var _selectLock:Boolean = false;
        protected var _select:Boolean = false;

        public function MovieToCheck2(_arg1:MovieClip, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            if (_arg2)
            {
                this.x = _arg1.x;
                this.y = _arg1.y;
            };
            if (((_arg1.parent) && (_arg3)))
            {
                _arg1.parent.addChild(this);
                this.name = _arg1.name;
            };
            this._btn = _arg1;
            this._btn.x = 0;
            this._btn.y = 0;
            addChild(this._btn);
            this.mouseChildren = false;
            this._btn.gotoAndStop(1);
            this.initMouse();
            this.buttonMode = true;
            this.useHandCursor = true;
        }

        public function get skin()
        {
            return (this._btn);
        }

        public function set skin(_arg1):void
        {
            var _local2:int;
            if ((_arg1 is MovieClip))
            {
                if (this._btn)
                {
                    _local2 = this._btn.currentFrame;
                    if (contains(this._btn))
                    {
                        removeChild(this._btn);
                    };
                    addChild(this._btn);
                    this._btn = _arg1;
                    this._btn.gotoAndStop(_local2);
                };
            };
        }

        public function get btn():MovieClip
        {
            return (this._btn);
        }

        protected function initMouse():void
        {
            addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown, false, 0, true);
            addEventListener(MouseEvent.MOUSE_UP, this.mouseUp, false, 0, true);
            addEventListener(MouseEvent.CLICK, this.mouseClick, false, 0, true);
        }

        protected function mouseUp(_arg1:MouseEvent):void
        {
        }

        protected function mouseOut(_arg1:MouseEvent):void
        {
        }

        protected function mouseOver(_arg1:MouseEvent):void
        {
        }

        protected function mouseDown(_arg1:MouseEvent):void
        {
        }

        protected function mouseClick(_arg1:MouseEvent):void
        {
            if (this._select)
            {
                this.select = false;
            }
            else
            {
                this.select = true;
            };
        }

        public function set selectLock(_arg1:Boolean):void
        {
            this._selectLock = _arg1;
        }

        public function get selectLock():Boolean
        {
            return (this._selectLock);
        }

        public function set select(_arg1:Boolean):void
        {
            if (this._select == _arg1)
            {
                return;
            };
            if (this._selectLock)
            {
                return;
            };
            this._select = _arg1;
            if (this._select)
            {
                this._btn.gotoAndStop(2);
                dispatchEvent(new Event(Event.SELECT));
                dispatchEvent(new SelectEvent(SelectEvent.SELECT, this.data, this.select));
            }
            else
            {
                dispatchEvent(new SelectEvent(SelectEvent.RESELECT, this.data, this.select));
                this._btn.gotoAndStop(1);
            };
            dispatchEvent(new SelectEvent(SelectEvent.UPSELECT, this.data, this.select));
        }

        public function get select():Boolean
        {
            return (this._select);
        }

        public function destory():void
        {
            removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            removeEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
            removeEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
            removeEventListener(MouseEvent.CLICK, this.mouseClick);
        }


    }
}//package com.snake.ui.mcontrols
