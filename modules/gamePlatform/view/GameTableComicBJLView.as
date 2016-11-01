package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import modules.gamePlatform.view.events.*;
    import modules.gamePlatform.model.vo.*;
    import gamePlatform.*;
    import modules.gamePlatform.view.components.*;
    import com.greensock.loading.*;

    public class GameTableComicBJLView extends GameTableView 
    {

        private var paoPao:MovieClip;
        private var paoPaoLoader:SWFLoader;
        private var timeID:uint;
        private var loadSkin:TableLoadingSkin;
        private var skin:GameTableComicBJLSkin;
        private var btn_StartGame:MovieClip;
        private var helpBtn:MovieClip;
        private var waitPanel:GameTableRoomWaitPanelView;

        public function GameTableComicBJLView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.loadSkin = new TableLoadingSkin();
            this.loadSkin.gotoAndStop(1);
            this.skin = new GameTableComicBJLSkin();
            this.waitPanel = new GameTableRoomWaitPanelView();
            this.btn_StartGame = this.skin.mc_startGame;
            Tools.setButton(this.btn_StartGame);
            this.helpBtn = this.skin.help;
            Tools.setButton(this.helpBtn);
            this.paoPaoLoader = LoaderMax.getLoader("lobbyMuba");
            this.paoPao = (this.paoPaoLoader.rawContent as MovieClip);
            addChild(this.skin);
            this.btn_StartGame.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.skin.mc_lu.buttonMode = true;
            this.skin.mc_lu.addEventListener(MouseEvent.CLICK, this.tableWaitGoToGameFun);
            this.helpBtn.addEventListener(MouseEvent.CLICK, this.helpBtnFun);
            this.skin.rateType_mc.addEventListener(MouseEvent.CLICK, this.rateTypeFun);
            this.skin.rateType_mc.visible = false;
            addChild(this.paoPao);
            this.paoPao.y = (this.waitPanel.y = this.skin.mc_lu.y);
            this.paoPao.x = (this.waitPanel.x = this.skin.mc_lu.x);
            this.paoPao.width = (this.waitPanel.width = this.skin.mc_lu.width);
            this.paoPao.height = (this.waitPanel.height = this.skin.mc_lu.height);
            this.paoPao.play();
            this.timeID = setInterval(this.paoPao.play, 2000);
        }

        private function rateTypeFun(_arg1:MouseEvent):void
        {
            if (_arg1.currentTarget.currentFrame == 1)
            {
                _arg1.currentTarget.gotoAndStop(2);
                tableVO.rateType = 1;
            }
            else
            {
                tableVO.rateType = 0;
                _arg1.currentTarget.gotoAndStop(1);
            };
        }

        private function helpBtnFun(_arg1:MouseEvent):void
        {
            var _local2:Event = new Event("showRule");
            dispatchEvent(_local2);
        }

        protected function tableWaitGoToGameFun(_arg1:MouseEvent):void
        {
            tableWaitGoToGame();
        }

        public function showWaitPanel(_arg1:GameMoneyGroup, _arg2:String):void
        {
            var _local3:Object;
            if (this.waitPanel == null)
            {
                this.waitPanel = new GameTableRoomWaitPanelView();
                this.waitPanel.x = this.skin.mc_lu.x;
                this.waitPanel.y = this.skin.mc_lu.y;
            };
            this.waitPanel.addEventListener("selectMoneyGroup", this.selectMoneyGroup);
            if (_arg2 == "custom")
            {
                this.waitPanel.visible = false;
            };
            var _local4:uint = uint(tableVO.gameid);
            if ((((_arg2 == "custom")) && ((_local4 < 80))))
            {
                _local3 = {
                    "min":0,
                    "max":0
                };
            };
            this.waitPanel.setMoneyGroup(_arg1, _arg2, _local4, _local3);
            if (!contains(this.waitPanel))
            {
                addChild(this.waitPanel);
            };
        }

        protected function selectMoneyGroup(_arg1:DataEvent):void
        {
            var _local2:GameTableViewEvent = new GameTableViewEvent(GameTableViewEvent.GOTO_GAME_MONEYGROUP);
            _local2.moneyTypeGroup = _arg1.data;
            dispatchEvent(_local2);
        }

        public function hitWaitPanel():void
        {
            if (((this.waitPanel) && (contains(this.waitPanel))))
            {
                this.waitPanel.removeEventListener("selectMoneyGroup", this.selectMoneyGroup);
                removeChild(this.waitPanel);
            };
        }

        public function startLoad():void
        {
            if (!contains(this.loadSkin))
            {
                addChild(this.loadSkin);
            };
            this.loadSkin.txt_loading.text = "";
        }

        public function hitLoad():void
        {
            if (contains(this.loadSkin))
            {
                removeChild(this.loadSkin);
            };
            this.loadSkin.txt_loading.text = "";
        }

        public function showProgress(_arg1:Number):void
        {
            var _local2:Number = ((_arg1 * 100) >> 0);
            this.loadSkin.txt_loading.text = (_local2 + "%");
        }

        public function initTable():void
        {
        }

        public function upTime():void
        {
        }

        public function addZero(_arg1:Number):String
        {
            var _local2 = "";
            if (_arg1 <= 9)
            {
                _local2 = ("0" + _arg1);
            }
            else
            {
                _local2 = ("" + _arg1);
            };
            return (_local2);
        }

        public function upGameHistory():void
        {
        }

        public function upGameState():void
        {
        }

        public function upFarmer():void
        {
        }

        private function clear():void
        {
        }

        public function addToStage():void
        {
        }

        override public function dispose():void
        {
            this.clear();
            clearInterval(this.timeID);
        }


    }
}//package modules.gamePlatform.view
