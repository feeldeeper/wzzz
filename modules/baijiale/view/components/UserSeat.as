package modules.baijiale.view.components
{
    import flash.events.*;
    import flash.display.*;
    import baijiale.*;
    import modules.baijiale.model.*;
    import modules.baijiale.model.seat.*;
    import com.greensock.*;
    import com.greensock.loading.*;

    public class UserSeat extends Sprite 
    {

        public var header:MovieClip;
        private var dingWei:MoneySkinOne;
        private var dingWeiLoseCoordinate:Object;
        private var mc_h:MoneySkinOne;
        private var mc_x:MoneySkinOne;
        private var mc_z:MoneySkinOne;
        private var mc_zd:MoneySkinOne;
        private var mc_xd:MoneySkinOne;
        private var mc_big:MoneySkinOne;
        private var mc_small:MoneySkinOne;
        private var dingWeiLose:InjectMoneyShow;
        private var isInit:Boolean;
        private var swfLoader:SWFLoader;
        private var chipSkinArr:Array;
        public var baijialeUser:BaijialeUserModel;
        private var _seat:SeatModel;
        private var _userTableNum:uint;
        private var _userid:String;
        private var chinBtnCoordinate:Array;
        private var nowUser:String;
        private var nowUserSeat:SeatModel;
        private var skin:MovieClip;
        private var userBox:UserInfoPanelSkin;

        public function UserSeat(_arg1:MovieClip)
        {
            var _local5:String;
            var _local6:Class;
            this.chipSkinArr = ["mc_z", "mc_x", "mc_h", "mc_zd", "mc_xd", "mc_big", "mc_small"];
            super();
            this.skin = _arg1;
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            addChild(this.skin);
            var _local2:uint;
            while (_local2 < this.chipSkinArr.length)
            {
                _local5 = this.chipSkinArr[_local2];
                this[_local5] = (this.skin.getChildByName(_local5) as MoneySkinOne);
                this[_local5].label.text = "0";
                this[_local5].visible = false;
                this[_local5].mouseChildren = false;
                this[_local5].mouseEnabled = false;
                _local2++;
            };
            this.dingWei = (this.skin.getChildByName("dingWei") as MoneySkinOne);
            this.dingWei.visible = false;
            var _local3:MovieClip = (this.skin.getChildByName("dingWeiLose") as MovieClip);
            _local3.visible = false;
            if (this.isInit == false)
            {
                this.swfLoader = LoaderMax.getLoader("userHeader");
                _local6 = this.swfLoader.getClass("other.MoneySkinOneNoFilter");
                this.dingWeiLose = new InjectMoneyShow("dingWeiLose");
                this.dingWeiLose.skin = _local6;
                this.isInit = true;
            };
            this.dingWeiLose.x = _local3.x;
            this.dingWeiLose.y = _local3.y;
            this.dingWeiLose.scaleX = _local3.scaleX;
            this.dingWeiLose.scaleY = _local3.scaleY;
            this.dingWeiLose.visible = false;
            this.dingWeiLose.setMoney(0);
            addChild(this.dingWeiLose);
            this.dingWeiLoseCoordinate = {
                "x":this.dingWeiLose.x,
                "y":this.dingWeiLose.y
            };
            this.chinBtnCoordinate = [{
                "x":this.mc_z.x,
                "y":this.mc_z.y
            }, {
                "x":this.mc_x.x,
                "y":this.mc_x.y
            }, {
                "x":this.mc_h.x,
                "y":this.mc_h.y
            }, {
                "x":this.mc_zd.x,
                "y":this.mc_zd.y
            }, {
                "x":this.mc_xd.x,
                "y":this.mc_xd.y
            }, {
                "x":this.mc_big.x,
                "y":this.mc_big.y
            }, {
                "x":this.mc_small.x,
                "y":this.mc_small.y
            }];
            this.mouseChildren = false;
            this.buttonMode = true;
            var _local4:Sprite = (this.skin.getChildByName("bg") as Sprite);
            Tools.setHitArea(this, _local4);
            this.userBox = (_arg1.user as UserInfoPanelSkin);
            this.header = this.userBox.header;
            this.userBox.text_user.text = "";
            this.userBox.text_money.text = "";
            this.userBox.visible = false;
            this.mc_small.visible = false;
            this.mc_big.visible = false;
        }

        public function injectMoney():void
        {
            this.zxhShow();
        }

        private function selectSeat(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("selectSeat"));
        }

        public function get seat():SeatModel
        {
            return (this._seat);
        }

        public function get seatNum():Number
        {
            if (!this.seat)
            {
                return (-1);
            };
            return (this._seat.seat);
        }

        public function setSeat(_arg1:SeatModel):void
        {
            this._seat = _arg1;
        }

        public function setUserTableNum(_arg1:uint):void
        {
            this._userTableNum = _arg1;
        }

        public function upUser():void
        {
            if (((this.seat) && (!((this.seat.userid == "")))))
            {
                this.userBox.text_user.text = this.seat.userid;
                if (this.baijialeUser.userid == this.seat.userid)
                {
                    this.userBox.text_money.text = (this.baijialeUser.userMoney + "");
                    this.userBox.bg.gotoAndStop(2);
                    this.zxhShow();
                }
                else
                {
                    if (((this.seat.seat / 7) >> 0) == ((this.baijialeUser.seat / 7) >> 0))
                    {
                        this.userBox.text_money.text = (this.seat.userMoney + "");
                        this.zxhShow();
                    }
                    else
                    {
                        this.userBox.text_money.text = "";
                        this.hideUserBox();
                    };
                    this.userBox.bg.gotoAndStop(1);
                };
                this.userBox.visible = true;
            }
            else
            {
                this.userBox.visible = false;
                this.hideUserBox();
            };
        }

        public function hideUserBox(_arg1:uint=0):void
        {
            this.killTweenMax();
            this.mc_z.x = this.chinBtnCoordinate[0].x;
            this.mc_z.y = this.chinBtnCoordinate[0].y;
            this.mc_x.x = this.chinBtnCoordinate[1].x;
            this.mc_x.y = this.chinBtnCoordinate[1].y;
            this.mc_h.x = this.chinBtnCoordinate[2].x;
            this.mc_h.y = this.chinBtnCoordinate[2].y;
            this.mc_zd.x = this.chinBtnCoordinate[3].x;
            this.mc_zd.y = this.chinBtnCoordinate[3].y;
            this.mc_xd.x = this.chinBtnCoordinate[4].x;
            this.mc_xd.y = this.chinBtnCoordinate[4].y;
            this.mc_big.x = this.chinBtnCoordinate[5].x;
            this.mc_big.y = this.chinBtnCoordinate[5].y;
            this.mc_small.x = this.chinBtnCoordinate[6].x;
            this.mc_small.y = this.chinBtnCoordinate[6].y;
            this.dingWeiLose.x = this.dingWeiLoseCoordinate.x;
            this.dingWeiLose.y = this.dingWeiLoseCoordinate.y;
            this.mc_z.label.text = "0";
            this.mc_x.label.text = "0";
            this.mc_h.label.text = "0";
            this.mc_zd.label.text = "0";
            this.mc_xd.label.text = "0";
            this.mc_big.label.text = "0";
            this.mc_small.label.text = "0";
            this.dingWeiLose.setMoney(0);
            this.mc_z.visible = false;
            this.mc_h.visible = false;
            this.mc_x.visible = false;
            this.mc_zd.visible = false;
            this.mc_xd.visible = false;
            this.mc_big.visible = false;
            this.mc_small.visible = false;
            this.dingWei.visible = false;
            this.dingWeiLose.visible = false;
        }

        private function zxhShow():void
        {
            if (this.seat.z > 0)
            {
                this.mc_z.visible = true;
                this.mc_z.label.text = (this.seat.z + "");
                if (this.baijialeUser.userid == this.seat.userid)
                {
                    this.mc_z.bg.gotoAndStop(2);
                }
                else
                {
                    this.mc_z.bg.gotoAndStop(1);
                };
            };
            if (this.seat.h > 0)
            {
                this.mc_h.visible = true;
                this.mc_h.label.text = (this.seat.h + "");
                if (this.baijialeUser.userid == this.seat.userid)
                {
                    this.mc_h.bg.gotoAndStop(2);
                }
                else
                {
                    this.mc_h.bg.gotoAndStop(1);
                };
            };
            if (this.seat.x > 0)
            {
                this.mc_x.visible = true;
                this.mc_x.label.text = (this.seat.x + "");
                if (this.baijialeUser.userid == this.seat.userid)
                {
                    this.mc_x.bg.gotoAndStop(2);
                }
                else
                {
                    this.mc_x.bg.gotoAndStop(1);
                };
            };
            if (this.seat.zd > 0)
            {
                this.mc_zd.visible = true;
                this.mc_zd.label.text = (this.seat.zd + "");
                if (this.baijialeUser.userid == this.seat.userid)
                {
                    this.mc_zd.bg.gotoAndStop(2);
                }
                else
                {
                    this.mc_zd.bg.gotoAndStop(1);
                };
            };
            if (this.seat.xd > 0)
            {
                this.mc_xd.visible = true;
                this.mc_xd.label.text = (this.seat.xd + "");
                if (this.baijialeUser.userid == this.seat.userid)
                {
                    this.mc_xd.bg.gotoAndStop(2);
                }
                else
                {
                    this.mc_xd.bg.gotoAndStop(1);
                };
            };
            if (this.seat.big > 0)
            {
                this.mc_big.visible = true;
                this.mc_big.label.text = (this.seat.big + "");
            };
            if (this.seat.small > 0)
            {
                this.mc_small.visible = true;
                this.mc_small.label.text = (this.seat.small + "");
            };
            this.refreshMoney();
        }

        private function refreshMoney():void
        {
            this.userBox.text_money.text = String(this.seat.userMoney);
        }

        public function chipWinMovie(_arg1:Object):void
        {
            var _local2:uint;
            var _local3:uint;
            var _local4:uint;
            var _local5:uint;
            var _local6:uint;
            var _local7:uint;
            var _local8:uint;
            if (_arg1.zxh == 0)
            {
                _local2 = uint(this.mc_z.label.text);
                if (_local2 > 0)
                {
                    this.dingWeiLose.setMoney(uint((_local2 * _arg1.zRate)));
                };
                this.movieToLose(this.mc_x);
                this.movieToLose(this.mc_h);
            }
            else
            {
                if (_arg1.zxh == 1)
                {
                    _local3 = uint(this.mc_x.label.text);
                    if (_local3 > 0)
                    {
                        this.dingWeiLose.setMoney((_local3 * 1));
                    };
                    this.movieToLose(this.mc_z);
                    this.movieToLose(this.mc_h);
                }
                else
                {
                    _local4 = uint(this.mc_h.label.text);
                    if (_local4 > 0)
                    {
                        this.dingWeiLose.setMoney((_local4 * 8));
                    };
                    this.movieToLose(this.mc_z);
                    this.movieToLose(this.mc_x);
                };
            };
            if (_arg1.zbool)
            {
                _local5 = uint(this.mc_zd.label.text);
                if (_local5 > 0)
                {
                    this.dingWeiLose.setMoney((uint((_local5 * 11)) + this.dingWeiLose.money));
                };
            }
            else
            {
                this.movieToLose(this.mc_zd);
            };
            if (_arg1.xbool)
            {
                _local6 = uint(this.mc_xd.label.text);
                if (_local6 > 0)
                {
                    this.dingWeiLose.setMoney((uint((_local6 * 11)) + this.dingWeiLose.money));
                };
            }
            else
            {
                this.movieToLose(this.mc_xd);
            };
            if (_arg1.bigSmall)
            {
                _local7 = uint(this.mc_big.label.text);
                if (_local7 > 0)
                {
                    this.dingWeiLose.setMoney((uint((_local7 * 0.5)) + this.dingWeiLose.money));
                };
                this.movieToLose(this.mc_small);
            }
            else
            {
                _local8 = uint(this.mc_small.label.text);
                if (_local8 > 0)
                {
                    this.dingWeiLose.setMoney((uint((_local8 * 1.5)) + this.dingWeiLose.money));
                };
                this.movieToLose(this.mc_big);
            };
            TweenMax.delayedCall(1, this.dividend);
            TweenMax.delayedCall(5, this.hideUserBox);
        }

        private function movieToLose(mc:MovieClip):void
        {
            TweenLite.to(mc, 1, {
                "x":this.dingWeiLose.x,
                "y":this.dingWeiLose.y,
                "onComplete":function ():void
                {
                    mc.label.text = "0";
                    mc.visible = false;
                }
            });
        }

        private function dividend():void
        {
            if (this.dingWeiLose.money != 0)
            {
                this.dingWeiLose.visible = true;
            }
            else
            {
                this.dingWeiLose.visible = false;
                this.dingWeiLose.setMoney(0);
            };
            if (this.mc_z.label.text != "0")
            {
                TweenLite.to(this.dingWeiLose, 1, {
                    "x":this.mc_z.x,
                    "y":this.mc_z.y,
                    "onComplete":function ():void
                    {
                        sumDividend(mc_z);
                        sumZd();
                    }
                });
            };
            if (this.mc_x.label.text != "0")
            {
                TweenLite.to(this.dingWeiLose, 1, {
                    "x":this.mc_x.x,
                    "y":this.mc_x.y,
                    "onComplete":function ():void
                    {
                        sumDividend(mc_x);
                        sumZd();
                    }
                });
            };
            if (this.mc_h.label.text != "0")
            {
                TweenLite.to(this.dingWeiLose, 1, {
                    "x":this.mc_h.x,
                    "y":this.mc_h.y,
                    "onComplete":function ():void
                    {
                        sumDividend(mc_h);
                        sumZd();
                    }
                });
            };
            if ((((((this.mc_z.label.text == "0")) && ((this.mc_x.label.text == "0")))) && ((this.mc_h.label.text == "0"))))
            {
                this.sumZd();
            };
        }

        private function sumZd(delay:uint=0):void
        {
            if (this.mc_zd.label.text != "0")
            {
                TweenLite.to(this.dingWeiLose, 1, {
                    "x":this.mc_zd.x,
                    "y":this.mc_zd.y,
                    "onComplete":function ():void
                    {
                        sumDividend(mc_zd);
                        sumXd();
                    }
                });
            }
            else
            {
                this.sumXd();
            };
        }

        private function sumXd():void
        {
            if (this.mc_xd.label.text != "0")
            {
                TweenLite.to(this.dingWeiLose, 1, {
                    "x":this.mc_xd.x,
                    "y":this.mc_xd.y,
                    "onComplete":function ():void
                    {
                        sumDividend(mc_xd);
                        sumDa();
                    }
                });
            }
            else
            {
                this.sumDa();
            };
        }

        private function sumDa():void
        {
            if (this.mc_big.label.text != "0")
            {
                TweenLite.to(this.dingWeiLose, 1, {
                    "x":this.mc_big.x,
                    "y":this.mc_big.y,
                    "onComplete":function ():void
                    {
                        sumDividend(mc_big);
                        sumXiao();
                    }
                });
            }
            else
            {
                this.sumXiao();
            };
        }

        private function sumXiao():void
        {
            if (this.mc_small.label.text != "0")
            {
                TweenLite.to(this.dingWeiLose, 1, {
                    "x":this.mc_small.x,
                    "y":this.mc_small.y,
                    "onComplete":function ():void
                    {
                        sumDividend(mc_small);
                        sumFinish();
                    }
                });
            }
            else
            {
                this.sumFinish();
            };
        }

        private function sumFinish():void
        {
            TweenLite.to(this.dingWeiLose, 1, {
                "x":(this.userBox.x + 48),
                "y":(this.userBox.y + 10)
            });
        }

        private function sumDividend(_arg1:MovieClip):void
        {
            _arg1.visible = false;
            var _local2:uint = (uint(_arg1.label.text) + this.dingWeiLose.money);
            this.dingWeiLose.setMoney(_local2);
        }

        public function get userTableNum():uint
        {
            return (this._userTableNum);
        }

        public function get userid():String
        {
            if (!this.seat)
            {
                return ("");
            };
            return (this.seat.userid);
        }

        public function killTweenMax():void
        {
            TweenMax.killDelayedCallsTo(this.dividend);
            TweenMax.killDelayedCallsTo(this.hideUserBox);
        }

        public function removeUser():void
        {
            this.userBox.visible = false;
            this.userBox.text_money.text = "";
            this.hideUserBox();
        }

        public function addUser(_arg1:SeatModel):void
        {
            var _local2:uint = Math.ceil((this.baijialeUser.seat / 7));
            if (((_arg1.seat / 7) >> 0) == ((this.baijialeUser.seat / 7) >> 0))
            {
                this.setSeat(_arg1);
                this.userBox.visible = true;
                if (_arg1.userid == this.baijialeUser.userid)
                {
                    if (_arg1.nickName != null && _arg1.nickName != "")
                    {
                        this.userBox.text_user.text = _arg1.nickName;
                    }
                    else
                    {
                        this.userBox.text_user.text = _arg1.userid;
                    };
                    this.userBox.bg.gotoAndStop(2);
                }
                else
                {
                    if (_arg1.nickName != null && _arg1.nickName != "")
                    {
                        this.userBox.text_user.text = _arg1.nickName;
                    }
                    else
                    {
                        this.userBox.text_user.text = Tools.userNameMask(_arg1.userid);
                    };
                    this.userBox.bg.gotoAndStop(1);
                };
                this.hideUserBox();
                this.zxhShow();
            };
        }

        public function refreshUser():void
        {
            this.refreshMoney();
        }


    }
}//package modules.baijiale.view.components
