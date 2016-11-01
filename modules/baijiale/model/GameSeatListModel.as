package modules.baijiale.model
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.seat.*;
    import org.robotlegs.mvcs.*;

    public class GameSeatListModel extends Actor 
    {

        private var _allLength:Number;
        private var _currentGroupNum:Number = 0;
        private var _seatGroupNum:Number;
        private var _seatList:Array;
        [Inject]
        public var baijialeUser:BaijialeUserModel;


        public function addUser(_arg1:Object):void
        {
            var _local2:SeatModel;
            _local2 = this.getSeat(_arg1.seat);
            if (_local2 == null)
            {
                return;
            };
            if (_local2.userid != null)
            {
                return;
            };
            _local2.addUser(_arg1);
            var _local3:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.SEAT_LIST_ADD);
            _local3.seat = _local2;
            _local3.data = _arg1;
            dispatch(_local3);
        }

        public function get allLength():Number
        {
            return (this._allLength);
        }

        public function get currentGroup():Array
        {
            return (this.getGroupByGroupNumber(this.currentGroupNum));
        }

        public function get currentGroupNum():Number
        {
            return (this._currentGroupNum);
        }

        public function getGroupByGroupNumber(_arg1:Number):Array
        {
            var _local4:SeatModel;
            var _local2:Array = new Array();
            var _local3:int = ((_arg1 * this.seatGroupNum) - this.seatGroupNum);
            while (_local3 < (_arg1 * this.seatGroupNum))
            {
                _local4 = (this.seatList[_local3] as SeatModel);
                _local2.push(_local4);
                _local3++;
            };
            return (_local2);
        }

        public function getGroupBySeatNum(_arg1:Number):Array
        {
            var _local5:SeatModel;
            if (this.seatList == null)
            {
                return (null);
            };
            var _local2:Array = new Array();
            var _local3:Number = ((_arg1 / this.seatGroupNum) >> 0);
            var _local4:int = _local3;
            while (_local4 < (_local3 + this.seatGroupNum))
            {
                _local5 = (this.seatList[_local4] as SeatModel);
                _local2.push(_local5);
                _local4++;
            };
            return (_local2);
        }

        public function getGroupNumberBySeatNum(_arg1:Number):Number
        {
            if (this.seatList == null)
            {
                return (0);
            };
            var _local2:Number = ((_arg1 / this.seatGroupNum) >> 0);
            return ((_local2 + 1));
        }

        public function getSeat(_arg1:Number):SeatModel
        {
            if (this.seatList == null)
            {
                return (null);
            };
            return (this.seatList[_arg1]);
        }

        public function getSeatByUserid(_arg1:String):SeatModel
        {
            var _local2:SeatModel;
            if (this.seatList == null)
            {
                return (null);
            };
            var _local3:int;
            while (_local3 < this.seatList.length)
            {
                _local2 = this.seatList[_local3];
                if (_local2.userid == _arg1)
                {
                    return (_local2);
                };
                _local3++;
            };
            return (null);
        }

        public function initList(_arg1:Object):void
        {
            var _local3:uint;
            var _local6:Array;
            var _local7:uint;
            var _local8:SeatModel;
            var _local9:Object;
            this._allLength = 112;
            this._seatGroupNum = 7;
            this._seatList = new Array();
            var _local2:Number = (this._allLength / this._seatGroupNum);
            _local3 = 0;
            while (_local3 < _local2)
            {
                _local6 = [];
                _local7 = 0;
                while (_local7 < this._seatGroupNum)
                {
                    _local8 = new SeatModel(((_local3 * this._seatGroupNum) + _local7));
                    _local8.group = _local6;
                    _local8.groupNum = _local3;
                    _local6.push(_local8);
                    this._seatList.push(_local8);
                    _local7++;
                };
                _local3++;
            };
            var _local4:Array = _arg1.arr;
            _local3 = 0;
            while (_local3 < _local4.length)
            {
                _local9 = _local4[_local3];
                _local8 = this.getSeat(_local9.seat);
                if (_local8 != null)
                {
                    _local8.addUser(_local9);
                };
                _local3++;
            };
            var _local5:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.SEAT_LIST);
            _local5.data = this.seatList;
            dispatch(_local5);
            this._currentGroupNum = -1;
            this.gotoUserGroup();
        }

        public function nextGroup():void
        {
            var _local1:Number = ((this.allLength / this.seatGroupNum) >> 0);
            if ((this.currentGroupNum + 1) <= _local1)
            {
                this.setGroup((this.currentGroupNum + 1));
            };
        }

        public function previousGroup():void
        {
            if ((this.currentGroupNum - 1) >= 1)
            {
                this.setGroup((this.currentGroupNum - 1));
            };
        }

        public function gotoUserGroup():void
        {
            var _local1:Number = this.getGroupNumberBySeatNum(this.baijialeUser.seat);
            this.setGroup(_local1);
        }

        public function removeUser(_arg1:Object):void
        {
            var _local2:SeatModel;
            _local2 = this.getSeatByUserid(_arg1.userid);
            if (_local2 == null)
            {
                return;
            };
            if (_local2.userid == null)
            {
                return;
            };
            var _local3:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.SEAT_LIST_REMOVE);
            _local3.seat = _local2;
            _local3.data = _arg1;
            dispatch(_local3);
            _local2.removeUser(_arg1);
        }

        public function get seatGroupNum():Number
        {
            return (this._seatGroupNum);
        }

        public function get seatList():Array
        {
            return (this._seatList);
        }

        public function setGroup(_arg1:Number):void
        {
            if (this._currentGroupNum == _arg1)
            {
                return;
            };
            if (_arg1 >= 100)
            {
                _arg1 = 100;
            };
            if (_arg1 <= 1)
            {
                _arg1 = 1;
            };
            this._currentGroupNum = _arg1;
            var _local2:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.UP_GROUP);
            _local2.seat = null;
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function userInject(_arg1:Object):void
        {
            var _local2:SeatModel;
            _local2 = this.getSeat(_arg1.seat);
            if (_local2 == null)
            {
                return;
            };
            if (_local2.userid == null)
            {
                return;
            };
            _local2.userInject(_arg1);
            var _local3:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.USER_INJECT_MONEY);
            _local3.seat = _local2;
            _local3.data = _arg1;
            dispatch(_local3);
        }

        public function groupInjectMoney(_arg1:Array):void
        {
            var _local4:Object;
            var _local2:int;
            while (_local2 < _arg1.length)
            {
                _local4 = _arg1[_local2];
                this.userInject(_local4);
                _local2++;
            };
            var _local3:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.GROUP_INJECT_MONEY);
            _local3.data = _arg1;
            dispatch(_local3);
        }

        public function clearAllUserInjectMoney():void
        {
            var _local1:SeatModel;
            if (!this.seatList)
            {
                return;
            };
            var _local2:int;
            while (_local2 < this.seatList.length)
            {
                _local1 = this.seatList[_local2];
                _local1.clearInjectMoney();
                _local2++;
            };
            var _local3:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.CLEAR_ALL_USER_INJECTMONEY);
            dispatch(_local3);
        }

        public function refreshAllUserMoney(_arg1:Array):void
        {
            var _local2:SeatModel;
            if (!this.seatList)
            {
                return;
            };
            var _local3:int;
            while (_local3 < _arg1.length)
            {
                _local2 = this.getSeatByUserid(_arg1[_local3].userName);
                if (_local2 != null)
                {
                    _local2.userMoney = _arg1[_local3].money;
                };
                _local3++;
            };
            var _local4:GameSeatListModelEvent = new GameSeatListModelEvent(GameSeatListModelEvent.REFERSH_ALL_USER_MONEY);
            dispatch(_local4);
        }


    }
}//package modules.baijiale.model
