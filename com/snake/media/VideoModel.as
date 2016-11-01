package com.snake.media
{
    import flash.events.*;
    import flash.utils.*;
    import flash.media.*;
    import flash.net.*;

    public class VideoModel extends EventDispatcher 
    {

        private var _videoURL:String = "Video.flv";
        private var _connection:NetConnection;
        private var _stream:NetStream;
        private var _video:Video;
        private var _stageVideo:StageVideo;
        private var _stageAvailable:Boolean = false;
        private var _linkPlay:Boolean = false;
        public var videoModel:Boolean = true;
        private var _custom:CustomClient;
        private var _playState:String = "playState_stop";
        private var _bufferTime:Number = 1;
        private var _duration:Number;
        private var seekNum:int;
        private var seekInterval:int;
        private var intervalMonitorBufferLengthEverySecond:uint;
        public var isShowBufferInfo:Boolean = false;
        public var isPlay:Boolean;
        private var soundVolume:Number = 0;
        private var _soundBool:Boolean = true;
        private var oldSeek:Number;
        private var playStateStopBool:Boolean = false;

        public function VideoModel(_arg1:Object=null)
        {
            if (_arg1)
            {
                if (_arg1.nc)
                {
                    this.connection = _arg1.nc;
                };
                if (_arg1.video)
                {
                    this.video = _arg1.video;
                };
                if (_arg1.linkPlay)
                {
                    this.linkPlay = _arg1.linkPlay;
                };
            };
        }

        public function get stageAvailable():Boolean
        {
            return (this._stageAvailable);
        }

        public function set stageAvailable(_arg1:Boolean):void
        {
            this._stageAvailable = _arg1;
        }

        public function get stageVideo():StageVideo
        {
            return (this._stageVideo);
        }

        public function set stageVideo(_arg1:StageVideo):void
        {
            this._stageVideo = _arg1;
        }

        public function set linkPlay(_arg1:Boolean):void
        {
            if (this._linkPlay == _arg1)
            {
                return;
            };
            this._linkPlay = _arg1;
        }

        public function get linkPlay():Boolean
        {
            return (this._linkPlay);
        }

        public function ncConnect(_arg1:String):void
        {
            if (this.connection)
            {
                this.connection.connect(_arg1);
            };
        }

        public function set connection(_arg1:NetConnection):void
        {
            if (_arg1 == null)
            {
                _arg1 = new NetConnection();
                _arg1.connect(null);
            };
            if (this._connection == _arg1)
            {
                return;
            };
            if (this._connection)
            {
                this._connection.removeEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this._connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            };
            this._connection = _arg1;
            this._connection.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
            this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            this.setStream(this._connection);
        }

        public function get connection():NetConnection
        {
            return (this._connection);
        }

        public function set video(_arg1:Video):void
        {
            if (this._video == _arg1)
            {
                return;
            };
            this._video = _arg1;
            if (this.stream)
            {
                this.video.attachNetStream(this.stream);
            };
        }

        public function get video():Video
        {
            return (this._video);
        }

        private function setStream(value:NetConnection):void
        {
            if (!value.connected)
            {
                return;
            };
            if (this._stream)
            {
                this._stream.removeEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
                this._stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
            };
            this._stream = new NetStream(this.connection);
            this._custom = new CustomClient(this);
            this.stream.client = this._custom;
            this.stream.bufferTime = this.bufferTime;
            this.stream.maxPauseBufferTime = 0;
            this.stream.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
            this.stream.addEventListener(IOErrorEvent.IO_ERROR, function ():void
            {
            });
            this.stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
            if (this.stageAvailable == true)
            {
                try
                {
                    if (this.stageVideo)
                    {
                        this.stageVideo.attachNetStream(this.stream);
                    }
                    else
                    {
                        this.video.attachNetStream(this.stream);
                        this.stageAvailable = false;
                    };
                }
                catch(e:Error)
                {
                    video.attachNetStream(stream);
                    stageAvailable = false;
                };
            }
            else
            {
                if (this.video)
                {
                    this.video.attachNetStream(this.stream);
                };
            };
        }

        public function monPlayback():void
        {
            if (this.isShowBufferInfo == true)
            {
                DebugOutput.add(("Buffer length: " + this.stream.bufferLength));
            };
            if (this.stream.bufferLength >= (this.bufferTime + 2.5))
            {
                if (((((((((((!((this.playState == "playState_buffer_empty"))) || (!((this.playState == "playState_seek_notify"))))) || (!((this.playState == "playState_insufficientBW"))))) || (!((this.playState == "playState_buffer_full"))))) || (!((this.playState == "playState_insufficientBW"))))) || (!((this.playState == "playState_seek_invalidTime")))))
                {
                    if (this.isShowBufferInfo == true)
                    {
                        DebugOutput.add(((this.stream.bufferLength + "超过延时秒数:") + this.bufferTime));
                    };
                    this.stream.pause();
                    setTimeout(this.stream.resume, 1000);
                };
            };
        }

        private function seekIntervalFun(_arg1:Number):void
        {
            if (this.seekNum >= _arg1)
            {
                clearInterval(this.seekInterval);
                this.seekNum = 0;
            }
            else
            {
                if (this.stream.bufferLength >= this.bufferTime)
                {
                    try
                    {
                        this.stream.pause();
                        setTimeout(this.stream.resume, 1000);
                    }
                    catch(e:Error)
                    {
                    };
                };
                this.seekNum++;
            };
        }

        public function get stream():NetStream
        {
            return (this._stream);
        }

        public function set videoURL(_arg1:String):void
        {
            if (this._videoURL == _arg1)
            {
                return;
            };
            this._videoURL = _arg1;
            if (this.linkPlay)
            {
                this.connectStreamPlay();
            };
        }

        public function get videoURL():String
        {
            return (this._videoURL);
        }

        public function get custom():CustomClient
        {
            return (this._custom);
        }

        public function get bufferTime():Number
        {
            return (this._bufferTime);
        }

        public function set bufferTime(_arg1:Number):void
        {
            this._bufferTime = _arg1;
            if (this.stream)
            {
                this.stream.maxPauseBufferTime = (this._bufferTime * 2);
            };
        }

        public function get bufferLength():Number
        {
            if (this.stream)
            {
                return (this.stream.bufferLength);
            };
            return (0);
        }

        public function get soundTransform():SoundTransform
        {
            if (this.stream)
            {
                return (this.stream.soundTransform);
            };
            return (null);
        }

        public function get soundValue():Number
        {
            if (this.stream)
            {
                return (this.stream.soundTransform.volume);
            };
            return (0);
        }

        public function set soundValue(_arg1:Number):void
        {
            var _local2:SoundTransform;
            if (this.stream)
            {
                _local2 = this.stream.soundTransform;
                _local2.volume = _arg1;
                this.stream.soundTransform = _local2;
            };
        }

        public function set soundBool(_arg1:Boolean):void
        {
            var _local2:SoundTransform;
            if (this.stream)
            {
                this._soundBool = _arg1;
                _local2 = this.stream.soundTransform;
                if (_arg1)
                {
                    if (this.soundVolume != 0)
                    {
                        _local2.volume = this.soundVolume;
                    }
                    else
                    {
                        _local2.volume = 1;
                    };
                    this.stream.soundTransform = _local2;
                }
                else
                {
                    this.soundVolume = _local2.volume;
                    _local2.volume = 0;
                    this.stream.soundTransform = _local2;
                };
            };
        }

        public function get soundBool():Boolean
        {
            return (this._soundBool);
        }

        public function get progress():Number
        {
            if (this.stream)
            {
                return ((this.stream.bytesLoaded / this.stream.bytesTotal));
            };
            return (0);
        }

        public function get currentFPS():Number
        {
            if (this.stream)
            {
                return (this.stream.currentFPS);
            };
            return (0);
        }

        public function get playState():String
        {
            return (this._playState);
        }

        public function connectStreamPlay():void
        {
            if (((((!(this.connection)) || (!(this.video)))) || (!(this.stream))))
            {
                return;
            };
            if (!this.connection.connected)
            {
                return;
            };
            DebugOutput.add(("播放:" + this.videoURL));
            this.stream.play(this.videoURL);
            this.killMonitorBuffer();
            this.intervalMonitorBufferLengthEverySecond = setInterval(this.monPlayback, 5000);
            this.isPlay = true;
        }

        private function killMonitorBuffer():void
        {
            if (this.intervalMonitorBufferLengthEverySecond > 0)
            {
                clearInterval(this.intervalMonitorBufferLengthEverySecond);
            };
        }

        public function play():void
        {
            this.connectStreamPlay();
        }

        public function resume():void
        {
            if (this.stream)
            {
                this.stream.resume();
                this.isPlay = true;
                this._playState = "playState_play";
                dispatchEvent(new Event(this._playState));
            };
        }

        public function pause():void
        {
            if (this.stream)
            {
                this.stream.pause();
                this._playState = "playState_pause";
                this.isPlay = false;
                dispatchEvent(new Event(this._playState));
            };
        }

        public function close():void
        {
            this.killMonitorBuffer();
            if (this.stream)
            {
                this.stream.close();
                this._playState = "playState_stop";
                dispatchEvent(new Event(this._playState));
            };
            if (this.connection)
            {
                this.connection.close();
            };
        }

        public function togglePause():void
        {
            if (this.stream)
            {
                this.stream.togglePause();
                if (this._playState == "playState_pause")
                {
                    this._playState = "playState_play";
                }
                else
                {
                    if (this._playState == "playState_play")
                    {
                        this._playState = "playState_pause";
                    };
                };
                dispatchEvent(new Event(this._playState));
            };
        }

        public function seek(_arg1:Number):void
        {
            if (this.stream)
            {
                this.oldSeek = this.time;
                this.stream.seek(_arg1);
                this._playState = "playState_play";
            };
        }

        public function get time():Number
        {
            if (this.stream)
            {
                return (this.stream.time);
            };
            return (0);
        }

        public function get timeNum():Number
        {
            return ((this.time / this.duration));
        }

        public function get duration():Number
        {
            return (this._duration);
        }

        public function set duration(_arg1:Number):void
        {
            this._duration = _arg1;
            dispatchEvent(new Event("upAllTime"));
        }

        public function get allTime():Number
        {
            return (this.duration);
        }

        private function netStatusHandler(_arg1:NetStatusEvent):void
        {
            if (this.isShowBufferInfo)
            {
            };
            switch (_arg1.info.code)
            {
                case "NetConnection.Connect.Success":
                    this.setStream(this._connection);
                    if (this.linkPlay)
                    {
                        this.connectStreamPlay();
                    };
                    break;
                case "NetStream.Play.StreamNotFound":
                    this.duration = 0;
                    break;
                case "NetStream.Seek.InvalidTime":
                    this._playState = "playState_seek_invalidTime";
                    break;
                case "NetStream.Pause.Notify":
                    this._playState = "playState_seek_notify";
                    break;
                case "NetStream.Seek.Notify":
                    this._playState = "playState_seek_notify";
                    break;
                case "NetStream.Buffer.Empty":
                    this._playState = "playState_buffer_empty";
                    break;
                case "NetStream.Play.InsufficientBW":
                    this._playState = "playState_insufficientBW";
                    dispatchEvent(new Event(this._playState));
                    break;
                case "NetStream.Buffer.Full":
                    this._playState = "playState_buffer_full";
                    break;
                case "NetStream.Play.UnpublishNotify":
                    DebugOutput.add("FME停止发布");
                    break;
                case "NetStream.Play.PublishNotify":
                    DebugOutput.add("FME开始发布");
                    break;
                case "NetStream.Play.Start":
                    this._playState = "playState_play";
                    dispatchEvent(new Event(this._playState));
                    break;
                case "NetStream.Play.Stop":
                    this.killMonitorBuffer();
                    this.isPlay = false;
                    this._playState = "playState_stop";
                    if (!this.playStateStopBool)
                    {
                        this.playStateStopBool = true;
                    };
                    dispatchEvent(new Event(this._playState));
                    break;
            };
            dispatchEvent(_arg1);
            if (String(_arg1.info.code).split(".")[0] == "NetStream")
            {
            };
        }

        private function securityErrorHandler(_arg1:SecurityErrorEvent):void
        {
        }

        private function asyncErrorHandler(_arg1:AsyncErrorEvent):void
        {
        }


    }
}//package com.snake.media

import flash.events.*;
import com.snake.media.*;

class CustomClient 
{

    public var model:VideoModel;
    public var metaData:Object;
    public var cuePoint:Object;

    public function CustomClient(_arg1:VideoModel=null):void
    {
        this.model = _arg1;
    }

    public function onFI(_arg1:Object):void
    {
    }

    public function onMetaData(_arg1:Object):void
    {
        if (this.model)
        {
            this.metaData = _arg1;
            this.model.duration = _arg1.duration;
            this.model.dispatchEvent(new Event("MetaData"));
        };
    }

    public function onCuePoint(_arg1:Object):void
    {
        if (this.model)
        {
            this.cuePoint = _arg1;
            this.model.dispatchEvent(new Event("CuePoint"));
        };
    }

    public function checkBandwidth():int
    {
        return (0);
    }

    public function onBWDone():int
    {
        return (0);
    }


}
