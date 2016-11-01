package modules.gamePlatform
{
    import flash.display.*;
    import modules.gamePlatform.controller.startup.*;
    import org.robotlegs.base.*;
    import org.robotlegs.utilities.modular.mvcs.*;

    public class GamePlatformContext extends ModuleContext 
    { 
		
        public function GamePlatformContext(_arg1:DisplayObjectContainer=null, _arg2:Boolean=true)
        {
            super(_arg1, _arg2);
        }

        override public function startup():void
        {
			/*
			injector.mapSingleton(GamePlatformModel);//平台所有游戏数据
            injector.mapSingleton(modules.gamePlatform.model.UserInfoModel);//平台所有用户数据
            injector.mapSingleton(GameLoadService);//游戏加载服务
            injector.mapSingleton(FMSMainService);//视频加载服务
            injector.mapSingleton(VideoMainService);//视频加载服务
            injector.mapSingleton(VideoHallService);//视频加载服务
            mediatorMap.mapView(GameListView, GameListViewMediator); //
            mediatorMap.mapView(GameRoomContentView, GameRoomContentViewMediator);//
            mediatorMap.mapView(GameRoomView, GameRoomViewMediator);//
            mediatorMap.mapView(GameTableBaijialeView, GameTableBaijialeViewMediator);//
            //mediatorMap.mapView(GameTableDaxiaoView, GameTableDaxiaoViewMediator);
            //mediatorMap.mapView(GameTableLonghuView, GameTableLonghuViewMediator);
            //mediatorMap.mapView(GameTableLunPanView, GameTableLunPanViewMediator);
            //mediatorMap.mapView(GameTableNNGameView, GameTableNNGameViewMediator);
            mediatorMap.mapView(GameTableView, GameTableViewMediator); //
            mediatorMap.mapView(LoginView, LoginViewMediator); //登录界面
            mediatorMap.mapView(MainContainersView, MainContainersViewMediator); //
            mediatorMap.mapView(TopPanelView, TopPanelViewMediator); //
            mediatorMap.mapView(UserInfoView, UserInfoViewMediator); //
            mediatorMap.mapView(AlertDefaultView, AlertDefaultViewMediator); //
            mediatorMap.mapView(GamePlatformSoundView, GamePlatformSoundViewMediator); //
            mediatorMap.mapView(JournalingPanelView, JournalingPanelViewMediator); //
            mediatorMap.mapView(ResultPanelView, ResultPanelViewMediator); //
            mediatorMap.mapView(EditPasswordPanelView, EditPasswordPanelViewMediator); //
            mediatorMap.mapView(EditNickNamePanelView, EditNickNamePanelViewMediator); //
            mediatorMap.mapView(RulesPanelView, RulesPanelViewMediator); //
            mediatorMap.mapView(GameGroupTableDiskView, GameGroupTableDiskViewMediator); //
            mediatorMap.mapView(GameTableComicBJLView, GameTableComicBJLViewMediator); //
            commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, GamePlatformStarupCompleteCommand); //
            commandMap.mapEvent(FMSMainServiceEvent.FMS_CALL, FMSCallCommand); //
            commandMap.mapEvent(GamePlatformModelEvent.GAME_START_LINK, GameStartLinkCommand); //
			
			//var _local1:MainContainersView = new MainContainersView();
			//contextView.addChild(new LoginView());			
			//this.gameLoadService.gamePlatformModel = this.gamePlatformModel;
            //this.gamePlatformModel.gameLoadService = this.gameLoadService;
            //this.gamePlatformModel.fmsMainServer = this.fmsMainServer;
        	*/
            commandMap.mapEvent(ContextEvent.STARTUP, GamePlatformStartupCommand, ContextEvent, true);
            dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
            super.startup();
        }


    }
}//package modules.gamePlatform
