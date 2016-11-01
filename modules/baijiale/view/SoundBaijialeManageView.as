package modules.baijiale.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.media.*;
    import com.greensock.*;
    import com.snake.utils.*;

    public class SoundBaijialeManageView extends Sprite 
    {

        private var gameAssets:SWFLibrary;
        public var gameID:uint;
        private var assetsArr:Array;
        private var Banker:Sound;
        private var Banker0:Sound;
        private var Banker1:Sound;
        private var Banker2:Sound;
        private var Banker3:Sound;
        private var Banker4:Sound;
        private var Banker5:Sound;
        private var Banker6:Sound;
        private var Banker7:Sound;
        private var Banker8:Sound;
        private var Banker9:Sound;
        private var Player:Sound;
        private var Player0:Sound;
        private var Player1:Sound;
        private var Player2:Sound;
        private var Player3:Sound;
        private var Player4:Sound;
        private var Player5:Sound;
        private var Player6:Sound;
        private var Player7:Sound;
        private var Player8:Sound;
        private var Player9:Sound;
        private var PlayerWin:Sound;
        private var BankerWin:Sound;
        private var Tie:Sound;
        private var Playerdrawcard:Sound;
        private var Bankerdrawcard:Sound;
        private var GameDealSound:Sound;
        public var rslInit:Boolean = false;

        public function SoundBaijialeManageView()
        {
            this.assetsArr = ["Banker", "Player", "Banker0", "Banker1", "Banker2", "Banker3", "Banker4", "Banker5", "Banker6", "Banker7", "Banker8", "Banker9", "Player0", "Player1", "Player2", "Player3", "Player4", "Player5", "Player6", "Player7", "Player8", "Player9", "PlayerWin", "BankerWin", "Tie", "Playerdrawcard", "Bankerdrawcard"];
            super();
            this.initDisplay();
        }

        private function initDisplay():void
        {
        }

        public function initLoad(_arg1:String):void
        {
            //var _local2 = ((_arg1 + "") + "modules/baijiale/soundRsl.jpg");
			var _local2 = ("assets/soundRsl.swf");
            //if (_arg1 == "")
			if(false)
            {
                this.gameAssets = new SWFLibrary(0);
				//this.gameAssets = new SWFLibrary(3);
            }
            else
            {
                this.gameAssets = new SWFLibrary(3);
            };
            this.gameAssets.load(_local2);
            this.gameAssets.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
        }

        private function loaderCompleteHandler(_arg1:Event):void
        {
            var _local2:String;
            for each (_local2 in this.assetsArr)
            {
                this[_local2] = this.gameAssets.getSound((_local2 + "_sc"));
            };
            this.GameDealSound = this.gameAssets.getSound("GameDealSound");
            this.rslInit = true;
            this.gameAssets.removeEventListener(Event.COMPLETE, this.loaderCompleteHandler);
        }

        public function playSoundByName(_arg1:String):void
        {
            if (!this.rslInit)
            {
                return;
            };
            if (this[_arg1] != null)
            {
                this[_arg1].play();
            };
        }

        public function upGameResults(_arg1:Object):void
        {
            var _local4:String;
            var _local2:uint = _arg1.zhuangPoints;
            var _local3:uint = _arg1.xiangPoints;
            if (this.gameID > 80)
            {
                this.playSoundByName(("Player" + _local3));
                TweenMax.delayedCall(2, this.playSoundByName, [("Banker" + _local2)]);
            };
            switch (_arg1.zxh)
            {
                case 0:
                    _local4 = "BankerWin";
                    break;
                case 1:
                    _local4 = "PlayerWin";
                    break;
                case 2:
                    _local4 = "Tie";
                    break;
            };
            this.playSoundByName(_local4);
        }

        public function upGameDeal(_arg1:Object):void
        {
            var _local2:uint;
            if (_arg1 != null)
            {
                _local2 = (_arg1.dealArr.length - 1);
                if ((((_local2 == 0)) || ((_local2 == 2))))
                {
                    TweenMax.delayedCall(2, this.playSoundByName, ["Player"]);
                }
                else
                {
                    if ((((_local2 == 1)) || ((_local2 == 3))))
                    {
                        TweenMax.delayedCall(2, this.playSoundByName, ["Banker"]);
                    };
                };
                if ((((_local2 == 3)) && ((_arg1.dealEnd == false))))
                {
                    if (_arg1.addPokerFlag == false)
                    {
                        TweenMax.delayedCall(2.2, this.playSoundByName, ["Playerdrawcard"]);
                    }
                    else
                    {
                        TweenMax.delayedCall(2.2, this.playSoundByName, ["Bankerdrawcard"]);
                    };
                };
                if ((((_local2 == 4)) && ((_arg1.dealEnd == false))))
                {
                    TweenMax.delayedCall(2.2, this.playSoundByName, ["Bankerdrawcard"]);
                };
            };
        }

        public function dispose():void
        {
            TweenMax.killDelayedCallsTo(this.playSoundByName);
        }


    }
}//package modules.baijiale.view
