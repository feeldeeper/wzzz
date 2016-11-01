package modules.gamePlatform.view
{
    import flash.events.*;
    import modules.gamePlatform.service.events.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;
    import modules.gamePlatform.service.*;
    import flash.external.*;
    import com.adobe.crypto.*;

    public class LoginViewMediator extends Mediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var fmsMainService:FMSMainService;
        [Inject]
        public var userInfo:UserInfoModel;


        private function get view():LoginView
        {
            return ((viewComponent as LoginView));
        }

        override public function onRegister():void
        {
            this.view.movieIn();
            this.view.addEventListener("login", this.login);
            addContextListener(FMSMainServiceEvent.LINK_CLOSE, this.linkClose);
            addContextListener(FMSMainServiceEvent.LINK_FAILED, this.linkFailed);
            addContextListener(FMSMainServiceEvent.LINK_REJECTED, this.linkRejected);
            addContextListener(FMSMainServiceEvent.LINK_SUCCESS, this.linkOk);
            addContextListener(FMSMainServiceEvent.LINK_START, this.linkStart);
        }

        private function linkStart(_arg1:FMSMainServiceEvent):void
        {
            this.view.linkStart();
        }

        private function linkOk(_arg1:FMSMainServiceEvent):void
        {
            this.gameModel.gotoPage("gameRoom");
            this.view.openBtn();
        }

        private function linkFailed(_arg1:FMSMainServiceEvent):void
        {
			trace("未连接上");
            this.gameModel.showError("网络繁忙...未能连接上服务器");
            this.view.showError("网络繁忙");
            this.view.openBtn();
        }

        private function linkClose(_arg1:FMSMainServiceEvent):void
        {
			trace("链接关闭");
            this.view.openBtn();
        }

        public function login(_arg1:Event):void
        {
            var _local2:Object = {};
            _local2.usertype = "user";
            _local2.userid = this.view.text_userName.text;			
            if (this.view.isTelModel == true)
            {
                _local2.isTelModel = this.view.isTelModel;
                this.view.isAutoLogin = false;
            };
            _local2.isAutoLogin = this.view.isAutoLogin;
            if (this.view.isAutoLogin == false)
            {
                this.userInfo.userpsw = MD5.hash(this.view.text_password.text);
                _local2.userpsw = this.userInfo.userpsw;
            }
            else
            {
                this.userInfo.userpsw = ExternalInterface.call("getPwd");
                _local2.userpsw = this.userInfo.userpsw;
            };
			////
			//_local2.userid = "xiaozhi8888";
			//_local2.userpsw = "57599f0e0f2778077f78fc00f143e41a";
			////
			if(ExternalInterface.available)
			{
				ExternalInterface.call("recordUser",_local2.userid);
			}
            _local2.bool = true;			
            this.userInfo.telModel = this.view.isTelModel;
            this.fmsMainService.fmslink(this.gameModel.mainServer, _local2);
			////this.fmsMainService.fmslink("rtmpe://localhost/gameMain", _local2);
        }

        private function linkRejected(_arg1:FMSMainServiceEvent):void
        {
            this.view.showError(_arg1.data.error);
            this.view.openBtn();
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.removeEventListener("login", this.login);
            removeContextListener(FMSMainServiceEvent.LINK_CLOSE, this.linkClose);
            removeContextListener(FMSMainServiceEvent.LINK_FAILED, this.linkFailed);
            removeContextListener(FMSMainServiceEvent.LINK_SUCCESS, this.linkOk);
            removeContextListener(FMSMainServiceEvent.LINK_START, this.linkStart);
            this.view.dispose();
        }


    }
}//package modules.gamePlatform.view
