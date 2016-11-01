package modules.gamePlatform.view
{
    import flash.events.*;
    import modules.gamePlatform.model.events.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;
    import modules.gamePlatform.service.*;

    public class TopPanelViewMediator extends Mediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var videoServer:VideoHallService;


        private function get view():TopPanelView
        {
            return ((viewComponent as TopPanelView));
        }

        override public function onRegister():void
        {
            addContextListener(GamePlatformModelEvent.GAME_NEW, this.showNews);
            addContextListener(Event.ACTIVATE, this.onActivate);
            addContextListener(Event.DEACTIVATE, this.onDeactivate);
            addContextListener(GamePlatformModelEvent.UP_GAME_NOTICE, this.upGameNotice);
            this.view.BBS_mc.reStart();
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GamePlatformModelEvent.GAME_NEW, this.showNews);
            removeContextListener(Event.ACTIVATE, this.onActivate);
            removeContextListener(Event.DEACTIVATE, this.onDeactivate);
            removeContextListener(GamePlatformModelEvent.UP_GAME_NOTICE, this.upGameNotice);
            this.view.BBS_mc.Unload();
        }

        private function showNews(_arg1:GamePlatformModelEvent):void
        {
            this.view.showNews(this.gameModel.gameNew);
        }

        private function onActivate(_arg1:Event):void
        {
        }

        private function onDeactivate(_arg1:Event):void
        {
        }

        private function upGameNotice(_arg1:GamePlatformModelEvent):void
        {
            this.view.BBS_mc.getLanInfo((_arg1.data as String));
        }


    }
}//package modules.gamePlatform.view
