package modules.baijiale.view
{
    import flash.events.*;
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class TotalPotPanelViewMediator extends Mediator 
    {

        [Inject]
        public var gameDataModel:GameDataModel;
        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var userInfo:UserInfoModel;
        [Inject]
        public var gamePlatformModel:GamePlatformModel;


        private function get view():TotalPotPanelView
        {
            return ((viewComponent as TotalPotPanelView));
        }

        override public function onRegister():void
        {
            addContextListener(GameDataModelEvent.GAME_ALL_INJECT, this.gameAllInject);
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            addContextListener(GameDataModelEvent.UP_LIMIT_INFO, this.upLimitInfo);
            this.view.setServerLine(this.gamePlatformModel.serverLine);
            this.view.addEventListener("upServerLineSelect", this.upServerLineSelect);
        }

        private function upServerLineSelect(_arg1:Event):void
        {
            var _local2:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.UP_SERVER_LINE_SELECT);
            _local2.data = this.view.serverLineID;
            eventDispatcher.dispatchEvent(_local2);
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
            this.view.upGameState({
                "gameState":this.gameDataModel.gameState,
                "gameTableName":this.gameDataModel.gameTableName,
                "gameBoot":this.gameDataModel.gameBoot,
                "roundNum":this.gameDataModel.roundNum,
                "gameNumber":this.gameDataModel.gameNumber
            });
        }

        private function upLimitInfo(_arg1:GameDataModelEvent):void
        {
            if (!(((((uint(this.baijialeModel.currentGameTable.gameid) > 80)) || ((this.userInfo.chipModel == "custom")))) || ((this.userInfo.chipModel == "default"))))
            {
                this.view.updateLimit(_arg1.data);
            };
        }

        private function gameAllInject(_arg1:GameDataModelEvent):void
        {
            this.view.gameAllInject(_arg1.data);
        }

        private function initGameInfo(_arg1:GameDataModelEvent):void
        {
            var _local2:Array;
            if (this.gamePlatformModel.waitGameModel.moneyTypeGroup)
            {
                _local2 = this.gamePlatformModel.waitGameModel.moneyTypeGroup.split("_");
            };
            if ((((uint(this.baijialeModel.currentGameTable.gameid) > 80)) && ((this.userInfo.chipModel == "custom"))))
            {
                this.view.updateLimit({
                    "telMax":_local2[1],
                    "telMin":_local2[0]
                });
            }
            else
            {
                this.view.updateLimit(_arg1.data);
            };
            if (this.userInfo.chipModel == "default")
            {
                this.view.updateLimit({
                    "telMax":_local2[1],
                    "telMin":_local2[0]
                });
            };
            if (uint(this.baijialeModel.currentGameTable.gameid) > 80)
            {
                this.view.videoModel = true;
            }
            else
            {
                this.view.videoModel = false;
            };
            this.view.selectModel();
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GameDataModelEvent.GAME_ALL_INJECT, this.gameAllInject);
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            removeContextListener(GameDataModelEvent.UP_LIMIT_INFO, this.upLimitInfo);
            this.view.removeEventListener("upServerLineSelect", this.upServerLineSelect);
            this.view.dispose();
        }


    }
}//package modules.baijiale.view
