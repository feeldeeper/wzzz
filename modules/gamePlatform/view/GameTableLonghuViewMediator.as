package modules.gamePlatform.view
{
    import flash.events.*;
    import modules.gamePlatform.view.events.*;
    import modules.gamePlatform.model.events.*;
    import modules.gamePlatform.service.events.*;
    import modules.gamePlatform.model.vo.events.*;
    import modules.gamePlatform.model.vo.*;
    import modules.gamePlatform.model.*;

    public class GameTableLonghuViewMediator extends GameTableViewMediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var userInfo:UserInfoModel;


        private function get view():GameTableLonghuView
        {
            return ((viewComponent as GameTableLonghuView));
        }

        override public function onRegister():void
        {
            super.onRegister();
            if (this.view.tableVO)
            {
                this.addTableVO();
            }
            else
            {
                this.view.addEventListener(GameTableViewEvent.ADD_TABLEVO, this.addTableVO);
            };
            addContextListener(GameLoadServiceEvent.GAME_LOAD_START, this.gameLoadStart);
            addContextListener(GameLoadServiceEvent.GAME_PROGRESS, this.gameProgress);
            addContextListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameLoaded);
            addContextListener(GamePlatformModelEvent.WAIT_GOTO_GAME, this.waitGotoGame);
            addContextListener(GamePlatformModelEvent.GOTO_GAME_END, this.gotoGameEnd);
            this.view.addEventListener(GameTableViewEvent.TABLE_WAIT_GOTO_GAME, this.tableWaitGoToGame);
            this.view.addEventListener(GameTableViewEvent.GOTO_GAME_MONEYGROUP, this.gotoGameByMoneyGroup);
            this.view.upFarmer();
            this.view.upGameState();
            this.view.upGameHistory();
            this.view.upTime();
            this.view.addEventListener("showRule", this.showRuleFun);
        }

        override public function onRemove():void
        {
            super.onRemove();
            if (this.view.tableVO)
            {
                this.view.tableVO.removeEventListener(GameTableVOEvent.UP_FARMER, this.upFarmer);
                this.view.tableVO.removeEventListener(GameTableVOEvent.UP_GAMESTATE, this.upGameState);
                this.view.tableVO.removeEventListener(GameTableVOEvent.UP_GAME_HISTORY, this.upGameHistory);
                this.view.tableVO.removeEventListener(GameTableVOEvent.UP_TIME, this.upTime);
            }
            else
            {
                this.view.removeEventListener(GameTableViewEvent.ADD_TABLEVO, this.addTableVO);
            };
            removeContextListener(GameLoadServiceEvent.GAME_LOAD_START, this.gameLoadStart);
            removeContextListener(GameLoadServiceEvent.GAME_PROGRESS, this.gameProgress);
            removeContextListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameLoaded);
            removeContextListener(GamePlatformModelEvent.WAIT_GOTO_GAME, this.waitGotoGame);
            removeContextListener(GamePlatformModelEvent.GOTO_GAME_END, this.gotoGameEnd);
            this.view.removeEventListener(GameTableViewEvent.TABLE_WAIT_GOTO_GAME, this.tableWaitGoToGame);
            this.view.removeEventListener(GameTableViewEvent.GOTO_GAME_MONEYGROUP, this.gotoGameByMoneyGroup);
            this.view.removeEventListener("showRule", this.showRuleFun);
            this.view.dispose();
        }

        protected function addTableVO(_arg1:GameTableViewEvent=null):void
        {
            this.view.initTable();
            this.view.tableVO.addEventListener(GameTableVOEvent.UP_FARMER, this.upFarmer);
            this.view.tableVO.addEventListener(GameTableVOEvent.UP_GAMESTATE, this.upGameState);
            this.view.tableVO.addEventListener(GameTableVOEvent.UP_GAME_HISTORY, this.upGameHistory);
            this.view.tableVO.addEventListener(GameTableVOEvent.UP_TIME, this.upTime);
        }

        private function gotoGameEnd(_arg1:GamePlatformModelEvent):void
        {
            this.view.hitWaitPanel();
            this.view.hitLoad();
        }

        protected function gotoGameByMoneyGroup(_arg1:GameTableViewEvent):void
        {
            var _local2:Object = {};
            _local2.moneyTypeGroup = _arg1.moneyTypeGroup;
            _local2.gameType = this.view.tableVO.gameType;
            this.gameModel.waitGameModel.setWaitInGameObject(_local2);
            if (this.userInfo.chipModel == "default")
            {
                this.gameModel.gotoGame(this.view.tableVO);
            }
            else
            {
                this.gameModel.gotoGame(this.view.tableVO);
            };
        }

        protected function tableWaitGoToGame(_arg1:Event):void
        {
            var _local2:Boolean = this.gameModel.loadGame(this.view.tableVO);
            if (_local2)
            {
                this.gameModel.waitGotoGame(this.view.tableVO);
            };
        }

        private function waitGotoGame(_arg1:GamePlatformModelEvent):void
        {
            var _local2:GameMoneyGroup;
            if (_arg1.table == this.view.tableVO)
            {
                _local2 = (this.gameModel.waitGameModel.getMoneyGroup(this.view.tableVO.gameType) as GameMoneyGroup);
                this.view.showWaitPanel(_local2, this.userInfo.chipModel);
            }
            else
            {
                this.view.hitWaitPanel();
            };
        }

        private function gameLoadStart(_arg1:GameLoadServiceEvent):void
        {
            if (_arg1.gameTableVO == this.view.tableVO)
            {
                this.view.startLoad();
            }
            else
            {
                this.view.hitLoad();
            };
        }

        private function gameProgress(_arg1:GameLoadServiceEvent):void
        {
            if (_arg1.gameTableVO == this.view.tableVO)
            {
                this.view.showProgress(_arg1.gameProgress);
            };
        }

        private function gameLoaded(_arg1:GameLoadServiceEvent):void
        {
            if (_arg1.gameTableVO == this.view.tableVO)
            {
                this.view.hitLoad();
                this.gameModel.waitGotoGame(this.view.tableVO);
            };
        }

        protected function upTime(_arg1:GameTableVOEvent):void
        {
            this.view.upTime();
        }

        protected function upGameHistory(_arg1:GameTableVOEvent):void
        {
            this.view.upGameHistory();
        }

        protected function upGameState(_arg1:GameTableVOEvent):void
        {
            this.view.upGameState();
        }

        protected function upFarmer(_arg1:GameTableVOEvent):void
        {
            this.view.upFarmer();
        }

        private function showRuleFun(_arg1:Event):void
        {
            this.gameModel.showResultPanel("longhu");
        }


    }
}//package modules.gamePlatform.view
