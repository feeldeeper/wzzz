package modules.baijiale.controller.fmsServer
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.mvcs.*;

    public class FMSBaijialeGameInitCommand extends Command 
    {

        [Inject]
        public var event:GameDataModelEvent;
        [Inject]
        public var baijialeModel:BaijialeModel;


        override public function execute():void
        {
        }


    }
}//package modules.baijiale.controller.fmsServer
