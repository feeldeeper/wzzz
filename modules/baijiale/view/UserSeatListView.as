package modules.baijiale.view
{
    import flash.events.*;
    import flash.display.*;
    import baijiale.*;
    import modules.baijiale.view.components.*;
    import modules.baijiale.model.*;
    import modules.baijiale.model.seat.*;
    import com.greensock.loading.*;

    public class UserSeatListView extends Sprite 
    {

        private var skin:UserSeatListSkin;
        public var playArr:Array;
        public var tieArr:Array;
        public var bankArr:Array;
        public var userArr:Array;
        private var userHeader:SWFLoader;
        private var isInit:Boolean;
        public var baijialeUser:BaijialeUserModel;

        public function UserSeatListView(_arg1:UserSeatListSkin)
        {
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            var _local1:MovieClip;
            var _local2:Class;
            var _local3:int;
            var _local4:UserSeat;
            var _local5:MovieClip;
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            addChild(this.skin);
            if (this.isInit == false)
            {
                this.userArr = new Array();
                this.userHeader = LoaderMax.getLoader("userHeader");
                _local2 = this.userHeader.getClass("userHeader.UserHeaderSkin");
                _local3 = 0;
                while (_local3 < 7)
                {
                    _local4 = new UserSeat(this.skin[("user_" + _local3)]);
                    this.userArr.push(_local4);
                    _local4.setUserTableNum(_local3);
                    addChild(_local4);
                    _local5 = new (_local2)();
                    _local5.width = 40;
                    _local5.height = 40;
                    _local5.x = 1;
                    _local5.y = 1;
                    _local5.gotoAndStop(Tools.randRange(1, 16));
                    _local4.header.addChild(_local5);
                    _local4.hideUserBox();
                    _local3++;
                };
                this.isInit = true;
            };
        }

        protected function selectSeat(_arg1:Event):void
        {
        }

        public function dispose():void
        {
        }

        public function addSeatList(_arg1:SeatModel):void
        {
            var _local2:UserSeat;
            var _local3:uint;
            var _local4:uint = Math.ceil((_arg1.seat / 7));
            if (_arg1.seat > 6)
            {
                if ((_arg1.seat % 7) == 0)
                {
                    _local3 = 0;
                }
                else
                {
                    _local3 = Math.abs((((_local4 * 7) - _arg1.seat) - 7));
                };
            }
            else
            {
                _local3 = _arg1.seat;
            };
            _local2 = this.userArr[_local3];
            _local2.addUser(_arg1);
        }

        public function removeSeatList(_arg1:Object):void
        {
            var _local2:UserSeat;
            var _local3:int;
            while (_local3 < this.userArr.length)
            {
                _local2 = this.userArr[_local3];
                if (_local2.userid == _arg1.userid)
                {
                    _local2.removeUser();
                };
                _local3++;
            };
        }

        public function userInjectMoney(_arg1:SeatModel):void
        {
            var _local2:UserSeat;
            var _local3:int;
            while (_local3 < this.userArr.length)
            {
                _local2 = this.userArr[_local3];
                if (_local2.userid == _arg1.userid)
                {
                    _local2.injectMoney();
                };
                _local3++;
            };
        }

        public function refershALLUserMoney():void
        {
            var _local1:UserSeat;
            var _local2:int;
            while (_local2 < this.userArr.length)
            {
                _local1 = this.userArr[_local2];
                _local1.refreshUser();
                _local2++;
            };
        }

        public function upGroup(_arg1:Array):void
        {
            var _local2:UserSeat;
            var _local3:SeatModel;
            var _local4:int;
            while (_local4 < this.userArr.length)
            {
                _local3 = _arg1[_local4];
                if (((_local3) && (!((_local3.userid == "")))))
                {
                };
                _local2 = this.userArr[_local4];
                _local2.setSeat(_local3);
                _local4++;
            };
        }

        public function initUserSeat(_arg1:Array):void
        {
            var _local2:UserSeat;
            var _local3:int;
            _local3 = 0;
            while (_local3 < this.userArr.length)
            {
                this.userArr[_local3].removeUser();
                _local3++;
            };
            _local3 = 0;
            while (_local3 < _arg1.length)
            {
                if (_arg1[_local3].userid != null)
                {
                    this.addSeatList(_arg1[_local3]);
                };
                _local3++;
            };
        }

        public function setBaijialeUser(_arg1:BaijialeUserModel):void
        {
            var _local2:UserSeat;
            this.baijialeUser = _arg1;
            var _local3:int;
            while (_local3 < this.userArr.length)
            {
                _local2 = this.userArr[_local3];
                _local2.baijialeUser = _arg1;
                _local3++;
            };
        }

        public function closeLink():void
        {
            var _local1:UserSeat;
            var _local2:int;
            while (_local2 < this.userArr.length)
            {
                _local1 = this.userArr[_local2];
                _local1.hideUserBox();
                _local2++;
            };
        }

        public function chipWinMovie(_arg1:Object):void
        {
            var _local2:UserSeat;
            var _local3:int;
            while (_local3 < this.userArr.length)
            {
                _local2 = this.userArr[_local3];
                _local2.chipWinMovie(_arg1);
                _local3++;
            };
        }


    }
}//package modules.baijiale.view
