package modules.baijiale.controller.fmsServer
{
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class FMSBaijialeLinkFailedCommand extends Command 
    {

        [Inject]
        public var gameModel:GamePlatformModel;


        override public function execute():void
        {
            this.gameModel.gotoPage("gameRoom");
            this.gameModel.showError("服务器端连接失败！");
        }


    }
}//package modules.baijiale.controller.fmsServer
