package modules.baijiale.view
{
    import flash.display.*;
    import baijiale.*;

    public class LanguagePanelView extends Sprite 
    {

        private var isShowRouteListPanel:Boolean;
        private var skin:LanguagePanelSkin;

        public function LanguagePanelView(_arg1:LanguagePanelSkin)
        {
            this.skin = _arg1;
            this.initDisplay();
            this.mouseChildren = false;
            this.mouseEnabled = false;
        }

        private function initDisplay():void
        {
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            this.skin.language.gotoAndStop(1);
        }

        public function setTableNum(_arg1:uint):void
        {
            this.skin.gotoAndStop(_arg1);
        }

        public function addToStage():void
        {
            addChild(this.skin);
        }

        public function showAllRoutePanel():void
        {
            if (this.isShowRouteListPanel == false)
            {
                this.skin.language.gotoAndStop(2);
                this.isShowRouteListPanel = true;
            }
            else
            {
                this.skin.language.gotoAndStop(1);
                this.isShowRouteListPanel = false;
            };
        }

        public function dispose():void
        {
            removeChild(this.skin);
        }


    }
}//package modules.baijiale.view
