package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.view.events.*;
    import modules.gamePlatform.model.vo.*;
    import com.snake.game.*;
    import flash.text.*;
    import gamePlatform.*;
    import modules.gamePlatform.view.components.*;
    import longhu.*;

    public class GameTableLonghuView extends GameTableView 
    {

        private var loger:BJLCardLog;
        private var loadSkin:TableLoadingSkin;
        private var skin:GameTableLonghuSkin;
        private var washingPanel:WashingPanelSkin;
        private var luBox:Sprite;
        private var luw:Number = 15;
        private var txt_hu:TextField;
        private var txt_draw:TextField;
        private var txt_long:TextField;
        private var txt_tableNum:TextField;
        private var txt_gameState:TextField;
        private var btn_StartGame:MovieClip;
        private var waitPanel:GameTableRoomWaitPanelView;
        private var clockMc:MovieClip;
        private var gameTime:uint = 45;
        private var box1:Sprite;
        private var box1Stage:Sprite;
        private var helpBtn:MovieClip;

        public function GameTableLonghuView()
        {
            this.loger = new BJLCardLog();
            this.box1 = new Sprite();
            this.box1Stage = new Sprite();
            super();
            this.initDisplay();
        }

        private function initDisplay():void
        {
            var _local1:uint;
            var _local2:uint;
            var _local3:uint;
            this.loadSkin = new TableLoadingSkin();
            this.loadSkin.gotoAndStop(1);
            this.skin = new GameTableLonghuSkin();
            addChild(this.skin);
            this.clockMc = this.skin.clockMc;
            this.luBox = new Sprite();
            addChild(this.luBox);
            this.luBox.x = this.skin.mc_lu.x;
            this.luBox.y = this.skin.mc_lu.y;
            this.luBox.graphics.lineStyle(0.5, 9803156);
            this.luBox.graphics.beginFill(0xFFFFFF);
            _local3 = 0;
            while (_local3 < (28 * 6))
            {
                _local1 = (_local3 % 28);
                _local2 = ((_local3 / 28) >> 0);
                this.luBox.graphics.drawRect((_local1 * this.luw), (_local2 * this.luw), this.luw, this.luw);
                _local3++;
            };
            this.luBox.width = this.skin.mc_lu.width;
            this.luBox.height = this.skin.mc_lu.height;
            this.luBox.addChild(this.box1);
            this.box1.addChildAt(this.box1Stage, 0);
            this.skin.removeChild(this.skin.mc_lu);
            this.txt_tableNum = this.skin.txt_tableNum;
            this.btn_StartGame = this.skin.mc_startGame;
            Tools.setButton(this.btn_StartGame);
            this.btn_StartGame.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.luBox.buttonMode = true;
            this.luBox.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.helpBtn = this.skin.help;
            Tools.setButton(this.helpBtn);
            this.helpBtn.addEventListener(MouseEvent.CLICK, this.helpBtnFun);
            this.initBoxMask(this.luBox, 420, 100);
            this.washingPanel = new WashingPanelSkin();
            this.washingPanel.visible = false;
            this.washingPanel.x = ((this.luBox.width - this.washingPanel.width) / 2);
            this.washingPanel.y = ((this.luBox.height - this.washingPanel.height) / 2);
            this.luBox.addChild(this.washingPanel);
            this.box1Stage.addChild(this.loger.zhuZaiMc);
        }

        private function initBoxMask(_arg1:Sprite, _arg2:uint, _arg3:uint):void
        {
            var _local4:Sprite = new Sprite();
            _local4.graphics.beginFill(0xFFFFFF);
            _local4.graphics.drawRect(0, 0, _arg2, _arg3);
            _arg1.addChildAt(_local4, 1);
            _arg1.mask = _local4;
        }

        protected function tableWaitGoToGameFun(_arg1:MouseEvent):void
        {
            tableWaitGoToGame();
        }

        public function showWaitPanel(_arg1:GameMoneyGroup, _arg2:String):void
        {
            var _local3:Object;
            if (this.waitPanel == null)
            {
                this.waitPanel = new GameTableRoomWaitPanelView();
                this.waitPanel.x = this.luBox.x;
                this.waitPanel.y = this.luBox.y;
            };
            this.waitPanel.addEventListener("selectMoneyGroup", this.selectMoneyGroup);
            if (_arg2 == "custom")
            {
            };
            var _local4:uint = uint(tableVO.gameid);
            if ((((_arg2 == "custom")) && ((_local4 < 89))))
            {
                DebugOutput.add("只显示，默认筹码");
                _local3 = {
                    "min":this.skin.tableLimitMin.text,
                    "max":this.skin.tableLimitMax.text
                };
            };
            DebugOutput.add(("默认筹码" + _arg2));
            this.waitPanel.setMoneyGroup(_arg1, _arg2, _local4, _local3);
            if (!contains(this.waitPanel))
            {
                addChild(this.waitPanel);
            };
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

        public function initTable():void
        {
            this.txt_tableNum.text = tableVO.gameid;
        }

        public function upTime():void
        {
            this.clockMc.time.text = String(tableVO.time);
            if (tableVO.time > 0)
            {
                this.clockMc.bg.gotoAndStop(Math.round(((this.gameTime - tableVO.time) * 2.2)));
            }
            else
            {
                this.clockMc.bg.gotoAndStop(0);
            };
        }

        public function addZero(_arg1:Number):String
        {
            var _local2 = "";
            if (_arg1 <= 9)
            {
                _local2 = ("0" + _arg1);
            }
            else
            {
                _local2 = ("" + _arg1);
            };
            return (_local2);
        }

        public function upGameHistory():void
        {
            this.clear();
            var _local1:Boolean;
            var _local2:Array = tableVO.gameHistory;
            var _local3:Array = _local2.concat(new Array());
            var _local4:uint;
            var _local5:uint;
            while (_local5 < _local3.length)
            {
                if (_local1 == false)
                {
                    if (_local3[_local5] > 7)
                    {
                        _local4++;
                    }
                    else
                    {
                        _local1 = true;
                        break;
                    };
                };
                _local5++;
            };
            _local3.splice(0, _local4);
            this.loger.zhuzaiLuShow(_local3, BigLuMoiveSkin, this.luw, this.luw);
            this.box1Stage.x = 0;
            if (this.loger.daLuLie > 30)
            {
                this.box1Stage.x = (this.box1Stage.x - ((this.loger.daLuLie - 30) * this.luw));
            };
        }

        public function upGameState():void
        {
            if (tableVO.gameState == 3)
            {
                this.washingPanel.visible = true;
            }
            else
            {
                this.washingPanel.visible = false;
            };
            if (tableVO.gameState == 2)
            {
                this.clockMc.time.text = "0";
                this.clockMc.bg.gotoAndStop(0);
            };
            this.skin.tableLimitMax.text = tableVO.tableLimitMax.toString();
            this.skin.tableLimitMin.text = tableVO.tableLimitMin.toString();
            this.skin.pu.text = tableVO.gameBoot.toString();
            this.skin.ju.text = tableVO.roundNum.toString();
        }

        public function upFarmer():void
        {
        }

        private function helpBtnFun(_arg1:MouseEvent):void
        {
            var _local2:Event = new Event("showRule");
            dispatchEvent(_local2);
        }

        private function clear():void
        {
            this.box1Stage.x = 0;
        }

        override public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
