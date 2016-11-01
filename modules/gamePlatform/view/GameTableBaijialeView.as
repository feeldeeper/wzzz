package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.view.events.*;
    import baijiale.*;
    import modules.gamePlatform.model.vo.*;
    import com.snake.game.*;
    import flash.text.*;
    import gamePlatform.*;
    import modules.gamePlatform.view.components.*;
    import com.snake.ui.gameControls.*;

    public class GameTableBaijialeView extends GameTableView 
    {

        private var loger:BJLCardLog;
        private var loadSkin:TableLoadingSkin;
        private var skin:GameTableBaijialeSkin;
        private var washingPanel:WashingPanelSkin;
        private var box1:Sprite;
        private var box2:Sprite;
        private var box3:Sprite;
        private var box4:Sprite;
        private var box5:Sprite;
        private var box6:Sprite;
        private var box1Stage:Sprite;
        private var box2Stage:Sprite;
        private var box3Stage:Sprite;
        private var box4Stage:Sprite;
        private var box5Stage:Sprite;
        private var box6Stage:Sprite;
        private var luBox:Sprite;
        private var luw:Number = 15;
        private var fv:Number = 60;
        private var fh:Number = 12;
        private var gew:Number = 7.5;
        private var geh:Number = 7.5;
        private var txt_banker:TextField;
        private var txt_draw:TextField;
        private var txt_player:TextField;
        private var txt_tableNum:TextField;
        private var txt_gameState:TextField;
        private var btn_StartGame:MovieClip;
        private var digit1:Digit;
        private var digit2:Digit;
        private var waitPanel:GameTableRoomWaitPanelView;
        private var mc_farmer:MovieClip;
        private var clockMc:MovieClip;
        private var gameTime:int = 0;
        private var helpBtn:MovieClip;

        public function GameTableBaijialeView()
        {
            this.loger = new BJLCardLog();
            this.box1 = new Sprite();
            this.box2 = new Sprite();
            this.box3 = new Sprite();
            this.box4 = new Sprite();
            this.box5 = new Sprite();
            this.box6 = new Sprite();
            this.box1Stage = new Sprite();
            this.box2Stage = new Sprite();
            this.box3Stage = new Sprite();
            this.box4Stage = new Sprite();
            this.box5Stage = new Sprite();
            this.box6Stage = new Sprite();
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
            this.skin = new GameTableBaijialeSkin();
            this.clockMc = this.skin.clockMc;
            this.luBox = new Sprite();
            this.luBox.x = this.skin.mc_lu.x;
            this.luBox.y = this.skin.mc_lu.y;
            this.luBox.graphics.lineStyle(0.5, 9803156);
            this.luBox.graphics.beginFill(0xFFFFFF);
            _local3 = 0;
            while (_local3 < (this.fv * this.fh))
            {
                _local1 = (_local3 % this.fv);
                _local2 = ((_local3 / this.fv) >> 0);
                this.luBox.graphics.drawRect((_local1 * this.gew), (_local2 * this.geh), this.gew, this.geh);
                _local3++;
            };
            this.luBox.graphics.endFill();
            this.luBox.graphics.lineStyle(0.5, 9803156);
            this.luBox.graphics.beginFill(0xFFFFFF);
            _local3 = 0;
            while (_local3 < 72)
            {
                _local1 = (_local3 % 12);
                _local2 = ((_local3 / 12) >> 0);
                this.luBox.graphics.drawRect(((_local1 * this.gew) * 2), ((_local2 * this.geh) * 2), (this.gew * 2), (this.geh * 2));
                _local3++;
            };
            this.luBox.graphics.endFill();
            this.luBox.width = 468;
            this.luBox.height = 100;
            this.luBox.addChild(this.box1);
            this.luBox.addChild(this.box2);
            this.box2.x = 180;
            this.luBox.addChild(this.box3);
            this.box3.x = this.box2.x;
            this.box3.y = 45;
            this.luBox.addChild(this.box4);
            this.box4.x = this.box2.x;
            this.box4.y = 67.5;
            this.luBox.addChild(this.box5);
            this.box5.x = (this.box2.x + 135);
            this.box5.y = this.box4.y;
            this.box6.x = this.box5.x;
            this.box6.y = 45;
            this.luBox.addChild(this.box6);
            var _local4:uint = 280;
            var _local5:uint = 55;
            this.box1.addChildAt(this.box1Stage, 0);
            this.box2.addChildAt(this.box2Stage, 0);
            this.box3.addChildAt(this.box3Stage, 0);
            this.box4.addChildAt(this.box4Stage, 0);
            this.box5.addChildAt(this.box5Stage, 0);
            this.box6.addChildAt(this.box6Stage, 0);
            this.skin.removeChild(this.skin.mc_lu);
            this.txt_tableNum = this.skin.txt_tableNum;
            this.txt_tableNum.text = "0";
            this.btn_StartGame = this.skin.mc_startGame;
            Tools.setButton(this.btn_StartGame);
            this.helpBtn = this.skin.help;
            Tools.setButton(this.helpBtn);
            this.washingPanel = new WashingPanelSkin();
            this.washingPanel.visible = false;
            this.washingPanel.x = ((this.luBox.width - this.washingPanel.width) / 2);
            this.washingPanel.y = ((this.luBox.height - this.washingPanel.height) / 2);
            addChild(this.skin);
            addChild(this.luBox);
            this.luBox.addChild(this.washingPanel);
            this.box1Stage.addChild(this.loger.zhuZaiMc);
            this.box2Stage.addChild(this.loger.daLuMc);
            this.initBoxMask(this.box1, 180, 112);
            this.initBoxMask(this.box2, 290, 56);
            this.initBoxMask(this.box3, 145, 28);
            this.initBoxMask(this.box4, 145, 28);
            this.initBoxMask(this.box5, 145, 28);
            this.initBoxMask(this.box6, 145, 28);
            this.btn_StartGame.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.luBox.buttonMode = true;
            this.luBox.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.helpBtn.addEventListener(MouseEvent.CLICK, this.helpBtnFun);
            this.skin.rateType_mc.addEventListener(MouseEvent.CLICK, this.rateTypeFun);
            this.skin.rateType_mc.visible = false;
        }

        private function rateTypeFun(_arg1:MouseEvent):void
        {
            if (_arg1.currentTarget.currentFrame == 1)
            {
                _arg1.currentTarget.gotoAndStop(2);
                tableVO.rateType = 1;
            }
            else
            {
                tableVO.rateType = 0;
                _arg1.currentTarget.gotoAndStop(1);
            };
        }

        private function initBoxMask(_arg1:Sprite, _arg2:uint, _arg3:uint):void
        {
            var _local4:Sprite = new Sprite();
            _local4.graphics.beginFill(0xFF0000);
            _local4.graphics.drawRect(0, 0, _arg2, _arg3);
            _arg1.addChildAt(_local4, 1);
            _arg1.mask = _local4;
        }

        private function initClock():void
        {
            addChild(this.clockMc);
        }

        private function helpBtnFun(_arg1:MouseEvent):void
        {
            var _local2:Event = new Event("showRule");
            dispatchEvent(_local2);
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

        public function initTable():void
        {
            this.txt_tableNum.text = tableVO.gameid;
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
            this.loger.zhuzaiLuShow(_local2, BigLuMoiveSkin, this.luw, this.luw);
            this.loger.daLuShow(_local3, DaLuMoiveSkin, 7.5, 7.5);
            this.box1Stage.x = (this.box2Stage.x = (this.box3Stage.x = (this.box4Stage.x = (this.box5Stage.x = (this.box6Stage.x = 0)))));
            if (this.loger.zhuZaiLuLie > 12)
            {
                this.box1Stage.x = (this.box1Stage.x - ((this.loger.zhuZaiLuLie - 12) * this.luw));
            };
            if (this.loger.daLuLie > 36)
            {
                this.box2Stage.x = (this.box2Stage.x - ((this.loger.daLuLie - 51) * 7.5));
            };
            if (this.loger.daYanLuLie > 72)
            {
                this.box3Stage.x = (this.box3Stage.x - ((this.loger.daYanLuLie - 51) * 3.75));
            };
            if (this.loger.xiaoLuLie > 72)
            {
                this.box4Stage.x = (this.box4Stage.x - ((this.loger.xiaoLuLie - 51) * 3.75));
            };
            if (this.loger.zhangLuLie > 72)
            {
                this.box5Stage.x = (this.box5Stage.x - ((this.loger.zhangLuLie - 51) * 3.75));
            };
            if (this.loger.sanXinLuLie > 36)
            {
                this.box6Stage.x = (this.box6Stage.x - ((this.loger.sanXinLuLie - 51) * 7.5));
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

        private function clear():void
        {
            this.box1Stage.x = 0;
        }

        public function addToStage():void
        {
        }

        override public function dispose():void
        {
            this.clear();
        }


    }
}//package modules.gamePlatform.view
