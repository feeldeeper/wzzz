package modules.gamePlatform.service
{
    import flash.events.*;
    import modules.gamePlatform.service.events.*;
    import flash.media.*;
    import com.snake.media.*;
    import flash.net.*;
    import org.robotlegs.mvcs.*;

    public class VideoHallService extends Actor 
    {

        private var _videoModel:VideoModel;
        private var _videoNc:NetConnection;

        public function VideoHallService()
        {
            this._videoNc = new NetConnection();
            this._videoNc.client = this;
            this._videoModel = new VideoModel({
                "nc":this.videoNc,
                "video":new Video(),
                "linkPlay":true
            });
            this._videoModel.isShowBufferInfo = false;
            this._videoModel.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
        }

        public function onBWDone():void
        {
        }

        public function get video():Video
        {
            return (this._videoModel.video);
        }

        public function get videoModel():VideoModel
        {
            return (this._videoModel);
        }

        public function get videoNc():NetConnection
        {
            return (this._videoNc);
        }

        public function close():void
        {
            this.videoNc.close();
        }

        public function linkVideo(_arg1:String, _arg2:String):void
        {
            this.videoModel.videoURL = _arg2;
            this.videoModel.ncConnect(_arg1);
            var _local3:VideoHallServiceEvent = new VideoHallServiceEvent(VideoHallServiceEvent.LINK_START);
            dispatch(_local3);
        }

        protected function netStatusHandler(_arg1:NetStatusEvent):void
        {
            var _local2:VideoHallServiceEvent;
			trace(_arg1.info.code);
            switch (_arg1.info.code)
            {
                case "NetConnection.Connect.Success":
                    _local2 = new VideoHallServiceEvent(VideoHallServiceEvent.LINK_SUCCESS);
                    dispatch(_local2);
                    _local2 = new VideoHallServiceEvent(VideoHallServiceEvent.VIDEO_START);
                    break;
                case "NetConnection.Connect.Closed":
                    _local2 = new VideoHallServiceEvent(VideoHallServiceEvent.LINK_CLOSE);
                    dispatch(_local2);
                    break;
                case "NetStream.Play.StreamNotFound":
                    _local2 = new VideoHallServiceEvent(VideoHallServiceEvent.VIDEO_ERROR);
                    dispatch(_local2);
                    break;
                case "NetStream.Play.Start":
                    _local2 = new VideoHallServiceEvent(VideoHallServiceEvent.VIDEO_PLAY);
                    dispatch(_local2);
                    break;
                case "NetStream.Play.Stop":
                    break;
                case "NetStream.Seek.InvalidTime":
                    break;
                case "NetStream.Pause.Notify":
                    break;
                case "NetStream.Seek.Notify":
                    break;
                case "NetStream.Buffer.Empty":
                    break;
                case "NetStream.Play.InsufficientBW":
                    break;
                case "NetStream.Buffer.Full":
                    break;
                case "NetStream.Play.UnpublishNotify":
                    break;
                case "NetStream.Play.PublishNotify":
                    break;
            };
            var _local3:String = String(_arg1.info.code).split(".")[0];
            if (_local3 == "NetStream")
            {
            };
        }


    }
}//package modules.gamePlatform.service
