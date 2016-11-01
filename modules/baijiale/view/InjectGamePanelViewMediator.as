package modules.baijiale.view
{
    import flash.events.*;
    import modules.baijiale.model.events.*;
    import modules.baijiale.service.events.*;
    import modules.baijiale.view.events.*;
    import modules.baijiale.model.*;
    import modules.baijiale.service.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class InjectGamePanelViewMediator extends Mediator 
    {

        [Inject]
        public var gameDataModel:GameDataModel;
        [Inject]
        public var gamePlatformModel:GamePlatformModel;
        [Inject]
        public var fmsBaijiale:FMSBaijialeService;
        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var userInfo:UserInfoModel;


        private function get view():InjectGamePanelView
        {
            return ((viewComponent as InjectGamePanelView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            removeContextListener(BaijialeUserModelEvent.UP_USER_MONEY, this.upUserMoney);
            removeContextListener(BaijialeUserModelEvent.INJECT_MONEY_OK, this.injectMoneyOK);
            removeContextListener(BaijialeUserModelEvent.INJECT_MONEY_ERROR, this.injectMoneyError);
            removeContextListener(BaijialeUserModelEvent.INIT_USER_DATA, this.initUserData);
            removeContextListener(GameDataModelEvent.UP_GAME_RESULTS, this.upGameResults);
            removeContextListener(FMSBaijialeServiceEvent.CALL_FMS_ERROR, this.callFmsError);
            removeContextListener(FMSBaijialeServiceEvent.LINK_CLOSE, this.linkClose);
            removeContextListener(GameDataModelEvent.GAME_ALL_INJECT, this.gameAllInject);
            this.view.removeEventListener(InjectGamePanelViewEvent.INJECT_MONEY, this.injectMoneyToServer);
            this.view.removeEventListener(BaijialeModelEvent.GAME_INFO_PANEL_SHOW, this.showInfoPanel);
            this.view.removeEventListener(BaijialeModelEvent.GAME_SOUND_PLAYERBYNAME, this.soundPlay);
            this.view.removeEventListener("noBet", this.noBetFun);
            this.view.dispose();
        }

        override public function onRegister():void
        {
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            addContextListener(BaijialeUserModelEvent.UP_USER_MONEY, this.upUserMoney);
            addContextListener(BaijialeUserModelEvent.INJECT_MONEY_OK, this.injectMoneyOK);
            addContextListener(BaijialeUserModelEvent.INJECT_MONEY_ERROR, this.injectMoneyError);
            addContextListener(BaijialeUserModelEvent.INIT_USER_DATA, this.initUserData);
            addContextListener(GameDataModelEvent.UP_GAME_RESULTS, this.upGameResults);
            addContextListener(FMSBaijialeServiceEvent.CALL_FMS_ERROR, this.callFmsError);
            addContextListener(FMSBaijialeServiceEvent.LINK_CLOSE, this.linkClose);
            addContextListener(GameDataModelEvent.GAME_ALL_INJECT, this.gameAllInject);
            this.view.addEventListener(InjectGamePanelViewEvent.INJECT_MONEY, this.injectMoneyToServer);
            this.view.addEventListener(BaijialeModelEvent.GAME_INFO_PANEL_SHOW, this.showInfoPanel);
            this.view.addEventListener(BaijialeModelEvent.GAME_SOUND_PLAYERBYNAME, this.soundPlay);
            this.view.addEventListener("noBet", this.noBetFun);
            this.view.addToStage();
        }

        private function linkClose(_arg1:FMSBaijialeServiceEvent):void
        {
            this.view.btnClose();
        }

        private function callFmsError(_arg1:FMSBaijialeServiceEvent):void
        {
            switch (_arg1.data.msg)
            {
                case "betLimit":
                    this.view.injectMoneyError(_arg1.data);
                    this.baijialeModel.showInfoPanel("upper");
                    this.baijialeModel.playSoundRsl("ChipError");
                    return;
            };
        }

        private function noBetFun(_arg1:Event):void
        {
            if (uint(this.gameDataModel.gameid) >= 80)
            {
                this.baijialeModel.noBetBackRoom();
            };
        }

        private function upGameResults(_arg1:GameDataModelEvent):void
        {
            this.view.upGameResults(_arg1.data);
        }

        private function initUserData(_arg1:BaijialeUserModelEvent):void
        {
            var _local2:Array;
            this.view.initUserData(_arg1.userData);
            if (this.gamePlatformModel.waitGameModel.moneyTypeGroup)
            {
                _local2 = this.gamePlatformModel.waitGameModel.moneyTypeGroup.split("_");
            };
            if ((((uint(this.baijialeModel.currentGameTable.gameid) > 80)) && ((this.userInfo.chipModel == "custom"))))
            {
                this.view.limitMin = uint(_local2[0]);
                this.view.limitMax = uint(_local2[1]);
				this.view.tieMax = this.gameDataModel.telTieMax;
				this.view.pairMax = this.gameDataModel.telPairMax;
				this.view.diffMax = this.gameDataModel.telDiffMax;
            }
            else
            {
                this.view.limitMin = this.gameDataModel.telMin;
                this.view.limitMax = this.gameDataModel.telMax;
				this.view.tieMax = this.gameDataModel.telTieMax;
				this.view.pairMax = this.gameDataModel.telPairMax;
				this.view.diffMax = this.gameDataModel.telDiffMax;
            };
            if (this.userInfo.chipModel == "default")
            {
                this.view.limitMin = uint(_local2[0]);
                this.view.limitMax = uint(_local2[1]);
				this.view.tieMax = this.gameDataModel.telTieMax;
				this.view.pairMax = this.gameDataModel.telPairMax;
				this.view.diffMax = this.gameDataModel.telDiffMax;
            };
        }

        protected function injectMoneyToServer(_arg1:InjectGamePanelViewEvent):void
        {
            var _local2:Object;
            if (this.view.gameState == 1)
            {
                _local2 = new Object();
                _local2.inject = this.view.getInjectMoneyData();
                _local2.rateType = this.baijialeModel.currentGameTable.rateType;
                if (_local2.inject)
                {
                    this.fmsBaijiale.injectMoney(_local2);
                    this.baijialeModel.gameInjectMoneying();
                };
            };
        }

        private function injectMoneyError(_arg1:BaijialeUserModelEvent):void
        {
            this.view.injectMoneyError(_arg1.data);
        }

        private function injectMoneyOK(_arg1:BaijialeUserModelEvent):void
        {
            this.view.injectMoneyOK(_arg1.data);
        }

        private function initGameInfo(_arg1:GameDataModelEvent):void
        {
            this.view.noBetnum = 0;
            if (((((!((_arg1.data.customChipArr == undefined))) && ((uint(this.baijialeModel.currentGameTable.gameid) < 800)))) && ((this.userInfo.chipModel == "custom"))))
            {
                if (_arg1.data.customChipArr.length > 0)
                {
                    this.view.initInjectMoneyBtn(_arg1.data.customChipArr);
                };
            }
            else
            {
                this.view.initInjectMoneyBtn(this.gamePlatformModel.waitGameModel.moneyGroup);
            };
            this.view.setTableVO(this.baijialeModel.currentGameTable);
            this.view.tipsLimitInfo.max = _arg1.data.telMax;
            this.view.tipsLimitInfo.min = _arg1.data.telMin;
            if (this.gameDataModel.gameState == 1)
            {
                this.view.btnOpen();
            }
            else
            {
                this.view.btnClose();
            };
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
            this.view.setGameState(this.gameDataModel.gameState);
        }

        private function showInfoPanel(_arg1:BaijialeModelEvent):void
        {
            this.baijialeModel.showInfoPanel(_arg1.data.info);
            switch (_arg1.data.info)
            {
                case "lower":
                case "upper":
                case "noMoney":
                    this.baijialeModel.playSoundRsl("ChipError");
                    return;
            };
        }

        private function soundPlay(_arg1:BaijialeModelEvent):void
        {
            if (_arg1.data.rsl == "main")
            {
                this.baijialeModel.playSoundRsl(_arg1.data.name);
            };
        }

        private function upUserMoney(_arg1:BaijialeUserModelEvent):void
        {
            this.view.upUserBalanceMoney(this.userInfo.userMoney);
        }

        private function gameAllInject(_arg1:GameDataModelEvent):void
        {
            this.view.tipsLimitInfo.z = _arg1.data.z;
            this.view.tipsLimitInfo.x = _arg1.data.x;
            this.view.tipsLimitInfo.h = _arg1.data.h;
            this.view.tipsLimitInfo.zd = _arg1.data.zd;
            this.view.tipsLimitInfo.xd = _arg1.data.xd;
        }


    }
}//package modules.baijiale.view
