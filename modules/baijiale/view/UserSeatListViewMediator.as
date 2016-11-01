package modules.baijiale.view
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.view.events.*;
    import modules.baijiale.model.*;
    import modules.baijiale.service.*;
    import org.robotlegs.mvcs.*;

    public class UserSeatListViewMediator extends Mediator 
    {

        [Inject]
        public var gameSeatList:GameSeatListModel;
        [Inject]
        public var baijialeUser:BaijialeUserModel;
        [Inject]
        public var baijialeFms:FMSBaijialeService;


        private function get view():UserSeatListView
        {
            return ((viewComponent as UserSeatListView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GameSeatListModelEvent.SEAT_LIST, this.initSeatList);
            removeContextListener(GameSeatListModelEvent.SEAT_LIST_ADD, this.addSeatList);
            removeContextListener(GameSeatListModelEvent.SEAT_LIST_REMOVE, this.removeSeatList);
            removeContextListener(GameSeatListModelEvent.USER_INJECT_MONEY, this.userInjectMoney);
            removeContextListener(GameSeatListModelEvent.UP_GROUP, this.upCurrentGroup);
            removeContextListener(GameSeatListModelEvent.REFERSH_ALL_USER_MONEY, this.refershAllUserMoney);
            removeContextListener(BaijialeUserModelEvent.UP_SEAT, this.upUserSeat);
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            removeContextListener(GameSeatListModelEvent.CLEAR_ALL_USER_INJECTMONEY, this.clearAllUserInjectMoney);
            removeContextListener(BaijialeModelEvent.CLOSE_LINK, this.closeLink);
            this.view.removeEventListener(UserSeatListViewEvent.SELECT_SEAT, this.seletSeat);
            this.view.dispose();
        }

        override public function onRegister():void
        {
            addContextListener(GameSeatListModelEvent.SEAT_LIST, this.initSeatList);
            addContextListener(GameSeatListModelEvent.SEAT_LIST_ADD, this.addSeatList);
            addContextListener(GameSeatListModelEvent.SEAT_LIST_REMOVE, this.removeSeatList);
            addContextListener(GameSeatListModelEvent.USER_INJECT_MONEY, this.userInjectMoney);
            addContextListener(GameSeatListModelEvent.UP_GROUP, this.upCurrentGroup);
            addContextListener(GameSeatListModelEvent.REFERSH_ALL_USER_MONEY, this.refershAllUserMoney);
            addContextListener(BaijialeUserModelEvent.UP_SEAT, this.upUserSeat);
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            addContextListener(GameSeatListModelEvent.CLEAR_ALL_USER_INJECTMONEY, this.clearAllUserInjectMoney);
            addContextListener(BaijialeModelEvent.CLOSE_LINK, this.closeLink);
            this.view.addEventListener(UserSeatListViewEvent.SELECT_SEAT, this.seletSeat);
            this.view.setBaijialeUser(this.baijialeUser);
        }

        private function initSeatList(_arg1:GameSeatListModelEvent):void
        {
            this.view.initUserSeat((_arg1.data as Array));
        }

        private function refershAllUserMoney(_arg1:GameSeatListModelEvent):void
        {
            this.view.refershALLUserMoney();
        }

        private function closeLink(_arg1:BaijialeModelEvent):void
        {
            this.view.closeLink();
        }

        private function clearAllUserInjectMoney(_arg1:GameSeatListModelEvent):void
        {
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
        }

        protected function seletSeat(_arg1:UserSeatListViewEvent):void
        {
            this.baijialeFms.userSetSeat(_arg1.seat.seat);
        }

        private function upUserSeat(_arg1:BaijialeUserModelEvent):void
        {
        }

        private function upCurrentGroup(_arg1:GameSeatListModelEvent):void
        {
            this.view.upGroup(this.gameSeatList.currentGroup);
        }

        private function userInjectMoney(_arg1:GameSeatListModelEvent):void
        {
            this.view.userInjectMoney(_arg1.seat);
        }

        private function removeSeatList(_arg1:GameSeatListModelEvent):void
        {
            this.view.removeSeatList(_arg1.data);
        }

        private function addSeatList(_arg1:GameSeatListModelEvent):void
        {
            this.view.addSeatList(_arg1.seat);
        }


    }
}//package modules.baijiale.view
