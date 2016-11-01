package modules.gamePlatform.controller
{
    import modules.gamePlatform.model.events.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class GameStartLinkCommand extends Command 
    {

        [Inject]
        public var event:GamePlatformModelEvent;
        [Inject]
        public var gameModel:GamePlatformModel;


        override public function execute():void
        {
            super.execute();
            this.gameModel.currentGame.startLink(this.event.table, this.injector);
        }


    }
}//package modules.gamePlatform.controller
