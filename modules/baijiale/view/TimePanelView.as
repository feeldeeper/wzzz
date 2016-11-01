package modules.baijiale.view
{
    import flash.events.*;
    import flash.display.*;
    import baijiale.*;
    import com.greensock.*;
    import flash.geom.*;

    public class TimePanelView extends Sprite 
    {

        private var skin:TimePanelSkin;
        private var showInfo:MovieClip;
        private var _maxCountingNumber:uint = 45;
        private var _farmerBool:Boolean;
        private var mc_farmer:MovieClip;

        public function TimePanelView(_arg1:TimePanelSkin)
        {
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            this.mc_farmer = this.skin.mc_farmer;
            this.mc_farmer.visible = false;
            this.skin.stopper.visible = false;
            this.skin.gameResultsInfo.visible = false;
        }

        protected function dragDown(_arg1:MouseEvent):void
        {
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.dragUp);
            this.startDrag(false, new Rectangle(0, 0, (0x0400 - 98), (800 - 74)));
        }

        public function get farmerBool():Boolean
        {
            return (this._farmerBool);
        }

        public function set farmerBool(_arg1:Boolean):void
        {
            if (this._farmerBool == _arg1)
            {
                return;
            };
            this._farmerBool = _arg1;
            if (this.farmerBool)
            {
                addChild(this.mc_farmer);
            }
            else
            {
                if (contains(this.mc_farmer))
                {
                    removeChild(this.mc_farmer);
                };
            };
        }

        protected function dragUp(_arg1:MouseEvent):void
        {
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.dragUp);
            this.stopDrag();
        }

        public function showTime(_arg1:Number):void
        {
            var _local2:String;
            if (_arg1 == 0)
            {
            };
            _local2 = this.addLeadingZero(_arg1);
            this.skin.stopper.tenDigit.gotoAndStop((int(_local2.charAt(0)) + 1));
            this.skin.stopper.singleDigit.gotoAndStop((int(_local2.charAt(1)) + 1));
            this.skin.stopper.stopperBar.scaleX = (_arg1 / this._maxCountingNumber);
        }

        public function upGameState(_arg1:Number):void
        {
            switch (_arg1)
            {
                case 0:
                    return;
                case 2:
                    this.playResultsInfoMc("stoping");
                    this.skin.stopper.visible = false;
                    return;
                case 1:
                    this.playResultsInfoMc("starting");
                    this.skin.stopper.visible = true;
                    return;
                case 3:
                    this.playResultsInfoMc("washing", false);
                    return;
            };
        }

        public function upGameResults(_arg1:Object):void
        {
            switch (_arg1.zxh)
            {
                case 0:
                    this.playResultsInfoMc("zwin");
                    return;
                case 1:
                    this.playResultsInfoMc("xwin");
                    return;
                case 2:
                    this.playResultsInfoMc("he");
                    return;
            };
        }

        public function playResultsInfoMc(_arg1:String, _arg2:Boolean=true):void
        {
            this.skin.gameResultsInfo.gotoAndStop(_arg1);
            this.skin.gameResultsInfo.visible = true;
            if (_arg2 == true)
            {
                TweenLite.killTweensOf(this.skin.gameResultsInfo);
                TweenLite.to(this.skin.gameResultsInfo, 2, {"visible":false});
            };
        }

        private function addLeadingZero(_arg1:Number):String
        {
            return ((((_arg1)<10) ? ("0" + _arg1) : _arg1.toString()));
        }

        public function addToStage():void
        {
            addChild(this.skin);
        }

        public function dispose():void
        {
            removeChild(this.skin);
            this.skin.gameResultsInfo.visible = false;
            this.skin.stopper.visible = false;
        }


    }
}//package modules.baijiale.view
