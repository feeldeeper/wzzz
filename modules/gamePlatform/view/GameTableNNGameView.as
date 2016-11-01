package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.view.events.*;
    import modules.gamePlatform.model.vo.*;
    import gamePlatform.*;
    import modules.gamePlatform.view.components.*;
    import com.greensock.loading.*;
    import niuniu.*;
    import lib.*;

    public class GameTableNNGameView extends GameTableView 
    {

        private var luBox:Sprite;
        private var luw:Number = 20;
        private var box1:Sprite;
        private var box1Stage:Sprite;
        private var loadSkin:TableLoadingSkin;
        private var skin:GameTableNiuNiuSkin;
        private var btn_StartGame:MovieClip;
        private var helpBtn:MovieClip;
        private var waitPanel:GameTableRoomWaitPanelView;
        private var routeArr:Array;
        private var gameTime:int = 0;

        public function GameTableNNGameView()
        {
            this.box1 = new Sprite();
            this.box1Stage = new Sprite();
            this.routeArr = new Array();
            super();
            this.initDisplay();
        }

        private function initDisplay():void
        {
            var _local2:uint;
            var _local3:uint;
            var _local4:uint;
            var _local5:NNRecordSkin;
            var _local1:NNNavSkin = new NNNavSkin();
            this.skin = new GameTableNiuNiuSkin();
            addChild(this.skin);
            this.loadSkin = new TableLoadingSkin();
            this.loadSkin.gotoAndStop(1);
            this.luBox = new Sprite();
            this.luBox.x = this.skin.mc_lu.x;
            this.luBox.y = this.skin.mc_lu.y;
            this.luBox.graphics.lineStyle(0.5, 9803156);
            this.luBox.graphics.beginFill(0xFFFFFF);
            this.luBox.mouseEnabled = false;
            Tools.setButton(this.skin.mc_startGame);
            _local4 = 0;
            while (_local4 < (16 * 6))
            {
                _local2 = (_local4 % 16);
                _local3 = ((_local4 / 16) >> 0);
                this.luBox.graphics.drawRect((_local2 * 29), (_local3 * 41), 29, 41);
                _local4++;
            };
            this.luBox.addChild(this.box1);
            this.skin.mc_lu.buttonMode = true;
            this.skin.mc_lu.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.skin.mc_startGame.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            _local4 = 0;
            while (_local4 < 14)
            {
                _local5 = new NNRecordSkin();
                this.routeArr.push(_local5);
                _local5.x = ((_local4 * 29) + 29);
                _local5.visible = false;
                this.luBox.addChild(_local5);
                _local4++;
            };
            this.luBox.x = 62;
            this.luBox.addChild(_local1);
            addChild(this.luBox);
            addEventListener(Event.ADDED_TO_STAGE, this.addToStage);
        }

        protected function tableWaitGoToGameFun(_arg1:MouseEvent):void
        {
            tableWaitGoToGame();
        }

        public function upTime():void
        {
            this.skin.clockMc.time.text = String(tableVO.time);
            if (tableVO.time > 0)
            {
                this.skin.clockMc.bg.gotoAndStop(Math.round(((tableVO.injectTime - tableVO.time) * 2.2)));
            }
            else
            {
                this.skin.clockMc.bg.gotoAndStop(0);
            };
        }

        public function upGameHistory():void
        {
            var _local3:Array;
            var _local4:NNRecordSkin;
            var _local5:int;
            var _local6:MovieClip;
            var _local7:Array;
            var _local1:Array = tableVO.gameHistory;
            if (_local1.length >= 14)
            {
                _local1 = _local1.slice((_local1.length - 14), _local1.length);
            };
            var _local2:int;
            while (_local2 < _local1.length)
            {
                _local3 = _local1[_local2];
                _local4 = this.routeArr[_local2];
                _local4.visible = true;
                _local5 = 0;
                while (_local5 < 6)
                {
                    _local6 = _local4[("play" + _local5)];
                    if (_local3[_local5] == undefined)
                    {
                        _local6.visible = false;
                    }
                    else
                    {
                        _local6.visible = true;
                        _local7 = _local3[_local5].split("_");
                        if (Number(_local7[1]) == 0)
                        {
                            _local6.nn.visible = false;
                            _local6.card1.visible = false;
                            _local6.card0.visible = true;
                            _local6.card0.gotoAndStop((Number(_local7[0]) + 1));
                        }
                        else
                        {
                            _local6.nn.visible = true;
                            _local6.card1.visible = true;
                            _local6.card0.visible = false;
                            _local6.card1.gotoAndStop((Number(_local7[0]) + 1));
                            if (Number(_local7[0]) > 26)
                            {
                                _local6.nn.gotoAndStop((Number(_local7[1]) + 10));
                            }
                            else
                            {
                                _local6.nn.gotoAndStop(Number(_local7[1]));
                            };
                        };
                    };
                    _local5++;
                };
                _local2++;
            };
        }

        private function addToStage(_arg1:Event):void
        {
        }

        public function initTable():void
        {
        }

        protected function selectMoneyGroup(_arg1:DataEvent):void
        {
            var _local2:GameTableViewEvent = new GameTableViewEvent(GameTableViewEvent.GOTO_GAME_MONEYGROUP);
            _local2.moneyTypeGroup = _arg1.data;
            dispatchEvent(_local2);
        }

        public function hitWaitPanel():void
        {
            if (((this.waitPanel) && (contains(this.waitPanel))))
            {
                this.waitPanel.removeEventListener("selectMoneyGroup", this.selectMoneyGroup);
                removeChild(this.waitPanel);
            };
        }

        public function startLoad():void
        {
            if (!contains(this.loadSkin))
            {
                addChild(this.loadSkin);
            };
            this.loadSkin.txt_loading.text = "";
        }

        public function hitLoad():void
        {
            if (contains(this.loadSkin))
            {
                removeChild(this.loadSkin);
            };
            this.loadSkin.txt_loading.text = "";
        }

        public function showProgress(_arg1:Number):void
        {
            var _local2:Number = ((_arg1 * 100) >> 0);
            this.loadSkin.txt_loading.text = (_local2 + "%");
        }

        public function showWaitPanel(_arg1:GameMoneyGroup, _arg2:String):void
        {
            var _local3:Object;
            var _local5:Sprite;
            if (this.waitPanel == null)
            {
                _local5 = new Sprite();
                this.waitPanel = new GameTableRoomWaitPanelView();
                this.waitPanel.hideBg();
                _local5.x = (this.waitPanel.x = this.skin.mc_lu.x);
                this.waitPanel.y = ((317 - this.waitPanel.height) / 2);
                _local5.graphics.beginFill(0);
                _local5.graphics.drawRect(0, 0, 465, 247.05);
                _local5.graphics.endFill();
                _local5.width = this.skin.mc_lu.width;
                _local5.height = 247.05;
                _local5.y = this.skin.mc_lu.y;
                _local5.alpha = 0.8;
                addChild(_local5);
            };
            this.waitPanel.addEventListener("selectMoneyGroup", this.selectMoneyGroup);
            if (_arg2 == "custom")
            {
            };
            var _local4:uint = uint(tableVO.gameid);
            if ((((_arg2 == "custom")) && ((_local4 < 80))))
            {
                _local3 = {
                    "min":this.skin.tableLimitMin.text,
                    "max":this.skin.tableLimitMax.text
                };
            };
            this.waitPanel.setMoneyGroup(_arg1, _arg2, _local4, _local3);
            if (!contains(this.waitPanel))
            {
                addChild(this.waitPanel);
            };
        }

        public function upGameState():void
        {
            if (this.gameTime == 0)
            {
                this.gameTime = (100 / tableVO.injectTime);
            };
            if (tableVO.gameState == 2)
            {
                this.skin.clockMc.time.text = "0";
                this.skin.clockMc.bg.gotoAndStop(0);
            };
            this.skin.tableLimitMax.text = tableVO.tableLimitMax.toString();
            this.skin.tableLimitMin.text = tableVO.tableLimitMin.toString();
            this.skin.pu.text = tableVO.gameBoot.toString();
            this.skin.ju.text = tableVO.roundNum.toString();
        }

        override public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
