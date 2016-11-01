package modules.baijiale.view
{
    import modules.gamePlatform.model.vo.*;
    import flash.events.*;
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import com.greensock.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;

    public class SimulationsViewMediator extends ModuleMediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var gameDataModel:GameDataModel;
        [Inject]
        public var baijialeModel:BaijialeModel;


        private function get view():SimulationsView
        {
            return ((viewComponent as SimulationsView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            removeContextListener(GameDataModelEvent.UP_GAME_HISTORY, this.upGameHistory);
            removeContextListener(GameDataModelEvent.UP_TIME, this.upTime);
            removeContextListener(GameDataModelEvent.UP_GAME_DEAL, this.upGameDeal);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            removeContextListener(BaijialeModelEvent.SHOW_ALL_ROUTE_PANEL, this.showAllRoutePanel);
            this.view.removeEventListener("gotoRouteBoxTable", this.gotoRouteBoxTable);
            eventDispatcher.removeEventListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.gameCloseFun);
            this.gameCloseFun();
            this.view.dispose();
        }

        override public function onRegister():void
        {
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            addContextListener(GameDataModelEvent.UP_GAME_HISTORY, this.upGameHistory);
            addContextListener(GameDataModelEvent.UP_TIME, this.upTime);
            addContextListener(GameDataModelEvent.UP_GAME_DEAL, this.upGameDeal);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            addContextListener(BaijialeModelEvent.SHOW_ALL_ROUTE_PANEL, this.showAllRoutePanel);
            this.view.addEventListener("gotoRouteBoxTable", this.gotoRouteBoxTable);
            eventDispatcher.addEventListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.gameCloseFun);
            this.view.addToStage();
        }

        private function initGameInfo(_arg1:GameDataModelEvent=null):void
        {
            var _local4:GameTableVO;
            var _local2:Array = new Array();
            if (this.baijialeModel.currentGameTable == null)
            {
                return;
            };
            var _local3:int;
            while (_local3 < this.gameModel.tableList.length)
            {
                _local4 = (this.gameModel.tableList[_local3] as GameTableVO);
                _local2.push(_local4);
                _local3++;
            };
        }

        private function showAllRoutePanel(_arg1:BaijialeModelEvent):void
        {
            var _local4:GameTableVO;
            var _local2:Array = new Array();
            if (this.baijialeModel.currentGameTable == null)
            {
                return;
            };
            var _local3:int;
            while (_local3 < this.gameModel.tableList.length)
            {
                _local4 = (this.gameModel.tableList[_local3] as GameTableVO);
                if (_local4.gameType == "baijiale")
                {
                    _local2.push(_local4);
                };
                _local3++;
            };
            this.view.initRouteListPanel(_local2);
        }

        private function upTime(_arg1:GameDataModelEvent):void
        {
            this.view.upTime();
        }

        private function upGameDeal(_arg1:GameDataModelEvent):void
        {
            if (this.gameDataModel.gameState == 2)
            {
                if (uint(this.baijialeModel.currentGameTable.gameid) > 80)
                {
                    TweenMax.delayedCall(1, this.view.showMask);
                };
            };
        }

        private function upGameHistory(_arg1:GameDataModelEvent):void
        {
            this.view.showHistory(_arg1.data);
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
            if (this.gameDataModel.gameState != 2)
            {
                TweenMax.delayedCall(4, this.view.showMask, [false]);
            };
        }

        private function gameCloseFun(_arg1:BaijialeModelEvent=null):void
        {
            TweenMax.killDelayedCallsTo(this.view.showMask);
            this.view.showMask(false, 0);
        }

        private function gotoRouteBoxTable(_arg1:Event):void
        {
            var _local2:GameTableVO = this.gameModel.tableList[(this.view.gotoRouteBoxTableID + 1)];
            this.gameModel.gotoGame(_local2);
        }


    }
}//package modules.baijiale.view
