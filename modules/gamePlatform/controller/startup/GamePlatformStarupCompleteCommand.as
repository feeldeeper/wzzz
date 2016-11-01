package modules.gamePlatform.controller.startup
{
    import flash.events.*;
    import modules.gamePlatform.view.*;
    import com.snake.net.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;
    import modules.gamePlatform.service.*;
    import com.greensock.loading.*;

    public class GamePlatformStarupCompleteCommand extends Command 
    {

        [Inject]
        public var gamePlatformModel:GamePlatformModel;
        [Inject]
        public var gameLoadService:GameLoadService;
        [Inject]
        public var fmsMainServer:FMSMainService;
        private var fmsTest:FMSTest;

        public function GamePlatformStarupCompleteCommand()
        {
            this.fmsTest = new FMSTest();
            super();
        }

        override public function execute():void
        {
            var _local4:XML;
            var _local5:FrameHashModel;
            var _local6:String;
            var _local7:Object;
            var _local8:String;
            var _local9:String;
            var _local10:uint;
            var _local1:MainContainersView = new MainContainersView();
			
            contextView.addChild(_local1);
			 
            this.gameLoadService.gamePlatformModel = this.gamePlatformModel;
            this.gamePlatformModel.gameLoadService = this.gameLoadService;
            this.gamePlatformModel.fmsMainServer = this.fmsMainServer;
            var _local2:String = (LoaderMax.getContent("config") as String);
			 
            try
            {
                _local4 = (LoaderMax.getContent("liveServerReserve") as XML);
                _local5 = new FrameHashModel("bfdbdb8f");
                _local6 = _local5.decrypt(_local2);
				//trace(_local6)
                _local7 = Tools.json_decode(_local2);
                if (_local4)
                {
                    if ((((_local4.enabled == 1)) && ((_local4.match == 0))))
                    {
                        _local10 = 0;
                        while (_local10 < _local7.gameModelArr.length)
                        {
                            _local9 = Tools.getLiveAppName(_local7.gameModelArr[_local10].videoUrll);
                            _local8 = (("rtmp://" + _local4.linkIp) + _local9);
                            _local7.gameModelArr[_local10].videoUrll = _local8;
                            _local10++;
                        };
                        _local7.gameRoomVideoUrl = _local8;
                    };
                    _local7.serverLine = _local4.serverLine;
                };
            }
            catch(e:Error)
            {
            };
            var _local3:Array = [_local7.gameRoomVideoUrl, "183.60.201.211/xin/", "183.60.201.211/xin/", "183.60.201.211/xin/", "183.60.201.211/xin/"];
            //this.fmsTest.setFmsList(_local3);
            gamePlatformModel.setConfig(_local7);
        }

        private function testFinish(_arg1:Event):void
        {
            DebugOutput.add(("测试完毕：" + this.fmsTest.getBest()));
        }


    }
}//package modules.gamePlatform.controller.startup
