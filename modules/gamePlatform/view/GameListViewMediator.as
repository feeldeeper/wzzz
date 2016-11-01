package modules.gamePlatform.view
{
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class GameListViewMediator extends Mediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;


        private function get view():GameListView
        {
            return ((viewComponent as GameListView));
        }

        override public function onRegister():void
        {
            if (this.view.initTableBool == false)
            {
                this.view.initTable(this.gameModel.tableList);
            };
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.dispose();
        }


    }
}//package modules.gamePlatform.view
