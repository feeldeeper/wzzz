package modules.gamePlatform.view
{
    import modules.gamePlatform.model.*;

    public class GameTableLunPanViewMediator extends GameTableViewMediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var userInfo:UserInfoModel;


        private function get view():GameTableLunPanView
        {
            return ((viewComponent as GameTableLunPanView));
        }

        override public function onRegister():void
        {
            super.onRegister();
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.dispose();
        }


    }
}//package modules.gamePlatform.view
