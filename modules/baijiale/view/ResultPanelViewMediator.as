package modules.baijiale.view
{
    import org.robotlegs.mvcs.*;

    public class ResultPanelViewMediator extends Mediator 
    {


        private function get view():ResultPanelView
        {
            return ((viewComponent as ResultPanelView));
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
}//package modules.baijiale.view
