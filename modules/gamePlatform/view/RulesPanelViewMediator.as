package modules.gamePlatform.view
{
    import flash.events.*;
    import com.snake.managers.*;
    import org.robotlegs.mvcs.*;

    public class RulesPanelViewMediator extends Mediator 
    {


        private function get view():RulesPanelView
        {
            return ((viewComponent as RulesPanelView));
        }

        override public function onRegister():void
        {
            this.view.initReSize();
            this.view.addEventListener("close", this.close);
        }

        protected function close(_arg1:Event):void
        {
            AlertManager.getInstance().remove(this.view);
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.removeEventListener("close", this.close);
            this.view.dispose();
        }


    }
}//package modules.gamePlatform.view
