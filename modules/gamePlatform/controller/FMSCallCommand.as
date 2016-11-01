package modules.gamePlatform.controller
{
    import modules.gamePlatform.service.events.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;
    import modules.gamePlatform.service.*;

    public class FMSCallCommand extends Command 
    {

        [Inject]
        public var event:FMSMainServiceEvent;
        [Inject]
        public var gameModel:GamePlatformModel;
        [Inject]
        public var userInfo:UserInfoModel;
        [Inject]
        public var videoServer:VideoHallService;


        override public function execute():void
        {
            super.execute();
			trace((new Date()).toLocaleTimeString()+this.event.funName+"="+Tools.json_encode(this.event.data));
            if (this.event.funName == "loginOk")
            {
                this.userInfo.initUser(this.event.data);
				/*
				trace("-------------------");
				trace(this.event.data.userid+"==");//xiaozhi8888
				trace(this.event.data.userName+"==");//xiaozhi8888
				trace(this.event.data.userMoney+"==");//0.5
				trace(this.event.data.realType+"==");//real
				trace(this.event.data.gameArr+"==");//baijiale,longhu,daxiao
				trace(this.event.data.passWord+"==");//57599f0e0f2778077f78fc00f143e41a
				trace(this.event.data.chipModel+"==");//custom
				trace(this.event.data.nickName+"==");//null
				trace(this.event.data.parentTreeStr+"==");//admin/zonggongsi/gudong001/xiaohai/xiaozhi
				trace(this.event.data.hideWash+"==");//1
				trace("-------------------");
				*/
				 
                this.gameModel.waitGameModel.initVO(this.event.data.maxMin);
                this.gameModel.loginAmf(this.event.data);
            };
            if (this.event.funName == "gameStateList")
            {
                this.gameModel.gameStateList(this.event.data);
            };
            if (this.event.funName == "gameHistoryList")
            {
                this.gameModel.gameHistoryList(this.event.data);
            };
            if (this.event.funName == "gameUserSeatList")
            {
                this.gameModel.gameUserSeatList(this.event.data);
            };
            if (this.event.funName == "gameUserSeat")
            {
                this.gameModel.gameUserSeat(this.event.data);
            };
            if (this.event.funName == "gameState")
            {
                this.gameModel.gameState(this.event.data);
            };
            if (this.event.funName == "gameHistory")
            {
                this.gameModel.gameHistory(this.event.data);
            };
            if (this.event.funName == "gameFarmer")
            {
                this.gameModel.gameFarmer(this.event.data);
            };
            if (this.event.funName == "otherUserLogin")
            {
                DebugOutput.add("重新登录");
                this.gameModel.showError({
                    "type":"error",
                    "error":"不允许重复登录",
                    "url":"login"
                });
                this.gameModel.otherUserLogin();
            };
            if (this.event.funName == "broadcastNotice")
            {
                this.gameModel.gameNotice(this.event.data);
            };
        }


    }
}//package modules.gamePlatform.controller
