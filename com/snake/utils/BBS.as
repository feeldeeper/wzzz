package com.snake.utils
{
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import flash.text.*;

    public class BBS extends MovieClip 
    {

        private var _b:MovieClip;
        private var bbsContent:String = "";
        private var bbs_txt:TextField;
        private var factor:int = 20;
        private var tf:TextFormat;
        private var maqueeId:int = 0;
        private var _mask:MovieClip;
        private var _widthW:Number;
        private var _heightH:Number;

        public function BBS(_arg1:Number, _arg2:Number, _arg3:uint=14):void
        {
            this.widthW = _arg1;
            this.heightH = _arg2;
            this._b = new MovieClip();
            this._mask = new MovieClip();
            this.bbs_txt = new TextField();
            this._mask.graphics.beginFill(0);
            this._mask.graphics.drawRect(0, 0, this.widthW, this.heightH);
            this._mask.graphics.endFill();
            this.addChild(this._mask);
            this._b.graphics.beginFill(0);
            this._b.graphics.drawRect(0, 0, this.widthW, this.heightH);
            this._b.graphics.endFill();
            this._b.buttonMode = true;
            this._b.alpha = 0;
            this.addChild(this._b);
            this.bbs_txt = new TextField();
            this.tf = new TextFormat();
            this.bbs_txt.selectable = false;
            this.bbs_txt.autoSize = "left";
            this.bbs_txt.multiline = false;
            this.bbs_txt.wordWrap = false;
            this.tf.color = 0xFFFFFF;
            this.tf.bold = true;
            this.tf.font = "宋体";
            this.tf.size = _arg3;
            this._b.addEventListener(MouseEvent.MOUSE_OVER, this.mouseHandler);
            this._b.addEventListener(MouseEvent.MOUSE_OUT, this.mouseHandler);
        }

        public function get heightH():Number
        {
            return (this._heightH);
        }

        public function set heightH(_arg1:Number):void
        {
            this._heightH = _arg1;
        }

        public function get widthW():Number
        {
            return (this._widthW);
        }

        public function set widthW(_arg1:Number):void
        {
            this._widthW = _arg1;
        }

        private function addBBSTxt():void
        {
            this.bbs_txt.defaultTextFormat = this.tf;
            this.bbs_txt.text = this.bbsContent;
            this.bbs_txt.x = this.widthW;
            this.bbs_txt.y = ((this.heightH - this.bbs_txt.height) * 0.5);
            this.addChild(this.bbs_txt);
            this.addChild(this._b);
            this.bbs_txt.mask = this._mask;
        }

        private function onAddedHandler():void
        {
            this.addBBSTxt();
            clearInterval(this.maqueeId);
            this.maqueeId = setInterval(this.marqueeFun, 500);
        }

        public function getLanInfo(_arg1:String=null):void
        {
            if (_arg1)
            {
                this.bbsContent = _arg1;
            };
            if ((((this.bbsContent == null)) || ((this.bbsContent == ""))))
            {
                this.bbsContent = "暂时无公告！";
            };
            this.onAddedHandler();
        }

        private function mouseHandler(_arg1:MouseEvent):void
        {
            clearInterval(this.maqueeId);
            if (_arg1.type != MouseEvent.MOUSE_OVER)
            {
                this.maqueeId = setInterval(this.marqueeFun, 500);
            };
        }

        private function marqueeFun():void
        {
            this.bbs_txt.x = (this.bbs_txt.x - this.factor);
            if ((this.bbs_txt.x + this.bbs_txt.width) <= 0)
            {
                this.bbs_txt.x = this._b.width;
            };
        }

        public function Unload():void
        {
            clearInterval(this.maqueeId);
            this._b.removeEventListener(MouseEvent.MOUSE_OVER, this.mouseHandler);
            this._b.removeEventListener(MouseEvent.MOUSE_OUT, this.mouseHandler);
        }

        public function reStart():void
        {
            this.onAddedHandler();
            this._b.addEventListener(MouseEvent.MOUSE_OVER, this.mouseHandler);
            this._b.addEventListener(MouseEvent.MOUSE_OUT, this.mouseHandler);
        }


    }
}//package com.snake.utils
