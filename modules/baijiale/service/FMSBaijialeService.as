package modules.baijiale.service
{
    import flash.events.*;
    import modules.baijiale.service.events.*;
    import com.snake.gamefms.events.*;
    import com.snake.gamefms.*;
	import com.snake.gamefms.Des;
    import org.robotlegs.utilities.modular.mvcs.*;

    public class FMSBaijialeService extends ModuleActor 
    {

        public var fmsClient:FmsClient;
        public var fmser:FMSBase;
        private var des:com.snake.gamefms.Des;

        public function FMSBaijialeService()
        {
            this.des = new Des();
            super();
            this.fmsClient = new FmsClient();
            this.fmser = new FMSBase(this.fmsClient);
            this.fmser.addEventListener(FmsEvent.LINK_START, this.linkStart);
            this.fmser.addEventListener(FmsEvent.LINK_SUCCESS, this.linkOk);
            this.fmser.addEventListener(FmsEvent.LINK_CLOSE, this.linkClose);
            this.fmser.addEventListener(FmsEvent.LINK_REJECTED, this.linkRejected);
            this.fmser.addEventListener(FmsEvent.LINK_FAILED, this.linkError);
            this.fmser.addEventListener(FmsEvent.LINK_RETRY, this.linkRetry);
            this.fmser.addEventListener(FmsEvent.LINK_SERVER_CLOSE, this.fmsServerClose);
            this.fmsClient.addEventListener(FmsEvent.FMS_CALL, this.fmsCall);
        }

        public function fmslink(_arg1:String, _arg2, _arg3:uint=0, _arg4:uint=0):void
        {
            var _local5:Object = {};
            _local5.fmsUrl = _arg1;
            _local5.value = _arg2;
            _local5.value.seatId = _arg4;
            Tools.setTimeOut(this.fmslinkTimeOut, _arg3, _local5);
            var _local6:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.LINK_DELAY_START);
            eventDispatcher.dispatchEvent(_local6);
        }

        private function fmslinkTimeOut(_arg1:Object):void
        {
			//trace(_arg1.fmsUrl);
            this.fmser.connect(_arg1.fmsUrl, _arg1.value);
        }

        public function close():void
        {
            this.fmser.close(true);
        }

        private function fmsCall(_arg1:FmsEvent):void
        {
            var _local2:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.FMS_CALL);
            _local2.data = _arg1.data.data;
            _local2.fmsData = _arg1.data;
            _local2.funName = _arg1.data.type;
            eventDispatcher.dispatchEvent(_local2);
        }

        public function callFms(_arg1):void
        {
            this.fmser.callFmsByName("callFms", _arg1, this.callFmsResult, this.callFmsError);
        }

        public function injectMoney(_arg1:Object):void
        {
            var _local2:Object = {};
            var _local3:String = this.des.genIV(16);
            _local2.fun = "userInjectMoney";
            _local2.data = _arg1;
            this.fmser.callFms(_local2, this.callFmsResult);
        }

        public function refreshMoney():void
        {
        }

        public function userSetSeat(_arg1:Object):void
        {
            var _local2:Object = {};
            _local2.fun = "userSetSeat";
            _local2.data = _arg1;
            this.fmser.callFms(_local2);
        }

        private function callFmsResult(_arg1):void
        {
            var _local2:FMSBaijialeServiceEvent;
            if (_arg1.type == false)
            {
                DebugOutput.add("调用服务器方法失败:", Tools.json_encode(_arg1));
                _local2 = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.CALL_FMS_ERROR);
            }
            else
            {
                _local2 = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.CALL_FMS_RESULT);
            };
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
        }

        private function callFmsError(_arg1):void
        {
            DebugOutput.add(" 调用服务器方法错误:", Tools.json_encode(_arg1));
            var _local2:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.CALL_FMS_ERROR);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkStart(_arg1:FmsEvent):void
        {
            var _local2:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.LINK_START);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkOk(_arg1:FmsEvent):void
        {
            var _local2:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.LINK_SUCCESS);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkClose(_arg1:FmsEvent):void
        {
            var _local2:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.LINK_CLOSE);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkRejected(_arg1:FmsEvent):void
        {
            var _local2:String = ("拒绝链接:" + Tools.json_encode(_arg1.data));
            var _local3:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.LINK_REJECTED);
            _local3.data = _arg1.data;
            eventDispatcher.dispatchEvent(_local3);
        }

        private function linkError(_arg1:FmsEvent):void
        {
            var _local2:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.LINK_FAILED);
            eventDispatcher.dispatchEvent(_local2);
        }

        protected function fmsServerClose(_arg1:FmsEvent):void
        {
            var _local2:FMSBaijialeServiceEvent = new FMSBaijialeServiceEvent(FMSBaijialeServiceEvent.LINK_SERVER_CLOSE);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkRetry(_arg1:FmsEvent):void
        {
        }


    }
}//package modules.baijiale.service
