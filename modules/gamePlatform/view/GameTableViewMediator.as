package modules.gamePlatform.view
{
    import modules.gamePlatform.view.events.*;
    import org.robotlegs.mvcs.*;

    public class GameTableViewMediator extends Mediator 
    {


        private function get view():GameTableView
        {
            return ((viewComponent as GameTableView));
        }

        override public function onRegister():void
        {
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.dispose();
        }

        private function gameRules(_arg1:GameTableViewEvent):void
        {
        }


    }
}//package modules.gamePlatform.view
