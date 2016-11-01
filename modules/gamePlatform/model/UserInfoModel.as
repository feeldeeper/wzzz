package modules.gamePlatform.model
{
    import modules.gamePlatform.model.events.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import com.utils.*;

    public class UserInfoModel extends ModuleActor 
    {

        private var _hideWash:Boolean;
        private var _userid:String = "";
        public var userpsw:String = "";
        private var _realType:String = "tryModel";
        private var _usertype:String = "user";
        private var _chipModel:String;
        private var _telModel:Boolean;
        private var _nickName:String;
        private var _parentTreeStr:String;
        private var _userMoney:Number = 0;
        private var _userName:Object;
        private var _gameArr:Array;


        public function get parentTreeStr():String
        {
            return (this._parentTreeStr);
        }

        public function set nickName(_arg1:String):void
        {
            this._nickName = _arg1;
            var _local2:UserInfoModelEvent = new UserInfoModelEvent(UserInfoModelEvent.UP_USER_INFO);
            _local2.data = this;
            eventDispatcher.dispatchEvent(_local2);
        }

        public function get nickName():String
        {
            return (this._nickName);
        }

        public function get telModel():Boolean
        {
            return (this._telModel);
        }

        public function set telModel(_arg1:Boolean):void
        {
            this._telModel = _arg1;
        }

        public function get hideWash():Boolean
        {
            return (this._hideWash);
        }

        public function get chipModel():String
        {
            return (this._chipModel);
        }

        public function set chipModel(_arg1:String):void
        {
            this._chipModel = _arg1;
        }

        public function initUser(_arg1:Object):void
        {
            DebugOutput.add("会员细腻");
            Print.printf(_arg1);
            if (_arg1.hideWash == 1)
            {
                this._hideWash = true;
            }
            else
            {
                this._hideWash = false;
            };
            this._userid = _arg1.userid;
            this._userName = _arg1.userName;
            this.userMoney = _arg1.userMoney;
			
			//this._userid = "ouyang1";
            //this._userName = "ouyang1";
            //this.userMoney = "280000";
			
            this.realType = _arg1.realType;
            this._gameArr = _arg1.gameArr;
            this.userpsw = _arg1.passWord;
            this._chipModel = _arg1.chipModel;
            this._nickName = _arg1.nickName;
            this._parentTreeStr = _arg1.parentTreeStr;
            var _local2:UserInfoModelEvent = new UserInfoModelEvent(UserInfoModelEvent.UP_USER_INFO);
            _local2.data = this;
            eventDispatcher.dispatchEvent(_local2);
        }

        public function get userid():String
        {
            return (this._userid);
        }

        public function get usertype():String
        {
            return (this._usertype);
        }

        public function get userName():Object
        {
            return (this._userName);
        }

        public function get gameArr():Array
        {
            return (this._gameArr.concat());
        }

        public function get loginServerData():Object
        {
            var _local1:Object = {};
            _local1.usertype = "user";
            _local1.userid = this.userid;
            _local1.userpsw = this.userpsw;
			////
			//_local1.userid = "xiaozhi8888";
            //_local1.userpsw = "57599f0e0f2778077f78fc00f143e41a";
			////
            _local1.isTelModel = this.telModel;
            _local1.bool = true;
            return (_local1);
        }

        public function get userMoney():Number
        {
            return (this._userMoney);
        }

        public function set userMoney(_arg1:Number):void
        {
            if (this._userMoney == _arg1)
            {
                return;
            };
            this._userMoney = _arg1;
            var _local2:UserInfoModelEvent = new UserInfoModelEvent(UserInfoModelEvent.UP_USER_MONEY);
            _local2.money = this._userMoney;
            eventDispatcher.dispatchEvent(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        public function get realType():String
        {
            return (this._realType);
        }

        public function set realType(_arg1:String):void
        {
            this._realType = _arg1;
        }


    }
}//package modules.gamePlatform.model
