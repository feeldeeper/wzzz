package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.system.*;
    import flash.utils.*;
    import flash.net.*;
    import flash.text.*;
    import gamePlatform.*;
    import com.snake.utils.*;

    public class EditPasswordPanelView extends Sprite 
    {

        private var skin:EditPasswordPanelSkin;
        private var btn:SimpleButton;
        private var autoBtn:MovieClip;
        private var enterBtn:MovieClip;
        private var oldPwd:TextField;
        private var newPwd:TextField;
        private var rePwd:TextField;
        private var progressbar:MovieClip;
        private var language:MovieClip;
        private var safety:TextField;
        private var viewPwd:TextField;
        private var tabIndexs:uint;
        private var userID:String;
        private var _nc:NetConnection;
        public var errorStr:String;
        private var isInit:Boolean;
        private var userType:String;
        private var parentTreeStr:String;

        public function EditPasswordPanelView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            if (this.isInit == false)
            {
                this.skin = new EditPasswordPanelSkin();
                addChild(this.skin);
                this.newPwd = this.skin.newPwd;
                this.autoBtn = this.skin.autoBtn;
                this.enterBtn = this.skin.enterBtn;
                this.rePwd = this.skin.rePwd;
                this.progressbar = this.skin.progressbar;
                this.safety = this.skin.safety;
                this.language = this.skin.language;
                this.viewPwd = this.skin.viewPwd;
                this.oldPwd = this.skin.oldPwd;
                this.oldPwd.displayAsPassword = true;
                this.newPwd.displayAsPassword = true;
                this.rePwd.displayAsPassword = true;
                this.btn = this.skin.btn_close;
                this.btn.addEventListener(MouseEvent.CLICK, this.close);
                Tools.setButton(this.autoBtn);
                Tools.setButton(this.enterBtn);
                Tools.setNoMouse(this.language);
                this.autoBtn.addEventListener(MouseEvent.CLICK, this.autoBtnFun);
                this.enterBtn.addEventListener(MouseEvent.CLICK, this.enterBtnFun);
                this.newPwd.addEventListener(KeyboardEvent.KEY_UP, this.testPwdFun);
                this._nc = new NetConnection();
                this._nc.addEventListener(NetStatusEvent.NET_STATUS, this.statusHandler);
                this.isInit = true;
            };
        }

        protected function close(_arg1:MouseEvent=null):void
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
            this.userType = _arg2;
            this.parentTreeStr = _arg3;
            setTimeout(this.alertNoEditPwd, 500);
        }

        private function alertNoEditPwd():void
        {
            if (this.parentTreeStr.indexOf("apiuser") > -1)
            {
                this.showError("修改密码请在[王者至尊现金网]修改密码！");
                setTimeout(this.close, 1000);
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

        private function autoBtnFun(_arg1:MouseEvent):void
        {
            var _local2:String = PassWordTest.randomPassWore();
            this.newPwd.text = _local2;
            this.viewPwd.text = _local2;
            System.setClipboard(_local2);
            this.testPwd(_local2);
        }

        private function testPwd(_arg1:String):void
        {
            var _local2:uint = PassWordTest.getStrength(_arg1);
            this.progressbar.maskMC.width = (_local2 * 14);
            if (_local2 < 6)
            {
                this.safety.text = "安全度：低";
            }
            else
            {
                if (_local2 < 15)
                {
                    this.safety.text = "安全度：中";
                }
                else
                {
                    if (_local2 > 15)
                    {
                        this.safety.text = "安全度：高";
                    };
                };
            };
        }

        private function testPwdFun(_arg1:KeyboardEvent):void
        {
            this.testPwd(this.newPwd.text);
        }

        private function checkrePwd():void
        {
            if (this.newPwd.text != this.rePwd.text)
            {
                this.showError("重複輸入的密碼必須相同");
            };
        }

        private function enterBtnFun(_arg1:MouseEvent):void
        {
            if (this.oldPwd.length < 6)
            {
                this.showError("舊密碼不能為空");
                return;
            };
            if (this.newPwd.text != this.rePwd.text)
            {
                this.showError("重複輸入的密碼必須相同");
                return;
            };
            if ((((this.newPwd.length < 6)) || ((this.rePwd.length < 6))))
            {
                this.showError("密碼字元數必須大於6個");
                return;
            };
            var _local2:Object = {
                "userName":this.userID,
                "pwd":this.oldPwd.text,
                "newPwd":this.newPwd.text
            };
            this._nc.call("Sim_Main.changePwd", new Responder(this.onResult, this.getStatus), _local2);
        }

        private function onResult(_arg1:Object):void
        {
            if (_arg1.type == true)
            {
                this.showError("密碼修改成功");
            }
            else
            {
                this.showError("密碼修改失敗");
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
