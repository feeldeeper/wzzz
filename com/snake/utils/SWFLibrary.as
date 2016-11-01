package com.snake.utils
{
    import flash.system.*;
    import flash.events.*;
    import flash.display.*;
    import flash.media.*;
    import flash.net.*;
    import flash.text.*;

    public class SWFLibrary extends EventDispatcher 
    {

        private var _libraryURL:String;
        private var _loaded:Boolean;
        private var _request:URLRequest;
        private var _loader:Loader;
        private var _loaderContext:LoaderContext;
        public var loaderInfo:LoaderInfo;

        public function SWFLibrary(_arg1:uint=0)
        {
            this._request = new URLRequest();
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadCompleteHandler);
            this._loader.contentLoaderInfo.addEventListener(Event.INIT, this.loadInitHandler);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadErrorHandler);
            this._loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.loadHTTPStatusHandler);
            this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loadProgressHandler);
            this.loaderInfo = this._loader.contentLoaderInfo;
            this._loaded = false;
            switch (_arg1)
            {
                case 0:
                    this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
                    return;
                case 1:
                    this._loaderContext = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
                    return;
                case 2:
                    this._loaderContext = new LoaderContext(false, new ApplicationDomain(null));
                    return;
                case 3:
                    this._loaderContext = new LoaderContext(false, new ApplicationDomain(null), SecurityDomain.currentDomain);
                    return;
                default:
                    this._loaderContext = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain.parentDomain.parentDomain));
            };
        }

        public function load(_arg1:String):void
        {
            this._loaded = false;
            this._request.url = _arg1;
            this._loader.load(this._request, this._loaderContext);
            this._libraryURL = _arg1;
        }

        public function unload():void
        {
            this._loader.unload();
        }

        public function get loaded():Boolean
        {
            return (this._loaded);
        }

        public function getSprite(_arg1:String):Sprite
        {
            var _local2:Class = this.getAsset(_arg1);
            if (_local2)
            {
                return (Sprite(new (_local2)()));
            };
            return (null);
        }

        public function getMovieClip(_arg1:String):MovieClip
        {
            var _local2:Class = this.getAsset(_arg1);
            if (_local2)
            {
                return (MovieClip(new (_local2)()));
            };
            return (null);
        }

        public function getSound(_arg1:String):Sound
        {
            var _local2:Class = this.getAsset(_arg1);
            if (_local2)
            {
                return (Sound(new (_local2)()));
            };
            return (null);
        }

        public function getFont(_arg1:String):Font
        {
            var _local2:Class = this.getAsset(_arg1);
            if (_local2)
            {
                return (Font(new (_local2)()));
            };
            return (null);
        }

        public function getBitmapData(_arg1:String):BitmapData
        {
            var _local2:Class = this.getAsset(_arg1);
            if (_local2)
            {
                return (BitmapData(new (_local2)(0, 0)));
            };
            return (null);
        }

        public function getBitmap(_arg1:String):Bitmap
        {
            var _local2:Class = this.getAsset(_arg1);
            if (_local2)
            {
                return (new Bitmap(BitmapData(new (_local2)(0, 0))));
            };
            return (null);
        }

        public function getAsset(linkage:String):Class
        {
            var Asset:Class;
            try
            {
                Asset = (this.loaderInfo.applicationDomain.getDefinition(linkage) as Class);
            }
            catch(error:ReferenceError)
            {
                return (null);
            };
            return (Asset);
        }

        public function hasDefinition(_arg1:String):Boolean
        {
            return (this.loaderInfo.applicationDomain.hasDefinition(_arg1));
        }

        public function dispose():void
        {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadCompleteHandler);
            this._loader.contentLoaderInfo.removeEventListener(Event.INIT, this.loadInitHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadErrorHandler);
            this._loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.loadHTTPStatusHandler);
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadProgressHandler);
        }

        private function loadCompleteHandler(_arg1:Event):void
        {
            this._loaded = true;
            dispatchEvent(_arg1);
        }

        private function loadInitHandler(_arg1:Event):void
        {
            dispatchEvent(_arg1);
        }

        private function loadOpenHandler(_arg1:Event):void
        {
            dispatchEvent(_arg1);
        }

        private function loadErrorHandler(_arg1:IOErrorEvent):void
        {
            dispatchEvent(_arg1);
        }

        private function loadHTTPStatusHandler(_arg1:HTTPStatusEvent):void
        {
            dispatchEvent(_arg1);
        }

        private function loadProgressHandler(_arg1:ProgressEvent):void
        {
            dispatchEvent(_arg1);
        }


    }
}//package com.snake.utils
