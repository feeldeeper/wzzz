package 
{

    import com.greensock.*;
    import com.greensock.events.*;
    import com.greensock.loading.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    
    import modules.gamePlatform.model.*;
	
	import modules.gamePlatform.view.components.*;
	import modules.gamePlatform.view.*;

    public class Preloader extends MovieClip 
    {

        private var mainProgress:Number = 10;
        private var _httpUrl:String = "";
        private var loadmc:PreLoadingDisplay;
		
		

        public function Preloader()
        {
            this.loadmc = new PreLoadingDisplay();
            super();
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            this.contextMenu = new ContextMenu();
            this.contextMenu.hideBuiltInItems();
            if (stage)
            {
                this.addStage();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, this.addStage);
            };
        }

        protected function addStage(_arg1:Event=null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.addStage);
            stage.scaleMode = StageScaleMode.EXACT_FIT;
            stage.align = StageAlign.TOP_LEFT;
            addChild(this.loadmc);
            addEventListener(Event.ENTER_FRAME, this.checkFrame);
            loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progress);
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
        }

        private function progress(_arg1:ProgressEvent):void
        {
            var _local2:Number = (((_arg1.bytesLoaded / _arg1.bytesTotal) * this.mainProgress) >> 0);
            this.loadmc.show(_local2, "Initializing:");
        }

        private function ioError(_arg1:IOErrorEvent):void
        {
        }

        private function checkFrame(_arg1:Event):void
        {
            if (currentFrame == totalFrames)
            {
                stop();
                this.loadingFinished();
            };
        }

        private function loadingFinished():void
        {
            var _local1:String;
            removeEventListener(Event.ENTER_FRAME, this.checkFrame);
            loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.progress);
            loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            if (ExternalInterface.available)
            {
                _local1 = "data/config.txt";
            }
            else
            {
                _local1 = "data/config.txt";
            };
            var _local2:DataLoader = new DataLoader(_local1, {
                "name":"config",
                "onComplete":this.confingComplete,
                "noCache":true
            });
            _local2.load(true);
        }

        private function confingComplete(_arg1:LoaderEvent):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("loadComplete");
            };
            this.otherLoad();
        }

        private function otherLoad():void
        {
            var _local1:String = (LoaderMax.getContent("config") as String);
            var _local2:FrameHashModel = new FrameHashModel("bfdbdb8f");
            var _local3:String = _local2.decrypt(_local1);
            var _local4:Object = Tools.json_decode(_local1);
			//trace(_local3);
			//trace(_local4);
			//trace(JSON10.encode(_local4))
            if (_local4.httpUrl)
            {
                this._httpUrl = _local4.httpUrl;
            };
            var _local5:LoaderMax = new LoaderMax({
                "name":"configLoader",
                "onProgress":this.progressHandler,
                "onComplete":this.completeHandler,
                "onError":this.errorHandler
            });
            _local5.append(new XMLLoader("assets/ip.xml", {
                "name":"liveServerReserve",
                "autoPlay":false
            }));
            _local5.append(new SWFLoader(("assets/gameStateSoundRsl.swf?v=0.1"), {
                "name":"gameStateSoundRsl",
                "autoPlay":false
            }));
            _local5.append(new SWFLoader(("assets/userHeader.swf"), {
                "name":"userHeader",
                "autoPlay":false
            }));
            _local5.append(new SWFLoader(("assets/MUBA.swf"), {
                "name":"lobbyMuba",
                "autoPlay":false,
                "noCache":true
            }));
            _local5.append(new SWFLoader(("assets/ad.swf"), {
                "name":"lobbyAd",
                "autoPlay":false
            }));
            _local5.append(new SWFLoader(("assets/co.swf"), {
                "name":"lobbyCo",
                "autoPlay":false,
                "noCache":true
            }));
            _local5.load();

        }

        private function progressHandler(_arg1:LoaderEvent):void
        {
            var _local2:Number = _arg1.target.progress;
            _local2 = (this.mainProgress + ((_local2 * (100 - this.mainProgress)) >> 0));
            this.loadmc.show(_local2, "Configure settings:");
        }

        private function errorHandler(_arg1:LoaderEvent):void
        {
            this.loadmc.show(90, ((("Configure Error:" + _arg1.target) + ": ") + _arg1.text));
        }

        private function completeHandler(e:LoaderEvent):void
        {
            TweenMax.to(this.loadmc, 0.5, {
                "alpha":0,
                "onComplete":function ():void
                {
                    if (contains(loadmc))
                    {
                        removeChild(loadmc);
                    };
                    loadmc = null;
                }
            });
            this.startup();
            var queue:LoaderMax = new LoaderMax({
                "name":"configLoader2",
                "onComplete":this.completeHandler2
            });
            queue.append(new SWFLoader(("assets/WinAniPane.swf"), {
                "name":"winAniPaneLoader",
                "autoPlay":false
            }));
            queue.load();
        }

        private function completeHandler2(_arg1:LoaderEvent):void
        {
        }

        private function startup():void
        {
			//测试
			//var test:GameRoomContentView = new GameRoomContentView();
			//var test1:GameRoomContentView = new GameRoomContentView();
			//var test2:GameRoomView = new GameRoomView();
			//var test3:GameTableBaijialeView = new GameTableBaijialeView();
			//var test4:GameTableView = new GameTableView();
			//addChild(test);
			//addChild(test1);
			//addChild(test2);
			//addChild(test3);
			//addChild(test4);
            //测试完毕
			var _local1:Class = (getDefinitionByName("GamePlatform") as Class);
            var _local2:Sprite = new (_local1)();
            _local2.alpha = 0;
            addChild(_local2);
            TweenMax.to(_local2, 1, {"alpha":1});
        }


    }
}//package 
