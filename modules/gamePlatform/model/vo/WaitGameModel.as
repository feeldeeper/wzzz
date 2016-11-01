package modules.gamePlatform.model.vo
{
    import flash.events.*;
    import flash.utils.*;

    public class WaitGameModel extends EventDispatcher 
    {

        private var _gameType:String;
        private var _moneyTypeGroup:String;
        private var _waitInGameObject:Object;
        private var moneyGroupDic:Dictionary;
        private var _moneyGroup:Array;

        public function WaitGameModel()
        {
            this.moneyGroupDic = new Dictionary();
            super();
        }

        public function addMoneyGroup(_arg1:Object):void
        {
            if (this.moneyGroupDic[_arg1.type] != null)
            {
                return;
            };
            var _local2:GameMoneyGroup = new GameMoneyGroup();
            this.moneyGroupDic[_arg1.type] = _local2;
            _local2.type = _arg1.type;
            var _local3:Array = String(_arg1.maxMin).split(",");
            _local2.setMoneyGroup(_local3, _arg1);
        }

        public function addMoneyGroupByGameType(_arg1:String, _arg2:Object):void
        {
            var _local3:GameMoneyGroup = new GameMoneyGroup();
            this.moneyGroupDic[_arg1] = _local3;
            _local3.type = _arg1;
        }

        public function get gameType():String
        {
            return (this._gameType);
        }

        public function getMoneyGroup(_arg1:String):GameMoneyGroup
        {
            if (this.moneyGroupDic[_arg1] != null)
            {
                return ((this.moneyGroupDic[_arg1] as GameMoneyGroup));
            };
            return (null);
        }

        public function initVO(_arg1:Array):void
        {
            var _local3:Object;
            if (!_arg1)
            {
                return;
            };
            var _local2:int;
            while (_local2 < _arg1.length)
            {
                _local3 = _arg1[_local2];
                if (_local3.type != null)
                {
                    this.addMoneyGroup(_local3);
                };
                _local2++;
            };
        }

        public function get moneyTypeGroup():String
        {
            return (this._moneyTypeGroup);
        }

        public function get moneyGroup():Array
        {
            return (this._moneyGroup);
        }

        public function setWaitInGameObject(_arg1:Object):void
        {
            this._waitInGameObject = _arg1;
            if (_arg1.gameType)
            {
                this._gameType = _arg1.gameType;
            };
            if (_arg1.moneyTypeGroup)
            {
                this._moneyTypeGroup = _arg1.moneyTypeGroup;
            };
            this._moneyGroup = this.getMoneyGroup(this._gameType).getMoneyGroup(this._moneyTypeGroup);
        }

        public function get waitInGameObject():Object
        {
            return (this._waitInGameObject);
        }


    }
}//package modules.gamePlatform.model.vo
