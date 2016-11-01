package modules.baijiale.view
{
    import modules.gamePlatform.model.vo.*;
    import flash.events.*;
    import flash.display.*;
    import baijiale.*;
    import modules.baijiale.view.components.*;
    import flash.text.*;
    import com.greensock.*;
    import com.snake.game.*;
    import com.snake.ui.mcontrols.*;

    public class SimulationsView extends Sprite 
    {

        private var skin:SimulationsSkin;
        private var simulationsBox:Sprite;
        private var loger:BJLCardLog;
        private var box1:Sprite;
        private var box2:Sprite;
        private var box3:Sprite;
        private var box4:Sprite;
        private var box5:Sprite;
        private var box6:Sprite;
        private var box1Stage:Sprite;
        private var box2Stage:Sprite;
        private var box3Stage:Sprite;
        private var box4Stage:Sprite;
        private var box5Stage:Sprite;
        private var box6Stage:Sprite;
        private var nowLogArr:Array;
        private var simulationsBoxMask:MovieClip;
        private var timeOut:TextField;
        public var gotoRouteBoxTableID:uint;
        private var isInitRouteListPanel:Boolean;
        private var isShowRouteListPanel:Boolean;
        private var _w:Number = 20;
        private var text_all:TextField;
        private var text_brank:TextField;
        private var text_tie:TextField;
        private var text_play:TextField;
        private var fv:Number = 70;
        private var fh:Number = 12;
        private var gew:Number = 10;
        private var geh:Number = 10;
        private var tableBtnArr:Array;
        private var gotoList:GotoGameTableListView;
        private var _history:Array;

        public function SimulationsView(_arg1:SimulationsSkin)
        {
            this.loger = new BJLCardLog();
            this.box1 = new Sprite();
            this.box2 = new Sprite();
            this.box3 = new Sprite();
            this.box4 = new Sprite();
            this.box5 = new Sprite();
            this.box6 = new Sprite();
            this.box1Stage = new Sprite();
            this.box2Stage = new Sprite();
            this.box3Stage = new Sprite();
            this.box4Stage = new Sprite();
            this.box5Stage = new Sprite();
            this.box6Stage = new Sprite();
            this.tableBtnArr = new Array();
            super();
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            var _local1:int;
            var _local4:uint;
            var _local5:uint;
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            this.gotoList = new GotoGameTableListView(this.skin.gotoGameList);
            this.simulationsBoxMask = this.skin.simulationsBoxMask;
            Tools.setNoMouse(this.simulationsBoxMask);
            Tools.setButton(this.skin.zwl);
            Tools.setButton(this.skin.xwl);
            this.skin.zwl.addEventListener(MouseEvent.CLICK, this.zwlFun);
            this.skin.xwl.addEventListener(MouseEvent.CLICK, this.xwlFun);
            Tools.setNoMouse(this.skin.language);
            this.simulationsBox = this.skin.simulationsBox;
            Tools.removeAllChild(this.simulationsBox);
            this.simulationsBox.graphics.lineStyle(0.5, 9803156);
            this.simulationsBox.graphics.beginFill(0xFFFFFF);
            _local1 = 0;
            while (_local1 < (this.fv * this.fh))
            {
                _local4 = (_local1 % this.fv);
                _local5 = ((_local1 / this.fv) >> 0);
                this.simulationsBox.graphics.drawRect((_local4 * this.gew), (_local5 * this.geh), this.gew, this.geh);
                _local1++;
            };
            this.simulationsBox.graphics.endFill();
            this.simulationsBox.graphics.lineStyle(0.5, 9803156);
            this.simulationsBox.graphics.beginFill(0xFFFFFF);
            _local1 = 0;
            while (_local1 < 72)
            {
                _local4 = (_local1 % 12);
                _local5 = ((_local1 / 12) >> 0);
                this.simulationsBox.graphics.drawRect(((_local4 * this.gew) * 2), ((_local5 * this.geh) * 2), (this.gew * 2), (this.geh * 2));
                _local1++;
            };
            this.simulationsBox.graphics.endFill();
            this.simulationsBox.width = 780;
            this.simulationsBox.height = 150;
            this.simulationsBox.addChild(this.box1);
            this.simulationsBox.addChild(this.box2);
            this.box2.x = 240;
            this.simulationsBox.addChild(this.box3);
            this.box3.x = this.box2.x;
            this.box3.y = 60;
            this.simulationsBox.addChild(this.box4);
            this.box4.x = this.box2.x;
            this.box4.y = 90;
            this.simulationsBox.addChild(this.box5);
            this.box5.x = (this.box2.x + 230);
            this.box5.y = this.box4.y;
            this.box6.x = this.box5.x;
            this.box6.y = 60;
            this.simulationsBox.addChild(this.box6);
            var _local2:uint = 460;
            var _local3:uint = (10 * 6);
            this.box1.addChildAt(this.box1Stage, 0);
            this.box2.addChildAt(this.box2Stage, 0);
            this.box3.addChildAt(this.box3Stage, 0);
            this.box4.addChildAt(this.box4Stage, 0);
            this.box5.addChildAt(this.box5Stage, 0);
            this.box6.addChildAt(this.box6Stage, 0);
            this.initBoxMask(this.box1, (20 * 12), (20 * 6), 20, 1);
            this.initBoxMask(this.box2, _local2, _local3, 10, 2);
            this.initBoxMask(this.box3, 230, (10 * 3), 5, 3);
            this.initBoxMask(this.box4, 230, (10 * 3), 5, 4);
            this.initBoxMask(this.box5, 230, (10 * 3), 5, 5);
            this.initBoxMask(this.box6, 230, (10 * 3), 10, 2);
            this.text_all = this.skin.text_all;
            this.text_brank = this.skin.text_brank;
            this.text_tie = this.skin.text_tie;
            this.text_play = this.skin.text_play;
            this.text_all.text = "";
            this.text_brank.text = "";
            this.text_tie.text = "";
            this.text_play.text = "";
            this.skin.routeListPanel.visible = false;
        }

        private function initBoxMask(_arg1:Sprite, _arg2:uint, _arg3:uint, _arg4:uint, _arg5:uint):void
        {
            this[(("box" + _arg5) + "Stage")].mouseChildren = false;
            this[(("box" + _arg5) + "Stage")].mouseEnabled = false;
            var _local6:Sprite = new Sprite();
            var _local7:MovieClip = new RouteNavSkin();
            var _local8:Sprite = new Sprite();
            var _local9:Sprite = new Sprite();
            _local6.graphics.beginFill(0xFF0000);
            _local6.graphics.drawRect(0, 0, _arg2, _arg3);
            _local8.alpha = 0;
            _local8.graphics.beginFill(0);
            _local8.graphics.drawRect(0, 0, _arg2, _arg3);
            _local8.mouseChildren = false;
            _local8.mouseEnabled = false;
            _arg1.addChildAt(_local8, 1);
            _local7.alpha = 0;
            _local7.x = ((_arg2 - _local7.width) / 2);
            _local7.y = ((_arg3 - _local7.height) / 2);
            _arg1.addChildAt(_local7, 2);
            _arg1.addChildAt(_local6, 3);
            _arg1.mask = _local6;
            _arg1.addEventListener(MouseEvent.MOUSE_OVER, this.box2Over);
            _arg1.addEventListener(MouseEvent.MOUSE_OUT, this.box2Out);
            _local7.left.addEventListener(MouseEvent.CLICK, this.EventUp(this.box2LeftClick, _arg4));
            _local7.right.addEventListener(MouseEvent.CLICK, this.EventUp(this.box2RightClick, _arg4));
        }

        private function box2RightClick(_arg1:MouseEvent, ... _args):void
        {
            _arg1.currentTarget.parent.parent.getChildAt(0).x = (_arg1.currentTarget.parent.parent.getChildAt(0).x + _args[0]);
        }

        private function box2LeftClick(_arg1:MouseEvent, ... _args):void
        {
            _arg1.currentTarget.parent.parent.getChildAt(0).x = (_arg1.currentTarget.parent.parent.getChildAt(0).x - _args[0]);
        }

        private function EventUp(f:Function, ... arg):Function
        {
            return (function (_arg1:Event):void
            {
                f.apply(null, [_arg1].concat(arg));
            });
        }

        private function box2Over(_arg1:MouseEvent, ... _args):void
        {
            TweenLite.to(_arg1.currentTarget.getChildAt(2), 0.3, {"alpha":1});
            TweenLite.to(_arg1.currentTarget.getChildAt(1), 0.3, {"alpha":0.3});
        }

        private function box2Out(_arg1:MouseEvent, ... _args):void
        {
            TweenLite.to(_arg1.currentTarget.getChildAt(2), 0.5, {"alpha":0});
            TweenLite.to(_arg1.currentTarget.getChildAt(1), 0.5, {"alpha":0});
        }

        public function get history():Array
        {
            return (this._history.concat([]));
        }

        public function showHistory(_arg1:Object):void
        {
            var _local2:Array = (_arg1 as Array);
            var _local3:Object = this.loger.zxh_arr(_local2);
            this.text_all.text = _local2.length.toString();
            this.text_brank.text = _local3.zhuan.toString();
            this.text_tie.text = _local3.he.toString();
            this.text_play.text = _local3.xian.toString();
            this.showLog(_arg1);
        }

        public function bankerQ():void
        {
        }

        public function playerQ():void
        {
        }

        private function clear():void
        {
            this.box1Stage.visible = false;
            this.box2Stage.visible = false;
            this.box3Stage.visible = false;
            this.box4Stage.visible = false;
            this.box5Stage.visible = false;
            this.box6Stage.visible = false;
        }

        private function showLog(_arg1:Object):void
        {
            var _local2:Array = (_arg1 as Array);
            this.upLog(_local2);
        }

        private function upLog(_arg1:Array, _arg2:Boolean=false):void
        {
            var _local7:Array;
            var _local8:Array;
            var _local9:uint;
            var _local10:uint;
            var _local11:uint;
            var _local12:uint;
            TweenMax.killDelayedCallsTo(this.hideMc);
            var _local3:uint;
            while (_local3 < _arg1.length)
            {
                if (_arg1[_local3] >= 20)
                {
                    _arg1[_local3] = (_arg1[_local3] - 20);
                };
                _local3++;
            };
            if (_arg2 == false)
            {
                this.nowLogArr = _arg1;
                _local7 = _arg1.concat([]);
                _local8 = _arg1.concat([]);
                _local9 = 0;
                _local10 = 0;
                _local11 = 0;
                _local12 = 0;
                _local7.push(0);
                _local8.push(4);
                this.skin.nextZDaLuMc.gotoAndStop((this.loger.nextLuNum(_local7, 1) + 1));
                this.skin.nextXDaLuMc.gotoAndStop((this.loger.nextLuNum(_local8, 1) + 1));
                if (_local7.length > 1)
                {
                    _local9 = (this.loger.nextLuNum(_local7, 2) + 1);
                    _local10 = (this.loger.nextLuNum(_local8, 2) + 1);
                    _local11 = (this.loger.nextLuNum(_local7, 3) + 1);
                    _local12 = (this.loger.nextLuNum(_local8, 3) + 1);
                };
                this.skin.nextZDaYanMc.gotoAndStop(_local9);
                this.skin.nextXDaYanMc.gotoAndStop(_local10);
                this.skin.nextZZhangLangMc.gotoAndStop(_local11);
                this.skin.nextXZhangLangMc.gotoAndStop(_local12);
            };
            if (_arg1.length <= 0)
            {
                this.clear();
                return;
            };
            this.box1Stage.visible = true;
            this.box2Stage.visible = true;
            this.box3Stage.visible = true;
            this.box4Stage.visible = true;
            this.box5Stage.visible = true;
            this.box6Stage.visible = true;
            var _local4:Array = _arg1.concat(new Array());
            var _local5:uint;
            var _local6:Boolean;
            _local3 = 0;
            while (_local3 < _local4.length)
            {
                if (_local6 == false)
                {
                    if (_local4[_local3] > 7)
                    {
                        _local5++;
                    }
                    else
                    {
                        _local6 = true;
                        break;
                    };
                };
                _local3++;
            };
            _local4.splice(0, _local5);
            this.loger.zhuzaiLuShow(_arg1, BigLuMoiveSkin, 20, 20);
            this.loger.daLuShow(_local4, DaLuMoiveSkin, 10, 10);
            this.loger.dayanShow(_local4, DaYanMoiveSkin, 5, 5);
            this.loger.xiaoluShow(_local4, XiaoLuMoiveSkin, 5, 5);
            this.loger.zhangluShow(_local4, ZhangLangMoiveSkin, 5, 5);
            this.loger.sanXingShow(_local4, DaLuMoiveSkin, 10, 10);
            this.box1Stage.x = (this.box2Stage.x = (this.box3Stage.x = (this.box4Stage.x = (this.box5Stage.x = (this.box6Stage.x = 0)))));
            if (this.loger.zhuZaiLuLie > 11)
            {
                this.box1Stage.x = (this.box1Stage.x - ((this.loger.zhuZaiLuLie - 11) * 20));
            };
            if (this.loger.daLuLie > 45)
            {
                this.box2Stage.x = (this.box2Stage.x - ((this.loger.daLuLie - 45) * 10));
            };
            if (this.loger.daYanLuLie > 45)
            {
                this.box3Stage.x = (this.box3Stage.x - ((this.loger.daYanLuLie - 45) * 5));
            };
            if (this.loger.xiaoLuLie > 45)
            {
                this.box4Stage.x = (this.box4Stage.x - ((this.loger.xiaoLuLie - 45) * 5));
            };
            if (this.loger.zhangLuLie > 45)
            {
                this.box5Stage.x = (this.box5Stage.x - ((this.loger.zhangLuLie - 45) * 5));
            };
            if (this.loger.sanXinLuLie > 22)
            {
                this.box6Stage.x = (this.box6Stage.x - ((this.loger.sanXinLuLie - 22) * 10));
            };
            this.showLastLu(_arg2);
        }

        public function showLastLu(_arg1:Boolean=false):void
        {
            this.lastZhuzaiLu(this.box1Stage, _arg1);
            this.lastZhuzaiLu(this.box2Stage, _arg1);
            this.lastZhuzaiLu(this.box3Stage, _arg1);
            this.lastZhuzaiLu(this.box4Stage, _arg1);
            this.lastZhuzaiLu(this.box5Stage, _arg1);
            this.lastZhuzaiLu(this.box6Stage, _arg1);
        }

        private function lastZhuzaiLu(_arg1:Sprite, _arg2:Boolean):void
        {
            var _local3:Sprite;
            var _local4:DisplayObject;
            if (_arg1.numChildren > 0)
            {
                _local3 = (_arg1.getChildAt(0) as Sprite);
                if (_local3.numChildren > 0)
                {
                    _local4 = _local3.getChildAt((_local3.numChildren - 1));
                    if (_arg2 != false)
                    {
                        TweenMax.delayedCall(5, this.hideMc, [_local4]);
                    };
                };
            };
        }

        private function hideMc(_arg1:MovieClip):void
        {
            _arg1.visible = false;
        }

        private function zwlFun(_arg1:MouseEvent):void
        {
            var _local2:Array = this.nowLogArr.concat([]);
            _local2.push(0);
            this.upLog(_local2, true);
        }

        private function xwlFun(_arg1:MouseEvent):void
        {
            var _local2:Array = this.nowLogArr.concat([]);
            _local2.push(4);
            this.upLog(_local2, true);
        }

        public function showMask(_arg1:Boolean=true, _arg2:Number=0):void
        {
            this.simulationsBoxMask.visible = false;
            if (_arg1 == true)
            {
                TweenLite.to(this.simulationsBoxMask, _arg2, {"autoAlpha":0.7});
            }
            else
            {
                TweenLite.to(this.simulationsBoxMask, _arg2, {"autoAlpha":0});
            };
        }

        public function initRouteListPanel(_arg1:Array):void
        {
            var _local2:GameTableVO;
            var _local3:AllRoutePanel;
            var _local4:Sprite;
            var _local5:Sprite;
            var _local6:uint;
            var _local7:MovieToVScrollBar;
            if (this.isShowRouteListPanel == false)
            {
                this.skin.routeListPanel.visible = true;
                this.isShowRouteListPanel = true;
            }
            else
            {
                this.skin.routeListPanel.visible = false;
                this.isShowRouteListPanel = false;
            };
            if (this.isInitRouteListPanel == false)
            {
                this.skin.routeListPanel.visible = true;
                _local4 = new Sprite();
                _local5 = new Sprite();
                _local5.graphics.beginFill(0xFF0000);
                _local5.graphics.drawRect(0, 0, 492, 318);
                _local4.mask = _local5;
                this.skin.routeListPanel.addChild(_local4);
                this.skin.routeListPanel.addChild(_local5);
                _local6 = 0;
                while (_local6 < _arg1.length)
                {
                    _local2 = (_arg1[_local6] as GameTableVO);
                    _local3 = new AllRoutePanel(_local2);
                    _local3.y = (_local6 * 92.5);
                    _local4.addChild(_local3);
                    _local3.buttonMode = true;
                    _local3.id = _local6;
                    _local3.addEventListener(MouseEvent.CLICK, this.gotoRouteBoxTable);
                    _local6++;
                };
                _local7 = new MovieToVScrollBar(this.skin.routeListPanel.list, {
                    "hideBool":true,
                    "height":320,
                    "coordinateBool":false
                }, true, true);
                _local7.tabEnabled = false;
                _local7.tabChildren = false;
                _local7.content = _local4;
                this.isInitRouteListPanel = true;
            };
        }

        private function gotoRouteBoxTable(_arg1:MouseEvent):void
        {
            this.gotoRouteBoxTableID = _arg1.currentTarget.id;
            dispatchEvent(new Event("gotoRouteBoxTable"));
        }

        public function upTime():void
        {
        }

        public function addToStage():void
        {
            addChild(this.skin);
            addChild(this.simulationsBox);
            addChild(this.simulationsBoxMask);
            this.simulationsBoxMask.visible = false;
            addChild(this.gotoList);
            this.box1Stage.addChild(this.loger.zhuZaiMc);
            this.box2Stage.addChild(this.loger.daLuMc);
            this.box3Stage.addChild(this.loger.daYanMc);
            this.box4Stage.addChild(this.loger.xiaoLuMc);
            this.box5Stage.addChild(this.loger.zhangLuMc);
            this.box6Stage.addChild(this.loger.sanXinMc);
        }

        public function dispose():void
        {
            removeChild(this.skin);
            removeChild(this.gotoList);
            removeChild(this.simulationsBox);
            removeChild(this.simulationsBoxMask);
            this.box1Stage.removeChild(this.loger.zhuZaiMc);
            this.box2Stage.removeChild(this.loger.daLuMc);
            this.box3Stage.removeChild(this.loger.daYanMc);
            this.box4Stage.removeChild(this.loger.xiaoLuMc);
            this.box5Stage.removeChild(this.loger.zhangLuMc);
            this.box6Stage.removeChild(this.loger.sanXinMc);
        }


    }
}//package modules.baijiale.view
