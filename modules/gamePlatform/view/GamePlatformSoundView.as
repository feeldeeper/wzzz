package modules.gamePlatform.view
{
    import flash.display.*;
    import flash.media.*;
    import com.greensock.loading.*;
    import com.greensock.*;

    public class GamePlatformSoundView extends Sprite 
    {

        private var assetsLangageArr:Array;
        private var assetsArr:Array;
        private var soundRslLoader:SWFLoader;
        private var BettingStarted:Sound;
        private var BettingStopped:Sound;
        private var NoBettinginthisgame:Sound;
        private var ChipInOk:Sound;
        private var ChipError:Sound;
        private var BtnSelect:Sound;
        private var BtnClick:Sound;
        private var Win:Sound;
        private var DI:Sound;
        private var soundRslIsInit:Boolean = false;
        private var aniPanelIsInit:Boolean = false;
        private var winAniPaneLoader:SWFLoader;
        private var firstWinPanel1:MovieClip;
        private var firstWinPanel2:MovieClip;
        private var firstWinPanel3:MovieClip;
        private var firstWinPanel4:MovieClip;
        private var firstWinFlag:uint = 0;

        public function GamePlatformSoundView()
        {
            this.assetsLangageArr = ["BettingStarted", "BettingStopped", "NoBettinginthisgame"];
            this.assetsArr = ["ChipInOk", "ChipError", "BtnSelect", "BtnClick", "Win", "DI"];
            super();
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
        }

        public function initSoundModel():void
        {
            var _local1:String;
            var _local2:String;
            var _local3:Class;
            var _local4:Class;
            this.soundRslLoader = LoaderMax.getLoader("gameStateSoundRsl");
            if (this.soundRslIsInit == false)
            {
                for each (_local1 in this.assetsLangageArr)
                {					 
                    _local3 = this.soundRslLoader.getClass((_local1 + "_sc"));
                    this[_local1] = new (_local3)();
                };
                for each (_local2 in this.assetsArr)
                {
					if(_local2!="DI")
					{					 
                    _local4 = this.soundRslLoader.getClass(_local2);
                    this[_local2] = new (_local4)();
					}
                };
                this.soundRslIsInit = true;
            };
        }

        public function dispose():void
        {
        }

        public function playSound(_arg1:String):void
        {
            this.initAniWinpanel();
            if (_arg1 == "Win")
            {
                this.firstWinFlag++;
                switch (this.firstWinFlag)
                {
                    case 1:
                        this.showAniWinpanel(1);
                        break;
                    case 2:
                        this.showAniWinpanel(2);
                        break;
                    case 3:
                        this.showAniWinpanel(3);
                        break;
                    case 4:
                        this.showAniWinpanel(4);
                        break;
                };
            }
            else
            {
                if (_arg1 == "Lost")
                {
                    this.firstWinFlag = 0;
                };
            };
            if (_arg1 != "Lost")
            {
                if (((this[_arg1]) && ((this[_arg1] is Sound))))
                {
                    this[_arg1].play();
                };
            };
        }

        private function initAniWinpanel():void
        {
            var _local1:uint;
            var _local2:Class;
            if (this.aniPanelIsInit == false)
            {
                this.winAniPaneLoader = LoaderMax.getLoader("winAniPaneLoader");
                _local1 = 1;
                while (_local1 < 5)
                {
                    _local2 = this.winAniPaneLoader.getClass(("winAniPane.firstWin" + _local1));
                    this[("firstWinPanel" + _local1)] = new (_local2)();
                    this[("firstWinPanel" + _local1)].stop();
                    this[("firstWinPanel" + _local1)].x = 300;
                    this[("firstWinPanel" + _local1)].y = 210;
                    _local1++;
                };
                this.aniPanelIsInit = true;
            };
        }

        private function showAniWinpanel(_arg1:uint):void
        {
            addChild(this[("firstWinPanel" + _arg1)]);
            this[("firstWinPanel" + _arg1)].gotoAndStop(1);
            this[("firstWinPanel" + _arg1)].play();
            TweenMax.delayedCall(1.56, this.stopAniWinPanel);
            TweenMax.delayedCall(5, this.removeAniWinPanel);
        }

        private function stopAniWinPanel():void
        {
            this.firstWinPanel1.stop();
            this.firstWinPanel2.stop();
            this.firstWinPanel3.stop();
            this.firstWinPanel4.stop();
        }

        private function removeAniWinPanel():void
        {
            var _local1:uint = 1;
            while (_local1 < 5)
            {
                if (this.contains(this[("firstWinPanel" + _local1)]))
                {
                    removeChild(this[("firstWinPanel" + _local1)]);
                };
                _local1++;
            };
        }


    }
}//package modules.gamePlatform.view
