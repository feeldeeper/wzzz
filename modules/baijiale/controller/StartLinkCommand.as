package modules.baijiale.controller
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import modules.baijiale.service.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;

    public class StartLinkCommand extends ModuleCommand 
    {

        [Inject]
        public var videoServer:VideoBaijialeService;
        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var fmsBaijialeService:FMSBaijialeService;
        [Inject]
        public var videoService:VideoBaijialeService;
        [Inject]
        public var event:BaijialeModelEvent;
        [Inject]
        public var userModel:UserInfoModel;


        override public function execute():void
        {
            this.baijialeModel.startLink(this.event.table);
            var _local1:String = ((this.event.table.gameUrl + "/") + this.event.table.gameid);//rtmpe://121.199.1.57/baijiale/01
            //var _local1:String = (("rtmpe://localhost/baijiale/") + this.event.table.gameid);
            this.fmsBaijialeService.fmslink(_local1, this.userModel.loginServerData, 500, this.event.table.seatId);
        }


    }
}//package modules.baijiale.controller
