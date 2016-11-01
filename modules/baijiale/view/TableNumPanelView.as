package modules.baijiale.view
{
    import flash.display.*;
    import baijiale.*;

    public class TableNumPanelView extends Sprite 
    {

        private var skin:TableNumPanelSkin;

        public function TableNumPanelView(_arg1:TableNumPanelSkin)
        {
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            addChild(this.skin);
        }

        public function dispose():void
        {
        }

        public function setTableNum(_arg1:uint):void
        {
            this.skin.title.text = (_arg1 - 1).toString();
        }


    }
}//package modules.baijiale.view
