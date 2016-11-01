package modules.baijiale.view
{
    import flash.events.*;
    import modules.baijiale.model.events.*;
    import modules.baijiale.service.events.*;
    import modules.baijiale.model.*;
    import modules.baijiale.service.*;
    import org.robotlegs.mvcs.*;
    import modules.gamePlatform.model.*;

    public class VideoPanelViewMediator extends Mediator 
    {

        [Inject]
        public var baijialeModel:BaijialeModel;
        [Inject]
        public var videoServer:VideoBaijialeService;
        [Inject]
        public var gamePlatformModel:GamePlatformModel;
        private var isShowAllRoutePanel:Boolean;


        private function get view():VideoPanelView
        {
            return ((viewComponent as VideoPanelView));
        }

        override public function onRemove():void
        {
            super.onRemove();
            removeContextListener(VideoBaijialeServiceEvent.LINK_SUCCESS, this.linkSuccess);
            removeContextListener(VideoBaijialeServiceEvent.VIDEO_ERROR, this.videoError);
            removeContextListener(VideoBaijialeServiceEvent.VIDEO_BUFFER_FULL, this.videoBufferFull);
            removeContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            removeContextListener(BaijialeModelEvent.CLOSE_LINK, this.linkClose);
            removeContextListener(BaijialeModelEvent.SHOW_ALL_ROUTE_PANEL, this.showAllRoutePanel);
            removeContextListener(BaijialeModelEvent.UP_SERVER_LINE_SELECT, this.upServerLineSelect);
            this.videoServer.close();
            this.videoServer.video.clear();
            this.videoServer.video2.clear();
            this.view.dispose();
        }

        override public function onRegister():void
        {
            addContextListener(VideoBaijialeServiceEvent.LINK_SUCCESS, this.linkSuccess);
            addContextListener(VideoBaijialeServiceEvent.VIDEO_ERROR, this.videoError);
            addContextListener(VideoBaijialeServiceEvent.VIDEO_BUFFER_FULL, this.videoBufferFull);
            addContextListener(GameDataModelEvent.INIT_GAME_INFO, this.initGameInfo);
            addContextListener(BaijialeModelEvent.CLOSE_LINK, this.linkClose);
            addContextListener(BaijialeModelEvent.SHOW_ALL_ROUTE_PANEL, this.showAllRoutePanel);
            addContextListener(BaijialeModelEvent.UP_SERVER_LINE_SELECT, this.upServerLineSelect);
            this.view.videoServer = this.videoServer;
            this.view.addToStage();
            this.videoServer.video.smoothing = true;
            this.videoServer.videoModel.bufferTime = 0.5;
            this.videoServer.videoModel.isShowBufferInfo = false;
            this.videoServer.video2.smoothing = true;
            this.videoServer.videoModel2.bufferTime = 0.5;
            this.videoServer.videoModel2.isShowBufferInfo = false;
        }

        private function upServerLineSelect(_arg1:BaijialeModelEvent):void
        {
            this.videoServer.videoModel.close();
            this.videoServer.videoNc.close();
            this.videoServer.video.clear();
            this.videoServer.videoModel2.close();
            this.videoServer.videoNc2.close();
            this.videoServer.video2.clear();
            this.gamePlatformModel.selectCustomVideoLine = true;
            var _local2:String = Tools.getLiveAppName(this.baijialeModel.currentGameTable.videoUrll);
            switch (_arg1.data)
            {
                case 0:
                    this.gamePlatformModel.gameRoomVideoUrl = "rtmp://183.60.201.211";
                    this.gamePlatformModel.serverLine = "tel";
                    break;
                case 1:
                    this.gamePlatformModel.gameRoomVideoUrl = "rtmp://183.60.201.211";
                    this.gamePlatformModel.serverLine = "tel2";
                    break;
                case 2:
                    this.gamePlatformModel.gameRoomVideoUrl = "rtmp://183.60.201.211";
                    this.gamePlatformModel.serverLine = "cnc";
                    break;
                case 3:
                    this.gamePlatformModel.gameRoomVideoUrl = "rtmp://183.60.201.211";
                    this.gamePlatformModel.serverLine = "cnc2";
                    break;
                case 4:
                    this.gamePlatformModel.gameRoomVideoUrl = "rtmp://183.60.201.211";
                    this.gamePlatformModel.serverLine = "bgp";
                    break;
                case 5:
                    this.gamePlatformModel.gameRoomVideoUrl = "rtmp://183.60.201.211";
                    this.gamePlatformModel.serverLine = "bgp";
                    break;
            };
            if (this.isShowAllRoutePanel == false)
            {
                this.videoServer.linkVideo((this.gamePlatformModel.gameRoomVideoUrl + _local2), this.baijialeModel.currentGameTable.videoName, uint(this.baijialeModel.currentGameTable.gameid), 2);
            }
            else
            {
                this.videoServer.linkVideo((this.gamePlatformModel.gameRoomVideoUrl + _local2), this.baijialeModel.currentGameTable.videoName, uint(this.baijialeModel.currentGameTable.gameid), 1);
            };
        }

        private function showAllRoutePanel(_arg1:BaijialeModelEvent):void
        {
            if (this.isShowAllRoutePanel == false)
            {
                this.isShowAllRoutePanel = true;
                this.videoServer.videoModel2.close();
                this.videoServer.videoNc2.close();
                this.videoServer.video2.clear();
            }
            else
            {
                this.isShowAllRoutePanel = false;
                this.videoServer.linkOtherVideo((this.gamePlatformModel.gameRoomVideoUrl + Tools.getLiveAppName(this.baijialeModel.currentGameTable.videoUrll)), this.baijialeModel.currentGameTable.videoName, uint(this.baijialeModel.currentGameTable.gameid));
            };
        }

        private function playVideo(_arg1:Event=null):void
        {
            var _local2:String;
            if (this.gamePlatformModel.selectCustomVideoLine == true)
            {
                _local2 = (this.gamePlatformModel.gameRoomVideoUrl + Tools.getLiveAppName(this.baijialeModel.currentGameTable.videoUrll));
            }
            else
            {
                _local2 = this.baijialeModel.currentGameTable.videoUrll;
            };
            var _local3:String = this.baijialeModel.currentGameTable.videoName;
            if (this.isShowAllRoutePanel == false)
            {
                DebugOutput.add("游戏初始化完成 进行视频的连接....", (_local2 + _local3));
                this.videoServer.linkVideo(_local2, _local3, uint(this.baijialeModel.currentGameTable.gameid), 2);
            }
            else
            {
                this.videoServer.linkVideo(_local2, _local3, uint(this.baijialeModel.currentGameTable.gameid), 1);
            };
            this.view.gameID = uint(this.baijialeModel.currentGameTable.gameid);
            this.view.oldVideoName = "";
        }

        private function videoPlay(_arg1:VideoBaijialeServiceEvent):void
        {
            this.view.videoPlay();
        }

        private function videoError(_arg1:VideoBaijialeServiceEvent):void
        {
            this.view.videoError();
        }

        private function linkClose(_arg1:BaijialeModelEvent):void
        {
            this.videoServer.close();
            this.videoServer.video.clear();
            this.videoServer.video2.clear();
            this.view.linkClose();
        }

        private function linkSuccess(_arg1:VideoBaijialeServiceEvent):void
        {
        }

        private function initGameInfo(_arg1:GameDataModelEvent):void
        {
            this.view.linkSuccess();
            if (this.videoServer.videoModel.stageAvailable == false)
            {
                this.view.setVideo(this.videoServer.video);
            };
            this.view.setVideoOther(this.videoServer.video2);
            this.playVideo();
            if (uint(this.baijialeModel.currentGameTable.gameid) > 80)
            {
                this.view.videoModel = true;
            }
            else
            {
                this.view.videoModel = false;
            };
            this.view.selectModel();
        }

        private function videoBufferFull(_arg1:VideoBaijialeServiceEvent):void
        {
            this.view.videoPlay();
        }


    }
}//package modules.baijiale.view
