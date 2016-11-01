package modules.gamePlatform.view
{
    import modules.gamePlatform.model.events.*;
    import org.robotlegs.mvcs.*;

    public class GamePlatformSoundViewMediator extends Mediator 
    {


        private function get view():GamePlatformSoundView
        {
            return ((viewComponent as GamePlatformSoundView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(GamePlatformModelEvent.CONFING_INIT, this.initSoundModel);
            removeContextListener(GamePlatformModelEvent.PLAY_GENERAL_SOUND, this.playSound);
            this.view.dispose();
        }

        override public function onRegister():void
        {
            addContextListener(GamePlatformModelEvent.CONFING_INIT, this.initSoundModel);
            addContextListener(GamePlatformModelEvent.PLAY_GENERAL_SOUND, this.playSound);
        }

        private function playSound(_arg1:GamePlatformModelEvent):void
        {
            this.view.playSound(String(_arg1.data));
        }

        private function initSoundModel(_arg1:GamePlatformModelEvent):void
        {
            this.view.initSoundModel();
        }


    }
}//package modules.gamePlatform.view
