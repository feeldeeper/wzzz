package modules.baijiale.view
{
    import flash.events.*;
    import flash.display.*;
    import modules.baijiale.view.events.*;
    import baijiale.*;
    import flash.text.*;
    import com.snake.utils.*;

    public class GameInterfaceView extends Sprite 
    {

        public var text_limitMax:TextField;
        public var text_limitMin:TextField;
        public var language:MovieClip;
        public var gameState:MovieClip;
        public var text_gameid:TextField;
        public var text_round:TextField;
        public var text_gameNumber:TextField;
        public var text_userid:TextField;
        public var text_userMoney:TextField;
        public var text_time:TextField;
        public var btn_brackRoom:MovieClip;
        public var btn_simulations:MovieClip;
        public var btn_seatSelect:MovieClip;
        public var btn_gameRecord:MovieClip;
        public var btn_rules:MovieClip;
        public var bottomMc:Sprite;
        private var btn_tel:MovieClip;
        private var btn_brackRoom2:MovieClip;
        private var btn_recharge:MovieClip;
        private var btn_fullccreen:MovieClip;
        public var BBS_mc:BBS;
        public var skin:GameMainInterfaceSkin;
        private var bottomBtnArr:Array;
        private var simulationsBool:Boolean = false;
        public var text_groupNum:TextField;

        public function GameInterfaceView(_arg1:GameMainInterfaceSkin)
        {
            this.bottomBtnArr = ["btn_rules", "btn_brackRoom", "btn_gameRecord", "btn_fullccreen"];
            super();
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            this.language = this.skin.language;
            this.language.mouseChildren = false;
            this.language.mouseEnabled = false;
            this.gameState = this.skin.gameState;
            this.text_gameid = this.skin.text_gameid;
            this.text_round = this.skin.text_round;
            this.text_gameNumber = this.skin.text_gameNumber;
            this.text_userid = this.skin.text_userid;
            this.text_userMoney = this.skin.text_userMoney;
            this.text_gameid.text = "0";
            this.text_round.text = "0";
            this.text_gameNumber.text = "0";
            this.text_userid.text = "";
            this.text_userMoney.text = "0";
            this.text_limitMax = this.skin.limitMax;
            this.text_limitMin = this.skin.limitMin;
            this.btn_brackRoom = this.skin.menuPanel.btn_brackRoom;
            Tools.setButton(this.btn_brackRoom);
            this.btn_simulations = this.skin.menuPanel.btn_simulations;
            Tools.setButton(this.btn_simulations);
            this.btn_gameRecord = this.skin.menuPanel.btn_gameRecord;
            Tools.setButton(this.btn_gameRecord);
            this.btn_rules = this.skin.menuPanel.btn_rules;
            Tools.setButton(this.btn_rules);
            this.btn_recharge = this.skin.mc_recharge;
            Tools.setButton(this.btn_recharge);
            this.btn_fullccreen = this.skin.menuPanel.btn_fullccreen;
            Tools.setButton(this.btn_fullccreen);
            Tools.setButton(this.skin.mc_gotoGameList);
            this.skin.mc_gotoGameList.addEventListener(MouseEvent.CLICK, this.gotoGameList);
            this.skin.mc_n.visible = false;
            this.skin.mc_p.visible = false;
            this.skin.language.visible = false;
            this.skin.mc_gotoTable.visible = false;
            this.text_groupNum = this.skin.text_tableNum;
            this.text_groupNum.visible = false;
            this.bottomMc = this.skin.bottomMc;
            this.BBS_mc = new BBS(165, 22, 10);
            this.BBS_mc.x = 60;
            this.BBS_mc.y = 492;
            this.skin.menuPanel.visible = false;
            Tools.setButton(this.skin.showMenu);
            this.skin.showMenu.addEventListener(MouseEvent.CLICK, this.showMenuFun);
        }

        private function showMenuFun(_arg1:MouseEvent):void
        {
            if (this.skin.menuPanel.visible == false)
            {
                this.skin.menuPanel.visible = true;
            }
            else
            {
                this.skin.menuPanel.visible = false;
            };
        }

        protected function showResultPanel(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("showResultPanel"));
        }

        protected function gotoGameList(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("showGameLeftList"));
        }

        protected function goMyGroup(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("goMyGroup"));
        }

        protected function gotoGroup(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("gotoGroup"));
        }

        protected function pGroup(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("pGroup"));
        }

        protected function nGroup(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("nGroup"));
        }

        private function recharge(_arg1:MouseEvent):void
        {
            var _local2:GameInterfaceViewEvent = new GameInterfaceViewEvent(GameInterfaceViewEvent.BACK_ROOM);
            _local2.data = this.simulationsBool;
            dispatchEvent(_local2);
        }

        protected function system(_arg1:MouseEvent):void
        {
            var _local2:GameInterfaceViewEvent = new GameInterfaceViewEvent(GameInterfaceViewEvent.SYSTEM);
            dispatchEvent(_local2);
        }

        protected function rules(_arg1:MouseEvent):void
        {
            var _local2:GameInterfaceViewEvent = new GameInterfaceViewEvent(GameInterfaceViewEvent.GAME_RULES);
            dispatchEvent(_local2);
            this.skin.menuPanel.visible = false;
        }

        protected function gameRecord(_arg1:MouseEvent):void
        {
            var _local2:GameInterfaceViewEvent = new GameInterfaceViewEvent(GameInterfaceViewEvent.GAME_RECORD);
            dispatchEvent(_local2);
            this.skin.menuPanel.visible = false;
        }

        protected function seatSelect(_arg1:MouseEvent):void
        {
            var _local2:GameInterfaceViewEvent = new GameInterfaceViewEvent(GameInterfaceViewEvent.SEAT_SELECT);
            dispatchEvent(_local2);
        }

        protected function simulations(_arg1:MouseEvent):void
        {
            !((this.simulationsBool == this.simulationsBool));
            var _local2:GameInterfaceViewEvent = new GameInterfaceViewEvent(GameInterfaceViewEvent.UP_SIMULATIONS_PANEL);
            _local2.data = this.simulationsBool;
            dispatchEvent(_local2);
        }

        protected function brackRoom(_arg1:MouseEvent):void
        {
            var _local2:GameInterfaceViewEvent = new GameInterfaceViewEvent(GameInterfaceViewEvent.BACK_ROOM);
            _local2.data = this.simulationsBool;
            dispatchEvent(_local2);
            this.skin.menuPanel.visible = false;
        }

        private function showTooltip(_arg1:MouseEvent):void
        {
            if (_arg1.currentTarget.mTooltip.visible == true)
            {
                _arg1.currentTarget.mTooltip.visible = false;
            }
            else
            {
                _arg1.currentTarget.mTooltip.visible = true;
            };
        }

        private function btnFullccreenFun(_arg1:MouseEvent):void
        {
            if (stage.displayState == StageDisplayState.NORMAL)
            {
                stage.displayState = StageDisplayState.FULL_SCREEN;
            }
            else
            {
                stage.displayState = StageDisplayState.NORMAL;
            };
            this.skin.menuPanel.visible = false;
        }

        public function addToStage():void
        {
            new RegExp();
            addChild(this.skin);
            addChild(this.BBS_mc);
            this.btn_brackRoom.addEventListener(MouseEvent.CLICK, this.brackRoom);
            this.btn_gameRecord.addEventListener(MouseEvent.CLICK, this.gameRecord);
            this.btn_rules.addEventListener(MouseEvent.CLICK, this.rules);
            this.btn_recharge.addEventListener(MouseEvent.CLICK, this.recharge);
            this.btn_fullccreen.addEventListener(MouseEvent.CLICK, this.btnFullccreenFun);
            this.skin.mc_gotoGameList.addEventListener(MouseEvent.CLICK, this.gotoGameList);
            var _local1:uint;
            while (_local1 < this.bottomBtnArr.length)
            {
                this.skin.menuPanel[this.bottomBtnArr[_local1]].mTooltip.visible = false;
                this.skin.menuPanel[this.bottomBtnArr[_local1]].addEventListener(MouseEvent.MOUSE_OVER, this.showTooltip);
                this.skin.menuPanel[this.bottomBtnArr[_local1]].addEventListener(MouseEvent.MOUSE_OUT, this.showTooltip);
                _local1++;
            };
        }

        public function setGameNotice(_arg1:String):void
        {
            this.BBS_mc.getLanInfo(_arg1);
        }

        public function dispose():void
        {
            removeChild(this.skin);
            removeChild(this.BBS_mc);
            this.btn_brackRoom.removeEventListener(MouseEvent.CLICK, this.brackRoom);
            this.btn_gameRecord.removeEventListener(MouseEvent.CLICK, this.gameRecord);
            this.btn_rules.removeEventListener(MouseEvent.CLICK, this.rules);
            this.btn_recharge.removeEventListener(MouseEvent.CLICK, this.recharge);
            this.btn_fullccreen.removeEventListener(MouseEvent.CLICK, this.btnFullccreenFun);
            this.skin.mc_gotoGameList.removeEventListener(MouseEvent.CLICK, this.gotoGameList);
            var _local1:uint;
            while (_local1 < this.bottomBtnArr.length)
            {
                this.skin.menuPanel[this.bottomBtnArr[_local1]].mTooltip.visible = false;
                this.skin.menuPanel[this.bottomBtnArr[_local1]].removeEventListener(MouseEvent.MOUSE_OVER, this.showTooltip);
                this.skin.menuPanel[this.bottomBtnArr[_local1]].removeEventListener(MouseEvent.MOUSE_OUT, this.showTooltip);
                _local1++;
            };
            this.BBS_mc.Unload();
        }


    }
}//package modules.baijiale.view
