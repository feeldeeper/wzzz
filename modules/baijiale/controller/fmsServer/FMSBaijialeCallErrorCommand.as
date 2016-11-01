package modules.baijiale.controller.fmsServer
{
    import modules.baijiale.service.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.mvcs.*;

    public class FMSBaijialeCallErrorCommand extends Command 
    {

        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var event:FMSBaijialeServiceEvent;


        override public function execute():void
        {
            if (this.event.data)
            {
            };
        }


    }
}//package modules.baijiale.controller.fmsServer
