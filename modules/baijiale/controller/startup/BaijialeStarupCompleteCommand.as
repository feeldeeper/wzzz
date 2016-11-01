package modules.baijiale.controller.startup
{
    import modules.baijiale.view.*;
    import modules.baijiale.model.*;
    import org.robotlegs.utilities.modular.mvcs.*;

    public class BaijialeStarupCompleteCommand extends ModuleCommand 
    {

        [Inject]
        public var baijialeModel:BaijialeModel;


        override public function execute():void
        {
            contextView.addChild(new BaijialeContainersView());
			//contextView.addChild(new VideoPanelView());
            this.baijialeModel.modelInit();
        }


    }
}//package modules.baijiale.controller.startup
