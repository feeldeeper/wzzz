package modules.baijiale.view
{
    import flash.events.*;
    import modules.baijiale.model.events.*;
    import modules.gamePlatform.model.events.*;
    import modules.baijiale.view.events.*;
    import modules.baijiale.model.*;
    import modules.baijiale.service.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;
    import flash.external.*;

    public class GameInterfaceViewMediator extends ModuleMediator 
    {

        [Inject]
        public var gameDataModel:GameDataModel;
        [Inject]
        public var gameSeatList:GameSeatListModel;
        [Inject]
        public var userInfo:UserInfoModel;
        [Inject]
        public var baijialeUser:BaijialeUserModel;
        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var fmsBaijiale:FMSBaijialeService;


        private function get view():GameInterfaceView
        {
            return ((viewComponent as GameInterfaceView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(BaijialeUserModelEvent.UP_USER_MONEY, this.upUserMoney);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            removeContextListener(GameSeatListModelEvent.UP_GROUP, this.upCurrentGroup);
            removeContextListener(BaijialeUserModelEvent.INJECT_MONEY_OK, this.injectMoneyOK);
            removeContextListener(GameDataModelEvent.UP_GAME_NOTICE, this.upGameNotice);
            this.gameModel.eventDispatcher.removeEventListener(GamePlatformModelEvent.REFRESH_MONEY_RESULT, this.amfRefreshMoney);
            this.view.removeEventListener(GameInterfaceViewEvent.BACK_ROOM, this.backRoom);
            this.view.removeEventListener(GameInterfaceViewEvent.GAME_RECORD, this.gameRecord);
            this.view.removeEventListener(GameInterfaceViewEvent.GAME_RULES, this.gameRules);
            this.view.removeEventListener(GameInterfaceViewEvent.SEAT_SELECT, this.seatSelect);
            this.view.removeEventListener(GameInterfaceViewEvent.SYSTEM, this.systemPanel);
            this.view.removeEventListener(GameInterfaceViewEvent.UP_SIMULATIONS_PANEL, this.simulationsPanel);
            this.view.removeEventListener("goMyGroup", this.goMyGroup);
            this.view.removeEventListener("gotoGroup", this.gotoGroup);
            this.view.removeEventListener("pGroup", this.pGroup);
            this.view.removeEventListener("nGroup", this.nGroup);
            this.view.removeEventListener("showGameLeftList", this.showGameLeftList);
            this.view.removeEventListener("recharge", this.recharge);
            this.view.removeEventListener("refreshMoney", this.refreshMoney);
            this.view.BBS_mc.Unload();
            this.view.dispose();
        }

        override public function onRegister():void
        {
            addContextListener(BaijialeUserModelEvent.UP_USER_MONEY, this.upUserMoney);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            addContextListener(GameSeatListModelEvent.UP_GROUP, this.upCurrentGroup);
            addContextListener(BaijialeUserModelEvent.INJECT_MONEY_OK, this.injectMoneyOK);
            addContextListener(GameDataModelEvent.UP_GAME_NOTICE, this.upGameNotice);
            this.gameModel.eventDispatcher.addEventListener(GamePlatformModelEvent.REFRESH_MONEY_RESULT, this.amfRefreshMoney);
            this.view.addEventListener(GameInterfaceViewEvent.BACK_ROOM, this.backRoom);
            this.view.addEventListener(GameInterfaceViewEvent.GAME_RECORD, this.gameRecord);
            this.view.addEventListener(GameInterfaceViewEvent.GAME_RULES, this.gameRules);
            this.view.addEventListener(GameInterfaceViewEvent.SEAT_SELECT, this.seatSelect);
            this.view.addEventListener(GameInterfaceViewEvent.SYSTEM, this.systemPanel);
            this.view.addEventListener(GameInterfaceViewEvent.UP_SIMULATIONS_PANEL, this.simulationsPanel);
            this.view.addEventListener("goMyGroup", this.goMyGroup);
            this.view.addEventListener("gotoGroup", this.gotoGroup);
            this.view.addEventListener("pGroup", this.pGroup);
            this.view.addEventListener("nGroup", this.nGroup);
            this.view.addEventListener("showGameLeftList", this.showGameLeftList);
            this.view.addEventListener("recharge", this.recharge);
            this.view.addEventListener("refreshMoney", this.refreshMoney);
            this.initGameInfo();
            this.view.addToStage();
            this.view.BBS_mc.reStart();
        }

        private function amfRefreshMoney(_arg1:GamePlatformModelEvent):void
        {
            this.userInfo.userMoney = Number(_arg1.data);
            this.view.text_userMoney.text = String(_arg1.data);
        }

        private function refreshMoney(_arg1:Event):void
        {
            this.fmsBaijiale.refreshMoney();
        }

        private function recharge(_arg1:Event):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("recharge");
            };
        }

        protected function showGameLeftList(_arg1:Event):void
        {
            this.baijialeModel.showAllRoutePanel();
        }

        private function injectMoneyOK(_arg1:BaijialeUserModelEvent):void
        {
            this.view.text_userMoney.text = String(this.userInfo.userMoney);
        }

        private function upUserMoney(_arg1:BaijialeUserModelEvent):void
        {
            this.view.text_userMoney.text = String(this.userInfo.userMoney);
        }

        private function upCurrentGroup(_arg1:GameSeatListModelEvent):void
        {
            this.view.text_groupNum.text = ("" + this.gameSeatList.currentGroupNum);
        }

        protected function nGroup(_arg1:Event):void
        {
            this.gameSeatList.nextGroup();
        }

        protected function pGroup(_arg1:Event):void
        {
            this.gameSeatList.previousGroup();
        }

        protected function gotoGroup(_arg1:Event):void
        {
            this.gameSeatList.setGroup(Number(this.view.text_groupNum.text));
        }

        protected function goMyGroup(_arg1:Event):void
        {
            this.gameSeatList.gotoUserGroup();
        }

        protected function backRoom(_arg1:GameInterfaceViewEvent):void
        {
            this.baijialeModel.backRoom();
        }

        protected function gameRecord(_arg1:GameInterfaceViewEvent):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("showGameLog", this.userInfo.userid, this.userInfo.userpsw);
            };
        }

        protected function gameRules(_arg1:GameInterfaceViewEvent):void
        {
            this.baijialeModel.gameRules();
        }

        protected function seatSelect(_arg1:GameInterfaceViewEvent):void
        {
            this.baijialeModel.seatSelect();
        }

        protected function systemPanel(_arg1:GameInterfaceViewEvent):void
        {
            this.baijialeModel.systemPanel();
        }

        protected function simulationsPanel(_arg1:GameInterfaceViewEvent):void
        {
            this.baijialeModel.simulationsPanel(_arg1.data);
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
            this.upViewText();
        }

        private function initGameInfo(_arg1:GameDataModelEvent=null):void
        {
            this.upViewText();
        }

        public function upViewText():void
        {
            var _local1:Array;
            if (this.gameDataModel.gameid)
            {
                this.view.text_gameid.text = this.gameDataModel.gameid;
            };
            if (this.gameDataModel.gameNumber)
            {
                this.view.text_gameNumber.text = this.gameDataModel.gameNumber;
            };
            if (this.gameDataModel.roundNum)
            {
                this.view.text_round.text = (this.gameDataModel.roundNum + "");
            };
            if (this.userInfo.userid)
            {
                this.view.text_userid.text = this.userInfo.userid;
            };
            if (this.userInfo.userMoney)
            {
                this.view.text_userMoney.text = (this.userInfo.userMoney + "");
            };
            if (this.gameModel.waitGameModel.moneyTypeGroup)
            {
                _local1 = this.gameModel.waitGameModel.moneyTypeGroup.split("_");
            };
            if (uint(this.gameDataModel.gameid) > 80)
            {
                this.view.text_limitMin.text = _local1[0];
                this.view.text_limitMax.text = _local1[1];
            }
            else
            {
                this.view.text_limitMax.text = String(this.gameDataModel.telMax);
                this.view.text_limitMin.text = String(this.gameDataModel.telMin);
            };
        }

        public function upViewTimeText():void
        {
        }

        private function upGameNotice(_arg1:GameDataModelEvent):void
        {
            this.view.setGameNotice((_arg1.data as String));
        }


    }
}//package modules.baijiale.view
