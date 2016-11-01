package modules.gamePlatform.view
{
    import flash.events.*;
    import com.snake.managers.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class JournalingPanelViewMediator extends Mediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var userModel:UserInfoModel;


        private function get view():JournalingPanelView
        {
            return ((viewComponent as JournalingPanelView));
        }

        override public function onRegister():void
        {
            this.view.initReSize();
            this.view.setAmfUrl(this.gameModel.httpUrl + "Amf/");
            this.view.setUserInfo(this.userModel.userid, this.userModel.userpsw, this.userModel.hideWash);
            this.view.addEventListener("close", this.close);
            this.view.addEventListener("error", this.showError);
        }

        protected function close(_arg1:Event):void
        {
            AlertManager.getInstance().remove(this.view);
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.removeEventListener("error", this.showError);
            this.view.removeEventListener("close", this.close);
            this.view.dispose();
        }

        private function showError(_arg1:Event):void
        {
            this.gameModel.showError("連接服務器失敗");
        }


    }
}//package modules.gamePlatform.view
