package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import com.snake.ui.mcontrols.*;
    import gamePlatform.*;

    public class GameRoomContentView extends Sprite 
    {

        private var skin:GameRoomContentSkin;
        private var gameList:GameListView;
        private var contentMask:Shape;
        private var contentBox:Sprite;
        private var sl:MovieToVScrollBar;

        public function GameRoomContentView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            var _local3:MovieClip;
            this.skin = new GameRoomContentSkin();
            this.contentBox = new Sprite();
            this.contentMask = new Shape();
            this.contentMask.graphics.beginFill(0);
            this.contentMask.graphics.drawRect(0, 0, 100, 100);
            addChild(this.contentMask);
            this.contentBox.mask = this.contentMask;
            this.contentMask.x = (this.contentBox.x = this.skin.gameListBox.x);
            this.contentMask.y = (this.contentBox.y = this.skin.gameListBox.y);
            this.contentMask.width = this.skin.gameListBox.width;
            this.contentMask.height = 572;
            Tools.removeAllChild(this.skin.gameListBox);
            this.sl = new MovieToVScrollBar(this.skin.gameListSL, {
                "hideBool":true,
                "height":580,
                "coordinateBool":false
            }, true, true);
            this.sl.tabEnabled = false;
            this.sl.tabChildren = false;
            this.sl.content = this.contentBox;
            this.gameList = new GameListView();
            var _local1:Array = new Array();
            var _local2:int;
            while (_local2 < 4)
            {
                _local3 = (this.skin[("btn_" + _local2)] as MovieClip);
                _local3.addEventListener("upSelect", this.navSelectFun);
                _local1.push(_local3);
                _local3.language.gotoAndStop((_local2 + 1));
                _local2++;
            };
            Tools.setSelectArr(_local1, 0);
            this.navSelect("gameList");
            this.contentBox.addChild(this.gameList);
            this.gameList.addEventListener("initOK", this.gameListInitOK);
            this.gameList.x = 15;
            this.gameList.y = 0;
        }

        private function gameListInitOK(_arg1:Event):void
        {
            this.sl.upSlider();
        }

        protected function navSelectFun(_arg1:Event):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2.id == 0)
            {
                this.navSelect("gameList");
            };
            if (_local2.id == 1)
            {
                this.navSelect("lhList");
            };
            if (_local2.id == 2)
            {
                this.navSelect("otherList");
            };
            if (_local2.id == 3)
            {
                this.navSelect("niu");
            };
        }

        public function navSelect(_arg1:String):void
        {
            Tools.removeAllChild(this.gameList);
            if (_arg1 == "gameList")
            {
                this.gameList.addChild(this.gameList.bjlPanel);
            };
            if (_arg1 == "lhList")
            {
                this.gameList.addChild(this.gameList.lhPanel);
            };
            if (_arg1 == "otherList")
            {
                this.gameList.addChild(this.gameList.otherPanel);
            };
            if (_arg1 == "niu")
            {
                this.gameList.addChild(this.gameList.niuPanel);
            };
            this.sl.gotoTheTop();
            this.sl.upSlider();
            this.sl.computeContentSize();
        }

        public function addToStage():void
        {
            addChild(this.skin);
            addChild(this.contentBox);
        }

        public function dispose():void
        {
            removeChild(this.skin);
            removeChild(this.contentBox);
        }


    }
}//package modules.gamePlatform.view
