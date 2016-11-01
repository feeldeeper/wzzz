package modules.gamePlatform.service
{
    import flash.events.*;
    import flash.display.*;
    import flash.system.*;
    import modules.gamePlatform.service.events.*;
    import modules.gamePlatform.model.vo.*;
    import modules.*;
    import flash.net.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.gamePlatform.model.*;
    import com.greensock.loading.*;

    public class GameLoadService extends ModuleActor 
    {

        public var gamePlatformModel:GamePlatformModel;
        private var loadedGame:Object;
        private var currentLoader:Loader;

        public function GameLoadService()
        {
            this.loadedGame = {};
            super();
        }

        public function get waitLoadGame():GameTableVO
        {
            return (this.loadedGame[this.currentLoader]);
        }

        public function loadGame(_arg1:GameTableVO):void
        {
            var _local2:GameLoadServiceEvent;
            var _local3:GameTableVO;
            var _local4:String;
            if (this.currentLoader)
            {
                this.currentLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadComplete);
                this.currentLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadError);
                this.currentLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadProgress);
                this.currentLoader.unload();
                _local2 = new GameLoadServiceEvent(GameLoadServiceEvent.UNLOAD_WAITLOAD);
                _local3 = (this.loadedGame[this.currentLoader] as GameTableVO);
                this.loadedGame[this.currentLoader] = null;
                this.currentLoader = null;
                _local2.gameTableVO = _local3;
                dispatch(_local2);
                moduleEventDispatcher.dispatchEvent(_local2);
            };
            if (this.loadedGame[_arg1.url] == null)
            {
                this.currentLoader = new Loader();
                this.loadedGame[this.currentLoader] = _arg1;
                this.currentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadComplete);
                this.currentLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadError);
                this.currentLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loadProgress);
                //_local4 = ((this.gamePlatformModel.httpUrl + "") + _arg1.url);
				_local4 = (_arg1.url);
                if (this.gamePlatformModel.httpUrl == "")
                {
                    this.currentLoader.load(new URLRequest(_local4), new LoaderContext(false, ApplicationDomain.currentDomain));
                }
                else
                {
					this.currentLoader.load(new URLRequest(_local4), new LoaderContext(false, ApplicationDomain.currentDomain));
                    //this.currentLoader.load(new URLRequest(_local4), this.getloaderContext());
                };
                DebugOutput.add(("load open:" + _local4), "是否相对路径：", (this.gamePlatformModel.httpUrl == ""));
                _local2 = new GameLoadServiceEvent(GameLoadServiceEvent.GAME_LOAD_START);
                _local2.gameTableVO = _arg1;
                dispatch(_local2);
                moduleEventDispatcher.dispatchEvent(_local2);
            }
            else
            {
                _local2 = new GameLoadServiceEvent(GameLoadServiceEvent.GAME_LOAD_COMPLETE);
                _local2.gameTableVO = _arg1;
                this.gamePlatformModel.setGameLoadComlete(_local2);
            };
        }

        public function getloaderContext():LoaderContext
        {
            var _local1:LoaderContext = new LoaderContext();
            _local1.applicationDomain = ApplicationDomain.currentDomain;
            try
            {
                _local1["allowLoadBytesCodeExecution"] = true;
            }
            catch(error:ReferenceError)
            {
            };
            if (Security.sandboxType == Security.REMOTE)
            {
                _local1.securityDomain = SecurityDomain.currentDomain;
            };
            return (_local1);
        }

        protected function loadProgress(_arg1:ProgressEvent):void
        {
            var _local3:GameLoadServiceEvent;
            var _local2:Number = (_arg1.bytesLoaded / _arg1.bytesTotal);
            _local3 = new GameLoadServiceEvent(GameLoadServiceEvent.GAME_PROGRESS);
            var _local4:GameTableVO = (this.loadedGame[this.currentLoader] as GameTableVO);
            _local3.gameTableVO = _local4;
            _local3.gameProgress = _local2;
            dispatch(_local3);
            moduleEventDispatcher.dispatchEvent(_local3);
        }

        protected function loadError(_arg1:IOErrorEvent):void
        {
            var _local2:GameLoadServiceEvent;
            this.currentLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadComplete);
            this.currentLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadError);
            this.currentLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadProgress);
            _local2 = new GameLoadServiceEvent(GameLoadServiceEvent.GAME_IO_ERROR);
            var _local3:GameTableVO = (this.loadedGame[this.currentLoader] as GameTableVO);
            this.loadedGame[this.currentLoader] = null;
            _local2.gameTableVO = _local3;
            dispatch(_local2);
            moduleEventDispatcher.dispatchEvent(_local2);
            DebugOutput.add(("load IOErrorEvent:" + _local3.url));
        }

        protected function loadComplete(_arg1:Event):void
        {
            var _local3:GameLoadServiceEvent;
            if (!this.currentLoader)
            {
                return;
            };
            this.currentLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadComplete);
            this.currentLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadError);
            this.currentLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadProgress);
            var _local2:GameTableVO = (this.loadedGame[this.currentLoader] as GameTableVO);
            this.loadedGame[this.currentLoader] = null;
            this.loadedGame[_local2.url] = this.currentLoader;
            DebugOutput.add(("load loadComplete:" + _local2.url), this.currentLoader.content);
            _local3 = new GameLoadServiceEvent(GameLoadServiceEvent.GAME_LOAD_COMPLETE);
            _local3.gameTableVO = _local2;
            _local3.game = (this.currentLoader.content as IGameModule);
            this.currentLoader = null;
            this.gamePlatformModel.setGameLoadComlete(_local3);
        }


    }
}//package modules.gamePlatform.service
