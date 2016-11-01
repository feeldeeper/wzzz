package modules.baijiale.view
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import com.greensock.*;
    import org.robotlegs.mvcs.*;

    public class TimePanelViewMediator extends Mediator 
    {

        [Inject]
        public var gameData:GameDataModel;
        [Inject]
        public var baijialeModel:BaijialeModel;


        private function get view():TimePanelView
        {
            return ((viewComponent as TimePanelView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GameDataModelEvent.UP_TIME, this.upTime);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            removeContextListener(GameDataModelEvent.UP_GAME_FARMER, this.gameFarmer);
            removeContextListener(GameDataModelEvent.UP_GAME_RESULTS, this.upGameResults);
            removeContextListener(BaijialeModelEvent.GAME_INFO_PANEL_SHOW, this.showInfoPanel);
            eventDispatcher.removeEventListener(BaijialeModelEvent.GAME_BETING_STATE, this.upBeting);
            eventDispatcher.removeEventListener(BaijialeUserModelEvent.INJECT_MONEY_OK, this.upSuccessfulBet);
            eventDispatcher.removeEventListener(BaijialeUserModelEvent.INJECT_MONEY_ERROR, this.upErrorBet);
            TweenMax.killDelayedCallsTo(this.successfulBet);
            this.view.dispose();
        }

        override public function onRegister():void
        {
            addContextListener(GameDataModelEvent.UP_TIME, this.upTime);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            addContextListener(GameDataModelEvent.UP_GAME_FARMER, this.gameFarmer);
            addContextListener(GameDataModelEvent.UP_GAME_RESULTS, this.upGameResults);
            addContextListener(BaijialeModelEvent.GAME_INFO_PANEL_SHOW, this.showInfoPanel);
            eventDispatcher.addEventListener(BaijialeModelEvent.GAME_BETING_STATE, this.upBeting);
            eventDispatcher.addEventListener(BaijialeUserModelEvent.INJECT_MONEY_OK, this.upSuccessfulBet);
            eventDispatcher.addEventListener(BaijialeUserModelEvent.INJECT_MONEY_ERROR, this.upErrorBet);
            this.view.addToStage();
        }

        private function showInfoPanel(_arg1:BaijialeModelEvent):void
        {
            this.view.playResultsInfoMc(_arg1.data.info);
        }

        private function upSuccessfulBet(_arg1:BaijialeUserModelEvent):void
        {
            TweenMax.delayedCall(1.5, this.successfulBet);
        }

        private function successfulBet():void
        {
            this.view.playResultsInfoMc("successfulBet");
            this.baijialeModel.playSoundRsl("ChipInOk");
        }

        private function upErrorBet(_arg1:BaijialeUserModelEvent):void
        {
            this.view.playResultsInfoMc("betError");
            this.baijialeModel.playSoundRsl("ChipError");
        }

        private function upBeting(_arg1:BaijialeModelEvent):void
        {
            this.view.playResultsInfoMc("beting");
        }

        private function upGameResults(_arg1:GameDataModelEvent):void
        {
            this.view.upGameResults(_arg1.data);
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
            this.view.upGameState(this.gameData.gameState);
        }

        private function gameFarmer(_arg1:GameDataModelEvent):void
        {
            this.view.farmerBool = this.gameData.farmerBool;
        }

        private function initGameInfo(_arg1:GameDataModelEvent):void
        {
            this.view.farmerBool = this.gameData.farmerBool;
        }

        private function upTime(_arg1:GameDataModelEvent):void
        {
            if (this.gameData.gameState == 1)
            {
                this.view.showTime(this.gameData.time);
                if ((((this.gameData.time < 10)) && ((this.gameData.time >= 0))))
                {
                    this.baijialeModel.playSoundRsl("DI");
                };
            }
            else
            {
                this.view.showTime(0);
            };
        }


    }
}//package modules.baijiale.view
