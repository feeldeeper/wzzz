package modules.baijiale.controller.startup
{
    import modules.baijiale.view.*;
    import modules.baijiale.model.events.*;
    import modules.baijiale.service.events.*;
    import modules.baijiale.model.*;
    import modules.baijiale.service.*;
    import org.robotlegs.base.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.baijiale.controller.fmsServer.*;
    import modules.baijiale.controller.*;

    public class BaijialeStartupCommand extends ModuleCommand 
    {


        override public function execute():void
        {
            injector.mapSingleton(VideoBaijialeService);
            injector.mapSingleton(FMSBaijialeService);
            injector.mapSingleton(GameDataModel);
            injector.mapSingleton(BaijialeModel);
            injector.mapSingleton(BaijialeUserModel);
            injector.mapSingleton(GameSeatListModel);
            mediatorMap.mapView(BaijialeContainersView, BaijialeContainersViewMediator);
            mediatorMap.mapView(InjectGamePanelView, InjectGamePanelViewMediator);
            mediatorMap.mapView(SimulationsView, SimulationsViewMediator);
            mediatorMap.mapView(TimePanelView, TimePanelViewMediator);
            mediatorMap.mapView(GameInterfaceView, GameInterfaceViewMediator);
            mediatorMap.mapView(TotalPotPanelView, TotalPotPanelViewMediator);
            mediatorMap.mapView(VideoPanelView, VideoPanelViewMediator);
            mediatorMap.mapView(DealCardView, DealCardViewMediator);
            mediatorMap.mapView(UserSeatListView, UserSeatListViewMediator);
            mediatorMap.mapView(SoundBaijialeManageView, SoundBaijialeManageViewMediator);
            mediatorMap.mapView(TableNumPanelView, TableNumPanelViewMediator);
            mediatorMap.mapView(LanguagePanelView, LanguagePanelViewMediator);
            mediatorMap.mapView(GotoTableBtnView, GotoTableBtnViewMediator);
            mediatorMap.mapView(GotoGameTableListView, GotoGameTableListViewMediator);
            commandMap.mapEvent(FMSBaijialeServiceEvent.FMS_CALL, FMSBaijialeCallCommand);
            commandMap.mapEvent(FMSBaijialeServiceEvent.CALL_FMS_RESULT, FMSBaijialeCallResultCommand);
            commandMap.mapEvent(FMSBaijialeServiceEvent.CALL_FMS_ERROR, FMSBaijialeCallErrorCommand);
            commandMap.mapEvent(FMSBaijialeServiceEvent.LINK_REJECTED, FMSBaijialeRejectedCommand);
            commandMap.mapEvent(FMSBaijialeServiceEvent.LINK_SERVER_CLOSE, FMSBaijialeCloseLinkCommand);
            commandMap.mapEvent(FMSBaijialeServiceEvent.LINK_FAILED, FMSBaijialeLinkFailedCommand);
            commandMap.mapEvent(BaijialeModelEvent.CLOSE_LINK, CloseLinkCommand);
            commandMap.mapEvent(BaijialeModelEvent.START_LINK, StartLinkCommand);
            commandMap.mapEvent(GameDataModelEvent.INIT_GAME_INFO, FMSBaijialeGameInitCommand);
            commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, BaijialeStarupCompleteCommand);
        }

        public function addFmsEvent():void
        {
        }


    }
}//package modules.baijiale.controller.startup
