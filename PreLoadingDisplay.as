package 
{
    import flash.events.*;
    import flash.display.*;
    import gamePlatform.*;

    public class PreLoadingDisplay extends Sprite 
    {

        private var skin:LoadMovieSkin;

        public function PreLoadingDisplay()
        {
            this.skin = new LoadMovieSkin();
            super();
            addChild(this.skin);
            addEventListener(Event.ADDED_TO_STAGE, this.addStage);
        }

        protected function addStage(_arg1:Event):void
        {
        }

        protected function removeStage(_arg1:Event):void
        {
            stage.removeEventListener(Event.RESIZE, this.reSize);
        }

        protected function reSize(_arg1:Event=null):void
        {
            if (!stage)
            {
                return;
            };
            this.x = ((this.stage.stageWidth / 2) >> 0);
            this.y = ((this.stage.stageHeight / 2) >> 0);
        }

        public function show(_arg1:Number, _arg2:String=""):void
        {
            this.skin.label.text = ((_arg2 + _arg1) + "%");
            this.skin.loadmc.width = (_arg1 * 2.789);
        }


    }
}//package 
