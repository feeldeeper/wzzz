package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.net.*;
    import gamePlatform.*;
    import com.snake.utils.*;

    public class EditNickNamePanelView extends Sprite 
    {

        private var skin:EditNickNamePanelSkin;
        private var enterBtn:MovieClip;
        private var userID:String;
        private var pwd:String;
        private var _nc:NetConnection;
        public var nickName:String;
        public var errorStr:String;
        private var isInit:Boolean;

        public function EditNickNamePanelView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            if (this.isInit == false)
            {
                this.skin = new EditNickNamePanelSkin();
                addChild(this.skin);
                this._nc = new NetConnection();
                this._nc.addEventListener(NetStatusEvent.NET_STATUS, this.statusHandler);
                this.skin.btn_close.addEventListener(MouseEvent.CLICK, this.close);
                Tools.setButton(this.skin.enterBtn);
                this.skin.enterBtn.addEventListener(MouseEvent.CLICK, this.enterBtnFun);
                this.isInit = true;
            };
        }

        private function enterBtnFun(_arg1:MouseEvent):void
        {
            if (this.skin.newNickName.text.length < 1)
            {
                this.showError("新昵称不能為空！");
                return;
            };
            var _local2:Object = {
                "userName":this.userID,
                "pwd":this.pwd,
                "nickName":this.skin.newNickName.text
            };
            this._nc.call("Sim_Main.changeNickName", new Responder(this.onResult, this.getStatus), _local2);
            this.nickName = this.skin.newNickName.text;
        }

        protected function close(_arg1:MouseEvent):void
        {
            dispatchEvent(new Event("close"));
        }

        public function initReSize():void
        {
            stage.addEventListener(Event.RESIZE, this.reSize);
            this.reSize();
        }

        public function setUserInfo(_arg1:String, _arg2:String, _arg3:String):void
        {
            this.userID = _arg1;
            this.pwd = _arg3;
            if (_arg2 != null)
            {
                this.skin.oldNickName.text = _arg2;
            };
        }

        protected function reSize(_arg1:Event=null):void
        {
            if (!stage)
            {
                return;
            };
            var _local2:uint = stage.stageWidth;
            var _local3:uint = stage.stageHeight;
            this.x = ((_local2 / 2) >> 0);
            this.y = ((_local3 / 2) >> 0);
        }

        private function onResult(_arg1:Object):void
        {
            if (_arg1.type == true)
            {
                this.showError("用户昵称修改成功");
                dispatchEvent(new Event("upNickName"));
            }
            else
            {
                this.showError("用户昵称修改失敗");
            };
        }

        private function getStatus(_arg1):void
        {
            DebugOutput.add("<CALL回执>:---------------------错误信息 ------------------\n\n");
            DebugOutput.add(ObjectUtil.ObjtoString(_arg1));
            DebugOutput.add("\n\n---------------------错误信息 end------------------");
        }

        private function showError(_arg1:String):void
        {
            this.errorStr = _arg1;
            dispatchEvent(new Event("error"));
        }

        public function setAmfUrl(_arg1:String):void
        {
            this._nc.connect(_arg1);
        }

        private function statusHandler(_arg1:NetStatusEvent):void
        {
            switch (_arg1.info.code)
            {
                case "NetConnection.Connect.Rejected":
                case "NetConnection.Connect.Failed":
                case "NetConnection.Connect.Closed":
                    this.showError("連接服務器失敗");
                    return;
            };
        }

        public function addToStage():void
        {
            this.initDisplay();
        }

        public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
