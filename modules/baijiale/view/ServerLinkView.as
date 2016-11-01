package modules.baijiale.view
{
    import flash.display.*;
    import baijiale.*;

    public class ServerLinkView extends Sprite 
    {

        private var skin:ServerLinkSkin;

        public function ServerLinkView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new ServerLinkSkin();
            addChild(this.skin);
        }

        public function dispose():void
        {
        }

        public function showLanguage(_arg1:uint):void
        {
            this.skin.mc.language.gotoAndStop(_arg1);
        }


    }
}//package modules.baijiale.view
