package com.snake.ui.gameControls
{
    import flash.display.*;
    import com.greensock.easing.*;
    import com.greensock.*;

    public class Digit extends Sprite 
    {

        private const TOP:int = 0;
        private const BOTTOM:int = 1;

        private var _skin:MovieClip;
        private var _currDigit:Array;
        private var _nextDigit:Array;
        private var _number:String = "0";

        public function Digit(_arg1:MovieClip)
        {
            this._skin = _arg1;
            this.initView();
        }

        private function initView():void
        {
            if (this._skin.parent)
            {
                this._skin.parent.addChild(this);
            };
            this.x = this._skin.x;
            this.y = this._skin.y;
            this._skin.x = (this._skin.y = 0);
            this.addChild(this._skin);
            this._currDigit = new Array(this._skin.top1, this._skin.bottom1);
            this._nextDigit = new Array(this._skin.top2, this._skin.bottom2);
            this.reset();
        }

        private function reset():void
        {
            this._skin.addChild(this._nextDigit[this.BOTTOM]);
            this._skin.addChild(this._currDigit[this.TOP]);
            this._nextDigit[this.BOTTOM].scaleY = -1;
            this._nextDigit[this.TOP].scaleY = 1;
        }

        public function set skin(_arg1:MovieClip):void
        {
            if (this.contains(this._skin))
            {
                this.removeChild(this._skin);
            };
            this._skin = _arg1;
            this._number = "0";
            this.initView();
        }

        public function get number():String
        {
            return (this._number);
        }

        public function flipTo(_arg1:String):void
        {
            if (this._number == _arg1)
            {
                return;
            };
            this._number = _arg1;
            this._nextDigit[this.TOP].t_num.text = _arg1;
            this._nextDigit[this.BOTTOM].t_num.text = _arg1;
            TweenLite.to(this._currDigit[this.TOP], 0.15, {
                "scaleY":0,
                "ease":Linear.easeNone
            });
            TweenLite.to(this._nextDigit[this.BOTTOM], 0.3, {
                "scaleY":1,
                "onComplete":this.flipComplete,
                "ease":Bounce.easeOut
            });
        }

        private function flipComplete():void
        {
            var _local1:Array = this._currDigit;
            this._currDigit = this._nextDigit;
            this._nextDigit = _local1;
            this.reset();
        }


    }
}//package com.snake.ui.gameControls
