package modules.baijiale.service
{
    import flash.events.*;
    import modules.baijiale.service.events.*;
    import flash.media.*;
    import flash.net.*;
    import com.snake.media.*;
    import org.robotlegs.mvcs.*;

    public class VideoBaijialeService extends Actor 
    {

        private var _videoModel2:VideoModel;
        private var _videoNc2:NetConnection;
        private var _videoModel:VideoModel;
        private var _videoNc:NetConnection;

        public function VideoBaijialeService()
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
            this._videoNc2 = new NetConnection();
            this._videoNc2.client = this;
            this._videoModel2 = new VideoModel({
                "nc":this.videoNc2,
                "video":new Video(),
                "linkPlay":true
            });
            this._videoModel2.isShowBufferInfo = false;
        }

        public function get videoNc2():NetConnection
        {
            return (this._videoNc2);
        }

        public function set videoNc2(_arg1:NetConnection):void
        {
            this._videoNc2 = _arg1;
        }

        public function get videoModel2():VideoModel
        {
            return (this._videoModel2);
        }

        public function set videoModel2(_arg1:VideoModel):void
        {
            this._videoModel2 = _arg1;
        }

        public function get video2():Video
        {
            return (this._videoModel2.video);
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
            this.videoNc2.close();
            this.videoModel.close();
            this.videoModel2.close();
        }

        public function linkVideo(_arg1:String, _arg2:String, _arg3:uint, _arg4:uint):void
        {
            this.videoModel.videoURL = _arg2;
            if (_arg3 < 80)
            {
                if (_arg4 == 2)
                {
                    this.videoModel2.videoURL = (_arg2 + "-1");
                    this.videoModel2.ncConnect(_arg1);
                };
            };
            this.videoModel.ncConnect(_arg1);
        }

        public function linkOtherVideo(_arg1:String, _arg2:String, _arg3:uint):void
        {
            this.videoModel2.videoURL = (_arg2 + "-1");
            this.videoModel2.ncConnect(_arg1);
        }

        protected function netStatusHandler(_arg1:NetStatusEvent):void
        {
            var _local2:VideoBaijialeServiceEvent;
            switch (_arg1.info.code)
            {
                case "NetConnection.Connect.Success":
                    _local2 = new VideoBaijialeServiceEvent(VideoBaijialeServiceEvent.LINK_SUCCESS);
                    dispatch(_local2);
                    _local2 = new VideoBaijialeServiceEvent(VideoBaijialeServiceEvent.VIDEO_START);
                    break;
                case "NetConnection.Connect.Closed":
                    _local2 = new VideoBaijialeServiceEvent(VideoBaijialeServiceEvent.LINK_CLOSE);
                    dispatch(_local2);
                    break;
                case "NetStream.Play.StreamNotFound":
                    _local2 = new VideoBaijialeServiceEvent(VideoBaijialeServiceEvent.VIDEO_ERROR);
                    dispatch(_local2);
                    break;
                case "NetStream.Play.Start":
                    _local2 = new VideoBaijialeServiceEvent(VideoBaijialeServiceEvent.VIDEO_PLAY);
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
                    _local2 = new VideoBaijialeServiceEvent(VideoBaijialeServiceEvent.VIDEO_BUFFER_FULL);
                    dispatch(_local2);
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
}//package modules.baijiale.service
