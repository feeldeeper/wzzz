package modules.baijiale.view
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.mvcs.*;

    public class LanguagePanelViewMediator extends Mediator 
    {

        [Inject]
        public var gameDataModel:GameDataModel;


        private function get view():LanguagePanelView
        {
            return ((viewComponent as LanguagePanelView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.dispose();
            removeContextListener(BaijialeModelEvent.SHOW_ALL_ROUTE_PANEL, this.showAllRoutePanel);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
        }

        override public function onRegister():void
        {
            addContextListener(BaijialeModelEvent.SHOW_ALL_ROUTE_PANEL, this.showAllRoutePanel);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            this.view.addToStage();
        }

        private function showAllRoutePanel(_arg1:BaijialeModelEvent):void
        {
            this.view.showAllRoutePanel();
        }

        private function initGameInfo(_arg1:GameDataModelEvent=null):void
        {
            if (this.gameDataModel.gameid)
            {
                this.view.setTableNum((uint(this.gameDataModel.gameid) + 1));
            };
        }


    }
}//package modules.baijiale.view
