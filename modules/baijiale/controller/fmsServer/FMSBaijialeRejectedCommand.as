package modules.baijiale.controller.fmsServer
{
    import modules.baijiale.service.events.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;

    public class FMSBaijialeRejectedCommand extends ModuleCommand 
    {

        [Inject]
        public var event:FMSBaijialeServiceEvent;
        [Inject]
        public var gameModel:GamePlatformModel;


        override public function execute():void
        {
            this.gameModel.gotoPage("gameRoom");
            this.gameModel.showError("服务器拒绝连接，帐号密码错误！");
        }


    }
}//package modules.baijiale.controller.fmsServer
