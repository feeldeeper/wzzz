package modules.gamePlatform.view
{
    import flash.display.*;
    import gamePlatform.*;
    import com.snake.utils.*;

    public class TopPanelView extends Sprite 
    {

        public var BBS_mc:BBS;
        private var skin:TopPanelSkin;

        public function TopPanelView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new TopPanelSkin();
            addChild(this.skin);
            this.BBS_mc = new BBS(400, 22);
            this.BBS_mc.x = 704;
            this.BBS_mc.y = 69;
            addChild(this.BBS_mc);
        }

        public function showNews(_arg1:String):void
        {
        }

        public function addToStage():void
        {
        }

        public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
