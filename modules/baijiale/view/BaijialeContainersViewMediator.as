package modules.baijiale.view
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.service.events.*;
    import org.robotlegs.mvcs.*;

    public class BaijialeContainersViewMediator extends Mediator 
    {


        private function get view():BaijialeContainersView
        {
            return ((viewComponent as BaijialeContainersView));
        }

        override public function onRegister():void
        {
            addContextListener(FMSBaijialeServiceEvent.LINK_DELAY_START, this.startLink);
            addContextListener(FMSBaijialeServiceEvent.LINK_SUCCESS, this.linkOk);
            addContextListener(BaijialeModelEvent.UP_SIMULATIONS_PANEL, this.simulationsPanel);
            addContextListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.showServerLink);
            addContextListener(BaijialeModelEvent.GAME_HIDE_SERVERLINK, this.hideServerLink);
            this.view.addToStage();
        }

        private function simulationsPanel(_arg1:BaijialeModelEvent):void
        {
            this.view.simulationsPanel();
        }

        private function linkOk(_arg1:FMSBaijialeServiceEvent):void
        {
            this.view.linkOk(1);
        }

        private function startLink(_arg1:FMSBaijialeServiceEvent):void
        {
            this.view.startLink(1);
        }

        private function showServerLink(_arg1:BaijialeModelEvent):void
        {
            this.view.startLink(2);
        }

        private function hideServerLink(_arg1:BaijialeModelEvent):void
        {
            this.view.linkOk(2);
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(FMSBaijialeServiceEvent.LINK_START, this.startLink);
            removeContextListener(FMSBaijialeServiceEvent.LINK_SUCCESS, this.linkOk);
            removeContextListener(BaijialeModelEvent.UP_SIMULATIONS_PANEL, this.simulationsPanel);
            removeContextListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.showServerLink);
            removeContextListener(BaijialeModelEvent.GAME_HIDE_SERVERLINK, this.hideServerLink);
            this.view.dispose();
        }


    }
}//package modules.baijiale.view
