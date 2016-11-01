package com.snake.net
{
    import flash.events.*;
    import flash.net.*;

    public class ClientBW extends FmsInf 
    {

        private var nc:NetConnection;
        public var testOK:Boolean = false;

        public function ClientBW(_arg1:int, _arg2:String=null, _arg3:String=null)
        {
            super(_arg1, _arg2, _arg3);
            this.nc = new NetConnection();
            this.nc.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
            this.nc.client = this;
        }

        public function test():void
        {
            if (this.nc.connected)
            {
                this.nc.close();
            };
            this.nc.connect(url);
        }

        public function netStatusHandler(_arg1:NetStatusEvent):void
        {
            switch (_arg1.info.code)
            {
                case "NetConnection.Connect.Success":
                    this.nc.call("checkBandwidth", null);
                    return;
                case "NetConnection.Connect.Rejected":
                    return;
                case "NetConnection.Connect.Failed":
                    return;
                case "NetConnection.Connect.Closed":
                    return;
            };
        }

        public function close(... _args):void
        {
        }

        public function onBWCheck(... _args):Number
        {
            return (0);
        }

        public function onBWDone(... _args):void
        {
            if (_args.length > 0)
            {
                this.testOK = true;
                bw = _args[0];
                delay = _args[3];
            };
        }

        override public function reset():void
        {
            super.reset();
        }

        public function stop():void
        {
            if (this.nc.connected)
            {
                this.nc.close();
            };
        }


    }
}//package com.snake.net
