package modules.baijiale.view
{
    import flash.display.*;
    import baijiale.*;

    public class ResultPanelView extends Sprite 
    {

        private var skin:ResultPanelSkin;
        private var settle:MovieClip;

        public function ResultPanelView(_arg1:ResultPanelSkin)
        {
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            this.settle = this.skin.mc_settle;
            this.skin.removeChild(this.settle);
        }

        public function showLabel(_arg1:String):void
        {
            addChild(this.settle);
            if (_arg1 != "0")
            {
                this.skin.mc_settle.mLang.gotoAndStop(1);
                this.skin.mc_settle.label.visible = true;
                this.skin.mc_settle.label.text = _arg1;
            }
            else
            {
                this.skin.mc_settle.mLang.gotoAndStop(2);
                this.skin.mc_settle.label.visible = false;
            };
            Tools.setTimeOut(this.settleOver, 5000);
        }

        private function settleOver(_arg1:Object=null):void
        {
            if (this.contains(this.settle))
            {
                removeChild(this.settle);
            };
        }

        public function addToStage():void
        {
            addChild(this.skin);
        }

        public function dispose():void
        {
            removeChild(this.skin);
        }


    }
}//package modules.baijiale.view
