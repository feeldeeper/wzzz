package modules.baijiale.controller.fmsServer
{
    import modules.baijiale.service.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.mvcs.*;

    public class FMSBaijialeCallResultCommand extends Command 
    {

        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var event:FMSBaijialeServiceEvent;


        override public function execute():void
        {
            if (this.event.data.type == false)
            {
                if (this.event.data.fun == "userInjectMoney")
                {
                    DebugOutput.add("超出限红");
                };
                if (this.event.data.fun == "userSetSeat")
                {
                };
            };
        }


    }
}//package modules.baijiale.controller.fmsServer
