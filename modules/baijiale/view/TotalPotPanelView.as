package modules.baijiale.view
{
    import flash.events.*;
    import flash.display.*;
    import baijiale.*;
    import flash.text.*;
    import com.greensock.*;
    import flash.geom.*;

    public class TotalPotPanelView extends Sprite 
    {

        private var skin:TotalPotSkin;
        private var txt_z:TextField;
        private var txt_h:TextField;
        private var txt_x:TextField;
        private var txt_zd:TextField;
        private var txt_xd:TextField;
        private var txt_big:TextField;
        private var txt_small:TextField;
        public var videoModel:Boolean;
        public var serverLineID:uint;
        private var isInit:Boolean;

        public function TotalPotPanelView(_arg1:TotalPotSkin)
        {
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            var _local1:MovieClip;
            var _local2:uint;
            if (this.isInit == false)
            {
                this.x = this.skin.x;
                this.y = this.skin.y;
                this.skin.x = (this.skin.y = 0);
                addChild(this.skin);
                this.txt_z = this.skin.virtualPanel.txt_z;
                this.txt_h = this.skin.virtualPanel.txt_h;
                this.txt_x = this.skin.virtualPanel.txt_x;
                this.txt_zd = this.skin.virtualPanel.txt_zd;
                this.txt_xd = this.skin.virtualPanel.txt_xd;
                this.txt_big = this.skin.virtualPanel.txt_big;
                this.txt_small = this.skin.virtualPanel.txt_small;
                this.txt_z.text = "0";
                this.txt_h.text = "0";
                this.txt_x.text = "0";
                this.txt_zd.text = "0";
                this.txt_xd.text = "0";
                this.skin.virtualPanel.switchVideoLine.switchPanel.visible = false;
                Tools.setButton(this.skin.virtualPanel.switchVideoLine.showPanelBtn);
                this.skin.virtualPanel.switchVideoLine.showPanelBtn.addEventListener(MouseEvent.CLICK, this.showPanelBtnFun);
                _local2 = 0;
                while (_local2 < 6)
                {
                    _local1 = this.skin.virtualPanel.switchVideoLine.switchPanel[("btn_" + _local2)];
                    _local1.id = _local2;
                    _local1.title.gotoAndStop((_local2 + 1));
                    Tools.setButton(_local1);
                    _local1.addEventListener(MouseEvent.CLICK, this.serverLineSelect);
                    _local2++;
                };
                this.isInit = true;
            };
        }

        private function serverLineSelect(_arg1:MouseEvent):void
        {
            this.serverLineID = _arg1.target.id;
            dispatchEvent(new Event("upServerLineSelect"));
            this.skin.virtualPanel.switchVideoLine.switchPanel.visible = false;
            this.skin.virtualPanel.switchVideoLine.showPanelBtn.title.gotoAndStop((this.serverLineID + 1));
        }

        private function showPanelBtnFun(_arg1:MouseEvent):void
        {
            this.skin.virtualPanel.switchVideoLine.switchPanel.visible = true;
        }

        protected function dragDown(_arg1:MouseEvent):void
        {
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.dragUp);
            this.startDrag(false, new Rectangle(0, 0, (0x0400 - 98), (700 - 74)));
        }

        protected function dragUp(_arg1:MouseEvent):void
        {
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.dragUp);
            this.stopDrag();
        }

        public function dispose():void
        {
        }

        public function upGameState(_arg1:Object):void
        {
            if (_arg1.gameState == 0)
            {
                this.txt_z.text = "0";
                this.txt_h.text = "0";
                this.txt_x.text = "0";
                this.txt_zd.text = "0";
                this.txt_xd.text = "0";
            };
            this.skin.limitPanel.titleName.text = _arg1.gameTableName.replace("baijiale", "");
            this.skin.limitPanel.xue.text = _arg1.gameBoot;
            this.skin.limitPanel.ju.text = _arg1.roundNum;
            this.skin.virtualPanel.gameNum.text = _arg1.gameNumber;
        }

        public function gameAllInject(_arg1:Object):void
        {
            this.txt_z.text = ("" + _arg1.z);
            this.txt_h.text = ("" + _arg1.h);
            this.txt_x.text = ("" + _arg1.x);
            this.txt_zd.text = ("" + _arg1.zd);
            this.txt_xd.text = ("" + _arg1.xd);
        }

        public function updatePerspective(_arg1:String):void
        {
        }

        public function updateLimit(_arg1:Object):void
        {
            this.skin.limitPanel.limitMax.text = _arg1.telMax;
            this.skin.limitPanel.limitMin.text = _arg1.telMin;
        }

        public function selectModel():void
        {
            if (this.videoModel == true)
            {
                this.skin.virtualPanel.bg.alpha = 0.5;
                this.skin.logo2.visible = true;
                this.skin.logo2.alpha = 0;
                TweenLite.to(this.skin.virtualPanel, 1, {
                    "x":555.95,
                    "y":-240
                });
                TweenLite.to(this.skin.logo, 1, {
                    "x":54.45,
                    "y":-335,
                    "alpha":0,
                    "onComplete":this.hiddenMc,
                    "onCompleteParams":[this.skin.logo, false]
                });
                TweenLite.to(this.skin.logo2, 1, {
                    "x":-452.45,
                    "y":-239,
                    "alpha":0.9,
                    "onComplete":this.hiddenMc,
                    "onCompleteParams":[this.skin.logo2, true]
                });
                TweenLite.to(this.skin.limitPanel, 1, {
                    "x":-515.95,
                    "y":-381.65
                });
            }
            else
            {
                this.skin.virtualPanel.bg.alpha = 1;
                this.skin.logo.visible = true;
                this.skin.logo.alpha = 1;
                TweenLite.to(this.skin.virtualPanel, 1, {
                    "x":52.5,
                    "y":-71
                });
                TweenLite.to(this.skin.logo, 1, {
                    "x":53.45,
                    "y":-289.5
                });
                TweenLite.to(this.skin.logo2, 1, {
                    "x":5.5,
                    "y":-304,
                    "alpha":0,
                    "onComplete":this.hiddenMc,
                    "onCompleteParams":[this.skin.logo2, false]
                });
                TweenLite.to(this.skin.limitPanel, 1, {
                    "x":52.5,
                    "y":-189.15
                });
            };
        }

        private function hiddenMc(_arg1:MovieClip, _arg2:Boolean):void
        {
            _arg1.visible = _arg2;
        }

        public function setServerLine(_arg1:String):void
        {
            switch (_arg1)
            {
                case "tel":
                    this.skin.virtualPanel.switchVideoLine.showPanelBtn.title.gotoAndStop(1);
                    return;
                case "tel2":
                    this.skin.virtualPanel.switchVideoLine.showPanelBtn.title.gotoAndStop(2);
                    return;
                case "cnc":
                    this.skin.virtualPanel.switchVideoLine.showPanelBtn.title.gotoAndStop(3);
                    return;
                case "cnc2":
                    this.skin.virtualPanel.switchVideoLine.showPanelBtn.title.gotoAndStop(4);
                    return;
                case "bgp":
                    this.skin.virtualPanel.switchVideoLine.showPanelBtn.title.gotoAndStop(5);
                    return;
            };
        }


    }
}//package modules.baijiale.view
