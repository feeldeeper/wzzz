package modules.baijiale.view
{
    import flash.display.*;
    import baijiale.*;

    public class BaijialeContainersView extends Sprite 
    {

        private var skin:BaijialeMainSkin;
        private var bg:Sprite;
        private var gameMainInterface:GameInterfaceView;
        private var videoPanel:VideoPanelView;
        private var injectGame:InjectGamePanelView;
        private var totalPot:TotalPotPanelView;
        private var timePanel:TimePanelView;
        private var serverLink:ServerLinkView;
        private var simulations:SimulationsView;
        private var tableNumPanel:TableNumPanelView;
        private var languagePanel:LanguagePanelView;
        private var soudManage:SoundBaijialeManageView;
        private var dealCard:DealCardView;

        public function BaijialeContainersView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new BaijialeMainSkin();
            this.videoPanel = new VideoPanelView(this.skin.videoPanel);
            addChild(this.videoPanel);
            this.simulations = new SimulationsView(this.skin.simulations);
            addChild(this.simulations);
            this.injectGame = new InjectGamePanelView(this.skin.injectGame);
            addChild(this.injectGame);
            this.totalPot = new TotalPotPanelView(this.skin.totalPot);
            this.gameMainInterface = new GameInterfaceView(this.skin.gameMainInterface);
            addChild(this.gameMainInterface);
            this.tableNumPanel = new TableNumPanelView(this.skin.tableNumPanel);
            this.tableNumPanel.mouseChildren = false;
            this.tableNumPanel.mouseEnabled = false;
            addChild(this.tableNumPanel);
            this.timePanel = new TimePanelView(this.skin.timePanel);
            addChild(this.timePanel);
            this.languagePanel = new LanguagePanelView(this.skin.LanguagePanel);
            addChild(this.languagePanel);
            this.soudManage = new SoundBaijialeManageView();
            addChild(this.soudManage);
            this.dealCard = new DealCardView();
            addChild(this.dealCard);
        }

        public function linkOk(_arg1:uint):void
        {
            if (((!((this.serverLink == null))) && (contains(this.serverLink))))
            {
                this.serverLink.showLanguage(_arg1);
                this.serverLink.visible = false;
            };
        }

        private function removeLinkPanel():void
        {
            if (((!((this.serverLink == null))) && (contains(this.serverLink))))
            {
                removeChild(this.serverLink);
            };
        }

        public function startLink(_arg1:uint):void
        {
            if (this.serverLink == null)
            {
                this.serverLink = new ServerLinkView();
            };
            this.serverLink.alpha = 1;
            this.serverLink.visible = true;
            this.serverLink.showLanguage(_arg1);
            addChild(this.serverLink);
        }

        public function addToStage():void
        {
            addChild(this.videoPanel);
            addChild(this.simulations);
            addChild(this.totalPot);
            addChild(this.injectGame);
            addChild(this.gameMainInterface);
            addChild(this.tableNumPanel);
            addChild(this.timePanel);
            addChild(this.languagePanel);
            addChild(this.soudManage);
            addChild(this.dealCard);
        }

        public function dispose():void
        {
            removeChild(this.videoPanel);
            removeChild(this.totalPot);
            removeChild(this.simulations);
            removeChild(this.injectGame);
            removeChild(this.gameMainInterface);
            removeChild(this.tableNumPanel);
            removeChild(this.timePanel);
            removeChild(this.languagePanel);
            removeChild(this.soudManage);
            removeChild(this.dealCard);
        }

        public function simulationsPanel():void
        {
            if (contains(this.simulations))
            {
                removeChild(this.simulations);
            }
            else
            {
                addChild(this.simulations);
            };
        }


    }
}//package modules.baijiale.view
