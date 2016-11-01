package modules.baijiale.model
{
    import flash.utils.*;
    import modules.baijiale.model.events.*;
    import org.robotlegs.mvcs.*;

    public class GameDataModel extends Actor 
    {

        private var _time:Number;
        private var _oldTime:Number;
        private var _intervalTime:uint;
        private var _videoName:String;
        private var _videoUrll:String;
        private var _gameid:String;
        private var _gameType:String = "baijiale";
        private var _gameTableName:String;
        private var _farmerBool:Boolean = false;
        private var _injectTime:Number;
        private var _gameHistory:Array;
        public var tableMax:Number;
        public var tableMin:Number;
        public var telMax:Number;
        public var telMin:Number;
        public var telTieMax:Number;
        public var telPairMax:Number;
        public var telDiffMax:Number;
        private var _gameState:Number;
        private var _gameBoot:Number;
        private var _roundNum:Number;
        private var _gameNumber:String;

        public function GameDataModel()
        {
            this.initTime();
        }

        public function get videoName():String
        {
            return (this._videoName);
        }

        public function get videoUrll():String
        {
            return (this._videoUrll);
        }

        public function initTime():void
        {
            this._intervalTime = setInterval(this.timeFunction, 1000);
        }

        private function timeFunction():void
        {
            eventDispatcher.dispatchEvent(new GameDataModelEvent(GameDataModelEvent.UP_TIME));
        }

        public function get time():Number
        {
            var _local1:Number;
            var _local2:uint;
            if (this.gameState != 1)
            {
                _local1 = 0;
            }
            else
            {
                _local2 = (((new Date().time - this._oldTime) / 1000) >> 0);
                _local1 = (this._time - _local2);
                if (_local1 < 0)
                {
                    _local1 = 0;
                };
            };
            return (_local1);
        }

        public function get timeHasElapsed():Number
        {
            return ((((new Date().time - this._oldTime) / 1000) >> 0));
        }

        public function get gameid():String
        {
            return (this._gameid);
        }

        public function get gameType():String
        {
            return (this._gameType);
        }

        public function get gameTableName():String
        {
            return (this._gameTableName);
        }

        public function get farmerBool():Boolean
        {
            return (this._farmerBool);
        }

        public function set farmerBool(_arg1:Boolean):void
        {
            if (this._farmerBool == _arg1)
            {
                return;
            };
            this._farmerBool = _arg1;
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.UP_GAME_FARMER);
            dispatch(_local2);
        }

        public function get injectTime():Number
        {
            return (this._injectTime);
        }

        public function get gameHistory():Array
        {
            return (this._gameHistory.concat(new Array()));
        }

        public function get gameState():Number
        {
            return (this._gameState);
        }

        public function get gameBoot():Number
        {
            return (this._gameBoot);
        }

        public function get roundNum():Number
        {
            return (this._roundNum);
        }

        public function get gameNumber():String
        {
            return (this._gameNumber);
        }

        public function initGameInfo(_arg1:Object):void
        {
            if (this.gameType != _arg1.gameType)
            {
                return;
            };
            this._gameid = _arg1.gameid;
            this._gameType = _arg1.gameType;
            this._gameTableName = _arg1.gameTableName;
            this.farmerBool = _arg1.farmerBool;
            this._injectTime = _arg1.injectTime;
            this.tableMax = _arg1.tableMax;
            this.tableMin = _arg1.tableMin;
            this.telMax = _arg1.telMax;
            this.telMin = _arg1.telMin;
            this.telTieMax = _arg1.telTieMax;
            this.telPairMax = _arg1.telPairMax;
            this.telPairMax = _arg1.telPairMax;
            this.telDiffMax = _arg1.telDiffMax;
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.INIT_GAME_INFO);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function setGameState(_arg1:Object):void
        {
            if (_arg1.gameType != this.gameType)
            {
                return;
            };
            if (_arg1.gameid != this.gameid)
            {
                return;
            };
            this._oldTime = new Date().time;
            this._time = _arg1.time;
            this._gameState = Number(_arg1.gameState);
            this._gameBoot = Number(_arg1.gameBoot);
            this._roundNum = Number(_arg1.roundNum);
            this._gameNumber = _arg1.gameNumber;
            this._injectTime = _arg1.injectTime;
            this.farmerBool = _arg1.farmerBool;
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.UP_GAMESTATE);
            dispatch(_local2);
        }

        public function setGameHistory(_arg1:Object):void
        {
            if (_arg1.gameType != this.gameType)
            {
                return;
            };
            if (_arg1.gameid != this.gameid)
            {
                return;
            };
            this._gameHistory = _arg1.gameHistory;
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.UP_GAME_HISTORY);
            _local2.data = this._gameHistory;
            dispatch(_local2);
        }

        public function setGameResults(_arg1:Object):void
        {
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.UP_GAME_RESULTS);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function setGameDeal(_arg1:Object):void
        {
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.UP_GAME_DEAL);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function setGameNotice(_arg1:Object):void
        {
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.UP_GAME_NOTICE);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function setLimitInfo(_arg1:Object):void
        {
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.UP_LIMIT_INFO);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function setGameFarmer(_arg1:Object):void
        {
            this.farmerBool = _arg1;
        }

        public function userInjectMoney(_arg1:Object):void
        {
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.USER_INJECT_MONEY);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function gameError(_arg1:Object):void
        {
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.GAME_ERROR);
            _local2.data = _arg1;
            dispatch(_local2);
        }

        public function gameAllInject(_arg1:Object):void
        {
            var _local2:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.GAME_ALL_INJECT);
            _local2.data = _arg1;
            dispatch(_local2);
        }


    }
}//package modules.baijiale.model
