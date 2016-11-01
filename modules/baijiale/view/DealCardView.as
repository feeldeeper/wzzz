package modules.baijiale.view
{
    import flash.display.*;
    import flash.utils.*;
    import baijiale.*;
    import com.greensock.*;
    import com.greensock.loading.*;
    import com.greensock.easing.*;

    public class DealCardView extends Sprite 
    {

        private var cardArr:Array;
        private var cardDrawSkin:MovieClip;
        private var resultPanel:MovieClip;
        private var xianPoints:uint;
        private var zhuangnPoints:uint;
        private var navMc:RouteNavSkin;
        private var _gameState:uint;
        private var isInit:Boolean;
        private var swfLoader:SWFLoader;

        public function DealCardView()
        {
            this.cardArr = new Array();
            this.resultPanel = new DealCardSkin();
            super();
            this.initDisplay();
        }

        public function get gameState():uint
        {
            return (this._gameState);
        }

        public function set gameState(_arg1:uint):void
        {
            this._gameState = _arg1;
        }

        private function initDisplay():void
        {
            var _local2:Class;
            var _local3:MovieClip;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            if (this.isInit == false)
            {
                this.swfLoader = LoaderMax.getLoader("userHeader");
                _local2 = this.swfLoader.getClass("otherLib.CardDraw");
                this.cardDrawSkin = new (_local2)();
            };
            var _local1:uint;
            while (_local1 < 6)
            {
                _local3 = this.cardDrawSkin[("Card" + _local1)];
                _local3.visible = false;
                _local3.gotoAndStop(1);
                this.cardArr.push(_local3);
                _local1++;
            };
            this.cardDrawSkin.width = 500;
            this.cardDrawSkin.height = 180;
            this.cardDrawSkin.y = 550;
            this.cardDrawSkin.x = 290;
            addChild(this.cardDrawSkin);
            this.resultPanel.y = 519;
            this.resultPanel.x = 360;
            this.resultPanel.xianBox.visible = false;
            this.resultPanel.zhuangBox.visible = false;
            this.resultPanel.visible = false;
            this.navMc = new RouteNavSkin();
            this.navMc.x = 138;
            this.navMc.y = ((this.resultPanel.height - this.navMc.height) / 2);
            this.resultPanel.addChild(this.navMc);
            addChild(this.resultPanel);
            this.navMc.visible = false;
        }

        public function clear():void
        {
            var _local1:uint;
            var _local2:MovieClip;
            _local1 = 0;
            while (_local1 < this.cardArr.length)
            {
                _local2 = this.cardArr[_local1];
                _local2.visible = false;
                _local2.gotoAndStop(1);
                _local1++;
            };
            this.xianPoints = 0;
            this.zhuangnPoints = 0;
            this.resultPanel.visible = false;
            this.resultPanel.xianBox.visible = false;
            this.resultPanel.zhuangBox.visible = false;
            this.navMc.visible = false;
            TweenMax.killDelayedCallsTo(this.gameDeal);
        }

        public function upGameState(_arg1:Number):void
        {
            this.gameState = _arg1;
            if (_arg1 == 0)
            {
                this.navMc.visible = false;
                if (this.xianPoints > this.zhuangnPoints)
                {
                    this.resultPanel.xianBox.visible = true;
                }
                else
                {
                    if (this.xianPoints < this.zhuangnPoints)
                    {
                        this.resultPanel.zhuangBox.visible = true;
                    };
                };
                TweenMax.delayedCall(4, this.clear);
            }
            else
            {
                this.clear();
            };
        }

        private function gameDeal(_arg1:Object):void
        {
            var _local2:MovieClip;
            var _local5:Object;
            var _local6:Object;
            var _local3:Array = _arg1.dealArr;
            this.resultPanel.visible = true;
            if ((((_arg1.addPokerFlag == false)) && ((_local3.length > 4))))
            {
                this.navMc.visible = false;
            }
            else
            {
                this.navMc.visible = true;
            };
            var _local4:int;
            while (_local4 < _local3.length)
            {
                _local2 = this.cardArr[_local4];
                _local5 = _arg1.dealArr[_local4];
                _local6 = this.resultPoints(_arg1.dealArr);
                this.resultPanel.xian.text = _local6.xian;
                this.resultPanel.zhuang.text = _local6.zhuang;
                if (_local5 == null)
                {
                    _local2.visible = false;
                    _local2.gotoAndStop(1);
                }
                else
                {
                    _local2.visible = true;
                    if ((_local4 + 1) < _local3.length)
                    {
                        if ((_local5 is Number))
                        {
                            _local2.CardSet.MCCard.gotoAndStop(uint((_local5 + 1)));
                        }
                        else
                        {
                            _local2.CardSet.MCCard.gotoAndStop(uint((_local5.id + 1)));
                        };
                    }
                    else
                    {
                        if ((_local5 is Number))
                        {
                            _local2.CardSet.MCCard.gotoAndStop(uint((_local5 + 1)));
                        }
                        else
                        {
                            _local2.CardSet.MCCard.gotoAndStop(uint((_local5.id + 1)));
                        };
                    };
                    if (_local2.currentFrame > 1)
                    {
                        _local2.gotoAndStop(15);
                    }
                    else
                    {
                        _local2.gotoAndPlay(1);
                    };
                };
                _local4++;
            };
        }

        public function upGameDeal(_arg1:Object):void
        {
            var _local2:uint;
            if (this.gameState == 2)
            {
                this.navMc.visible = true;
                _local2 = (_arg1.dealArr.length - 1);
                if ((_local2 % 2) == 0)
                {
                    this.navMc.left.visible = true;
                    this.navMc.right.visible = false;
                }
                else
                {
                    this.navMc.left.visible = false;
                    this.navMc.right.visible = true;
                };
                TweenMax.delayedCall(3, this.gameDeal, [_arg1]);
            };
        }

        private function resultPoints(_arg1:Array):Object
        {
            this.xianPoints = 0;
            this.zhuangnPoints = 0;
            var _local2:Array = _arg1.concat(new Array());
            var _local3:uint;
            while (_local3 < 6)
            {
                if (_local2[_local3] == undefined)
                {
                    _local2[_local3] = {"points":0};
                };
                if (_local2[_local3].points >= 10)
                {
                    _local2[_local3].points = 0;
                };
                _local3++;
            };
            this.xianPoints = this.dealX(_local2);
            this.zhuangnPoints = this.dealZ(_local2);
            return ({
                "xian":this.xianPoints,
                "zhuang":this.zhuangnPoints
            });
        }

        private function dealZ(_arg1:Object):uint
        {
            var _local2:uint = (this.integral(_arg1[1].points) + this.integral(_arg1[3].points));
            _local2 = this.dealPoints(_local2);
            if (((_arg1[5]) && (_arg1[5].points)))
            {
                _local2 = (this.integral(_arg1[5].points) + _local2);
            };
            return (this.dealPoints(_local2));
        }

        private function dealX(_arg1:Object):uint
        {
            var _local2:uint = (this.integral(_arg1[0].points) + this.integral(_arg1[2].points));
            _local2 = this.dealPoints(_local2);
            if (((_arg1[4]) && (_arg1[4].points)))
            {
                _local2 = (this.integral(_arg1[4].points) + _local2);
            };
            return (this.dealPoints(_local2));
        }

        private function dealPoints(_arg1:uint):uint
        {
            if (_arg1 >= 10)
            {
                return ((_arg1 - 10));
            };
            return (_arg1);
        }

        private function integral(_arg1:uint):uint
        {
            if (_arg1 >= 10)
            {
                return (0);
            };
            return (_arg1);
        }

        private function clone(_arg1:Object)
        {
            var _local2:ByteArray = new ByteArray();
            _local2.writeObject(_arg1);
            _local2.position = 0;
            return (_local2.readObject());
        }

        public function addToStage():void
        {
        }

        public function dispose():void
        {
            this.clear();
        }


    }
}//package modules.baijiale.view
