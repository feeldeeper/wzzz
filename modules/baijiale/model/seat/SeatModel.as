package modules.baijiale.model.seat
{
    import flash.events.*;
    import modules.baijiale.model.seat.events.*;

    public class SeatModel extends EventDispatcher 
    {

        public var group:Array;
        public var groupNum:uint;
        private var _big:Number = 0;
        private var _h:Number = 0;
        private var _seat:Number = 0;
        private var _small:Number = 0;
        private var _userMoney:Number = 0;
        private var _userid:String = null;
        private var _x:Number = 0;
        private var _xd:Number = 0;
        private var _z:Number = 0;
        private var _zd:Number = 0;
        private var _nickName:String = "";

        public function SeatModel(_arg1:Number)
        {
            this._seat = _arg1;
        }

        public function get nickName():String
        {
            return (this._nickName);
        }

        public function set nickName(_arg1:String):void
        {
            this._nickName = _arg1;
        }

        public function addUser(_arg1:Object):void
        {
            if (_arg1.seat != this.seat)
            {
                return;
            };
            this._userid = _arg1.userid;
            this._userMoney = _arg1.userMoney;
            this._z = _arg1.z;
            this._x = _arg1.x;
            this._h = _arg1.h;
            this._zd = _arg1.zd;
            this._xd = _arg1.xd;
            this._big = _arg1.big;
            this._small = _arg1.small;
            this._nickName = _arg1.nickName;
            dispatchEvent(new SeatModelEvent(SeatModelEvent.ADD_USER));
        }

        public function get big():Number
        {
            return (this._big);
        }

        public function get h():Number
        {
            return (this._h);
        }

        public function removeUser(_arg1:Object):void
        {
            if (this.userid != _arg1.userid)
            {
                return;
            };
            this._userid = null;
            this._userMoney = 0;
            this._z = 0;
            this._x = 0;
            this._h = 0;
            this._zd = 0;
            this._xd = 0;
            this._big = 0;
            this._small = 0;
            dispatchEvent(new SeatModelEvent(SeatModelEvent.REMOVE_USER));
        }

        public function get seat():Number
        {
            return (this._seat);
        }

        public function get small():Number
        {
            return (this._small);
        }

        public function userInject(_arg1:Object):void
        {
            if (this.userid != _arg1.userid)
            {
                return;
            };
            this._userMoney = _arg1.userMoney;
            this._z = _arg1.z;
            this._x = _arg1.x;
            this._h = _arg1.h;
            this._zd = _arg1.zd;
            this._xd = _arg1.xd;
            this._big = _arg1.big;
            this._small = _arg1.small;
            dispatchEvent(new SeatModelEvent(SeatModelEvent.USER_INJECT_MONEY));
        }

        public function getInjectMoney():Number
        {
            return (((((((this.z + this.x) + this.h) + this.zd) + this.xd) + this.big) + this.small));
        }

        public function clearInjectMoney():void
        {
            this._z = 0;
            this._x = 0;
            this._h = 0;
            this._zd = 0;
            this._xd = 0;
            this._big = 0;
            this._small = 0;
            dispatchEvent(new SeatModelEvent(SeatModelEvent.CLEAR_INJECT_MOMEY));
        }

        public function get userMoney():Number
        {
            return (this._userMoney);
        }

        public function set userMoney(_arg1:Number):void
        {
            this._userMoney = _arg1;
        }

        public function get userid():String
        {
            return (this._userid);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function get xd():Number
        {
            return (this._xd);
        }

        public function get z():Number
        {
            return (this._z);
        }

        public function get zd():Number
        {
            return (this._zd);
        }


    }
}//package modules.baijiale.model.seat
