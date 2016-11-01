package 
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.*;
    import flash.ui.*;

    public class GamePlatform extends Sprite 
    {

        private var context:GamePlatformContext;
        private var originalFrameRate:uint = 15;
        private var standbyFrameRate:uint = 1;

        public function GamePlatform()
        {
            this.contextMenu = new ContextMenu();
            this.contextMenu.hideBuiltInItems();
            addEventListener(Event.ADDED_TO_STAGE, this.addStage);
        }

        protected function addStage(_arg1:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.addStage);
            this.init();
        }

        private function init():void
        {
            DebugOutput.setStage(stage);
            DebugOutput.add("GamePlatform init");
            stage.addEventListener(Event.ACTIVATE, this.onActivate);
            stage.addEventListener(Event.DEACTIVATE, this.onDeactivate);
            this.context = new GamePlatformContext(this);
			trace("init finish");
        }

        private function onActivate(_arg1:Event):void
        {
        }

        private function onDeactivate(_arg1:Event):void
        {
        }

        public function onMetaData(_arg1:Object):void
        {
        }


    }
}//package 
