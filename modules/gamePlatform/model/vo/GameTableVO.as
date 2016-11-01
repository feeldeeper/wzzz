package modules.gamePlatform.model.vo
{
    import flash.events.*;
    import flash.utils.*;
    import modules.gamePlatform.model.vo.events.*;

    public class GameTableVO extends EventDispatcher 
    {

        protected var _gameClassName:String = "";
        protected var _url:String = "";
        public var room:String = "";
        protected var _gameType:String = "";
        protected var _gameid:String = "";
        protected var _gameTableName:String = "";
        private var _seatId:uint;
        private var _gameUrl:String = "";
        protected var _hidden:String = "";
        public var videoUrll:String = "";
        public var videoName:String = "";
        protected var _injectTime:Number;
        protected var _farmerBool:Boolean = false;
        private var _rateType:uint;
        public var tableNum:String = "";
        public var tableName:String = "";
        public var gameBoot:Number;
        public var roundNum:Number;
        public var gameNumber:String;
        protected var _gameState:Object;
        protected var _gameHistory:Array;
        private var _groupUserSeatList:Array;
        private var _tableLimitMax:uint;
        private var _tableLimitMin:uint;
        private var _gameSubType:String;
        private var _time:Number;
        private var _oldTime:Number;
        private var _leavingsTime:uint;
        private var _intervalTime:uint;

        public function GameTableVO(_arg1:IEventDispatcher=null)
        {
            this._gameHistory = [];
            this._groupUserSeatList = new Array();
            super(_arg1);
        }

        public function get gameSubType():String
        {
            return (this._gameSubType);
        }

        public function get tableLimitMin():uint
        {
            return (this._tableLimitMin);
        }

        public function get tableLimitMax():uint
        {
            return (this._tableLimitMax);
        }

        public function get rateType():uint
        {
            return (this._rateType);
        }

        public function set rateType(_arg1:uint):void
        {
            this._rateType = _arg1;
        }

        public function get seatId():uint
        {
            return (this._seatId);
        }

        public function set seatId(_arg1:uint):void
        {
            this._seatId = _arg1;
        }

        public function get groupUserSeatList():Array
        {
            return (this._groupUserSeatList);
        }

        public function set groupUserSeatList(_arg1:Array):void
        {
            this._groupUserSeatList = _arg1;
        }

        public function get hidden():String
        {
            return (this._hidden);
        }

        public function set hidden(_arg1:String):void
        {
            this._hidden = _arg1;
        }

        public function get injectTime():Number
        {
            return (this._injectTime);
        }

        public function get farmerBool():Boolean
        {
            return (this._farmerBool);
        }

        public function get gameType():String
        {
            return (this._gameType);
        }

        public function get gameid():String
        {
            return (this._gameid);
        }

        public function get gameHistory():Array
        {
            return (this._gameHistory.concat(new Array()));
        }

        public function get gameState():Object
        {
            return (this._gameState);
        }

        public function get url():String
        {
            return (this._url);
        }

        public function get gameClassName():String
        {
            return (this._gameClassName);
        }

        public function setConfingData(_arg1:Object):void
        {
			/*
			trace("--------c-----------");
			trace(_arg1.gameid+"=gameid");//01
			trace(_arg1.gameUrl+"=gameUrl");//rtmpe://121.199.1.57/baijiale
			trace(_arg1.tableName+"=tableName");//白加叻
			trace(_arg1.tableNum+"=tableNum");//01
			trace(_arg1.videoUrll+"=videoUrll");//rtmp://asia3.cccbar.com:1932/gobot3/
			trace(_arg1.videoName+"=videoName");//b001
			trace(_arg1.hidden+"=hidden");//undefined
			trace(_arg1.gameSubType+"=gameSubType");//bjl
			trace("--------c-----------");
			*/
            this._gameid = _arg1.gameid;
            this._gameUrl = _arg1.gameUrl;
            this._gameTableName = (this.gameType + _arg1.gameid);
            this.tableName = _arg1.tableName;
            this.tableNum = _arg1.tableNum;
            this.videoUrll = _arg1.videoUrll;
            this.videoName = _arg1.videoName;
            this.hidden = _arg1.hidden;
            this._gameSubType = _arg1.gameSubType;
            dispatchEvent(new GameTableVOEvent(GameTableVOEvent.SET_CONFING));
        }

        public function setFMSData(_arg1:Object):void
        {
            if (_arg1.gameType != this.gameType)
            {
                return;
            };
            if (_arg1.gameid != this.gameid)
            {
                return;
            };
			//trace("--------f-----------");
			//trace(_arg1.farmerBool+"=farmerBool");
			//trace("------f-------------");
            this._farmerBool = _arg1.farmerBool;
            dispatchEvent(new GameTableVOEvent(GameTableVOEvent.SET_FMS_INIT_DATA));
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
 
			/*
			trace("-------------------");
			//trace(this.gameType+"=this.gameType");//baijiale
			trace(this.gameid+"=this.gameid");//01
			trace(_arg1.time+"=time");//25
			trace(new Date().time+"=oldtime");//1422412679453
			trace(_arg1.gameState+"=gameState");//2
			trace(_arg1.injectTime+"=injectTime");//40 
			trace(_arg1.gameBoot+"=gameBoot");//0
			trace(_arg1.roundNum+"=roundNum");//55
			trace(_arg1.gameNumber+"=gameNumber");//0155150128103734
			//trace(_arg1.farmerBool+"=farmerBool");//undefined
			//trace(_arg1._tableLimitMax+"=_tableLimitMax");//undefined
			//trace(_arg1._tableLimitMin+"=_tableLimitMin");//undefined
 
			trace("-------------------");
			*/
            this._time = _arg1.time;//可变化 由40 或 0
            this._oldTime = new Date().time;//当前时间
            this._gameState = Number(_arg1.gameState);//1-可以投注 2-不可以投注
            this._injectTime = _arg1.injectTime;//百家乐固定40秒，投注时间
            this.gameBoot = Number(_arg1.gameBoot);//第几场 一般为0
            this.roundNum = Number(_arg1.roundNum);//第几次
            this.gameNumber = _arg1.gameNumber;//局编号
            this.farmerBool = _arg1.farmerBool;
            this._tableLimitMax = _arg1.telMax;
            this._tableLimitMin = _arg1.telMin;
            dispatchEvent(new GameTableVOEvent(GameTableVOEvent.UP_GAMESTATE));
        }

        public function setGameHistory(_arg1:Object):void
        {
            if (_arg1.gameType != this.gameType)
            {
                return;
            };
            if (_arg1.gameid != this.gameid && this.gameid!="01")
            {
                return;
            }; 
            this._gameHistory = _arg1.gameHistory;
			//trace(_arg1.gameHistory+"=history");
			//trace(_arg1.gameid+"=gameid");
			//trace(_arg1.gameType+"=gameType");
            dispatchEvent(new GameTableVOEvent(GameTableVOEvent.UP_GAME_HISTORY));
        }

        public function setGroupUserSeatList(_arg1:Object):void
        {
            if (_arg1.gameType != this.gameType)
            {
                return;
            };
            if (_arg1.gameid != this.gameid)
            {
                return;
            };
            this.groupUserSeatList = _arg1.userSeatList;
        }

        public function set farmerBool(_arg1:Boolean):void
        {
            this._farmerBool = _arg1;		 
            dispatchEvent(new GameTableVOEvent(GameTableVOEvent.UP_FARMER));
        }

        public function initTime():void
        {
            this.timeFunction();
            this._intervalTime = setInterval(this.timeFunction, 1000);
        }

        private function timeFunction():void
        {
            if (this.gameState != 1)
            {
                return;
            };
            dispatchEvent(new GameTableVOEvent(GameTableVOEvent.UP_TIME));
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
                if (this._injectTime == this._time)
                {
                    this._time = 0;
                };
                _local1 = ((this._injectTime - this._time) - _local2);
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

        public function get gameUrl():String
        {
            return (this._gameUrl);
        }

        public function get gameTableName():String
        {
            return (this._gameTableName);
        }


    }
}//package modules.gamePlatform.model.vo
