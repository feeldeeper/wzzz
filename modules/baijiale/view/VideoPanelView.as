package modules.baijiale.view
{
    import flash.events.*;
    import flash.display.*;
    import baijiale.*;
    import modules.baijiale.service.*;
    import flash.media.*;
    import com.greensock.*;
    import com.greensock.loading.*;
    import flash.geom.*;

    public class VideoPanelView extends Sprite 
    {

        private var skin:VideoPanelSkin;
        private var videoW:Number;
        private var videoH:Number;
        private var video:Video;
        private var videoOther:Video;
        private var videoOtherLib:SWFLoader;
        private var isInit:Boolean;
        private var _videoServer:VideoBaijialeService;
        private var stageVideo:StageVideo;
        private var _stageAvailable:Boolean;
        private var _oldVideoName:String;
        public var videoOtherSkin:Sprite;
        public var videoModel:Boolean;
        private var isSelectModel:Boolean;
        private var videoBar:MovieClip;
        public var gameID:uint;
        private var rect:Sprite;

        public function VideoPanelView(_arg1:VideoPanelSkin)
        {
            this.rect = new Sprite();
            super();
            this.skin = _arg1;
            this.initDisplay();
        }

        public function get oldVideoName():String
        {
            return (this._oldVideoName);
        }

        public function set oldVideoName(_arg1:String):void
        {
            this._oldVideoName = _arg1;
        }

        public function get stageAvailable():Boolean
        {
            return (this._stageAvailable);
        }

        public function set stageAvailable(_arg1:Boolean):void
        {
            this._stageAvailable = _arg1;
        }

        public function get videoServer():VideoBaijialeService
        {
            return (this._videoServer);
        }

        public function set videoServer(_arg1:VideoBaijialeService):void
        {
            this._videoServer = _arg1;
        }

        private function initDisplay():void
        {
            var _local1:Class;
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            this.skin.addChild(this.rect);
            this.rect.x = this.skin.videoMask.x;
            this.rect.y = this.skin.videoMask.y;
            this.videoW = this.skin.smaillVideoPanel.video1.bg.width;
            this.videoH = this.skin.smaillVideoPanel.video1.bg.height;
            addChild(this.skin);
            if (this.isInit == false)
            {
                this.videoOtherLib = LoaderMax.getLoader("userHeader");
                _local1 = this.videoOtherLib.getClass("videoOtherLib.videoBg");
                this.videoOtherSkin = new (_local1)();
                addChildAt(this.videoOtherSkin, 0);
                this.videoOtherSkin.visible = false;
                this.skin.videoMask.visible = false;
                this.isInit = true;
            };
            Tools.setNoMouse(this.skin.bigVideoBg);
            this.skin.smaillVideoPanel.video2.switchVideo.visible = false;
            this.skin.smaillVideoPanel.video2.videoOther.buttonMode = true;
            this.videoBar = this.skin.smaillVideoPanel.video2.videoBar;
            this.videoBar.visible = false;
            Tools.setButton(this.videoBar.btn1);
            Tools.setButton(this.videoBar.btn2);
            Tools.setButton(this.videoBar.btn3);
            Tools.setButton(this.skin.smaillVideoPanel.mBtnSwitchSize);
            this.skin.smaillVideoPanel.mBtnSwitchSize.visible = false;
            this.skin.smaillVideoPanel.mBtnSwitchSize.addEventListener(MouseEvent.CLICK, this.switchVideoSize);
            this.drawRectGrad();
        }

        private function drawRectGrad():void
        {
            var _local1:Array = new Array(738362, 738362);
            var _local2:Array = new Array(0, 1);
            var _local3:Array = new Array(0, 128);
            var _local4:Matrix = new Matrix();
            _local4.createGradientBox(1120, 189, (Math.PI / 2));
            this.rect.graphics.beginGradientFill(GradientType.LINEAR, _local1, _local2, _local3, _local4);
            this.rect.graphics.drawRect(0, 0, 1120, 189.3);
            this.rect.graphics.endFill();
        }

        private function switchVideoSize(_arg1:MouseEvent):void
        {
        }

        private function videoOtherMouseClick(_arg1:uint):void
        {
            switch (_arg1)
            {
                case 1:
                    this.videoServer.videoModel2.videoURL = this.oldVideoName;
                    return;
                case 2:
                    this.videoServer.videoModel2.videoURL = "hall1";
                    return;
                case 3:
                    this.videoServer.videoModel2.videoURL = "hall2";
					return;	
				default:
                    this.videoServer.videoModel2.videoURL = this.oldVideoName;
                    return;	
            };
        }

        private function videoOtherMouseOut(_arg1:MouseEvent):void
        {
            if (!stage)
            {
                return;
            };
            var _local2:Rectangle = new Rectangle(0, 0, this.skin.smaillVideoPanel.video2.videoOther.width, this.skin.smaillVideoPanel.video2.videoOther.height);
            if (_local2.contains(this.skin.smaillVideoPanel.video2.videoOther.mouseX, this.skin.smaillVideoPanel.video2.videoOther.mouseY))
            {
                this.showVideoBar();
            }
            else
            {
                this.videoBar.visible = false;
            };
        }

        private function showVideoBar():void
        {
            this.videoBar.visible = true;
        }

        private function videoOtherMouseOver(_arg1:MouseEvent):void
        {
        }

        private function addStage():void
        {
            stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, this.onStageVideoState);
        }

        private function onStageVideoState(e:StageVideoAvailabilityEvent):void
        {
            try
            {
                stage.removeEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, this.onStageVideoState);
                this.stageAvailable = (e.availability == StageVideoAvailability.AVAILABLE);
                DebugOutput.add(("stagevideo状态：" + this.stageAvailable));
                if (this.stageAvailable)
                {
                    this.stageVideo = stage.stageVideos[0];
                    this.videoServer.videoModel.stageAvailable = true;
                    this.videoServer.videoModel.stageVideo = this.stageVideo;
                    this.stageVideo.addEventListener(StageVideoEvent.RENDER_STATE, this.stageVideoStateChange);
                    if (this.videoModel == false)
                    {
                        this.stageVideo.viewPort = new Rectangle(1, 0, 501, 364);
                    }
                    else
                    {
                        this.stageVideo.viewPort = new Rectangle(0, 0, 1120, 540);
                        if (this.gameID > 80)
                        {
                            this.stageVideo.viewPort = new Rectangle(0, 0, 1120, 433);
                        };
                    };
                };
            }
            catch(e:Error)
            {
                videoServer.videoModel.stageAvailable = false;
            };
        }

        private function stageVideoStateChange(_arg1:StageVideoEvent):void
        {
            var _local2:String = _arg1.status;
            this.videoOtherSkin.visible = false;
            DebugOutput.add(("stagevideo播放的状态：" + _local2));
            this.stageVideo.removeEventListener(StageVideoEvent.RENDER_STATE, this.stageVideoStateChange);
        }

        public function showVideo(_arg1:Video):void
        {
        }

        public function setVideo(_arg1:Video):void
        {
            if (this.videoModel == false)
            {
                this.skin.smaillVideoPanel.video1.bg.addChild(_arg1);
                _arg1.width = this.videoW;
                _arg1.height = this.videoH;
            }
            else
            {
                this.skin.bigVideoBg.addChild(_arg1);
                _arg1.width = this.skin.bigVideoBg.width;
                if (this.gameID > 80)
                {
                    _arg1.height = 440;
                };
                this.skin.bigVideoBg.height = _arg1.height;
            };
        }

        public function setVideoOther(_arg1:Video):void
        {
            this.videoOther = _arg1;
            this.skin.smaillVideoPanel.video2.videoOther.addChild(this.videoOther);
            this.videoOther.width = this.videoW;
            this.videoOther.height = this.videoH;
            this.oldVideoName = this.videoServer.videoModel2.videoURL;
        }

        public function videoPlay():void
        {
            if (this.isSelectModel == false)
            {
                this.videoOtherSkin.visible = false;
                this.isSelectModel = true;
            };
        }

        public function videoError():void
        {
        }

        public function linkClose():void
        {
            this.isSelectModel = false;
            this.videoOtherSkin.visible = true;
        }

        public function linkSuccess():void
        {
        }

        public function addToStage():void
        {
            this.videoBar.btn1.addEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void
            {
                videoOtherMouseClick(1);
            });
            this.videoBar.btn2.addEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void
            {
                videoOtherMouseClick(2);
            });
            this.videoBar.btn3.addEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void
            {
                videoOtherMouseClick(3);
            });
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.videoOtherMouseOut);
        }

        public function selectModel():void
        {
            if (this.videoModel == true)
            {
                TweenLite.to(this.skin.smaillVideoPanel.video1, 0.5, {
                    "x":-457,
                    "y":-405.85
                });
                TweenLite.to(this.skin.smaillVideoPanel.video2, 0.5, {
                    "x":1025.3,
                    "y":-405.85
                });
                this.videoOtherSkin.visible = true;
                this.skin.videoMask.visible = true;
                this.skin.bg.visible = false;
                TweenLite.to(this.videoOtherSkin, 0.8, {
                    "alpha":1,
                    "onComplete":this.hiddenMc,
                    "onCompleteParams":[this.videoOtherSkin, true]
                });
                TweenLite.to(this.skin.videoMask, 0.8, {
                    "alpha":1,
                    "onComplete":this.hiddenMc,
                    "onCompleteParams":[this.skin.videoMask, true]
                });
            }
            else
            {
                this.skin.bg.visible = true;
                TweenLite.to(this.skin.smaillVideoPanel.video1, 0.5, {
                    "x":0,
                    "y":0
                });
                TweenLite.to(this.skin.smaillVideoPanel.video2, 0.5, {
                    "x":617.35,
                    "y":0
                });
                this.hiddenvideoOtherSkin();
            };
            this.addStage();
        }

        private function hiddenvideoOtherSkin():void
        {
            TweenLite.to(this.skin.videoMask, 0.5, {
                "alpha":0,
                "onComplete":this.hiddenMc,
                "onCompleteParams":[this.skin.videoMask, false]
            });
        }

        private function hiddenMc(_arg1:MovieClip, _arg2:Boolean):void
        {
            _arg1.visible = _arg2;
        }

        public function dispose():void
        {
            this.videoBar.btn1.removeEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void
            {
                videoOtherMouseClick(1);
            });
            this.videoBar.btn2.removeEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void
            {
                videoOtherMouseClick(2);
            });
            this.videoBar.btn3.removeEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void
            {
                videoOtherMouseClick(3);
            });
            if (stage)
            {
                stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.videoOtherMouseOut);
            };
        }


    }
}//package modules.baijiale.view
