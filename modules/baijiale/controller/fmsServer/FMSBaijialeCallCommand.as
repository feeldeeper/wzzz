package modules.baijiale.controller.fmsServer
{
    import modules.baijiale.service.events.*;
    import modules.baijiale.model.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;
	import Tools;

    public class FMSBaijialeCallCommand extends ModuleCommand 
    {

        [Inject]
        public var event:FMSBaijialeServiceEvent;
        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var gameUserModel:BaijialeUserModel;
        [Inject]
        public var gameDataModel:GameDataModel;
        [Inject]
        public var gameSeatList:GameSeatListModel;
        [Inject]
        public var gameModel:GamePlatformModel;


        override public function execute():void
        {
            var _local1:Object;
            var _local2:Array;
			trace((new Date()).toLocaleTimeString()+"="+this.event.funName+"="+Tools.json_encode(this.event.data));
            if (this.event.funName != "gameAllInject")
            {
            };
			 
            switch (this.event.funName)
            {
                case "loginOk":
                    this.gameUserModel.initUserData(this.event.data);
                    return;
                case "gameInfo":
                    this.gameDataModel.initGameInfo(this.event.data);
                    return;
                case "gameState":
                    this.gameDataModel.setGameState(this.event.data);
                    return;
                case "gameHistory":
                    this.gameDataModel.setGameHistory(this.event.data);
                    return;
                case "gameResults":
                    this.gameSeatList.clearAllUserInjectMoney();
                    this.gameDataModel.setGameResults(this.event.data);
                    return;
                case "gameDeal":
                    this.gameDataModel.setGameDeal(this.event.data);
                    return;
                case "gameFarmer":
                    this.gameDataModel.setGameFarmer(this.event.data);
                    return;
                case "GameError":
                    this.gameDataModel.gameError(this.event.data);
                    return;
                case "injectMoneyOk":
                    this.gameUserModel.injectMoneyOk(this.event.data);
                    return;
                case "injectMoneyError":
                    this.gameUserModel.injectMoneyError(this.event.data);
                    return;
                case "userInjectMoney":
                    this.gameSeatList.userInject(this.event.data);
                    return;
                case "groupInjectMoney":
                    this.gameSeatList.groupInjectMoney((this.event.data as Array));
                    return;
                case "seatList":
                    this.gameSeatList.initList(this.event.data);
                    return;
                case "seatList_add":
                    this.gameSeatList.addUser(this.event.data);
                    if (this.event.data.userid == this.gameUserModel.userid)
                    {
                        this.gameUserModel.seat = this.event.data.seat;
                        this.gameSeatList.gotoUserGroup();
                    };
                    return;
                case "seatList_remove":
                    this.gameSeatList.removeUser(this.event.data);
                    return;
                case "gameAllInject":
                    this.gameDataModel.gameAllInject(this.event.data);
                    return;
                case "userSurplusMoney":
                    _local1 = this.event.data;
                    if (_local1.userid == this.gameUserModel.userid)
                    {
                        this.gameUserModel.userMoney = Number(_local1.userMoney);
                    };
                    return;
                case "refreshAllUserMoney":
                    _local2 = (this.event.data as Array);
                    this.gameSeatList.refreshAllUserMoney(_local2);
                    return;
                case "broadcastNotice":
                    this.gameDataModel.setGameNotice(this.event.data);
                    return;
                case "updateLimitInfo":
                    this.gameDataModel.setLimitInfo(this.event.data);
                    return;
            };
        }


    }
}//package modules.baijiale.controller.fmsServer
