package modules.baijiale.controller
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import modules.baijiale.service.*;
    import org.robotlegs.utilities.modular.mvcs.*;

    public class CloseLinkCommand extends ModuleCommand 
    {

        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var fmsBaijialeService:FMSBaijialeService;
        [Inject]
        public var videoService:VideoBaijialeService;
        [Inject]
        public var event:BaijialeModelEvent;


        override public function execute():void
        {
            this.baijialeModel.closeLink(this.event.table);
            this.fmsBaijialeService.close();
            this.videoService.close();
            this.baijialeModel.dispose();
        }


    }
}//package modules.baijiale.controller
