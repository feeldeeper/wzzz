package modules.gamePlatform.view
{
    import modules.gamePlatform.view.events.*;
    import modules.gamePlatform.model.events.*;
    import modules.gamePlatform.service.events.*;
    import com.snake.managers.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class MainContainersViewMediator extends Mediator 
    {

        [Inject]
        public var view:MainContainersView;
        [Inject]
        public var gameModel:GamePlatformModel;


        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GamePlatformModelEvent.SHOW_ERROR, this.showError);
            removeContextListener(GamePlatformModelEvent.GOTO_GAME, this.gotoGame);
            removeContextListener(GamePlatformModelEvent.GOTO_PAGE, this.gotoPage);
            removeContextListener(GamePlatformModelEvent.CONFING_INIT, this.confingInit);
            removeContextListener(FMSMainServiceEvent.LINK_CLOSE, this.fmsClose);
            removeContextListener(FMSMainServiceEvent.LINK_SERVER_CLOSE, this.fmsClose);
            removeContextListener(FMSMainServiceEvent.LINK_REJECTED, this.fmsReject);
            removeContextListener(GamePlatformModelEvent.SHOW_GAME_LEFT_LIST, this.showGameLeftList);
            removeContextListener(GamePlatformModelEvent.SHOW_EDITPASSWORDPANEL, this.showEditpasswordPanel);
            removeContextListener(GamePlatformModelEvent.SHOW_EDITNICKNAMEPANEL, this.showNickNamePanel);
            removeContextListener(GamePlatformModelEvent.SHOW_JOURNALINGPANEL, this.showJournalingPanel);
            removeContextListener(GamePlatformModelEvent.SHOW_RESULTPANEL, this.showResultPanel);
            this.view.removeEventListener(MainContainersViewEvent.GOTO_GAME_END, this.gotoGameEnd);
            this.view.removeEventListener(MainContainersViewEvent.GOTO_PAGE_END, this.gotoPageEnd);
            this.view.removeEventListener(MainContainersViewEvent.RESIZE, this.reSize);
            this.view.dispose();
        }

        override public function onRegister():void
        {
            super.onRegister();
            AlertManager.getInstance().stage = contextView;
            addContextListener(GamePlatformModelEvent.SHOW_ERROR, this.showError);
            addContextListener(GamePlatformModelEvent.GOTO_GAME, this.gotoGame);
            addContextListener(GamePlatformModelEvent.GOTO_PAGE, this.gotoPage);
            addContextListener(GamePlatformModelEvent.CONFING_INIT, this.confingInit);
            addContextListener(FMSMainServiceEvent.LINK_CLOSE, this.fmsClose);
            addContextListener(FMSMainServiceEvent.LINK_SERVER_CLOSE, this.fmsClose);
            addContextListener(FMSMainServiceEvent.LINK_REJECTED, this.fmsReject);
            addContextListener(GamePlatformModelEvent.SHOW_GAME_LEFT_LIST, this.showGameLeftList);
            addContextListener(GamePlatformModelEvent.SHOW_EDITPASSWORDPANEL, this.showEditpasswordPanel);
            addContextListener(GamePlatformModelEvent.SHOW_EDITNICKNAMEPANEL, this.showNickNamePanel);
            addContextListener(GamePlatformModelEvent.SHOW_JOURNALINGPANEL, this.showJournalingPanel);
            addContextListener(GamePlatformModelEvent.SHOW_RESULTPANEL, this.showResultPanel);
            this.view.addEventListener(MainContainersViewEvent.GOTO_GAME_END, this.gotoGameEnd);
            this.view.addEventListener(MainContainersViewEvent.GOTO_PAGE_END, this.gotoPageEnd);
            this.view.addEventListener(MainContainersViewEvent.RESIZE, this.reSize);
            this.view.addToStage();
            this.view.reSize();
            this.view.initReSize();
        }

        private function showGameLeftList(_arg1:GamePlatformModelEvent):void
        {
        }

        private function showResultPanel(_arg1:GamePlatformModelEvent):void
        {
            this.view.showResultPanel(String(_arg1.data));
        }

        private function showJournalingPanel(_arg1:GamePlatformModelEvent):void
        {
            this.view.showJournalingPanel();
        }

        private function showEditpasswordPanel(_arg1:GamePlatformModelEvent):void
        {
            this.view.showEditpasswordPanel();
        }

        private function showNickNamePanel(_arg1:GamePlatformModelEvent):void
        {
            this.view.showNickNamePanel();
        }

        protected function reSize(_arg1:MainContainersViewEvent):void
        {
            this.gameModel.setContainerScale(_arg1.scale);
        }

        private function fmsReject(_arg1:FMSMainServiceEvent):void
        {
            this.view.showError("用户名或密码错误");
        }

        private function fmsClose(_arg1:FMSMainServiceEvent):void
        {
            this.view.showError("与服务器断开连接", "logout");
            this.gameModel.gotoPage("login");
        }

        private function showError(_arg1:GamePlatformModelEvent):void
        {
            this.view.showError(_arg1.data);
        }

        private function confingInit(_arg1:GamePlatformModelEvent):void
        {
            this.gameModel.gotoPage("login");
        }

        private function gotoPage(_arg1:GamePlatformModelEvent):void
        {
            this.view.gotoPage(_arg1.pageName);
        }

        protected function gotoPageEnd(_arg1:MainContainersViewEvent):void
        {
            this.gameModel.gotoPageEnd(this.view.pageName);
        }

        protected function gotoGameEnd(_arg1:MainContainersViewEvent):void
        {
            this.gameModel.startLiknNowGameEvent();
            this.gameModel.gotoGameEnd();
        }

        private function gotoGame(_arg1:GamePlatformModelEvent):void
        {
            this.view.gotoGame(this.gameModel.currentGame);
        }


    }
}//package modules.gamePlatform.view
