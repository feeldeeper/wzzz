package modules.baijiale.view
{
    import modules.gamePlatform.model.vo.events.*;
    import org.robotlegs.mvcs.*;

    public class GotoTableBtnViewMediator extends Mediator 
    {


        private function get view():GotoTableBtnView
        {
            return ((viewComponent as GotoTableBtnView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.tableVO.removeEventListener(GameTableVOEvent.UP_TIME, this.upTime);
            this.view.tableVO.removeEventListener(GameTableVOEvent.UP_GAMESTATE, this.upGameState);
            this.view.dispose();
        }

        override public function onRegister():void
        {
            this.view.tableVO.addEventListener(GameTableVOEvent.UP_TIME, this.upTime);
            this.view.tableVO.addEventListener(GameTableVOEvent.UP_GAMESTATE, this.upGameState);
            this.view.addToStage();
        }

        protected function upGameState(_arg1:GameTableVOEvent):void
        {
            this.view.upGameState();
        }

        protected function upTime(_arg1:GameTableVOEvent):void
        {
            this.view.upTime();
        }


    }
}//package modules.baijiale.view
