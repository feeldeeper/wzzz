package modules.gamePlatform.view
{
    import flash.events.*;
    import modules.gamePlatform.view.events.*;
    import modules.gamePlatform.model.events.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;
    import modules.gamePlatform.service.*;
    import flash.external.*;

    public class UserInfoViewMediator extends ModuleMediator 
    {

        [Inject]
        public var userInfo:UserInfoModel;
        [Inject]
        public var fmsMainService:FMSMainService;
        [Inject]
        public var gameModel:GamePlatformModel;


        private function get view():UserInfoView
        {
            return ((viewComponent as UserInfoView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.removeEventListener(UserInfoViewEvent.LANGUAGE, this.language);
            this.view.removeEventListener(UserInfoViewEvent.RULES, this.rules);
            this.view.removeEventListener(UserInfoViewEvent.RECORD, this.record);
            this.view.removeEventListener(UserInfoViewEvent.SERVER, this.server);
            this.view.removeEventListener(UserInfoViewEvent.OUT, this.out);
            this.view.removeEventListener(UserInfoViewEvent.EDITPASSWORD, this.editPassword);
            this.view.removeEventListener("showGameHistory", this.showGameHistory);
            removeContextListener(UserInfoModelEvent.UP_USER_MONEY, this.upUserMoney);
            removeContextListener(UserInfoModelEvent.UP_USER_INFO, this.upUserInfo);
            this.view.removeEventListener(UserInfoViewEvent.EDITNICKNAME, this.editNickName);
            this.gameModel.eventDispatcher.removeEventListener(GamePlatformModelEvent.REFRESH_MONEY_RESULT, this.amfRefreshMoney);
            this.view.dispose();
        }

        override public function onRegister():void
        {
            this.view.addEventListener(UserInfoViewEvent.LANGUAGE, this.language);
            this.view.addEventListener(UserInfoViewEvent.RULES, this.rules);
            this.view.addEventListener(UserInfoViewEvent.RECORD, this.record);
            this.view.addEventListener(UserInfoViewEvent.SERVER, this.server);
            this.view.addEventListener(UserInfoViewEvent.OUT, this.out);
            this.view.addEventListener(UserInfoViewEvent.EDITPASSWORD, this.editPassword);
            this.view.addEventListener("showGameHistory", this.showGameHistory);
            addContextListener(UserInfoModelEvent.UP_USER_MONEY, this.upUserMoney);
            addContextListener(UserInfoModelEvent.UP_USER_INFO, this.upUserInfo);
            this.view.showUserInfo(this.userInfo.userid, this.userInfo.userMoney, this.userInfo.nickName);
            this.view.addEventListener(UserInfoViewEvent.EDITNICKNAME, this.editNickName);
            this.gameModel.eventDispatcher.addEventListener(GamePlatformModelEvent.REFRESH_MONEY_RESULT, this.amfRefreshMoney);
            this.view.addToStage();
        }

        private function amfRefreshMoney(_arg1:GamePlatformModelEvent):void
        {
            this.userInfo.userMoney = Number(_arg1.data);
        }

        private function upUserInfo(_arg1:UserInfoModelEvent):void
        {
            this.view.showUserInfo(this.userInfo.userid, this.userInfo.userMoney, this.userInfo.nickName);
        }

        private function upUserMoney(_arg1:UserInfoModelEvent):void
        {
            this.view.showUserInfo(this.userInfo.userid, this.userInfo.userMoney, this.userInfo.nickName);
        }

        private function editNickName(_arg1:UserInfoViewEvent):void
        {
            this.gameModel.showEditNickNamePanel();
        }

        protected function editPassword(_arg1:UserInfoViewEvent):void
        {
            this.gameModel.showEditPasswordPanel();
        }

        protected function out(_arg1:UserInfoViewEvent):void
        {
            this.fmsMainService.close();
            if (ExternalInterface.available)
            {
                ExternalInterface.call("logout");
            };
        }

        protected function server(_arg1:UserInfoViewEvent):void
        {
        }

        protected function record(_arg1:UserInfoViewEvent):void
        {
            this.gameModel.showJournalingPanel();
        }

        protected function rules(_arg1:UserInfoViewEvent):void
        {
        }

        protected function language(_arg1:UserInfoViewEvent):void
        {
            this.gameModel.showSystemPanel(true);
        }

        private function showGameHistory(_arg1:Event):void
        {
            DebugOutput.add("要显示游戏记录");
            if (ExternalInterface.available)
            {
                ExternalInterface.call("showGameLog", this.userInfo.userid, this.userInfo.userpsw);
            };
        }


    }
}//package modules.gamePlatform.view
