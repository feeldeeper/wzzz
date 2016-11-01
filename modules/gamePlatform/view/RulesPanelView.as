package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import gamePlatform.*;

    public class RulesPanelView extends Sprite 
    {

        private var skin:RulesPanelSkin;
        private var btn:SimpleButton;

        public function RulesPanelView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new RulesPanelSkin();
            addChild(this.skin);
            this.btn = this.skin.btn_close;
            this.btn.addEventListener(MouseEvent.CLICK, this.close);
        }

        protected function close(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("close"));
        }

        public function initReSize():void
        {
            stage.addEventListener(Event.RESIZE, this.reSize);
            this.reSize();
        }

        protected function reSize(_arg1:Event=null):void
        {
            if (!stage)
            {
                return;
            };
            var _local2:uint = stage.stageWidth;
            var _local3:uint = stage.stageHeight;
            this.x = ((_local2 / 2) >> 0);
            this.y = ((_local3 / 2) >> 0);
        }

        public function dispose():void
        {
        }

        public function show(_arg1:String):void
        {
            this.skin.gotoAndStop(_arg1);
        }


    }
}//package modules.gamePlatform.view
