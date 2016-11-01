package com.snake.net
{
    import flash.events.*;
    import flash.net.*;
    import flash.display.*;
    import flash.text.*;

    public class FontsLoader extends EventDispatcher 
    {

        private var loader:Loader;
        private var _fontName:String;
        private var _font:Font = null;
        private var _loaded:Boolean = false;
        private var _state:String = "";

        public function FontsLoader(_arg1:String)
        {
            this.loader = new Loader();
            super();
            this._fontName = _arg1;
        }

        public function load(_arg1:String):void
        {
            this._loaded = false;
            this._font = null;
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.fontComplete);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.fontError);
            this.loader.load(new URLRequest(_arg1));
            this._state = "程序初始化";
        }

        private function fontError(_arg1:IOErrorEvent):void
        {
            this._state = "加载SWF文件出错";
            this._loaded = false;
        }

        private function fontComplete(_arg1:Event):void
        {
            var _local2:Array = Font.enumerateFonts();
            var _local3:int;
            while (_local3 < _local2.length)
            {
                if (_local2[_local3].fontName == this.fontName)
                {
                    this._font = _local2[_local3];
                    this._loaded = true;
                    break;
                };
                _local3++;
            };
            if (this._font)
            {
                this._state = "字体获取成功";
            }
            else
            {
                this._state = "swf内无指定字体";
            };
            dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get fontName():String
        {
            return (this._fontName);
        }

        public function get font():Font
        {
            return (this._font);
        }

        public function get state():String
        {
            return (this._state);
        }

        public function get loaded():Boolean
        {
            return (this._loaded);
        }

        public function destroy():void
        {
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.fontComplete);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.fontError);
        }


    }
}//package com.snake.net
