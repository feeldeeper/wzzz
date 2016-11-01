package modules.gamePlatform.view
{
    import org.robotlegs.mvcs.*;

    public class GameRoomContentViewMediator extends Mediator 
    {


        private function get view():GameRoomContentView
        {
            return ((viewComponent as GameRoomContentView));
        }

        override public function onRegister():void
        {
            this.view.addToStage();
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.dispose();
        }


    }
}//package modules.gamePlatform.view
