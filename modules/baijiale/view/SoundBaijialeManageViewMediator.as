package modules.baijiale.view
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class SoundBaijialeManageViewMediator extends Mediator 
    {

        [Inject]
        public var gameData:GameDataModel;
        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var gamePlatformModel:GamePlatformModel;


        private function get view():SoundBaijialeManageView
        {
            return ((viewComponent as SoundBaijialeManageView));
        }

        override public function onRegister():void
        {
            addContextListener(GameDataModelEvent.UP_GAME_DEAL, this.upGameDeal);
            addContextListener(GameDataModelEvent.UP_GAME_RESULTS, this.upGameResults);
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            eventDispatcher.addEventListener(BaijialeModelEvent.GAME_SOUND_BANKADDPOKER, this.upBankAddPoker);
            eventDispatcher.addEventListener(BaijialeModelEvent.GAME_SOUND_PLAYERADDPOKER, this.upPlayerAddPoker);
            eventDispatcher.addEventListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.gameCloseFun);
            if (this.view.rslInit == false)
            {
                this.view.initLoad(this.gamePlatformModel.httpUrl);
            };
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.dispose();
            removeContextListener(GameDataModelEvent.UP_GAME_DEAL, this.upGameDeal);
            removeContextListener(GameDataModelEvent.UP_GAME_RESULTS, this.upGameResults);
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            eventDispatcher.removeEventListener(BaijialeModelEvent.GAME_SOUND_BANKADDPOKER, this.upBankAddPoker);
            eventDispatcher.removeEventListener(BaijialeModelEvent.GAME_SOUND_PLAYERADDPOKER, this.upPlayerAddPoker);
            eventDispatcher.removeEventListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.gameCloseFun);
        }

        private function initGameInfo(_arg1:GameDataModelEvent=null):void
        {
            this.view.gameID = uint(this.baijialeModel.currentGameTable.gameid);
        }

        private function upBankAddPoker(_arg1:BaijialeModelEvent):void
        {
            this.view.playSoundByName("Bankerdrawcard");
        }

        private function upPlayerAddPoker(_arg1:BaijialeModelEvent):void
        {
            this.view.playSoundByName("Playerdrawcard");
        }

        private function upGameResults(_arg1:GameDataModelEvent):void
        {
            this.view.upGameResults(_arg1.data);
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
            switch (this.gameData.gameState)
            {
                case 2:
                    this.baijialeModel.playSoundRsl("BettingStopped");
                    return;
                case 1:
                    this.baijialeModel.playSoundRsl("BettingStarted");
                    return;
            };
        }

        private function upGameDeal(_arg1:GameDataModelEvent):void
        {
            var _local2:Object;
            if (this.gameData.gameState == 2)
            {
                _local2 = _arg1.data;
                this.view.upGameDeal(_local2);
            };
        }

        private function gameCloseFun(_arg1:BaijialeModelEvent):void
        {
            this.view.dispose();
        }


    }
}//package modules.baijiale.view
