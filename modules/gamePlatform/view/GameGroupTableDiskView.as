package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import modules.gamePlatform.model.vo.*;
    import com.snake.ui.mcontrols.*;
    import com.greensock.loading.*;
    import com.greensock.*;

    public class GameGroupTableDiskView extends Sprite 
    {

        private var skin:MovieClip;
        private var swfLoader:SWFLoader;
        private var swfInit:Boolean;
        private var contentMask:Shape;
        private var contentBox:Sprite;
        private var slSkin:MovieClip;
        private var bgSkin:MovieClip;
        private var sl:MovieToVScrollBar;
        private var huLanSkin:MovieClip;
        private var groupUserSeatList:Array;
        private var userSeatArr:Array;
        private var timer:Timer;
        private var _tableVO:GameTableVO;
        private var _seatId:uint;

        public function GameGroupTableDiskView()
        {
            this.userSeatArr = new Array();
            this.timer = new Timer(3000);
            super();
            this.initDisplay();
        }

        public function get tableVO():GameTableVO
        {
            return (this._tableVO);
        }

        public function set tableVO(_arg1:GameTableVO):void
        {
            this._tableVO = _arg1;
        }

        public function get seatId():uint
        {
            return (this._seatId);
        }

        public function set seatId(_arg1:uint):void
        {
            this._seatId = _arg1;
        }

        private function initDisplay():void
        {
            var _local1:uint;
            var _local2:Class;
            var _local3:Class;
            var _local4:Class;
            var _local5:uint;
            var _local6:uint;
            var _local7:MovieClip;
            if (this.swfInit == false)
            {
                this.swfLoader = LoaderMax.getLoader("userHeader");
                _local2 = this.swfLoader.getClass("otherLib.GroupTableDisk");
                _local3 = this.swfLoader.getClass("otherLib.GroupgameListSL");
                _local4 = this.swfLoader.getClass("otherLib.GroupClose");
                this.bgSkin = new (_local4)();
                this.slSkin = new (_local3)();
                this.bgSkin.x = 1078;
                this.bgSkin.y = 70;
                addChild(this.bgSkin);
                Tools.setButton(this.bgSkin);
                this.bgSkin.addEventListener(MouseEvent.CLICK, this.closeFun);
                this.swfInit = true;
            };
            this.contentBox = new Sprite();
            this.contentBox.x = 22;
            this.contentBox.y = 81;
            this.contentMask = new Shape();
            this.contentMask.graphics.beginFill(0);
            this.contentMask.graphics.drawRect(0, 0, 1010, 650);
            this.contentMask.x = 0;
            this.contentMask.y = 80;
            this.contentMask.width = 1106;
            this.contentMask.height = 570;
            this.contentBox.mask = this.contentMask;
            this.sl = new MovieToVScrollBar(this.slSkin, {
                "hideBool":true,
                "height":580,
                "coordinateBool":false
            }, true, true);
            this.sl.x = 1106;
            this.sl.y = 81;
            this.sl.tabEnabled = false;
            this.sl.tabChildren = false;
            this.sl.content = this.contentBox;
            _local1 = 0;
            while (_local1 < 16)
            {
                this.skin = new (_local2)();
                this.skin.x = ((_local1 % 4) * (this.skin.width + 38));
                this.skin.y = (((_local1 / 4) >> 0) * (this.skin.height + 10));
                this.userSeatArr.push(this.skin);
                this.contentBox.addChild(this.skin);
                Tools.setNoMouse(this.skin.people_mc);
                _local5 = (7 * _local1);
                this.skin.enterGame_mc.addEventListener(MouseEvent.CLICK, this.enterGameFun);
                _local6 = 0;
                while (_local6 < 7)
                {
                    _local7 = this.skin[("btn_" + _local6)];
                    Tools.setButton(_local7);
                    _local7.id = (_local6 + _local5);
                    _local7.subId = _local6;
                    _local7.addEventListener(MouseEvent.CLICK, this.selectSeat);
                    this.skin.people_mc[(("number" + _local6) + "_mc")].visible = false;
                    _local6++;
                };
                _local1++;
            };
            this.sl.upSlider();
        }

        private function enterGameFun(_arg1:MouseEvent):void
        {
            var _local3:MovieClip;
            var _local2:uint;
            while (_local2 < 7)
            {
                _local3 = _arg1.currentTarget.parent.people_mc[(("number" + _local2) + "_mc")];
                if (_local3.visible == false)
                {
                    _arg1.currentTarget.parent[("btn_" + _local2)].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    return;
                };
                _local2++;
            };
        }

        private function selectSeat(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = _arg1.currentTarget.parent.people_mc.getChildByName([(("number" + _arg1.currentTarget.subId) + "_mc")]);
            _local2.visible = true;
            TweenMax.delayedCall(1, this.enterGame, [_arg1.currentTarget.id]);
        }

        private function enterGame(_arg1:uint):void
        {
            this.tableVO.seatId = _arg1;
            this.seatId = _arg1;
            dispatchEvent(new Event("upSelectSeat"));
        }

        private function timerFun(_arg1:TimerEvent):void
        {
            this.showGroupUserSeatPanel();
        }

        public function setGameTableVO(_arg1:Object):void
        {
            var _local2:String;
            this.tableVO = (_arg1 as GameTableVO);
            if (this.tableVO.gameType == "baijiale")
            {
                _local2 = "百家樂";
            }
            else
            {
                _local2 = "龍虎";
            };
            var _local3:uint;
            while (_local3 < this.userSeatArr.length)
            {
                this.userSeatArr[_local3].tableCode_txt.text = (((_local2 + this.tableVO.gameid) + "-") + (_local3 + 1));
                _local3++;
            };
        }

        public function upGameTableVO(_arg1:Object):void
        {
            var _local2:GameTableVO = (_arg1 as GameTableVO);
            if (this.tableVO != null)
            {
                if (this.tableVO.gameTableName == _local2.gameTableName)
                {
                    this.tableVO = _local2;
                };
            };
        }

        public function showGroupUserSeatPanel():void
        {
            if (this.tableVO != null)
            {
                this.groupUserSeatList = this.tableVO.groupUserSeatList;
                this.showGroupUserSeatList();
            };
        }

        private function showGroupUserSeatList():void
        {
            var _local2:Object;
            this.clear();
            var _local1:uint;
            while (_local1 < this.groupUserSeatList.length)
            {
                _local2 = this.getTableSubSeat(this.groupUserSeatList[_local1]);
                this.userSeatArr[_local2.tableNum].people_mc[(("number" + _local2.seatNum) + "_mc")].visible = true;
                _local2 = null;
                _local1++;
            };
        }

        private function getTableSubSeat(_arg1:uint):Object
        {
            var _local2:uint;
            if (_arg1 == 0)
            {
                _local2 = 1;
            }
            else
            {
                _local2 = _arg1;
            };
            if ((_local2 % 7) == 0)
            {
                _local2 = (_arg1 + 1);
            };
            var _local3:Object = new Object();
            var _local4:uint = Math.ceil((_local2 / 7));
            var _local5:uint = Math.abs((((_local4 * 7) - _arg1) - 7));
            _local3.tableNum = (_local4 - 1);
            _local3.seatNum = _local5;
            return (_local3);
        }

        private function clear():void
        {
            var _local2:uint;
            var _local3:uint;
            var _local1:uint;
            while (_local1 < 16)
            {
                _local2 = (7 * _local1);
                _local3 = 0;
                while (_local3 < 7)
                {
                    if ((_local3 + _local2) != this.seatId)
                    {
                        this.userSeatArr[_local1].people_mc[(("number" + _local3) + "_mc")].visible = false;
                    };
                    _local3++;
                };
                _local1++;
            };
        }

        private function closeFun(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("close"));
        }

        public function startTimer():void
        {
            this.timer.start();
        }

        public function stopTimer():void
        {
            this.timer.stop();
        }

        public function addToStage():void
        {
            this.timer.addEventListener(TimerEvent.TIMER, this.timerFun);
            addChild(this.contentBox);
            addChild(this.contentMask);
            addChild(this.sl);
        }

        public function dispose():void
        {
            this.stopTimer();
            this.clear();
            this.timer.removeEventListener(TimerEvent.TIMER, this.timerFun);
            removeChild(this.contentBox);
            removeChild(this.contentMask);
            removeChild(this.sl);
        }


    }
}//package modules.gamePlatform.view
