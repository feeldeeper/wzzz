package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.view.events.*;
    import modules.*;
    import flash.net.*;
    import com.snake.managers.*;
    import flash.text.*;
    import com.greensock.loading.*;
    import flash.geom.*;
    import flash.external.*;
    import com.greensock.*;

    public class MainContainersView extends Sprite 
    {

        private var adPanel:MovieClip;
        private var swfh:uint = 652;
        private var swfw:uint = 1120;
        private var login:LoginView;
        private var gameRoom:GameRoomView;
        private var showBox:Sprite;
        private var showOtherBox:Sprite;
        private var journalingPanelView:JournalingPanelView;
        private var rulesPanel:RulesPanelView;
        private var editPasswordPanel:EditPasswordPanelView;
        private var editNickNamePanel:EditNickNamePanelView;
        private var soundView:GamePlatformSoundView;
        private var alert:AlertDefaultView;
        private var _pageName:String = "";
        private var _gameLeftListShow:Boolean = false;

        public function MainContainersView()
        {
            this.initDisplay();
        }

        public function initDisplay():void
        {
            var _local1:SWFLoader = LoaderMax.getLoader("lobbyAd");
            this.adPanel = (_local1.rawContent as MovieClip);
            this.soundView = new GamePlatformSoundView();
            this.showBox = new Sprite();
            this.showOtherBox = new Sprite();
            this.alert = new AlertDefaultView();
            this.init();
        }

        public function initReSize():void
        {
            stage.addEventListener(Event.RESIZE, this.reSize);
            this.reSize();
        }

        private function init():void
        {
            this.gameRoom = new GameRoomView();
            this.showBox.addChild(this.gameRoom);
            this.login = new LoginView();
            this.showBox.addChild(this.login);
            Tools.removeAllChild(this.showBox);
        }

        public function get pageName():String
        {
            return (this._pageName);
        }

        public function gotoPage(value:String):void
        {
            if (value == this.pageName)
            {
                return;
            };
            if (this._pageName == "game")
            {
                Tools.removeAllChild(this.showBox);
            }
            else
            {
                Tools.removeAllChild(this.showBox);
            };
            this._pageName = value;
            if (this.pageName == "login")
            {
                this.showBox.addChild(this.login);
            };
            if (this.pageName == "gameRoom")
            {
                this.showBox.addChild(this.gameRoom);
                try
                {
                    if (ExternalInterface.available)
                    {
                        if (ExternalInterface.call("getShowAD") == 1)
                        {
                            if (this.adPanel.visible == true)
                            {
                                addChild(this.adPanel);
                                this.gameRoom.visible = true;
                                this.adPanel.close.addEventListener(MouseEvent.CLICK, this.removeAdPanel);
                                TweenMax.delayedCall(5, this.removeAdPanel);
                            };
                        };
                    };
                }
                catch(e:Error)
                {
                    gameRoom.visible = true;
                    adPanel.visible = false;
                };
            };
            var event:MainContainersViewEvent = new MainContainersViewEvent(MainContainersViewEvent.GOTO_PAGE_END);
            dispatchEvent(event);
        }

        private function removeAdPanel(_arg1:Event=null):void
        {
            this.gameRoom.visible = true;
            this.adPanel.close.removeEventListener(MouseEvent.CLICK, this.removeAdPanel);
            this.adPanel.visible = false;
            removeChild(this.adPanel);
        }

        public function gotoGame(_arg1:IGameModule):void
        {
            this._pageName = "game";
            Tools.removeAllChild(this.showBox);
            this.showBox.addChild(Sprite(_arg1));
            var _local2:MainContainersViewEvent = new MainContainersViewEvent(MainContainersViewEvent.GOTO_GAME_END);
            dispatchEvent(_local2);
            Tools.GC();
        }

        public function reSize(_arg1:Event=null):void
        {
            DebugOutput.add("场景变化");
            var _local2:uint = stage.stageWidth;
            var _local3:uint = stage.stageHeight;
            var _local4:Number = Math.min((_local2 / this.swfw), (_local3 / this.swfh));
            this.showBox.scaleX = (this.scaleY = _local4);
            this.showBox.x = ((_local2 - (this.swfw * _local4)) / 2);
            this.showBox.y = 0;
            this.showOtherBox.scaleX = (this.scaleY = _local4);
            this.showOtherBox.x = ((_local2 - (this.swfw * _local4)) / 2);
            this.showOtherBox.y = 0;
            var _local5:MainContainersViewEvent = new MainContainersViewEvent(MainContainersViewEvent.RESIZE);
            _local5.scale = _local4;
            dispatchEvent(_local5);
        }

        public function showError(_arg1:Object, _arg2:String=""):void
        {
            var _local3:Object;
            if ((_arg1 is String))
            {
                _local3 = {};
                _local3.type = "error";
                _local3.error = _arg1;
                _arg1 = _local3;
            };
            if (_arg1.type == "error")
            {
                if (_arg1.url != undefined)
                {
                    _arg2 = _arg1.url;
                };
                this.alert.show(_arg1.error, "提示信息", _arg2);
                AlertManager.getInstance().push(this.alert, true, false, 0, 0.2);
            };
            if (_arg1.type == "fmsReject")
            {
                this.alert.show(_arg1.error, "提示信息");
                AlertManager.getInstance().push(this.alert, true, false, 0, 0.2);
            };
        }

        public function showResultPanel(_arg1:String):void
        {
            if (!this.rulesPanel)
            {
                this.rulesPanel = new RulesPanelView();
            };
            this.rulesPanel.show(_arg1);
            AlertManager.getInstance().push(this.rulesPanel, true, true, 0);
        }

        public function showJournalingPanel():void
        {
            if (!this.journalingPanelView)
            {
                this.journalingPanelView = new JournalingPanelView();
            };
            AlertManager.getInstance().push(this.journalingPanelView, true, true, 0);
        }

        public function showEditpasswordPanel():void
        {
            if (!this.editPasswordPanel)
            {
                this.editPasswordPanel = new EditPasswordPanelView();
            };
            AlertManager.getInstance().push(this.editPasswordPanel, true, true, 0);
        }

        public function showNickNamePanel():void
        {
            if (!this.editNickNamePanel)
            {
                this.editNickNamePanel = new EditNickNamePanelView();
            };
            AlertManager.getInstance().push(this.editNickNamePanel, true, true, 0);
        }

        public function getGameLeftListShow():Boolean
        {
            return (this._gameLeftListShow);
        }

        public function addToStage():void
        {
            addChild(this.showBox);
            addChild(this.showOtherBox);
            addChild(this.soundView);
        }

        public function dispose():void
        {
            removeChild(this.soundView);
            removeChild(this.showBox);
            removeChild(this.showOtherBox);
            stage.removeEventListener(Event.RESIZE, this.reSize);
        }


    }
}//package modules.gamePlatform.view
