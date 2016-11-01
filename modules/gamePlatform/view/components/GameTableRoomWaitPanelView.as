package modules.gamePlatform.view.components
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.model.vo.*;
    import gamePlatform.*;

    public class GameTableRoomWaitPanelView extends Sprite 
    {

        private var skin:GameTableWaitPanelSkin;

        public function GameTableRoomWaitPanelView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new GameTableWaitPanelSkin();
            addChild(this.skin);
            Tools.setButton(this.skin.mc_0);
            Tools.setButton(this.skin.mc_1);
            Tools.setButton(this.skin.mc_2);
        }

        public function setMoneyGroup(_arg1:GameMoneyGroup, _arg2:String, _arg3:uint, _arg4:Object=null):void
        {
            var _local5:uint;
            var _local7:MovieClip;
            if (_arg2 == "default")
            {
                _local5 = 3;
            }
            else
            {
                _local5 = 1;
            };
            if (_arg3 > 80)
            {
                _local5 = 3;
            };
            if ((((_arg1 == null)) || ((_arg1.moneyTypeGroup == null))))
            {
                return;
            };
            var _local6:int;
            while (_local6 < _local5)
            {
                _local7 = (this.skin[("mc_" + _local6)] as MovieClip);
                _local7.data = _arg1.moneyTypeGroup[_local6];
                _local7.moneyGroup = _arg1.getMoneyGroup(_arg1.moneyTypeGroup[_local6]);
                if (_local7.data)
                {
                    _local7.addEventListener(MouseEvent.CLICK, this.selectMoneyGroup);
                    if (_arg4 == null)
                    {
                        _local7.txt_min.text = String(_local7.data).split("_")[0];
                        _local7.txt_max.text = String(_local7.data).split("_")[1];
                    }
                    else
                    {
                        _local7.txt_min.text = _arg4.min;
                        _local7.txt_max.text = _arg4.max;
                    };
                }
                else
                {
                    _local7.txt_min.text = "";
                    _local7.txt_max.text = "";
                    _local7.visible = false;
                    Tools.setNoMouse(_local7);
                };
                _local6++;
            };
            if ((((_arg2 == "custom")) && ((_arg3 < 80))))
            {
                this.skin.mc_0.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
        }

        protected function selectMoneyGroup(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            var _local3:DataEvent = new DataEvent("selectMoneyGroup");
            _local3.data = _local2.data;
            dispatchEvent(_local3);
        }

        public function hideBg():void
        {
            this.skin.bg.visible = false;
        }

        public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view.components
