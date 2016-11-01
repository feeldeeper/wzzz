package modules.gamePlatform.view
{
    import modules.gamePlatform.model.events.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class GameRoomViewMediator extends Mediator 
    {

        [Inject]
        public var gameModel:GamePlatformModel;


        private function get view():GameRoomView
        {
            return ((viewComponent as GameRoomView));
        }

        override public function onRegister():void
        {
            addContextListener(GamePlatformModelEvent.SHOW_GROUP_USER_SEAT_Panel, this.showGroupUserSeatPanel);
            addContextListener(GamePlatformModelEvent.HIDE_GROUP_USER_SEAT_Panel, this.hideGroupUserSeatPanel);
            this.view.addToStage();
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GamePlatformModelEvent.SHOW_GROUP_USER_SEAT_Panel, this.showGroupUserSeatPanel);
            removeContextListener(GamePlatformModelEvent.HIDE_GROUP_USER_SEAT_Panel, this.hideGroupUserSeatPanel);
            this.view.dispose();
        }

        private function showGroupUserSeatPanel(_arg1:GamePlatformModelEvent):void
        {
            this.view.showGroupPanel();
        }

        private function hideGroupUserSeatPanel(_arg1:GamePlatformModelEvent):void
        {
            this.view.hideGroupPanel();
        }


    }
}//package modules.gamePlatform.view
