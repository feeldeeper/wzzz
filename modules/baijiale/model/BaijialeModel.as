package modules.baijiale.model
{
    import modules.gamePlatform.model.vo.*;
    import modules.baijiale.model.events.*;
    import modules.gamePlatform.model.events.*;
    import modules.baijiale.service.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;
    import flash.external.*;

    public class BaijialeModel extends ModuleActor 
    {

        [Inject]
        public var gameData:GameDataModel;
        [Inject]
        public var fmsBaijialeService:FMSBaijialeService;
        [Inject]
        public var videoService:VideoBaijialeService;
        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        private var userInfo:UserInfoModel;
        private var _currentGameTable:GameTableVO;


        public function modelInit():void
        {
            moduleEventDispatcher.addEventListener(GamePlatformModelEvent.GAME_STATE, this.roomGameState);
            moduleEventDispatcher.addEventListener(GamePlatformModelEvent.GAME_HISTORY, this.roomGameHistory);
            moduleEventDispatcher.addEventListener(GamePlatformModelEvent.GAME_OTHER_USER_LOGIN, this.otherUserLogin);
        }

        public function dispose():void
        {
            this.fmsBaijialeService.close();
            this.videoService.close();
            moduleEventDispatcher.removeEventListener(GamePlatformModelEvent.GAME_STATE, this.roomGameState);
            moduleEventDispatcher.removeEventListener(GamePlatformModelEvent.GAME_HISTORY, this.roomGameHistory);
            moduleEventDispatcher.removeEventListener(GamePlatformModelEvent.GAME_OTHER_USER_LOGIN, this.otherUserLogin);
        }

        private function roomGameHistory(_arg1:GamePlatformModelEvent):void
        {
            var _local2:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.ROOM_GAME_HISTORY);
            _local2.table = _arg1.table;
            dispatch(_local2);
        }

        private function roomGameState(_arg1:GamePlatformModelEvent):void
        {
            var _local2:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.ROOM_GAME_STATE);
            _local2.table = _arg1.table;
            dispatch(_local2);
        }

        public function get currentGameTable():GameTableVO
        {
            return (this._currentGameTable);
        }

        public function startLink(_arg1:GameTableVO):void
        {
            this._currentGameTable = _arg1;
        }

        public function closeLink(_arg1:GameTableVO):void
        {
            this._currentGameTable = null;
        }

        public function gameInjectMoneying():void
        {
            eventDispatcher.dispatchEvent(new BaijialeModelEvent(BaijialeModelEvent.GAME_BETING_STATE));
        }

        public function simulationsPanel(_arg1:Object):void
        {
            var _local2:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.UP_SIMULATIONS_PANEL);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function systemPanel():void
        {
            var _local1:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.SYSTEM_PANEL);
            dispatch(_local1);
        }

        public function seatSelect():void
        {
            var _local1:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.SEAT_SELECT_PANEL);
            dispatch(_local1);
        }

        public function gameRules():void
        {
            this.gameModel.showResultPanel("baijiale");
            var _local1:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.GAME_RULES_PANEL);
            dispatch(_local1);
        }

        public function gameRecord():void
        {
            var _local1:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.GAME_RECORD_PANEL);
            dispatch(_local1);
        }

        public function backRoom():void
        {
            this.closeLink(this.currentGameTable);
            this.dispose();
            this.gameModel.gotoPage("gameRoom");
        }

        private function logout():void
        {
            if (ExternalInterface.available)
            {
            };
        }

        public function noBetBackRoom():void
        {
            this.gameModel.showError("超过三局未下注，自动返回至大厅。");
            this.backRoom();
        }

        public function playSoundRsl(_arg1:String):void
        {
            this.gameModel.playSoundRsl(_arg1);
        }

        public function showInfoPanel(_arg1:String):void
        {
            var _local2:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.GAME_INFO_PANEL_SHOW);
            _local2.data = {"info":_arg1};
            dispatch(_local2);
        }

        public function showAllRoutePanel():void
        {
            var _local1:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.SHOW_ALL_ROUTE_PANEL);
            dispatch(_local1);
        }

        private function otherUserLogin(_arg1:GamePlatformModelEvent):void
        {
            this.backRoom();
        }


    }
}//package modules.baijiale.model
