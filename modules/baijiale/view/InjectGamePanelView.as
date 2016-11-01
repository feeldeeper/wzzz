package modules.baijiale.view
{
    import modules.gamePlatform.model.vo.*;
    import flash.events.*;
    import flash.display.*;
    import modules.baijiale.model.events.*;
    import modules.baijiale.view.events.*;
    import baijiale.*;
    import modules.baijiale.view.components.*;
    import modules.baijiale.model.*;
    import com.greensock.*;
    import com.greensock.loading.*;
    import com.snake.managers.*;
    import com.snake.game.*;

    public class InjectGamePanelView extends Sprite 
    {

        public var injectTypeNow:String = "";
        private var btn_allCancel:MovieClip;
        private var btn_cancel:MovieClip;
        private var btn_enter:MovieClip;
        private var chipArrToString:String = "1,2,5,10,20,30,50,100,150,200,300,500,1000,2000,3000,5000,10000,20000,50000,100000,500000,1000000";
        private var dealCard:DealCardView;
        private var otherLibLoader:SWFLoader;
        private var otherLibMc:Sprite;
        private var freebacMc:MovieClip;
        public var limitMax:uint;
        public var limitMin:uint;
        public var tieMax:uint;
        public var pairMax:uint;
        public var diffMax:uint;
        public var gameState:Number;
        private var injectBtnArr:Array;
        private var injectBtnBox:Sprite;
        private var injectMoneyModel:String = "";
        private var injectMoneyMoiveArr:Array;
        private var injectTypeArr:Array;
        private var injectOtherBtnArr:Array;
        private var moneyBox:Sprite;
        private var moneySelectNumber:uint = 0;
        private var mouseStyle:MoneySkin;
        private var mouseStyleBox:Sprite;
        private var chipBtnCoordinate:Array;
        private var oldInject:Object;
        private var oldInjectArr:Array;
        private var skin:InjectGameSkin;
        private var sureInjectData:Object;
        private var userSeatList:UserSeatListView;
        private var resultPanel:ResultPanelView;
        private var allInjectMoney:String;
        private var allInjectMoneyMc:MovieClip;
        private var userBalanceMoney:Number;
        private var _noBetnum:uint;
        private var tableVO:GameTableVO;
        private var tipsPanel:MovieClip;
        public var tipsLimitInfo:Object;
        private var zRate:Number = 0.95;
        private var zdRate:uint = 11;
        private var xdRate:uint = 11;
        private var hRate:uint = 8;
        private var userModel:BaijialeUserModel;

        public function InjectGamePanelView(_arg1:InjectGameSkin)
        {
            this.injectBtnBox = new Sprite();
            this.injectTypeArr = ["z", "h", "x", "zd", "xd"];
            this.injectOtherBtnArr = ["btn_enter", "btn_cancel", "btn_allCancel"];
            this.moneyBox = new Sprite();
            this.mouseStyle = new MoneySkin();
            this.sureInjectData = {};
            this.tipsLimitInfo = {
                "max":0,
                "min":0,
                "z":0,
                "x":0,
                "h":0,
                "zd":0,
                "xd":0
            };
            super();
            this.skin = _arg1;
            this.initDisplay();
        }

        public function get noBetnum():uint
        {
            return (this._noBetnum);
        }

        public function set noBetnum(_arg1:uint):void
        {
            this._noBetnum = _arg1;
        }

        private function initDisplay():void
        {
            var _local1:int;
            var _local2:MovieClip;
            var _local5:InjectMoneyShow;
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            this.otherLibLoader = LoaderMax.getLoader("userHeader");
            var _local3:Class = this.otherLibLoader.getClass("otherLib.tryPanle");
            var _local4:Class = this.otherLibLoader.getClass("otherLib.tipsPanel");
            this.otherLibMc = new (_local3)();
            this.tipsPanel = new (_local4)();
            this.tipsPanel.visible = false;
            Tools.setNoMouse(this.tipsPanel);
            this.injectBtnArr = new Array();
            this.injectBtnBox = new Sprite();
            _local1 = 0;
            while (_local1 < this.injectTypeArr.length)
            {
                _local2 = (this.skin[("mc_" + this.injectTypeArr[_local1])] as MovieClip);
                this.injectBtnArr.push(_local2);
                _local2.id = this.injectTypeArr[_local1];
                _local2.gotoAndStop(1);
                _local2.mouseChildren = false;
                _local2.buttonMode = true;
                _local2.select = false;
                this.injectBtnBox.addChild(_local2);
                _local1++;
            };
            this.injectMoneyMoiveArr = new Array();
            this.moneyBox = this.skin.injectMoneyBox;
            this.moneyBox.mouseChildren = false;
            this.moneyBox.mouseEnabled = false;
            Tools.removeAllChild(this.moneyBox);
            _local1 = 0;
            while (_local1 < this.injectTypeArr.length)
            {
                _local2 = (this.skin.injectMoneyBox[("mc_" + this.injectTypeArr[_local1])] as MovieClip);
                _local2.mouseChildren = false;
                _local2.mouseEnabled = false;
                _local2.buttonMode = true;
                _local5 = new InjectMoneyShow(this.injectTypeArr[_local1]);
                _local5.x = _local2.x;
                _local5.y = _local2.y;
                _local5.scaleX = _local2.scaleX;
                _local5.scaleY = _local2.scaleY;
                this.moneyBox.addChild(_local5);
                this.injectMoneyMoiveArr.push(_local5);
                _local1++;
            };
            this.userSeatList = new UserSeatListView(this.skin.userSeatList);
            Tools.setButton(this.skin.btn_enter);
            this.btn_enter = this.skin.btn_enter;
            this.btn_enter.mouseEnabled = false;
            Tools.setButton(this.skin.btn_cancel);
            this.btn_cancel = this.skin.btn_cancel;
            this.btn_cancel.mouseEnabled = false;
            Tools.setButton(this.skin.btn_allCancel);
            this.btn_allCancel = this.skin.btn_allCancel;
            this.btn_allCancel.mouseEnabled = false;
            this.mouseStyleBox = new Sprite();
            this.mouseStyleBox.mouseChildren = false;
            this.mouseStyleBox.mouseEnabled = false;
            this.mouseStyleBox.addChild(this.mouseStyle);
            this.resultPanel = new ResultPanelView(this.skin.resultPanel);
            this.showEnterBtn();
            this.freebacMc = this.skin.freebac_mc;
            this.freebacMc.visible = false;
            Tools.setNoMouse(this.freebacMc);
            this.userSeatList.mouseChildren = false;
            this.userSeatList.mouseEnabled = false;
        }

        private function otherBtnSwitch(_arg1:Boolean=false):void
        {
            var _local3:MovieClip;
            var _local2:uint;
            _local2 = 0;
            while (_local2 < 6)
            {
                _local3 = this.skin[("injectMoney_" + _local2)];
                _local3.mouseEnabled = _arg1;
                _local2++;
            };
            _local2 = 0;
            while (_local2 < this.injectOtherBtnArr.length)
            {
                _local3 = this.skin[this.injectOtherBtnArr[_local2]];
                _local3.mouseEnabled = _arg1;
                _local2++;
            };
        }

        public function btnClose():void
        {
            var _local2:MovieClip;
            this.injectMoneyModel = "waitSelect";
            this.injectTypeNow = "";
            this.moneySelectNumber = 0;
            MouseManager.getInstance().remove(this.injectBtnBox);
            var _local1:int;
            while (_local1 < this.injectBtnArr.length)
            {
                _local2 = (this.injectBtnArr[_local1] as MovieClip);
                if (_local2)
                {
                    _local2.select = false;
                    _local2.gotoAndStop(1);
                    _local2.mouseEnabled = false;
                };
                _local1++;
            };
            this.otherBtnSwitch(false);
            this.showEnterBtn(false);
        }

        public function btnOpen():void
        {
            var _local2:MovieClip;
            this.injectMoneyModel = "waitSelect";
            this.injectTypeNow = "";
            this.moneySelectNumber = 0;
            MouseManager.getInstance().remove(this.injectBtnBox);
            var _local1:int;
            while (_local1 < this.injectBtnArr.length)
            {
                _local2 = (this.injectBtnArr[_local1] as MovieClip);
                if (_local2)
                {
                    _local2.select = false;
                    _local2.gotoAndStop(1);
                    _local2.mouseEnabled = true;
                };
                _local1++;
            };
            this.otherBtnSwitch(true);
        }

        public function clearAllInject():void
        {
            var _local2:InjectMoneyShow;
            if (((this.oldInjectArr) && ((this.oldInjectArr.length > 0))))
            {
                this.oldInjectArr = new Array();
            };
            var _local1:int;
            while (_local1 < this.injectTypeArr.length)
            {
                _local2 = this.getInjectMoneyBox(this.injectTypeArr[_local1]);
                if (_local1 < 3)
                {
                    _local2.setMoney(0);
                }
                else
                {
                    _local2.setMoney(this.sureInjectData[this.injectTypeArr[_local1]]);
                };
                _local2.alpha = 0;
                _local1++;
            };
        }

        public function clearNowInject():void
        {
            var _local2:int;
            var _local3:Object;
            var _local4:InjectMoneyShow;
            if (this.gameState != 1)
            {
                return;
            };
            var _local1:Object = {};
            _local1.z = 0;
            _local1.x = 0;
            _local1.h = 0;
            _local1.zd = 0;
            _local1.xd = 0;
            _local1.z2 = 0;
            _local1.x2 = 0;
            _local1.z1 = 0;
            _local1.x1 = 0;
            _local1.big = 0;
            _local1.small = 0;
            if (((this.oldInjectArr) && ((this.oldInjectArr.length > 0))))
            {
                this.oldInjectArr.pop();
                _local2 = 0;
                while (_local2 < this.oldInjectArr.length)
                {
                    _local3 = this.oldInjectArr[_local2];
                    _local1[_local3.type] = (_local1[_local3.type] + _local3.money);
                    _local2++;
                };
            };
            _local2 = 0;
            while (_local2 < this.injectTypeArr.length)
            {
                _local4 = this.getInjectMoneyBox(this.injectTypeArr[_local2]);
                _local4.setMoney(_local1[this.injectTypeArr[_local2]]);
                if (_local4.money == this.sureInjectData[this.injectTypeArr[_local2]])
                {
                    _local4.alpha = 1;
                }
                else
                {
                    _local4.alpha = 0.8;
                };
                _local2++;
            };
        }

        public function getInjectBtn(_arg1:String):MovieClip
        {
            if (this.injectTypeArr.indexOf(_arg1) == -1)
            {
                return (null);
            };
            return ((this.skin[("mc_" + _arg1)] as MovieClip));
        }

        public function getInjectMoneyBox(_arg1:String):InjectMoneyShow
        {
            var _local3:InjectMoneyShow;
            var _local2:int;
            while (_local2 < this.injectMoneyMoiveArr.length)
            {
                _local3 = this.injectMoneyMoiveArr[_local2];
                if (_local3.type == _arg1)
                {
                    return (_local3);
                };
                _local2++;
            };
            return (null);
        }

        public function getInjectMoneyData():Object
        {
            var _local2:int;
            var _local3:Object;
            if (!this.oldInjectArr)
            {
                return (null);
            };
            if (!this.oldInject)
            {
                return (null);
            };
            var _local1:Object = {};
            _local1.z = 0;
            _local1.x = 0;
            _local1.h = 0;
            _local1.zd = 0;
            _local1.xd = 0;
            _local1.z2 = 0;
            _local1.x2 = 0;
            _local1.z1 = 0;
            _local1.x1 = 0;
            _local1.big = 0;
            _local1.small = 0;
            if (((this.oldInjectArr) && ((this.oldInjectArr.length > 0))))
            {
                _local2 = 0;
                while (_local2 < this.oldInjectArr.length)
                {
                    _local3 = this.oldInjectArr[_local2];
                    _local1[_local3.type] = (_local1[_local3.type] + _local3.money);
                    _local2++;
                };
            };
            return (_local1);
        }

        public function initInject():void
        {
            var _local2:InjectMoneyShow;
            this.injectMoneyModel = "waitSelect";
            this.injectTypeNow = "";
            this.moneySelectNumber = 0;
            this.oldInjectArr = null;
            this.oldInject = null;
            this.sureInjectData.z = 0;
            this.sureInjectData.x = 0;
            this.sureInjectData.h = 0;
            this.sureInjectData.zd = 0;
            this.sureInjectData.xd = 0;
            this.sureInjectData.z2 = 0;
            this.sureInjectData.x2 = 0;
            this.sureInjectData.z1 = 0;
            this.sureInjectData.x1 = 0;
            this.sureInjectData.big = 0;
            this.sureInjectData.small = 0;
            var _local1:int;
            while (_local1 < this.injectTypeArr.length)
            {
                _local2 = this.getInjectMoneyBox(this.injectTypeArr[_local1]);
                _local2.setMoney(0);
                _local2.alpha = 0;
                _local1++;
            };
        }
		
		public function initInjectMoneyBtn(arr:Array):void
        {
			var movienow:MovieClip;
			var i:int = 0;
			var s:int = 0;
			var m:int = 0;
			if(arr.length < 7)
				s = 7 - arr.length;
			for(var p=0;p<s;p++)
			{
				this.skin[("injectMoney_" + p)].visible = false;
			}
            while (i < arr.length)
            {
				m = i + s;
                this.skin[("injectMoney_" + m)].visible = true;
                this.skin[("injectMoney_" + m)].y = 441.9;
                movienow = (this.skin[("injectMoney_" + m)] as MovieClip);
                movienow.bg.visible = false;
                movienow.mouseChildren = false;
                movienow.buttonMode = true;
                if (arr[i])
                {
                    if (ChipsUtils.containChips(uint(arr[i]), this.chipArrToString))
                    {
                        movienow.gotoAndStop(("m" + uint(arr[i])));
                    }
                    else
                    {
                        movienow.gotoAndStop(1);
                        movienow["label"].text = (arr[i] + "");
                    };
                    movienow.money = uint(arr[i]);
                };
                movienow.addEventListener(MouseEvent.CLICK, this.moneySelectOrInject);
                i++;
            };
            this.initInject();
        }

        public function initInjectMoneyBtn1(_arg1:Array):void
        {
            var _local2:MovieClip;
            var _local4:MovieClip;
            var _local5:Boolean;
            _local2 = (this.skin["injectMoney_0"] as MovieClip);
            _local2.gotoAndStop("m10");
            _local2.money = 10;
            _local2.mouseChildren = false;
            _local2.buttonMode = true;
            _local2.bg.visible = false;
            _local2.addEventListener(MouseEvent.CLICK, this.moneySelectOrInject);
            var _local3:int;
            while (_local3 < _arg1.length)
            {
                this.skin["injectMoney_0"].visible = true;
                this.skin[("injectMoney_" + _local3)].y = 441.9;
                if (_arg1.length < 60)
                {
                    _local4 = (this.skin[("injectMoney_" + (_local3 + 2))] as MovieClip);
                    this.skin["injectMoney_0"].visible = false;
                    this.skin["injectMoney_1"].visible = false;
                }
                else
                {
                    _local4 = (this.skin[("injectMoney_" + (_local3 + 1))] as MovieClip);
                    _local4.visible = true;
                };
                _local4.bg.visible = false;
                _local4.mouseChildren = false;
                _local4.buttonMode = true;
                if (_arg1[_local3])
                {
                    _local5 = ChipsUtils.containChips(uint(_arg1[_local3]), this.chipArrToString);
                    if (_local5)
                    {
                        _local4.gotoAndStop(("m" + uint(_arg1[_local3])));
                    }
                    else
                    {
                        _local4.gotoAndStop(1);
                        _local4["label"].text = (_arg1[_local3] + "");
                    };
                    _local4.money = uint(_arg1[_local3]);
                };
                _local4.addEventListener(MouseEvent.CLICK, this.moneySelectOrInject);
                _local3++;
            };
            this.initInject();
        }

        public function initUserData(_arg1:BaijialeUserModel):void
        {
            var _local2:uint;
            var _local3:InjectMoneyShow;
            if (_arg1.realType == "try")
            {
                this.otherLibMc.x = 66;
                this.otherLibMc.y = 300;
                addChild(this.otherLibMc);
            };
            this.sureInjectData.z = _arg1.z;
            this.sureInjectData.x = _arg1.x;
            this.sureInjectData.h = _arg1.h;
            this.sureInjectData.zd = _arg1.zd;
            this.sureInjectData.xd = _arg1.xd;
            this.sureInjectData.z2 = _arg1.z2;
            this.sureInjectData.x2 = _arg1.x2;
            this.sureInjectData.z1 = _arg1.z1;
            this.sureInjectData.x1 = _arg1.x1;
            this.sureInjectData.big = _arg1.big;
            this.sureInjectData.small = _arg1.small;
            this.userModel = _arg1;
            this.userBalanceMoney = this.userModel.userMoney;
            _local2 = 0;
            while (_local2 < this.injectTypeArr.length)
            {
                _local3 = this.getInjectMoneyBox(this.injectTypeArr[_local2]);
                _local2++;
            };
            this.upInectMoneyNum();
            this.zRate = 0.95;
            this.zdRate = 11;
            this.xdRate = 11;
            this.hRate = 8;
            _local2 = 0;
            while (_local2 < _arg1.customRate.length)
            {
                if (_arg1.customRate[_local2] == 1)
                {
                    this.zRate = 0.9;
                };
                if (_arg1.customRate[_local2] == 2)
                {
                    this.zdRate = 10;
                };
                if (_arg1.customRate[_local2] == 3)
                {
                    this.xdRate = 10;
                };
                if (_arg1.customRate[_local2] == 4)
                {
                    this.hRate = 7;
                };
                _local2++;
            };
        }

        private function upInectMoneyNum():void
        {
            this.skin["allInjectMoney"].text = String(this.getInectMoneyNum());
        }

        private function getOldInjectMoneyNum():uint
        {
            var _local2:Object;
            var _local1:uint;
            for each (_local2 in this.oldInjectArr)
            {
                _local1 = (_local1 + uint(_local2.money));
            };
            return (_local1);
        }

        private function getInectMoneyNum():uint
        {
            var _local2:Object;
            var _local1:uint;
            for each (_local2 in this.sureInjectData)
            {
                _local1 = (_local1 + uint(_local2));
            };
            return (_local1);
        }

        public function injectMoney(_arg1:String, _arg2:uint):void
        {
            this.userBalanceMoney = this.userModel.userMoney;
            if (this.gameState != 1)
            {
                return;
            };
            DebugOutput.add(((("选择了筹码：" + _arg2) + "目标区域") + _arg1));
            var _local3:uint = (this.getNowInjectMoney() + this.moneySelectNumber);
            if ((((((((this.getInjectMoneyData() > this.userBalanceMoney)) || ((_arg2 > this.userBalanceMoney)))) || (((this.getInjectMoneyData() + _arg2) > this.userBalanceMoney)))) || ((_local3 > this.userBalanceMoney))))
            {
                this.showInfoPanel("noMoney");
                return;
            };
            if (this.userBalanceMoney <= this.limitMin)
            {
                this.setDealMoney(_arg1, uint(this.userBalanceMoney));
                return;
            };
            var _local4:String = this.checkChipIn(_arg1, _arg2);
            if (_local4 == "max")
            {
                this.showInfoPanel("upper");
                return;
            };
            this.setDealMoney(_arg1, _arg2);
        }

        private function setDealMoney(_arg1:String, _arg2:uint):void
        {
            var _local6:Object;
            if (this.oldInjectArr == null)
            {
                this.oldInjectArr = new Array();
            };
            if (this.oldInject != null)
            {
            };
            this.oldInject = {};
            this.oldInject.type = _arg1;
            this.oldInject.money = _arg2;
            this.oldInjectArr.push(this.oldInject);
            var _local3:uint;
            var _local4:int;
            while (_local4 < this.oldInjectArr.length)
            {
                _local6 = this.oldInjectArr[_local4];
                if (_local6.type == _arg1)
                {
                    _local3 = (_local3 + _local6.money);
                };
                _local4++;
            };
            var _local5:InjectMoneyShow = this.getInjectMoneyBox(_arg1);
            _local5.setMoney(_local3);
            _local5.alpha = 1;
        }

        public function injectMoneyError(_arg1:Object):void
        {
            DebugOutput.add("下注出错");
            this.clearAllInject();
            if (this.gameState == 1)
            {
                this.btnOpen();
            };
        }

        public function injectMoneyOK(_arg1:Object):void
        {
            var _local3:InjectMoneyShow;
            this.noBetnum = 0;
            this.oldInjectArr = null;
            this.oldInject = null;
            this.sureInjectData.z = _arg1.z;
            this.sureInjectData.x = _arg1.x;
            this.sureInjectData.h = _arg1.h;
            this.sureInjectData.zd = _arg1.zd;
            this.sureInjectData.xd = _arg1.xd;
            this.sureInjectData.z2 = _arg1.z2;
            this.sureInjectData.x2 = _arg1.x2;
            this.sureInjectData.z1 = _arg1.z1;
            this.sureInjectData.x1 = _arg1.x1;
            this.sureInjectData.big = _arg1.big;
            this.sureInjectData.small = _arg1.small;
            this.userBalanceMoney = _arg1.userMoney;
            var _local2:int;
            while (_local2 < this.injectTypeArr.length)
            {
                _local3 = this.getInjectMoneyBox(this.injectTypeArr[_local2]);
                if (_local2 < 3)
                {
                    _local3.setMoney(0);
                }
                else
                {
                    _local3.setMoney(this.sureInjectData[this.injectTypeArr[_local2]]);
                };
                _local3.alpha = 0;
                _local2++;
            };
            if (this.gameState == 1)
            {
                this.btnOpen();
            };
            this.upInectMoneyNum();
        }

        public function setGameState(_arg1:Number):void
        {
            var _local2:int;
            var _local3:MovieClip;
            if (this.gameState == _arg1)
            {
                return;
            };
            if (this.noBetnum > 3)
            {
                dispatchEvent(new Event("noBet"));
            };
            this.gameState = _arg1;
            if (this.gameState == 0)
            {
                MouseManager.getInstance().remove(this.injectBtnBox);
                _local2 = 0;
                while (_local2 < this.injectBtnArr.length)
                {
                    _local3 = (this.injectBtnArr[_local2] as MovieClip);
                    if (_local3)
                    {
                        _local3.select = false;
                        _local3.mouseEnabled = false;
                    };
                    _local2++;
                };
                this.skin.allInjectMoney.text = "0";
            };
            if (this.gameState == 1)
            {
                this.btnOpen();
                this.initInject();
                this.skin.allInjectMoney.text = "0";
            };
            if (this.gameState == 2)
            {
                this.btnClose();
                this.clearAllInject();
            };
        }

        private function playResultMc(name:String):void
        {
            var mc:MovieClip;
            mc = this.getInjectBtn(name);
            mc.gotoAndStop(3);
            TweenMax.delayedCall(6, function ():void
            {
                mc.gotoAndStop(1);
            });
        }

        public function upGameResults(_arg1:Object):void
        {
            var _local5:int;
            if (_arg1.zxh == 0)
            {
                this.playResultMc("z");
                this.getInjectMoneyBox("z").showWin();
                this.getInjectMoneyBox("x").showLose();
                this.getInjectMoneyBox("h").showLose();
            }
            else
            {
                if (_arg1.zxh == 1)
                {
                    this.playResultMc("x");
                    this.getInjectMoneyBox("x").showWin();
                    this.getInjectMoneyBox("z").showLose();
                    this.getInjectMoneyBox("h").showLose();
                }
                else
                {
                    this.playResultMc("h");
                    this.getInjectMoneyBox("h").showWin();
                    this.getInjectMoneyBox("x").showWin();
                    this.getInjectMoneyBox("z").showWin();
                };
            };
            if (_arg1.zbool)
            {
                this.playResultMc("zd");
                this.getInjectMoneyBox("zd").showWin();
            }
            else
            {
                this.getInjectMoneyBox("zd").showLose();
            };
            if (_arg1.xbool)
            {
                this.playResultMc("xd");
                this.getInjectMoneyBox("xd").showWin();
            }
            else
            {
                this.getInjectMoneyBox("xd").showLose();
            };
            Tools.setTimeOut(this.upGameResultsBtnLightOver, 8000);
            var _local2:uint;
            var _local3:Number = 0;
            var _local4:Number = 0;
            _local5 = 0;
            while (_local5 < this.injectTypeArr.length)
            {
                _local2 = (_local2 + this.sureInjectData[this.injectTypeArr[_local5]]);
                _local5++;
            };
            if (this.tableVO.rateType == 1)
            {
                if (_arg1.zhuangPoints == 6)
                {
                    _arg1.zRate = 0.5;
                }
                else
                {
                    _arg1.zRate = 1;
                };
            }
            else
            {
                _arg1.zRate = 0.95;
            };
            switch (_arg1.zxh)
            {
                case 0:
                    if (this.sureInjectData["z"] > 0)
                    {
						// if(this.sureInjectData["z"] == 10 || this.sureInjectData["z"] == 30 || this.sureInjectData["z"] == 50 || this.sureInjectData["z"] == 70 || this.sureInjectData["z"] == 90)
							// _local3 = _local3 + this.sureInjectData["z"] + this.sureInjectData["z"] - ((this.sureInjectData["z"]+10) * this.zRate);
						// else
						_local3 = (_local3 + ((this.sureInjectData["z"] * this.zRate) + this.sureInjectData["z"]));
                    };
                    break;
                case 1:
                    if (this.sureInjectData["x"] > 0)
                    {
                        _local3 = (_local3 + ((this.sureInjectData["x"] * 1) + this.sureInjectData["x"]));
                    };
                    break;
                case 2:
                    if (this.sureInjectData["h"] > 0)
                    {
                        _local3 = (_local3 + ((this.sureInjectData["h"] * 8) + this.sureInjectData["h"]));
                    };
                    _local3 = (_local3 + this.sureInjectData["z"]);
                    _local3 = (_local3 + this.sureInjectData["x"]);
                    break;
            };
            if ((((_arg1.zbool == true)) && ((this.sureInjectData["zd"] > 0))))
            {
                _local3 = (_local3 + ((this.sureInjectData["zd"] * 11) + this.sureInjectData["zd"]));
            };
            if ((((_arg1.xbool == true)) && ((this.sureInjectData["xd"] > 0))))
            {
                _local3 = (_local3 + ((this.sureInjectData["xd"] * 11) + this.sureInjectData["xd"]));
            };
            if (_arg1.bigSmall == false)
            {
                if (this.sureInjectData["small"] > 0)
                {
                    _local3 = (_local3 + ((this.sureInjectData["small"] * 1.5) + this.sureInjectData["small"]));
                };
            }
            else
            {
                if (this.sureInjectData["big"] > 0)
                {
                    _local3 = (_local3 + ((this.sureInjectData["big"] * 0.54) + this.sureInjectData["big"]));
                };
            };
            if (_arg1.xOdd == true)
            {
                if (this.sureInjectData["x1"] > 0)
                {
                    _local3 = (_local3 + ((this.sureInjectData["x1"] * 0.96) + this.sureInjectData["x1"]));
                };
            }
            else
            {
                if (this.sureInjectData["x2"] > 0)
                {
                    _local3 = (_local3 + ((this.sureInjectData["x2"] * 0.9) + this.sureInjectData["x2"]));
                };
            };
            if (_arg1.zOdd == true)
            {
                if (this.sureInjectData["z1"] > 0)
                {
                    _local3 = (_local3 + ((this.sureInjectData["z1"] * 0.94) + this.sureInjectData["z1"]));
                };
            }
            else
            {
                if (this.sureInjectData["z2"] > 0)
                {
                    _local3 = (_local3 + ((this.sureInjectData["z2"] * 0.94) + this.sureInjectData["z2"]));
                };
            };
            var _local6:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.GAME_SOUND_PLAYERBYNAME);
            if (_local2 > 1)
            {
                _local4 = (_local3 - _local2);
                if (_local4 > 1)
                {
                    this.resultPanel.showLabel(("+" + _local4.toFixed(2)));
                    _local6.data = {
                        "rsl":"main",
                        "name":"Win"
                    };
                    dispatchEvent(_local6);
                }
                else
                {
                    _local6.data = {
                        "rsl":"main",
                        "name":"Lost"
                    };
                    dispatchEvent(_local6);
                    this.resultPanel.showLabel(_local4.toFixed(2));
                };
            }
            else
            {
                _local6.data = {
                    "rsl":"main",
                    "name":"NoBettinginthisgame"
                };
                dispatchEvent(_local6);
                _local4 = 0;
                this.noBetnum++;
                this.resultPanel.showLabel("0");
            };
            this.userSeatList.chipWinMovie(_arg1);
        }

        private function upGameResultsBtnLightOver(_arg1:Object=null):void
        {
            if (this.gameState == 0)
            {
                this.btnClose();
            };
        }

        protected function cancelAllInjectMoney(_arg1:MouseEvent):void
        {
            this.btnOpen();
            this.clearAllInject();
        }

        protected function cancelInjectMoney(_arg1:MouseEvent):void
        {
            this.clearNowInject();
        }

        protected function injectBtnClick(_arg1:MouseEvent):void
        {
            var _local3:int;
            var _local4:MovieClip;
            if (this.gameState != 1)
            {
                return;
            };
            if (this.injectMoneyModel == "waitSelect")
            {
                this.injectMoneyModel = "injectModel2";
            };
            var _local2:MovieClip = (_arg1.target as MovieClip);
            this.injectTypeNow = _local2.id;
            if (this.injectMoneyModel == "default")
            {
                _local2.gotoAndStop(1);
                this.injectMoney(this.injectTypeNow, this.moneySelectNumber);
            }
            else
            {
                _local3 = 0;
                while (_local3 < this.injectBtnArr.length)
                {
                    _local4 = this.injectBtnArr[_local3];
                    _local4.select = false;
                    _local4.gotoAndStop(1);
                    _local3++;
                };
                _local2.select = true;
                _local2.gotoAndStop(4);
            };
        }

        protected function injectBtnOut(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if ((((this.injectMoneyModel == "default")) || ((this.injectMoneyModel == "waitSelect"))))
            {
                _local2.gotoAndStop(1);
            }
            else
            {
                if (_local2.select == false)
                {
                    _local2.gotoAndStop(1);
                }
                else
                {
                    _local2.gotoAndStop(4);
                };
            };
            this.tipsPanel.visible = false;
        }

        protected function injectBtnOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if ((((this.injectMoneyModel == "default")) || ((this.injectMoneyModel == "waitSelect"))))
            {
                _local2.gotoAndStop(2);
            }
            else
            {
                _local2.gotoAndStop(4);
            };
        }

        private function showBetTips(_arg1:MouseEvent):void
        {
            this.tipsPanel.visible = true;
            this.tipsPanel.x = (mouseX + 6);
            this.tipsPanel.y = (mouseY + 6);
            var _local2:MovieClip = (_arg1.target as MovieClip);
			var leftmoneybet:int = this.tipsLimitInfo.max - this.tipsLimitInfo.z - this.tipsLimitInfo.x - this.tipsLimitInfo.h - this.tipsLimitInfo.zd - this.tipsLimitInfo.xd;
            switch (_local2.id)
            {
                case "z":
                    this.tipsPanel.betTypeTxt.text = "庄";
                    this.tipsPanel.oddsTxt.text = 0.95;
                    // this.tipsPanel.limitTxt.text = ((uint(this.tipsLimitInfo.max) - this.tipsLimitInfo.z) + this.tipsLimitInfo.x);
					if(leftmoneybet>((this.diffMax - this.tipsLimitInfo.z) + this.tipsLimitInfo.x))
						this.tipsPanel.limitTxt.text = ((this.diffMax - this.tipsLimitInfo.z) + this.tipsLimitInfo.x);
					else
						this.tipsPanel.limitTxt.text = leftmoneybet;
                    return;
                case "x":
                    this.tipsPanel.betTypeTxt.text = "闲";
                    this.tipsPanel.oddsTxt.text = "1";
                    // this.tipsPanel.limitTxt.text = ((uint(this.tipsLimitInfo.max) - this.tipsLimitInfo.x) + this.tipsLimitInfo.z);
					if(leftmoneybet > ((this.diffMax - this.tipsLimitInfo.x) + this.tipsLimitInfo.z))
						this.tipsPanel.limitTxt.text = ((this.diffMax - this.tipsLimitInfo.x) + this.tipsLimitInfo.z);
					else
						this.tipsPanel.limitTxt.text = leftmoneybet;
                    return;
                case "h":
                    this.tipsPanel.betTypeTxt.text = "和";
                    this.tipsPanel.oddsTxt.text = this.hRate.toString();
                    // this.tipsPanel.limitTxt.text = (uint((this.tipsLimitInfo.max / 8)) - this.tipsLimitInfo.h);
					if(leftmoneybet > (this.tieMax - this.tipsLimitInfo.h))
						this.tipsPanel.limitTxt.text = (this.tieMax - this.tipsLimitInfo.h);
					else
						this.tipsPanel.limitTxt.text = leftmoneybet;
                    return;
                case "zd":
                    this.tipsPanel.betTypeTxt.text = "庄对";
                    this.tipsPanel.oddsTxt.text = this.zdRate.toString();
                    // this.tipsPanel.limitTxt.text = (uint((this.tipsLimitInfo.max / 11)) - this.tipsLimitInfo.zd);
					if(leftmoneybet > (this.pairMax - this.tipsLimitInfo.zd - this.tipsLimitInfo.xd))
						this.tipsPanel.limitTxt.text = (this.pairMax - this.tipsLimitInfo.zd - this.tipsLimitInfo.xd);
					else
						this.tipsPanel.limitTxt.text = leftmoneybet;
                    return;
                case "xd":
                    this.tipsPanel.betTypeTxt.text = "闲对";
                    this.tipsPanel.oddsTxt.text = this.xdRate.toString();
                    // this.tipsPanel.limitTxt.text = (uint((this.tipsLimitInfo.max / 11)) - this.tipsLimitInfo.xd);
					if(leftmoneybet > (this.pairMax - this.tipsLimitInfo.zd - this.tipsLimitInfo.xd))
						this.tipsPanel.limitTxt.text = (this.pairMax - this.tipsLimitInfo.zd - this.tipsLimitInfo.xd);
					else
						this.tipsPanel.limitTxt.text = leftmoneybet;
                    return;
            };
        }

        private function getAllInjectMoneyByType(_arg1:String):uint
        {
            var _local2:uint = (this.sureInjectData[_arg1] + this.getNowInjectMoneyByType(_arg1));
            if (_local2 == 0)
            {
                _local2 = 9999999;
            };
            return (_local2);
        }

        private function checkChipIn(_arg1:String, _arg2:uint):String
        {
            var _local3:String;
            var _local4:Object = this.getInjectMoneyData();
            // var _local5:uint = ((this.sureInjectData.h + _arg2) + this.getNowInjectMoneyByType("h"));
            // var _local6:uint = (this.sureInjectData.x + this.getNowInjectMoneyByType("x"));
            // var _local7:uint = (this.sureInjectData.z + this.getNowInjectMoneyByType("z"));
            // var _local8:uint = ((this.sureInjectData.xd + _arg2) + this.getNowInjectMoneyByType("xd"));
            // var _local9:uint = ((this.sureInjectData.zd + _arg2) + this.getNowInjectMoneyByType("zd"));
			
			var _local5:uint = ((this.tipsLimitInfo.h + _arg2) + this.getNowInjectMoneyByType("h"));
            var _local6:uint = (this.tipsLimitInfo.x + this.getNowInjectMoneyByType("x"));
            var _local7:uint = (this.tipsLimitInfo.z + this.getNowInjectMoneyByType("z"));
            var _local8:uint = ((this.tipsLimitInfo.xd + _arg2) + this.getNowInjectMoneyByType("xd"));
            var _local9:uint = ((this.tipsLimitInfo.zd + _arg2) + this.getNowInjectMoneyByType("zd"));
            
			
            var _local10:uint = ((this.sureInjectData.big + _arg2) + this.getNowInjectMoneyByType("big"));
            var _local11:uint = ((this.sureInjectData.small + _arg2) + this.getNowInjectMoneyByType("small"));
            var _local12:uint = (this.getInectMoneyNum() + _arg2);
            // var _local13:uint = ((this.getNowInjectMoney() + _arg2) + this.getInectMoneyNum());
            var _local13:uint = ((this.getNowInjectMoney() + _arg2) + this.tipsLimitInfo.z + this.tipsLimitInfo.x + this.tipsLimitInfo.h + this.tipsLimitInfo.zd + this.tipsLimitInfo.xd);
            var _local14:int = ((_local7 - _local6) + _arg2);
            var _local15:int = ((_local6 - _local7) + _arg2);
            var _local16:uint = (this.limitMax / 10);
            var limitZD:uint = this.pairMax;
            var limitXD:uint = this.pairMax;
            var limitH:uint = this.tieMax;
            var limitZXC:uint = this.diffMax;
            if (_local13 < 1)
            {
                _local13 = _arg2;
            };
            if ((((_local12 > this.limitMax)) || ((_local13 > this.limitMax))))
            {
				_local3 = "max";
            };
            // if ((((_local5 > _local16)) && ((_arg1 == "h"))))
            // {
                // _local3 = "max";
            // };
			if ((((_local5 > limitH)) && ((_arg1 == "h"))))
            {
                _local3 = "max";
            };
            if ((((_local15 > limitZXC)) && ((_arg1 == "x"))))
            {
                _local3 = "max";
            };
            if ((((_local14 > limitZXC)) && ((_arg1 == "z"))))
            {
                _local3 = "max";
            };
            var _local17:uint = (_local7 + _arg2);
            var _local18:uint = (_local6 + _arg2);
            if ((((((_arg1 == "z")) && (!((_local14 == 0))))) && ((_local17 > this.limitMax))))
            {
                if (_local14 > (_local18 * -0.1))
                {
                };
            };
            if ((((((_arg1 == "x")) && (!((_local15 == 0))))) && ((_local18 > this.limitMax))))
            {
                if (_local15 > (_local17 * -0.1))
                {
                };
            };
            // if (((((_local8 - _local9) >= _local16)) && ((_arg1 == "xd"))))
            // {
                // _local3 = "max";
            // };
            // if (((((_local9 - _local8) >= _local16)) && ((_arg1 == "zd"))))
            // {
                // _local3 = "max";
            // };
			if ((((_local8 + _local9 - _arg2) > limitXD) && _arg1 == "xd"))
            {
                _local3 = "max";
            };
            if ((((_local8 + _local9 - _arg2) > limitZD) && ((_arg1 == "zd"))))
            {
                _local3 = "max";
            };
            // if (((((_local10 * 0.54) > this.limitMax)) && ((_arg1 == "big"))))
            // {
                // _local3 = "max";
            // };
            // if (((((_local11 * 1.5) > this.limitMax)) && ((_arg1 == "small"))))
            // {
                // _local3 = "max";
            // };
            return (_local3);
        }

        protected function moneySelectOrInject(_arg1:MouseEvent):void
        {
            if (this.gameState != 1)
            {
                return;
            };
            if (this.injectMoneyModel == "waitSelect")
            {
                this.injectMoneyModel = "default";
            };
            var _local2:MovieClip = (_arg1.target as MovieClip);
            var _local3:uint;
            while (_local3 < 7)
            {
                this.skin[("injectMoney_" + _local3)].y = 441.9;
                this.skin[("injectMoney_" + _local3)].bg.visible = false;
                _local3++;
            };
            _local2.y = (_local2.y - 10);
            _local2.bg.visible = true;
            var _local4:uint = _local2.money;
            this.moneySelectNumber = _local4;
            var _local5:Boolean = ChipsUtils.containChips(_local4, this.chipArrToString);
            if (_local5)
            {
                this.mouseStyle.gotoAndStop(("m" + _local4));
            }
            else
            {
                this.mouseStyle.gotoAndStop(1);
                this.mouseStyle["label"].text = (_local4 + "");
            };
            this.mouseStyle.money = uint(_local4);
            if (this.injectMoneyModel == "injectModel2")
            {
                this.injectMoney(this.injectTypeNow, this.moneySelectNumber);
                MouseManager.getInstance().remove(this.injectBtnBox);
            }
            else
            {
                MouseManager.getInstance().push(this.injectBtnBox, this.mouseStyleBox, true);
            };
            this.showEnterBtn(true);
        }

        protected function postInjectMoney(_arg1:MouseEvent):void
        {
            var _local7:int;
            if (((!(this.oldInjectArr)) || (!(this.oldInject))))
            {
                this.showInfoPanel("selectBet");
                return;
            };
            if (this.injectMoneyModel == "waitSelect")
            {
                this.showInfoPanel("selectBet");
                return;
            };
            var _local2:uint = (this.getOldInjectMoneyNum() + this.getInectMoneyNum());
            if ((((_local2 < this.limitMin)) && ((this.userBalanceMoney > this.limitMin))))
            {
                this.showInfoPanel("lower");
                return;
            };
            var _local3:uint = (this.sureInjectData.x + this.getNowInjectMoneyByType("x"));
            var _local4:uint = (this.sureInjectData.z + this.getNowInjectMoneyByType("z"));
            var _local5:uint = ((this.sureInjectData.x + this.getNowInjectMoneyByType("x")) + this.moneySelectNumber);
            var _local6:uint = ((this.sureInjectData.z + this.getNowInjectMoneyByType("z")) + this.moneySelectNumber);
            var _local8:uint = Math.max(_local5, _local6);
            if ((((_local3 > 0)) && ((_local4 > 0))))
            {
                // if (_local3 == _local4)
                // {
                    // this.showInfoPanel("upper");//庄闲对打 一样的
                    // return;
                // };
                // if (_local3 > _local4)
                // {
                    // _local7 = (_local3 - _local4);
                // }
                // else
                // {
                    // _local7 = (_local4 - _local3);
                // };
                // if (_local7 < (_local8 * 0.02))
                // {
                    // this.showInfoPanel("upper");
                    // return;
                // };
				// if (_local7 < (_local8 * 0.02))
                // {
                    // this.showInfoPanel("upper");
                    // return;
                // };
            };
            this.btnClose();
            dispatchEvent(new InjectGamePanelViewEvent(InjectGamePanelViewEvent.INJECT_MONEY));
            this.showEnterBtn();
        }

        private function showEnterBtn(_arg1:Boolean=false):void
        {
            if (this.userBalanceMoney < this.limitMin)
            {
                this.btn_enter.language.gotoAndStop(2);
            }
            else
            {
                this.btn_enter.language.gotoAndStop(1);
            };
            this.btn_enter.visible = _arg1;
            this.btn_cancel.visible = _arg1;
            this.btn_allCancel.visible = _arg1;
        }

        private function getNowInjectMoneyByType(_arg1:String):uint
        {
            var _local3:Object;
            var _local2:uint;
            for each (_local3 in this.oldInjectArr)
            {
                if (_local3.type == _arg1)
                {
                    _local2 = (_local2 + uint(_local3.money));
                };
            };
            return (_local2);
        }

        private function getNowInjectMoney():uint
        {
            var _local2:Object;
            var _local1:uint;
            for each (_local2 in this.oldInjectArr)
            {
                _local1 = (_local1 + uint(_local2.money));
            };
            return (_local1);
        }

        private function showInfoPanel(_arg1:String):void
        {
            var _local2:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.GAME_INFO_PANEL_SHOW);
            _local2.data = {"info":_arg1};
            dispatchEvent(_local2);
        }

        public function setTableVO(_arg1:GameTableVO):void
        {
            this.tableVO = _arg1;
            if (this.tableVO)
            {
                if (this.tableVO.rateType == 1)
                {
                    this.freebacMc.visible = true;
                }
                else
                {
                    this.freebacMc.visible = false;
                };
            };
        }

        public function addToStage():void
        {
            var _local1:MovieClip;
            addChild(this.skin);
            addChild(this.injectBtnBox);
            addChild(this.freebacMc);
            addChild(this.userSeatList);
            addChild(this.skin.injectMoneyBox);
            addChild(this.btn_enter);
            addChild(this.btn_cancel);
            addChild(this.btn_allCancel);
            addChild(this.tipsPanel);
            addChild(this.resultPanel);
            this.btn_enter.addEventListener(MouseEvent.CLICK, this.postInjectMoney);
            this.btn_cancel.addEventListener(MouseEvent.CLICK, this.cancelInjectMoney);
            this.btn_allCancel.addEventListener(MouseEvent.CLICK, this.cancelAllInjectMoney);
            var _local2:uint;
            while (_local2 < this.injectTypeArr.length)
            {
                _local1 = (this.skin[("mc_" + this.injectTypeArr[_local2])] as MovieClip);
                _local1.addEventListener(MouseEvent.MOUSE_OVER, this.injectBtnOver);
                _local1.addEventListener(MouseEvent.MOUSE_OUT, this.injectBtnOut);
                _local1.addEventListener(MouseEvent.CLICK, this.injectBtnClick);
                _local1.addEventListener(MouseEvent.MOUSE_MOVE, this.showBetTips);
                _local2++;
            };
            addChild(this.skin["injectMoney_0"]);
            addChild(this.skin["injectMoney_1"]);
            addChild(this.skin["injectMoney_2"]);
            addChild(this.skin["injectMoney_3"]);
            addChild(this.skin["injectMoney_4"]);
            addChild(this.skin["injectMoney_5"]);
            addChild(this.skin["injectMoney_6"]);
        }

        public function upUserBalanceMoney(_arg1:Number):void
        {
            this.userBalanceMoney = _arg1;
        }

        public function dispose():void
        {
            var _local1:MovieClip;
            removeChild(this.skin);
            removeChild(this.injectBtnBox);
            removeChild(this.skin.injectMoneyBox);
            removeChild(this.userSeatList);
            removeChild(this.btn_enter);
            removeChild(this.btn_cancel);
            removeChild(this.btn_allCancel);
            removeChild(this.tipsPanel);
            removeChild(this.resultPanel);
            removeChild(this.freebacMc);
            this.btn_enter.removeEventListener(MouseEvent.CLICK, this.postInjectMoney);
            this.btn_cancel.removeEventListener(MouseEvent.CLICK, this.cancelInjectMoney);
            this.btn_allCancel.removeEventListener(MouseEvent.CLICK, this.cancelAllInjectMoney);
            var _local2:uint;
            while (_local2 < this.injectTypeArr.length)
            {
                _local1 = (this.skin[("mc_" + this.injectTypeArr[_local2])] as MovieClip);
                _local1.removeEventListener(MouseEvent.MOUSE_OVER, this.injectBtnOver);
                _local1.removeEventListener(MouseEvent.MOUSE_OUT, this.injectBtnOut);
                _local1.removeEventListener(MouseEvent.CLICK, this.injectBtnClick);
                _local2++;
            };
            this.noBetnum = 0;
        }


    }
}//package modules.baijiale.view
