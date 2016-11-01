package com.snake.gamefms
{
    import flash.events.*;
    import com.snake.gamefms.events.*;
    import flash.net.*;

    public class FMSBase extends EventDispatcher 
    {

        public var name:String = "FMSServer";
        private var atOneTime:Boolean;
        private var _nc:NetConnection;
        private var _ncCode:String;
        private var _linkBool:Boolean;
        private var retryConnectNum:uint = 0;
        private var _linkValue:Object;
        private var _server:String;
        private var _rejectedStr:String;
        private var _client:IFMSClient;

        public function FMSBase(_arg1:IFMSClient=null)
        {
            this._nc = new NetConnection();
            this._nc.addEventListener(NetStatusEvent.NET_STATUS, this.ncStatus);
            this._nc.addEventListener(IOErrorEvent.IO_ERROR, this.IO_ERROR);
            if (_arg1 != null)
            {
                this.client = _arg1;
            }
            else
            {
                this.client = new FmsClient();
            };
        }

        public function IO_ERROR(_arg1:IOErrorEvent):void
        {
        }

        public function retryConnect():void
        {
            this.retryConnectNum = (this.retryConnectNum + 1);
            if (this.retryConnectNum > 5)
            {
                return;
            };
            this.connect(this._server, this._linkValue);
            dispatchEvent(new FmsEvent(FmsEvent.LINK_RETRY));
        }

        public function connect(_arg1:String="rtmp://localhost/test/", _arg2:Object=null, _arg3:uint=3):void
        {
            this._linkBool = false;
            this.atOneTime = false;
            this._linkValue = _arg2;
            this._server = _arg1;
            if (!this.nc.objectEncoding)
            {
                this.nc.objectEncoding = _arg3;
            };
            if (_arg2 == null)
            {
                this.nc.connect(this._server);
            }
            else
            {
                this.nc.connect(this._server, this._linkValue);
            };
            dispatchEvent(new FmsEvent(FmsEvent.LINK_START));
        }

        private function ncStatus(_arg1:NetStatusEvent):void
        {
            this._ncCode = _arg1.info.code;
            switch (this._ncCode)
            {
                case "NetConnection.Connect.Success":
                    this.atOneTime = true;
                    this.retryConnectNum = 0;
                    this.dispatchEvent(new FmsEvent(FmsEvent.LINK_SUCCESS));
                    return;
                case "NetConnection.Connect.Failed":
                    this.dispatchEvent(new FmsEvent(FmsEvent.LINK_FAILED));
                    return;
                case "NetConnection.Connect.Rejected":
                    this.dispatchEvent(new FmsEvent(FmsEvent.LINK_REJECTED, _arg1.info.application));
                    return;
                case "NetConnection.Connect.Closed":
                    if (this.atOneTime)
                    {
                        this.dispatchEvent(new FmsEvent(FmsEvent.LINK_CLOSED));
                    }
                    else
                    {
                        this.dispatchEvent(new FmsEvent(FmsEvent.LINK_CLOSENO));
                    };
                    this.close();
                    return;
            };
        }

        public function set client(_arg1:IFMSClient):void
        {
            if (this._client == _arg1)
            {
                return;
            };
            this._client = _arg1;
            this.nc.client = this._client;
            this._client.fmsBase = this;
        }

        public function get client():IFMSClient
        {
            return (this._client);
        }

        public function get linkValue():Object
        {
            return (this._linkValue);
        }

        public function get rejectedStr():String
        {
            return (this._rejectedStr);
        }

        public function get nc():NetConnection
        {
            return (this._nc);
        }

        public function get ncCode():String
        {
            return (this._ncCode);
        }

        public function close(_arg1:Boolean=false):void
        {
            if (_arg1)
            {
                this.nc.removeEventListener(NetStatusEvent.NET_STATUS, this.ncStatus);
                this.nc.close();
                dispatchEvent(new FmsEvent(FmsEvent.LINK_CLOSE));
                dispatchEvent(new FmsEvent(FmsEvent.LINK_CLIENT_CLOSE, {"login":this.atOneTime}));
                this.nc.addEventListener(NetStatusEvent.NET_STATUS, this.ncStatus);
            }
            else
            {
                this.nc.close();
                dispatchEvent(new FmsEvent(FmsEvent.LINK_CLOSE));
                dispatchEvent(new FmsEvent(FmsEvent.LINK_SERVER_CLOSE, {"login":this.atOneTime}));
            };
        }

        public function callFmsByName(_arg1:String, _arg2=null, _arg3:Function=null, _arg4:Function=null):void
        {
            if (_arg3 == null)
            {
                _arg3 = this.callFmsResult;
            };
            if (_arg4 == null)
            {
                _arg4 = this.callFmsError;
            };
            var _local5:Responder = new Responder(_arg3, _arg4);
            this.nc.call(_arg1, _local5, _arg2);
        }

        public function callFms(_arg1=null, _arg2:Function=null, _arg3:Function=null):void
        {
            this.callFmsByName("callFms", _arg1, _arg2, _arg3);
        }

        private function callFmsResult(_arg1):void
        {
        }

        private function callFmsError(_arg1):void
        {
            DebugOutput.add((this.name + " 调用服务器方法错误:"), Tools.json_encode(_arg1));
        }


    }
}//package com.snake.gamefms
