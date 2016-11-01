package modules.gamePlatform.view
{
    import flash.events.*;
    import modules.gamePlatform.view.events.*;
    import com.snake.managers.*;
    import org.robotlegs.mvcs.*;

    public class AlertDefaultViewMediator extends Mediator 
    {


        private function get view():AlertDefaultView
        {
            return ((viewComponent as AlertDefaultView));
        }

        override public function onRegister():void
        {
            this.view.initReSize();
            this.view.addEventListener(AlertDefaultViewEvent.CLOSE, this.close);
        }

        protected function close(_arg1:Event):void
        {
            AlertManager.getInstance().remove(this.view);
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.view.removeEventListener(AlertDefaultViewEvent.CLOSE, this.close);
            this.view.dispose();
        }


    }
}//package modules.gamePlatform.view
