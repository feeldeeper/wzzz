package modules.baijiale.view
{
    import modules.gamePlatform.model.vo.*;
    import modules.baijiale.model.events.*;
    import modules.baijiale.view.events.*;
    import modules.baijiale.model.*;
    import modules.gamePlatform.service.events.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;

    public class GotoGameTableListViewMediator extends ModuleMediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var userInfo:UserInfoModel;
        private var gotoNum:uint = 0;


        private function get view():GotoGameTableListView
        {
            return ((viewComponent as GotoGameTableListView));
        }

        override public function onRegister():void
        {
            addContextListener(BaijialeModelEvent.ROOM_GAME_HISTORY, this.roomGameHistory);
            addContextListener(BaijialeModelEvent.ROOM_GAME_STATE, this.roomGameState);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            this.view.addEventListener(GotoGameTableListViewEvent.GOTO_TABLE, this.gotoTable);
            this.view.addEventListener(GotoGameTableListViewEvent.UP_TABLE, this.upTable);
            this.view.addToStage();
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(BaijialeModelEvent.ROOM_GAME_HISTORY, this.roomGameHistory);
            removeContextListener(BaijialeModelEvent.ROOM_GAME_STATE, this.roomGameState);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            this.view.removeEventListener(GotoGameTableListViewEvent.GOTO_TABLE, this.gotoTable);
            this.view.removeEventListener(GotoGameTableListViewEvent.UP_TABLE, this.upTable);
            this.view.dispose();
        }

        private function initGameInfo(_arg1:GameDataModelEvent=null):void
        {
            var _local4:GameTableVO;
            if (this.baijialeModel.currentGameTable == null)
            {
                return;
            };
            var _local2:Array = new Array();
            var _local3:int;
            while (_local3 < this.gameModel.tableList.length)
            {
                _local4 = (this.gameModel.tableList[_local3] as GameTableVO);
                _local2.push(_local4);
                _local3++;
            };
            this.view.initTableBox(_local2, this.baijialeModel.currentGameTable);
        }

        private function roomGameState(_arg1:BaijialeModelEvent):void
        {
        }

        private function roomGameHistory(_arg1:BaijialeModelEvent):void
        {
        }

        private function gameloadComplete(_arg1:GameLoadServiceEvent):void
        {
            var _local2:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.GAME_HIDE_SERVERLINK);
            eventDispatcher.dispatchEvent(_local2);
            if (this.view)
            {
                this.gotoNum++;
                if (this.gotoNum > 3)
                {
                    return;
                };
                if (this.checkLimit() == true)
                {
                    return;
                };
                this.gameModel.gotoGame(this.view.currentTable);
            };
            this.gameModel.eventDispatcher.removeEventListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameloadComplete);
        }

        protected function upTable(_arg1:GotoGameTableListViewEvent):void
        {
        }

        protected function gotoTable(_arg1:GotoGameTableListViewEvent):void
        {
            var _local2:BaijialeModelEvent;
            if (this.baijialeModel.currentGameTable != this.view.currentTable)
            {
                _local2 = new BaijialeModelEvent(BaijialeModelEvent.GAME_SHOW_SERVERLINK);
                eventDispatcher.dispatchEvent(_local2);
                if (this.gameModel.isExitGame(this.view.currentTable) == false)
                {
                    this.gameModel.eventDispatcher.addEventListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameloadComplete);
                    if (this.checkLimit() == true)
                    {
                        return;
                    };
                    this.gameModel.gotoGame(this.view.currentTable);
                }
                else
                {
                    if (this.checkLimit() == true)
                    {
                    };
                    this.gameModel.gotoGame(this.view.currentTable);
                };
            };
        }

        private function checkLimit():Boolean
        {
            if ((((uint(this.view.currentTable.gameid) > 80)) && ((this.userInfo.chipModel == "custom"))))
            {
                if (this.gameModel.waitGameModel.moneyTypeGroup)
                {
                    return (false);
                };
                this.gameModel.showError("台号80以上为电子台，必须从大厅【急速百家乐/龙虎】选择个人限红才能进入，选择一次即可。");
                this.baijialeModel.backRoom();
                return (true);
            };
            return (false);
        }


    }
}//package modules.baijiale.view
