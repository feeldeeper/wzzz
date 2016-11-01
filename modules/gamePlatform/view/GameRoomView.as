package modules.gamePlatform.view
{
    import flash.display.*;
    import gamePlatform.*;
    import com.greensock.loading.*;

    public class GameRoomView extends Sprite 
    {

        private var userInfo:UserInfoView;
        private var gameContent:GameRoomContentView;
        private var topPanel:TopPanelView;
        private var skin:GameRoomSkin;
        private var groupTableDisk:GameGroupTableDiskView;
        private var isInit:Boolean;
        private var swfLoader:SWFLoader;

        public function GameRoomView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            if (this.isInit == false)
            {
                this.swfLoader = LoaderMax.getLoader("userHeader");
                this.isInit = true;
            };
            this.skin = new GameRoomSkin();
            this.topPanel = new TopPanelView();
            this.topPanel.tabEnabled = false;
            this.topPanel.tabChildren = false;
            this.topPanel.x = 10;
            this.topPanel.y = 10;
            this.gameContent = new GameRoomContentView();
            this.gameContent.tabEnabled = false;
            this.gameContent.tabChildren = false;
            this.gameContent.y = 159;
            this.gameContent.x = 0;
            this.userInfo = new UserInfoView();
            this.userInfo.tabEnabled = false;
            this.userInfo.tabChildren = false;
            this.userInfo.x = 0;
            this.userInfo.y = 0;
            this.groupTableDisk = new GameGroupTableDiskView();
            this.groupTableDisk.y = 82;
            this.groupTableDisk.x = -4;
        }

        public function showGroupPanel():void
        {
            removeChild(this.gameContent);
            this.groupTableDisk.visible = true;
        }

        public function hideGroupPanel():void
        {
            addChild(this.gameContent);
            this.groupTableDisk.visible = false;
        }

        public function addToStage():void
        {
            addChild(this.skin);
            addChild(this.topPanel);
            addChild(this.gameContent);
            addChild(this.userInfo);
            this.groupTableDisk.visible = false;
            addChild(this.groupTableDisk);
        }

        public function dispose():void
        {
            removeChild(this.skin);
            removeChild(this.topPanel);
            removeChild(this.gameContent);
            removeChild(this.userInfo);
            this.groupTableDisk.visible = false;
            removeChild(this.groupTableDisk);
        }


    }
}//package modules.gamePlatform.view
