package com.snake.gamefms
{
    import flash.events.*;
    import com.snake.gamefms.events.*;

    public class FmsClient extends EventDispatcher implements IFMSClient 
    {

        public var onBWDone;
        private var _fms:FMSBase;

        public function FmsClient():void
        {
        }

        public function close():void
        {
            if (this._fms)
            {
                this._fms.close();
            };
        }

        public function get fmsBase():FMSBase
        {
            return (this._fms);
        }

        public function set fmsBase(_arg1:FMSBase):void
        {
            if (this._fms == null)
            {
                this._fms = _arg1;
            };
        }

        public function fmsCall(_arg1:Object):void
        {
            dispatchEvent(new FmsEvent(FmsEvent.FMS_CALL, _arg1));
            if ((((_arg1 == null)) && ((_arg1.type == null))))
            {
                return;
            };
            dispatchEvent(new FmsEvent(_arg1.type, _arg1.data));
        }

        public function httpCallBack(_arg1:Object):void
        {
        }


    }
}//package com.snake.gamefms
