package modules.gamePlatform.view
{
    import flash.display.*;
    import flash.utils.*;
    import gamePlatform.*;
    import com.greensock.loading.*;

    public class GameTableLunPanView extends GameTableView 
    {

        private var paoPao:MovieClip;
        private var paoPaoLoader:SWFLoader;
        private var timeID:uint;
        private var skin:GameTableLunpanSkin;

        public function GameTableLunPanView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new GameTableLunpanSkin();
            addChild(this.skin);
            this.paoPaoLoader = LoaderMax.getLoader("lobbyRo");
            this.paoPao = (this.paoPaoLoader.rawContent as MovieClip);
            addChild(this.paoPao);
            this.paoPao.y = this.skin.mc_lu.y;
            this.paoPao.x = this.skin.mc_lu.x;
            this.paoPao.width = this.skin.mc_lu.width;
            this.paoPao.height = this.skin.mc_lu.height;
            this.paoPao.play();
            this.timeID = setInterval(this.paoPao.play, 2000);
            addChild(this.skin.coming);
        }

        override public function dispose():void
        {
            clearInterval(this.timeID);
        }


    }
}//package modules.gamePlatform.view
