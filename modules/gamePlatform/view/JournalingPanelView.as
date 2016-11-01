package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.net.*;
    import com.snake.formatters.*;
    import flash.text.*;
    import gamePlatform.*;
    import org.mousebomb.ui.*;

    public class JournalingPanelView extends Sprite 
    {

        private var startDate:DatePicker;
        private var endDate:DatePicker;
        private var skin:JournalingPanelSkin;
        private var btn:SimpleButton;
        private var mc_start:MovieClip;
        private var mc_end:MovieClip;
        private var startTime:TextField;
        private var endTime:TextField;
        private var langage:MovieClip;
        private var enterBtn:MovieClip;
        private var userID:String;
        private var userPwd:String;
        private var totalMoney:TextField;
        private var profitMoney:TextField;
        private var washProfit:TextField;
        private var _nc:NetConnection;

        public function JournalingPanelView()
        {
            this._nc = new NetConnection();
            super();
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new JournalingPanelSkin();
            addChild(this.skin);
            this.btn = this.skin.btn_close;
            this.btn.addEventListener(MouseEvent.CLICK, this.close);
            this.mc_start = this.skin.mc_start;
            this.mc_end = this.skin.mc_end;
            this.startTime = this.skin.startTime;
            this.endTime = this.skin.endTime;
            this.langage = this.skin.langage;
            this.enterBtn = this.skin.enterBtn;
            Tools.setButton(this.mc_start);
            Tools.setButton(this.mc_end);
            Tools.setNoMouse(this.langage);
            Tools.setButton(this.enterBtn);
            this.mc_start.addEventListener(MouseEvent.CLICK, this.startShow);
            this.mc_end.addEventListener(MouseEvent.CLICK, this.endShow);
            this.enterBtn.addEventListener(MouseEvent.CLICK, this.enterBtnFun);
            this.startDate = new DatePicker();
            this.startDate.x = this.mc_start.x;
            this.startDate.y = this.mc_start.y;
            this.skin.addChild(this.startDate);
            this.startDate.hide();
            this.endDate = new DatePicker();
            this.endDate.x = this.mc_end.x;
            this.endDate.y = this.mc_end.y;
            this.totalMoney = this.skin.totalMoney;
            this.profitMoney = this.skin.profitMoney;
            this.washProfit = this.skin.washProfit;
            this.skin.addChild(this.endDate);
            this.endDate.hide();
            this.startTime.text = (this.fomatDate(this.dateAdd("month", -1)) + " 12:00:00");
            this.endTime.text = (this.fomatDate(new Date()) + " 11:59:59");
            this.startDate.addEventListener("select", this.startDateSelect);
            this.endDate.addEventListener("select", this.endDateSelect);
            this._nc.addEventListener(NetStatusEvent.NET_STATUS, this.statusHandler);
        }

        protected function endDateSelect(_arg1:Event):void
        {
            this.endTime.text = (this.fomatDate(this.endDate.selectDate) + " 11:59:59");
            this.endDate.hide();
        }

        protected function startDateSelect(_arg1:Event):void
        {
            this.startTime.text = (this.fomatDate(this.startDate.selectDate) + " 12:00:00");
            this.startDate.hide();
        }

        protected function endShow(_arg1:MouseEvent):void
        {
            this.endDate.show();
        }

        protected function startShow(_arg1:MouseEvent):void
        {
            this.startDate.show();
        }

        protected function close(_arg1:MouseEvent):void
        {
            this.endDate.hide();
            this.startDate.hide();
            dispatchEvent(new Event("close"));
        }

        public function initReSize():void
        {
            stage.addEventListener(Event.RESIZE, this.reSize);
            this.reSize();
        }

        protected function reSize(_arg1:Event=null):void
        {
            if (!stage)
            {
                return;
            };
            var _local2:uint = stage.stageWidth;
            var _local3:uint = stage.stageHeight;
            this.x = ((_local2 / 2) >> 0);
            this.y = ((_local3 / 2) >> 0);
        }

        private function fomatDate(_arg1:Date):String
        {
            var _local2:DateFormatter = new DateFormatter("YYYY-MM-DD");
            return (_local2.format(_arg1));
        }

        private function dateAdd(_arg1:String="", _arg2:Number=0, _arg3:Date=null):Date
        {
            if (_arg3 == null)
            {
                _arg3 = new Date();
            };
            var _local4:Date = new Date(_arg3.time);
            switch (_arg1.toLowerCase())
            {
                case "fullyear":
                case "month":
                case "date":
                case "hours":
                case "minutes":
                case "seconds":
                case "milliseconds":
                    _local4[_arg1] = (_local4[_arg1] + _arg2);
                    break;
            };
            return (_local4);
        }

        public function setUserInfo(_arg1:String, _arg2:String, _arg3:Boolean):void
        {
            this.userID = _arg1;
            this.userPwd = _arg2;
            if (_arg3 == true)
            {
                this.skin.langage.wash.visible = false;
                this.skin.washProfit.visible = false;
                this.skin.washTextBox.visible = false;
            };
        }

        private function enterBtnFun(_arg1:MouseEvent):void
        {
            var _local2:Object = {
                "sTime":this.startTime.text,
                "eTime":this.endTime.text
            };
            var _local3:Object = {
                "userName":this.userID,
                "pwd":this.userPwd,
                "time":_local2
            };
            this._nc.call("Sim_Main.getReport", new Responder(this.onResult, this.getStatus), _local3);
            DebugOutput.add("对岸");
        }

        private function onResult(_arg1:Object):void
        {
            if (_arg1.type == true)
            {
                if (_arg1.totalMoney)
                {
                    this.totalMoney.text = String(_arg1.totalMoney);
                }
                else
                {
                    this.totalMoney.text = "0.00";
                };
                if (_arg1.profitMoney)
                {
                    this.profitMoney.text = String(_arg1.profitMoney);
                }
                else
                {
                    this.profitMoney.text = "0.00";
                };
                if (_arg1.washProfit)
                {
                    this.washProfit.text = String(_arg1.washProfit);
                }
                else
                {
                    this.washProfit.text = "0.00";
                };
            };
        }

        private function getStatus(_arg1):void
        {
            DebugOutput.add("<CALL回执>:---------------------错误信息 ------------------\n\n");
            DebugOutput.add("\n\n---------------------错误信息 end------------------");
        }

        public function setAmfUrl(_arg1:String):void
        {
            this._nc.connect(_arg1);
        }

        private function statusHandler(_arg1:NetStatusEvent):void
        {
            switch (_arg1.info.code)
            {
                case "NetConnection.Connect.Rejected":
                case "NetConnection.Connect.Failed":
                case "NetConnection.Connect.Closed":
                    this.showError();
                    return;
            };
        }

        private function showError():void
        {
            dispatchEvent(new Event("error"));
        }

        public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
