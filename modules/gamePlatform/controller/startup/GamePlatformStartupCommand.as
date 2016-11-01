package modules.gamePlatform.controller.startup
{
    import modules.gamePlatform.view.*;
    import modules.gamePlatform.model.events.*;
    import modules.gamePlatform.service.events.*;
    import modules.baijiale.view.*;
    import org.robotlegs.base.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;
    import modules.gamePlatform.service.*;
    import modules.gamePlatform.controller.*;
	
	

    public class GamePlatformStartupCommand extends Command 
    {


        override public function execute():void
        {
			 
            injector.mapSingleton(GamePlatformModel);
            injector.mapSingleton(modules.gamePlatform.model.UserInfoModel);
            injector.mapSingleton(GameLoadService);
            injector.mapSingleton(FMSMainService);
            injector.mapSingleton(VideoMainService);
            injector.mapSingleton(VideoHallService);
            mediatorMap.mapView(GameListView, GameListViewMediator);
            mediatorMap.mapView(GameRoomContentView, GameRoomContentViewMediator);
            mediatorMap.mapView(GameRoomView, GameRoomViewMediator);
            mediatorMap.mapView(GameTableBaijialeView, GameTableBaijialeViewMediator);
            mediatorMap.mapView(GameTableDaxiaoView, GameTableDaxiaoViewMediator);
            mediatorMap.mapView(GameTableLonghuView, GameTableLonghuViewMediator);
            mediatorMap.mapView(GameTableLunPanView, GameTableLunPanViewMediator);
            mediatorMap.mapView(GameTableNNGameView, GameTableNNGameViewMediator);
            mediatorMap.mapView(GameTableView, GameTableViewMediator);
            mediatorMap.mapView(LoginView, LoginViewMediator);
            mediatorMap.mapView(MainContainersView, MainContainersViewMediator);
            mediatorMap.mapView(TopPanelView, TopPanelViewMediator);
            mediatorMap.mapView(UserInfoView, UserInfoViewMediator);
            mediatorMap.mapView(AlertDefaultView, AlertDefaultViewMediator);
            mediatorMap.mapView(GamePlatformSoundView, GamePlatformSoundViewMediator);
            mediatorMap.mapView(JournalingPanelView, JournalingPanelViewMediator);
            mediatorMap.mapView(ResultPanelView, ResultPanelViewMediator);
            mediatorMap.mapView(EditPasswordPanelView, EditPasswordPanelViewMediator);
            mediatorMap.mapView(EditNickNamePanelView, EditNickNamePanelViewMediator);
            mediatorMap.mapView(RulesPanelView, RulesPanelViewMediator);
            mediatorMap.mapView(GameGroupTableDiskView, GameGroupTableDiskViewMediator);
            mediatorMap.mapView(GameTableComicBJLView, GameTableComicBJLViewMediator);
            commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, GamePlatformStarupCompleteCommand);
            commandMap.mapEvent(FMSMainServiceEvent.FMS_CALL, FMSCallCommand);
            commandMap.mapEvent(GamePlatformModelEvent.GAME_START_LINK, GameStartLinkCommand);
        }


    }
}//package modules.gamePlatform.controller.startup
