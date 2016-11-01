package modules.baijiale.model
{
    import modules.baijiale.model.events.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;

    public class BaijialeUserModel extends ModuleActor 
    {

        [Inject]
        public var userInfoModel:UserInfoModel;
        private var usertype:String = "user";
        private var _userid:String;
        private var _realType:String;
        private var _customRate:Array;
        private var _ip:String;
        private var _seat:Number;
        private var gameArr:Array;
        private var _small:Number;
        private var _big:Number;
        private var _x1:Number;
        private var _z1:Number;
        private var _x2:Number;
        private var _z2:Number;
        private var _xd:Number;
        private var _zd:Number;
        private var _h:Number;
        private var _x:Number;
        private var _z:Number;

        public function BaijialeUserModel()
        {
            this._customRate = new Array();
            super();
        }

        public function get customRate():Array
        {
            return (this._customRate);
        }

        public function get realType():String
        {
            return (this._realType);
        }

        public function set realType(_arg1:String):void
        {
            this._realType = _arg1;
        }

        public function get userid():String
        {
            return (this._userid);
        }

        public function get ip():String
        {
            return (this._ip);
        }

        public function get seat():Number
        {
            return (this._seat);
        }

        public function set seat(_arg1:Number):void
        {
            if (this._seat == _arg1)
            {
                return;
            };
            this._seat = _arg1;
            var _local2:BaijialeUserModelEvent = new BaijialeUserModelEvent(BaijialeUserModelEvent.UP_SEAT);
            _local2.userData = this;
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function get small():Number
        {
            return (this._small);
        }

        public function get big():Number
        {
            return (this._big);
        }

        public function get x1():Number
        {
            return (this._x1);
        }

        public function get z1():Number
        {
            return (this._z1);
        }

        public function get x2():Number
        {
            return (this._x2);
        }

        public function get z2():Number
        {
            return (this._z2);
        }

        public function get xd():Number
        {
            return (this._xd);
        }

        public function get zd():Number
        {
            return (this._zd);
        }

        public function get h():Number
        {
            return (this._h);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function get z():Number
        {
            return (this._z);
        }

        public function initUserData(_arg1:Object):void
        {
            this._userid = _arg1.userid;
            this._ip = _arg1.ip;
            this.userMoney = Number(_arg1.userMoney);
            this.seat = Number(_arg1.seat);
            this.realType = _arg1.realType;
            this.gameArr = _arg1.gameArr;
			
			////
			//this._userid = "ouyang1";		 
			//this.userMoney = Number("280000");
			////
			
            if (_arg1.customRate != undefined)
            {
                this._customRate = (_arg1.customRate as Array);
            };
            this._z = _arg1.z;
            this._x = _arg1.x;
            this._h = _arg1.h;
            this._zd = _arg1.zd;
            this._xd = _arg1.xd;
            this._z2 = _arg1.z2;
            this._x2 = _arg1.x2;
            this._z1 = _arg1.z1;
            this._x1 = _arg1.x1;
            this._big = _arg1.big;
            this._small = _arg1.small;
            var _local2:BaijialeUserModelEvent = new BaijialeUserModelEvent(BaijialeUserModelEvent.INIT_USER_DATA);
            _local2.userData = this;
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function injectMoneyOk(_arg1:Object):void
        {
            this.userMoney = _arg1.userMoney;
			
            var _local2:BaijialeUserModelEvent = new BaijialeUserModelEvent(BaijialeUserModelEvent.INJECT_MONEY_OK);
            _local2.userData = this;
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function injectMoneyError(_arg1:Object):void
        {
            var _local2:BaijialeUserModelEvent = new BaijialeUserModelEvent(BaijialeUserModelEvent.INJECT_MONEY_ERROR);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function get userMoney():Number
        {
            return (this.userInfoModel.userMoney);
        }

        public function set userMoney(_arg1:Number):void
        {
            this.userInfoModel.userMoney = _arg1;
            var _local2:BaijialeUserModelEvent = new BaijialeUserModelEvent(BaijialeUserModelEvent.UP_USER_MONEY);
            _local2.data = _arg1;
            dispatch(_local2);
        }


    }
}//package modules.baijiale.model
