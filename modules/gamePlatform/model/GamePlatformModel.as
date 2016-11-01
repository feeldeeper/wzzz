package modules.gamePlatform.model
{
    import flash.events.*;
    import flash.display.*;
    import flash.system.*;
    import flash.utils.*;
    import modules.gamePlatform.model.events.*;
    import modules.gamePlatform.service.events.*;
    import modules.gamePlatform.model.vo.*;
    import modules.*;
    import flash.net.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.service.*;
    import com.snake.utils.*;
    import com.greensock.loading.*;
    import org.randy.crypto.*;
    import flash.external.*;

    public class GamePlatformModel extends ModuleActor 
    {

        private var _tableList:Array;
        private var _waitGameModel:WaitGameModel;
        private var _containerScale:Number;
        public var serverLine:String;
        public var videoLinkUrl:String;
        public var gameLoadService:GameLoadService;
        private var amfNc:NetConnection;
        private var amfLoginResponder:Responder;
        private var refreshMoneyResponder:Responder;
        public var fmsMainServer:FMSMainService;
        private var aesModel:Aes;
        private var userName:String;
        public var containerW:Number = 1100;
        public var containerH:Number = 700;
        private var _mainServer:String;
        private var _gameClassDictionary:Object;
        public var gameRoomVideoUrl:String;
        public var gameRoomVideoName:String;
        public var selectCustomVideoLine:Boolean;
        private var _gameNew:String;
        private var _confingObject:Object;
        private var _currentGameTable:GameTableVO;
        private var _currentGame:IGameModule;
        private var _screenState:String;
        private var _httpUrl:String = "http://www.wzzz88.com/";
        private var _language:String = "cn";
        private var _getGameLeftListShowBool:Boolean = false;

        public function GamePlatformModel()
        {
            this._tableList = new Array();
            this.amfNc = new NetConnection();
            this.amfLoginResponder = new Responder(this.onResult, this.getStatus);
            this.refreshMoneyResponder = new Responder(this.onRefreshMoneyResult, this.getStatus);
            this.aesModel = new Aes("MK2X8a915jkKbzvlJU1ZMR6rcKO+SBhmbPOmFD/2Mxw=");
            this._gameClassDictionary = {};
            super();
            this._waitGameModel = new WaitGameModel();
            //this.amfNc.connect("http://user.goboes.com:888/gateway/");
			trace(this.httpUrl + "Amf/");
			this.amfNc.connect(this.httpUrl + "Amf/");
            this.amfNc.addEventListener(NetStatusEvent.NET_STATUS, this.amfStatusHandler);
        }

        public function get containerScale():Number
        {
            return (this._containerScale);
        }

        public function setContainerScale(_arg1:Number):void
        {
            this._containerScale = _arg1;
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.CONTAINER_RESIZE);
            dispatch(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        private function amfStatusHandler(_arg1:NetStatusEvent):void
        {
            switch (_arg1.info.code)
            {
                case "NetConnection.Connect.Rejected":
                case "NetConnection.Connect.Failed":
                case "NetConnection.Connect.Closed":
                    return;
            };
        }

        public function get waitGameModel():WaitGameModel
        {
            return (this._waitGameModel);
        }

        public function get mainServer():String
        {
            return (this._mainServer);
        }

        public function get tableList():Array
        {
            return (this._tableList);
        }

        public function getGame(_arg1:GameTableVO):IGameModule
        {
            var _local2:Class;
            var _local3:IGameModule;
            if (this._gameClassDictionary[_arg1.gameClassName])
            {
                _local2 = this._gameClassDictionary[_arg1.gameClassName];
                if (this._gameClassDictionary[_local2] == null)
                {
                    _local3 = new (_local2)();
                    this._gameClassDictionary[_local2] = _local3;
                }
                else
                {
                    _local3 = this._gameClassDictionary[_local2];
                };
                return (_local3);
            };
            return (null);
        }

        public function addGameClass(_arg1:GameTableVO):void
        {
            if (this._gameClassDictionary[_arg1.gameClassName] != null)
            {
                return;
            };
            var _local2:Class = (ApplicationDomain.currentDomain.getDefinition(_arg1.gameClassName) as Class);
            this._gameClassDictionary[_arg1.gameClassName] = _local2;
        }

        public function getGameClass(_arg1:GameTableVO):Class
        {
            if (this._gameClassDictionary[_arg1.gameClassName])
            {
                return (this._gameClassDictionary[_arg1.gameClassName]);
            };
            return (null);
        }

        public function get gameNew():String
        {
            return (this._gameNew);
        }

        public function set gameNew(_arg1:String):void
        {
            this._gameNew = _arg1;
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_NEW);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        public function initGameModel():void
        {
            eventDispatcher.addEventListener(FMSMainServiceEvent.LINK_SERVER_CLOSE, this.fmsServerClose);
            eventDispatcher.addEventListener(FMSMainServiceEvent.LINK_CLOSE, this.fmsClose);
            eventDispatcher.addEventListener(FMSMainServiceEvent.LINK_REJECTED, this.fmsRejected);
            eventDispatcher.addEventListener(GamePlatformModelEvent.OLD_GAME_CLOSE_LINK, this.oldGameCloesLink);
        }

        private function oldGameCloesLink(_arg1:GamePlatformModelEvent):void
        {
            var _local2:IGameModule = _arg1.game;
            if (_local2)
            {
                _local2.cloesLink(_arg1.table);
            };
        }

        private function fmsServerClose(_arg1:FMSMainServiceEvent):void
        {
            this.showError({
                "type":"error",
                "error":"与服务器端断开连接",
                "url":"login"
            });
        }

        private function fmsRejected(_arg1:FMSMainServiceEvent):void
        {
            this.showError("服务器拒绝连接");
        }

        private function fmsClose(_arg1:FMSMainServiceEvent):void
        {
            if (this.currentGame)
            {
                this.closeLinkNowGameEvent(this.currentGame, this.currentGameTable);
            };
            this._currentGame = null;
            this._currentGameTable = null;
        }

        public function setConfig(_arg1:Object):void
        {
            var _local3:Object;
            var _local4:GameTableVO;
            this._confingObject = _arg1;
            this.serverLine = _arg1.serverLine;
            if (this.confingObject.httpUrl)
            {
                this._httpUrl = this.confingObject.httpUrl;
            };
            this._mainServer = this.confingObject.mainServer;
            this.gameRoomVideoUrl = this.confingObject.gameRoomVideoUrl;
            this.gameRoomVideoName = this.confingObject.gameRoomVideoName;
            this.gameNew = this.confingObject.gameNew;
            this._tableList = new Array();
            var _local2:int;
            while (_local2 < this.confingObject.gameModelArr.length)
            {
                _local3 = this.confingObject.gameModelArr[_local2];
                if (_local3.gameType == "baijiale")
                {
                    _local4 = new BaijialeGameTableVO();
                };
                if (_local3.gameType == "longhu")
                {
                    _local4 = new LonghuGameTableVO();
                };
                if (_local3.gameType == "daxiao")
                {
                    _local4 = new DaxiaoGameTableVO();
                };
                if (_local3.gameType == "lunpan")
                {
                    _local4 = new LunpanGameTableVO();
                };
                if (_local3.gameType == "paijiu")
                {
                    _local4 = new PaiJiuGameTableVO();
                };
                if (_local3.gameType == "lianhuan")
                {
                    _local4 = new LianHuanGameTableVO();
                };
                if (_local3.gameType == "sangong")
                {
                    _local4 = new SanGongGameTableVO();
                };
                if (_local3.gameType == "comic_bjl")
                {
                    _local4 = new ComicBJLGameTableVO();
                };
                if (_local3.gameType == "nnGame")
                {
                    _local4 = new NNGameTableVO();
                };
                if (_local4)
                {
                    _local4.setConfingData(_local3);
                    _local4.initTime();
                    this._tableList.push(_local4);
                };
                _local4 = null;
                _local2++;
            };
            DebugOutput.add("GameModel setConfing  mainServer:", this.mainServer, "gameRoomVideoUrl:", this.gameRoomVideoUrl, "tableList:", this._tableList.length);
            dispatch(new GamePlatformModelEvent(GamePlatformModelEvent.CONFING_INIT));
            this.initGameModel();
        }

        public function get confingObject():Object
        {
            return (this._confingObject);
        }

        public function waitGotoGame(_arg1:GameTableVO):void
        {
            var _local2:GamePlatformModelEvent;
            _local2 = new GamePlatformModelEvent(GamePlatformModelEvent.WAIT_GOTO_GAME);
            _local2.table = _arg1;
            this.eventDispatcher.dispatchEvent(_local2);
        }

        public function showGroupUserSeatPanel(_arg1:GameTableVO):void
        {
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_GROUP_USER_SEAT_Panel);
            _local2.table = _arg1;
            this.eventDispatcher.dispatchEvent(_local2);
        }

        public function gotoGame(_arg1:GameTableVO):void
        {
            var _local3:GameTableVO;
            var _local4:GamePlatformModelEvent;
            if (this.currentGameTable == _arg1)
            {
                return;
            };
            var _local2:IGameModule = this.getGame(_arg1);
            if (_local2 == null)
            {
                DebugOutput.add("游戏还没有加载过");
                this.gameLoadService.loadGame(_arg1);
                eventDispatcher.addEventListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameloadComplete);
                eventDispatcher.addEventListener(GameLoadServiceEvent.GAME_IO_ERROR, this.gameloadError);
            }
            else
            {
                DebugOutput.add("游戏加载过");
                _local3 = this._currentGameTable;
                this._currentGameTable = _arg1;
                if (_local3 == null)
                {
                    this._currentGame = _local2;
                    _local4 = new GamePlatformModelEvent(GamePlatformModelEvent.GOTO_GAME);
                    _local4.table = this.currentGameTable;
                    _local4.game = this._currentGame;
                    this.eventDispatcher.dispatchEvent(_local4);
                }
                else
                {
                    if (_local3.gameType != this.currentGameTable.gameType)
                    {
                        if (this._currentGame != null)
                        {
                            this.closeLinkNowGameEvent(this.currentGame, _local3);
                        };
                        this._currentGame = _local2;
                        _local4 = new GamePlatformModelEvent(GamePlatformModelEvent.GOTO_GAME);
                        _local4.table = this.currentGameTable;
                        _local4.game = this.currentGame;
                        this.eventDispatcher.dispatchEvent(_local4);
                    }
                    else
                    {
                        this.closeLinkNowGameEvent(this.currentGame, _local3);
                        this.startLiknNowGameEvent();
                    };
                };
            };
        }

        public function isExitGame(_arg1:GameTableVO):Boolean
        {
            var _local2:IGameModule = this.getGame(_arg1);
            if (_local2 == null)
            {
                return (false);
            };
            return (true);
        }

        public function startLiknNowGameEvent():void
        {
            var _local1:GamePlatformModelEvent;
            if (((this.currentGame) && (this.currentGameTable)))
            {
                _local1 = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_START_LINK);
                _local1.table = this.currentGameTable;
                _local1.game = this.currentGame;
                this.eventDispatcher.dispatchEvent(_local1);
                moduleEventDispatcher.dispatchEvent(_local1);
            };
        }

        public function closeLinkNowGameEvent(_arg1:IGameModule, _arg2:GameTableVO):void
        {
            var _local3:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.OLD_GAME_CLOSE_LINK);
            _local3.table = _arg2;
            _local3.game = _arg1;
            this.eventDispatcher.dispatchEvent(_local3);
            moduleEventDispatcher.dispatchEvent(_local3);
        }

        public function loadGame(_arg1:GameTableVO):Boolean
        {
            var _local2:Class = this.getGameClass(_arg1);
            if (_local2 == null)
            {
                this.gameLoadService.loadGame(_arg1);
                eventDispatcher.addEventListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameloadComplete);
                eventDispatcher.addEventListener(GameLoadServiceEvent.GAME_IO_ERROR, this.gameloadError);
                return (false);
            };
            return (true);
        }

        private function gameloadError(_arg1:GameLoadServiceEvent):void
        {
            eventDispatcher.removeEventListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameloadComplete);
            eventDispatcher.removeEventListener(GameLoadServiceEvent.GAME_IO_ERROR, this.gameloadError);
        }

        private function gameloadComplete(_arg1:GameLoadServiceEvent):void
        {
            eventDispatcher.removeEventListener(GameLoadServiceEvent.GAME_LOAD_COMPLETE, this.gameloadComplete);
            eventDispatcher.removeEventListener(GameLoadServiceEvent.GAME_IO_ERROR, this.gameloadError);
        }

        public function setGameLoadComlete(_arg1:GameLoadServiceEvent):void
        {
            var _local2:GameTableVO = _arg1.gameTableVO;
            this.addGameClass(_local2);
            var _local3:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_CLASS_LOADEND);
            _local3.table = _local2;
            eventDispatcher.dispatchEvent(_local3);
            dispatch(_arg1);
            moduleEventDispatcher.dispatchEvent(_arg1);
        }

        public function playSoundRsl(_arg1:String):void
        {
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.PLAY_GENERAL_SOUND);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
        }

        public function gotoPage(_arg1:String):void
        {
            if (_arg1 == "gameRoom")
            {
                if (this.currentGame)
                {
                    this.currentGame.dispose();
                };
            };
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GOTO_PAGE);
            _local2.pageName = _arg1;
            this.eventDispatcher.dispatchEvent(_local2);
        }

        public function gotoPageEnd(_arg1:String):void
        {
            this._currentGame = null;
            this._currentGameTable = null;
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GOTO_PAGE_END);
            _local2.pageName = _arg1;
            this.eventDispatcher.dispatchEvent(_local2);
            this.closeLinkNowGameEvent(this.currentGame, this.currentGameTable);
        }

        public function gotoGameEnd():void
        {
            DebugOutput.add("进入游戏界面结束");
            var _local1:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GOTO_GAME_END);
            this.eventDispatcher.dispatchEvent(_local1);
        }

        public function get currentGameTable():GameTableVO
        {
            return (this._currentGameTable);
        }

        public function get currentGame():IGameModule
        {
            return (this._currentGame);
        }

        public function showError(_arg1):void
        {
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_ERROR);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
        }

        public function get screenState():String
        {
            return (this._screenState);
        }

        public function screenSelect(_arg1:Boolean):void
        {
            var _local2 = "";
            if (_arg1 == false)
            {
                _local2 = StageDisplayState.NORMAL;
            }
            else
            {
                _local2 = StageDisplayState.FULL_SCREEN;
            };
            if (this._screenState == _local2)
            {
                return;
            };
            this._screenState = _local2;
            var _local3:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.UP_SCREENSTATE);
            _local3.data = this._screenState;
            eventDispatcher.dispatchEvent(_local3);
            moduleEventDispatcher.dispatchEvent(_local3);
        }

        public function get httpUrl():String
        {
            return (this._httpUrl);
        }

        public function get language():String
        {
            return (this._language);
        }

        public function set language(_arg1:String):void
        {
            if (_arg1 == this.language)
            {
                return;
            };
            this._language = _arg1;
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.UP_LANGUAGE);
            _local2.data = this.language;
            eventDispatcher.dispatchEvent(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        public function showSystemPanel(_arg1:Boolean):void
        {
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_SYSTEM_PANEL);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        public function showJournalingPanel():void
        {
            var _local1:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_JOURNALINGPANEL);
            eventDispatcher.dispatchEvent(_local1);
            moduleEventDispatcher.dispatchEvent(_local1);
        }

        public function showResultPanel(_arg1:String):void
        {
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_RESULTPANEL);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        public function showHistory(_arg1:String, _arg2:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("showGameLog", _arg1, _arg2);
            };
        }

        public function showEditPasswordPanel():void
        {
            var _local1:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_EDITPASSWORDPANEL);
            eventDispatcher.dispatchEvent(_local1);
            moduleEventDispatcher.dispatchEvent(_local1);
        }

        public function showEditNickNamePanel():void
        {
            var _local1:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_EDITNICKNAMEPANEL);
            eventDispatcher.dispatchEvent(_local1);
            moduleEventDispatcher.dispatchEvent(_local1);
        }

        public function get gameLeftListShowBool():Boolean
        {
            return (this._getGameLeftListShowBool);
        }

        public function showGameLeftList(_arg1:Boolean):void
        {
            this._getGameLeftListShowBool = _arg1;
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.SHOW_GAME_LEFT_LIST);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        public function gameStateList(_arg1:Object):void
        {
            var _local3:Object;
            var _local2:Array = (_arg1 as Array);
            var _local4:int;
            while (_local4 < _local2.length)
            {
                _local3 = _local2[_local4];
                if (_local3.gameTableName != null)
                {
                    this.gameState(_local3);
                };
                _local4++;
            };
            var _local5:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_STATE_LIST);
            eventDispatcher.dispatchEvent(_local5);
        }

        public function gameHistoryList(_arg1:Object):void
        {
            var _local3:Object;
            var _local2:Array = (_arg1 as Array);
            var _local4:int;
            while (_local4 < _local2.length)
            {
                _local3 = _local2[_local4];
 
                if (_local3.gameTableName != null)
                {
                    this.gameHistory(_local3);
                };
                _local4++;
            };
            var _local5:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_HISTORY_LIST);
            eventDispatcher.dispatchEvent(_local5);
        }

        public function loginAmf(_arg1:Object):void
        {
            this.userName = _arg1.userName;
            var _local2:Object = {
                "userName":this.userName,
                "passWord":_arg1.passWord
            };
			//trace("username="+_arg1.userName+";password="+_arg1.passWord);
           this.amfNc.call("Sim_Main.login", this.amfLoginResponder, _local2);
        }

        public function refreshMoneyAmf():void
        {
            //var _local1:Object = {"iv":this.aesModel.encrypt(this.userName)};
			var _local1:Object = {"iv":this.userName};
            this.amfNc.call("Sim_Main.getLiveMoney", this.refreshMoneyResponder, _local1);
        }

        private function onResult(_arg1:Object):void
        {
            if (_arg1.type == true)
            {
                setTimeout(this.refreshMoneyAmf, 5000);
            };
        }

        private function onRefreshMoneyResult(_arg1:Object):void
        {
            var _local2:GamePlatformModelEvent;
            if (_arg1.type == true)
            {
                _local2 = new GamePlatformModelEvent(GamePlatformModelEvent.REFRESH_MONEY_RESULT);
                //_local2.data = this.aesModel.decrypt(_arg1.money);
                _local2.data = _arg1.money;			
				this.eventDispatcher.dispatchEvent(_local2);
                moduleEventDispatcher.dispatchEvent(_local2);
            };
        }

        private function getStatus(_arg1):void
        {
            DebugOutput.add("<CALL回执>:---------------------错误信息 ------------------\n\n");
            DebugOutput.add(ObjectUtil.ObjtoString(_arg1));
            DebugOutput.add("\n\n---------------------错误信息 end------------------");
        }

        public function gameUserSeatList(_arg1:Object):void
        {
            var _local3:Object;
            var _local2:Array = (_arg1 as Array);
            var _local4:int;
            while (_local4 < _local2.length)
            {
                _local3 = _local2[_local4];
                if (_local3.gameTableName != null)
                {
                    this.gameUserSeat(_local3);
                };
                _local4++;
            };
        }

        public function gameState(_arg1:Object):void
        {
            var _local2:GameTableVO;
            var _local4:GamePlatformModelEvent;
            var _local3:int;
            while (_local3 < this.tableList.length)
            {
                _local2 = (this.tableList[_local3] as GameTableVO);
                if (_arg1.gameTableName == _local2.gameTableName)
                {
                    _local2.setGameState(_arg1);
                    _local4 = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_STATE);
                    _local4.table = _local2;
                    eventDispatcher.dispatchEvent(_local4);
                    moduleEventDispatcher.dispatchEvent(_local4);
                    return;
                };
                _local3++;
            };
        }

        public function gameNotice(_arg1:Object):void
        {
            var _local2:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.UP_GAME_NOTICE);
            _local2.data = _arg1;
            eventDispatcher.dispatchEvent(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
        }

        public function gameHistory(_arg1:Object):void
        {
            var _local2:GameTableVO;
            var _local4:GamePlatformModelEvent;
            var _local3:int;
            while (_local3 < this.tableList.length)
            {
                _local2 = (this.tableList[_local3] as GameTableVO);
                if (_arg1.gameTableName == _local2.gameTableName)
                {
                    _local2.setGameHistory(_arg1);
                    _local4 = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_HISTORY);
                    _local4.table = _local2;
                    eventDispatcher.dispatchEvent(_local4);
                    moduleEventDispatcher.dispatchEvent(_local4);
                    return;
                };
                _local3++;
            };
        }

        public function gameUserSeat(_arg1:Object):void
        {
            var _local2:GameTableVO;
            var _local4:GamePlatformModelEvent;
            var _local3:int;
            while (_local3 < this.tableList.length)
            {
                _local2 = (this.tableList[_local3] as GameTableVO);
                if (_arg1.gameTableName == _local2.gameTableName)
                {
                    _local2.setGroupUserSeatList(_arg1);
                    _local4 = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_USER_SEAT_LIST);
                    _local4.table = _local2;
                    eventDispatcher.dispatchEvent(_local4);
                    moduleEventDispatcher.dispatchEvent(_local4);
                    return;
                };
                _local3++;
            };
        }

        public function otherUserLogin():void
        {
            var _local1:GamePlatformModelEvent = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_OTHER_USER_LOGIN);
            moduleEventDispatcher.dispatchEvent(_local1);
            setTimeout(this.logout, 5000);
        }

        private function logout():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("logout");
            };
        }

        public function gameFarmer(_arg1:Object):void
        {
            var _local2:GameTableVO;
            var _local4:GamePlatformModelEvent;
            var _local3:int;
            while (_local3 < this.tableList.length)
            {
                _local2 = (this.tableList[_local3] as GameTableVO);
                if (_arg1.gameTableName == _local2.gameTableName)
                {
                    _local2.setGameState(_arg1);
                    _local4 = new GamePlatformModelEvent(GamePlatformModelEvent.GAME_FARMER);
                    _local4.table = _local2;
                    eventDispatcher.dispatchEvent(_local4);
                    moduleEventDispatcher.dispatchEvent(_local4);
                    return;
                };
                _local3++;
            };
        }


    }
}//package modules.gamePlatform.model
