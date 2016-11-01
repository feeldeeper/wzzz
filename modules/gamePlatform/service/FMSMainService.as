package modules.gamePlatform.service
{
    import flash.events.*;
    import modules.gamePlatform.service.events.*;
    import com.snake.gamefms.events.*;
    import com.snake.gamefms.*;
    import org.robotlegs.mvcs.*;

    public class FMSMainService extends Actor 
    {

        public var fmsClient:FmsClient;
        //public var ufmsClient:FmsClient;
        public var fmser:FMSBase;
		//public var ufmser:FMSBase;

        public function FMSMainService()
        {
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
			
			/*
			this.ufmsClient = new FmsClient();
            this.ufmser = new FMSBase(this.ufmsClient);
            this.ufmser.addEventListener(FmsEvent.LINK_START, this.linkStart);
            this.ufmser.addEventListener(FmsEvent.LINK_SUCCESS, this.linkOk);
            this.ufmser.addEventListener(FmsEvent.LINK_CLOSE, this.linkClose);
            this.ufmser.addEventListener(FmsEvent.LINK_REJECTED, this.linkRejected);
            this.ufmser.addEventListener(FmsEvent.LINK_FAILED, this.linkError);
            this.ufmser.addEventListener(FmsEvent.LINK_RETRY, this.linkRetry);
            this.ufmser.addEventListener(FmsEvent.LINK_SERVER_CLOSE, this.fmsServerClose);
            this.ufmsClient.addEventListener(FmsEvent.FMS_CALL, this.fmsCall);
			*/
        }

        public function callFms(_arg1):void
        {
            this.fmser.callFmsByName("callFms", _arg1, this.callFmsResult, this.callFmsError);
        }

        public function fmslink(_arg1:String, _arg2):void
        {
			//trace("aaaa"+_arg1+"bbb"+_arg2);//_arg1="rtmpe://115.29.169.66/gameMain/"
            this.fmser.connect(_arg1, _arg2);
			//this.fmser.connect("rtmpe://localhost/gameMain/", _arg2);
        }

        public function close():void
        {
            this.fmser.close(true);
        }

        private function fmsCall(_arg1:FmsEvent):void
        {
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.FMS_CALL);
			///////json解密
			//trace(_arg1.data);
			//_arg1.data=Tools.json_decode(_arg1.data);
			
			///////
            _local2.data = _arg1.data.data;
            _local2.fmsData = _arg1.data;
            _local2.funName = _arg1.data.type;
			 
            eventDispatcher.dispatchEvent(_local2);
        }

        private function callFmsResult(_arg1):void
        {
            DebugOutput.add(" 调用服务器方法成功:", Tools.json_encode(_arg1));
			trace(" 调用服务器方法成功:"+Tools.json_encode(_arg1));
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.CALL_FMS_RESULT);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
        }

        private function callFmsError(_arg1):void
        {
            DebugOutput.add(" 调用服务器方法错误:", Tools.json_encode(_arg1));
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.CALL_FMS_ERROR);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkStart(_arg1:FmsEvent):void
        {
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.LINK_START);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkOk(_arg1:FmsEvent):void
        {
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.LINK_SUCCESS);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkClose(_arg1:FmsEvent):void
        {
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.LINK_CLOSE);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkRejected(_arg1:FmsEvent):void
        {
            var _local2:String = ("拒绝链接:" + Tools.json_encode(_arg1.data));
            DebugOutput.add(_local2);
            var _local3:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.LINK_REJECTED);
            _local3.data = _arg1.data;
            eventDispatcher.dispatchEvent(_local3);
        }

        private function linkError(_arg1:FmsEvent):void
        {
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.LINK_FAILED);
            eventDispatcher.dispatchEvent(_local2);
        }

        protected function fmsServerClose(_arg1:FmsEvent):void
        {
            var _local2:FMSMainServiceEvent = new FMSMainServiceEvent(FMSMainServiceEvent.LINK_SERVER_CLOSE);
            eventDispatcher.dispatchEvent(_local2);
        }

        private function linkRetry(_arg1:FmsEvent):void
        {
        }


    }
}//package modules.gamePlatform.service
