package modules.gamePlatform.view
{
    import flash.events.*;
    import modules.gamePlatform.model.events.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class GameGroupTableDiskViewMediator extends Mediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;


        private function get view():GameGroupTableDiskView
        {
            return ((viewComponent as GameGroupTableDiskView));
        }

        override public function onRegister():void
        {
            super.onRegister();
            addContextListener(GamePlatformModelEvent.SHOW_GROUP_USER_SEAT_Panel, this.showGroupUserSeatPanel);
            this.view.addEventListener("upSelectSeat", this.upSelectSeatFun);
            this.view.addEventListener("close", this.closeFun);
            this.view.addToStage();
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GamePlatformModelEvent.SHOW_GROUP_USER_SEAT_Panel, this.showGroupUserSeatPanel);
            this.view.removeEventListener("upSelectSeat", this.upSelectSeatFun);
            this.view.removeEventListener("close", this.closeFun);
            this.view.dispose();
        }

        private function showGroupUserSeatPanel(_arg1:GamePlatformModelEvent):void
        {
            this.view.setGameTableVO(_arg1.table);
            this.view.showGroupUserSeatPanel();
            this.view.startTimer();
        }

        private function upUserSeatList(_arg1:GamePlatformModelEvent):void
        {
            this.view.upGameTableVO(_arg1.table);
        }

        private function upSelectSeatFun(_arg1:Event):void
        {
            DebugOutput.add("选了开始斤来啦");
            this.closeFun();
            this.gameModel.gotoGame(this.view.tableVO);
        }

        private function closeFun(_arg1:Event=null):void
        {
            this.view.stopTimer();
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.HIDE_GROUP_USER_SEAT_Panel);
            eventDispatcher.dispatchEvent(_local2);
        }


    }
}//package modules.gamePlatform.view
