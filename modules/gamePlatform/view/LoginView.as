package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import gamePlatform.*;
    import com.greensock.loading.*;
    import flash.external.*;
    import com.greensock.*;

    public class LoginView extends Sprite 
    {

        private var skin:LoginSkin;
        public var text_userName:TextField;
        public var text_password:TextField;
        public var text_error:TextField;
        private var btn_login:SimpleButton;
        private var btn_reset:MovieClip;
        private var paoPao:MovieClip;
        private var paoPaoLoader:SWFLoader;
        private var loading:MovieClip;
        public var isAutoLogin:Boolean;
        private var isLogin:Boolean;
        public var isTelModel:Boolean;

        public function LoginView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new LoginSkin();
            addChild(this.skin);
            var _local1:SWFLoader = LoaderMax.getLoader("userHeader");
            var _local2:Class = _local1.getClass("otherLib.LoginBg");
            var _local3:Sprite = new (_local2)();
            this.skin.addChildAt(_local3, 0);
        }

        public function movieIn():void
        {
            Tools.movieFrame(this.skin, "movieOut", this.moiveInEnd);
        }

        private function moiveInEnd():void
        {
            this.loading = this.skin.loading;
            this.loading.visible = false;
            this.text_error = this.skin.text_error;
            this.text_error.text = "";
			var tf:TextFormat=new TextFormat();
			tf.font="宋体";
			this.text_error.setTextFormat(tf);
            this.text_userName = this.skin.loginMc.text_userName;
            this.text_password = this.skin.loginMc.text_password;
            this.text_password.displayAsPassword = true;
            this.text_userName.text = "";
            this.text_password.text = "";
            this.btn_login = this.skin.loginMc.btn_login;
            this.btn_login.tabEnabled = false;
            this.btn_login.addEventListener(MouseEvent.CLICK, this.login);
            this.text_userName.addEventListener(MouseEvent.CLICK, this.resetAutoLogin);
            this.text_password.addEventListener(MouseEvent.CLICK, this.resetAutoLogin);
            dispatchEvent(new Event("movieOut"));
			/*
			//本段是网页登陆部分
            if (((((((ExternalInterface.available) && (!((ExternalInterface.call("getUserName") == null))))) && (!((ExternalInterface.call("getPwd") == null))))) && ((this.isLogin == false))))
            {
                this.text_userName.text = ExternalInterface.call("getUserName");
                this.text_password.text = ExternalInterface.call("getPwd");
                if (ExternalInterface.call("getUserName"))
                {
                    this.isAutoLogin = true;
                    this.btn_login.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                };
            }
            else
            {
                this.text_userName.text = "";
            };
			*/
			//测试用户名 密码
			// this.text_userName.text = "xiaozhi8888";
            // this.text_password.text = "801123";
			//测试用户名 密码
			
            addEventListener(KeyboardEvent.KEY_DOWN, this.enterHandler);
            /*
			if (ExternalInterface.available)
            {
                if (ExternalInterface.call("isTelModel"))
                {
                    this.isTelModel = true;
                };
            };
			*/
        }

        private function resetAutoLogin(_arg1:MouseEvent):void
        {
            this.isAutoLogin = false;
        }

        protected function reset(_arg1:MouseEvent):void
        {
            this.text_userName.text = "";
            this.text_password.text = "";
            this.text_error.text = "";
        }

        protected function login(_arg1:MouseEvent):void
        {
			/*
            if ((((this.text_userName.text.indexOf("_") > -1)) && ((this.isAutoLogin == false))))
            {
                this.text_error.text = "现金网帐号必须从现金网入口登录！";
                return;
            };
			*/
            if (!Tools.getDefaultBool(this.text_userName))
            {
                this.text_error.text = "请输入用户名";
                return;
            };
            if (!Tools.getDefaultBool(this.text_password))
            {
                this.text_error.text = "请输入密码";
                return;
            };
            this.isLogin = true;
            this.text_userName.visible = false;
            this.text_password.visible = false;
            this.loading.visible = true;
            this.loading.play();
            this.showError("正在连接服务器...");
            TweenMax.delayedCall(0.3, this.showError, ["开始验证帐号与密码..."]);
            TweenMax.delayedCall(0.8, this.showError, ["正在登录游戏服务器..."]);
            TweenMax.delayedCall(1.5, this.enterLogin);
            this.text_error.text = "";
        }

        private function enterLogin():void
        {
            dispatchEvent(new Event("login"));
        }

        public function showError(_arg1:String):void
        {
            if (this.text_error)
            {
                this.text_error.visible = true;
                this.text_error.text = _arg1;
            };
        }

        public function linkStart():void
        {
            if (this.btn_login)
            {
                this.btn_login.mouseEnabled = false;
            };
        }

        public function openBtn():void
        {
            if (this.btn_login)
            {
                this.btn_login.mouseEnabled = true;
                this.text_userName.visible = true;
                this.text_password.visible = true;
                this.loading.visible = false;
                this.loading.stop();
            };
        }

        private function enterHandler(_arg1:KeyboardEvent):void
        {
            if (_arg1.keyCode == 13)
            {
                this.btn_login.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
        }

        public function dispose():void
        {
            removeEventListener(KeyboardEvent.KEY_DOWN, this.enterHandler);
        }


    }
}//package modules.gamePlatform.view
