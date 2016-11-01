package modules.baijiale.view
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.mvcs.*;

    public class TableNumPanelViewMediator extends Mediator 
    {

        [Inject]
        public var gameDataModel:GameDataModel;


        private function get view():TableNumPanelView
        {
            return ((viewComponent as TableNumPanelView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.dispose();
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
        }

        override public function onRegister():void
        {
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
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
