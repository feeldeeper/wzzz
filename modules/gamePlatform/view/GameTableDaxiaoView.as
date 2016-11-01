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
    import daxiao.*;

    public class GameTableDaxiaoView extends GameTableView 
    {

        private var loger:DaxiaoCardlog;
        private var loadSkin:TableLoadingSkin;
        private var skin:GameTableDaxiaoSkin;
        private var luBox:Sprite;
        private var luw:Number = 25;
        private var txt_da:TextField;
        private var txt_draw:TextField;
        private var txt_xiao:TextField;
        private var txt_tableNum:TextField;
        private var txt_gameState:TextField;
        private var btn_StartGame:MovieClip;
        private var waitPanel:GameTableRoomWaitPanelView;
        private var mc_farmer:MovieClip;
        private var clockMc:MovieClip;
        private var gameTime:uint = 0;
        private var box1:Sprite;
        private var box1Stage:Sprite;
        private var helpBtn:MovieClip;

        public function GameTableDaxiaoView()
        {
            this.loger = new DaxiaoCardlog();
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
            this.skin = new GameTableDaxiaoSkin();
            addChild(this.skin);
            this.clockMc = this.skin.clockMc;
            this.luBox = new Sprite();
            addChild(this.luBox);
            this.luBox.x = this.skin.mc_lu.x;
            this.luBox.y = this.skin.mc_lu.y;
            this.luBox.graphics.lineStyle(0.5, 9803156);
            this.luBox.graphics.beginFill(16711399);
            _local3 = 0;
            while (_local3 < (17 * 6))
            {
                _local1 = (_local3 % 17);
                _local2 = ((_local3 / 17) >> 0);
                this.luBox.graphics.drawRect((_local1 * this.luw), (_local2 * this.luw), this.luw, this.luw);
                _local3++;
            };
            this.luBox.width = 468;
            this.luBox.height = 100;
            this.luBox.addChild(this.box1);
            this.box1.addChildAt(this.box1Stage, 0);
            this.skin.removeChild(this.skin.mc_lu);
            this.txt_tableNum = this.skin.txt_tableNum;
            this.btn_StartGame = this.skin.mc_startGame;
            Tools.setButton(this.btn_StartGame);
            this.btn_StartGame.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.helpBtn = this.skin.help;
            Tools.setButton(this.helpBtn);
            this.helpBtn.addEventListener(MouseEvent.CLICK, this.helpBtnFun);
            this.initBoxMask(this.luBox, 640, 124.95);
        }

        private function initBoxMask(_arg1:Sprite, _arg2:uint, _arg3:uint):void
        {
            var _local4:Sprite = new Sprite();
            _local4.graphics.beginFill(0xFF0000);
            _local4.graphics.drawRect(0, 0, _arg2, _arg3);
            _local4.x = _arg1.x;
            _local4.y = _arg1.y;
            addChildAt(_local4, 1);
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
                this.waitPanel.addEventListener("selectMoneyGroup", this.selectMoneyGroup);
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
        }

        public function upTime():void
        {
            this.clockMc.time.text = String(tableVO.time);
            if (tableVO.time > 0)
            {
                this.clockMc.bg.gotoAndStop(Math.round(((tableVO.injectTime - tableVO.time) * this.gameTime)));
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
            var _local2:Sprite;
            this.clear();
            var _local1:Array = DaxiaoCardlog.getLastArr(tableVO.gameHistory);
            _local2 = this.loger.getDaLuShowBox(_local1, BigLuMoiveSkin, this.luw, this.luw, "BigSmall");
            this.box1Stage.addChild(_local2);
            if (this.loger.daLuLie > 17)
            {
                this.box1Stage.x = (this.box1Stage.x - ((this.loger.daLuLie - 17) * this.luw));
            };
        }

        public function upGameState():void
        {
            if (this.gameTime == 0)
            {
                this.gameTime = (100 / tableVO.injectTime);
            };
            if (tableVO.gameState == 3)
            {
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
            Tools.removeAllChild(this.box1Stage);
            this.box1Stage.x = 0;
        }

        override public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
