package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.view.events.*;
    import flash.text.*;
    import gamePlatform.*;

    public class UserInfoView extends Sprite 
    {

        private var skin:UserInfoSkin;
        private var mc_logo:MovieClip;
        private var txt_userName:TextField;
        private var txt_userMoney:Object;
        private var logoMask:MovieClip;

        public function UserInfoView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            var _local2:MovieClip;
            this.skin = new UserInfoSkin();
            this.txt_userName = this.skin.txt_userName;
            this.txt_userMoney = this.skin.txt_userMoney;
            var _local1:int;
            while (_local1 < 5)
            {
                _local2 = this.skin[("btn_" + _local1)];
                _local2.id = _local1;
                Tools.setButton(_local2);
                _local2.addEventListener(MouseEvent.MOUSE_OVER, this.btnOver);
                _local2.addEventListener(MouseEvent.MOUSE_OUT, this.btnOut);
                _local2.addEventListener(MouseEvent.CLICK, this.btnFun);
                _local1++;
            };
            this.skin.editNickNameBtn.addEventListener(MouseEvent.CLICK, this.editNickNameBtnFun);
        }

        private function editNickNameBtnFun(_arg1:MouseEvent):void
        {
            var _local2:UserInfoViewEvent;
            _local2 = new UserInfoViewEvent(UserInfoViewEvent.EDITNICKNAME);
            dispatchEvent(_local2);
        }

        private function journalingPanel():void
        {
            var _local1:UserInfoViewEvent;
            _local1 = new UserInfoViewEvent(UserInfoViewEvent.RECORD);
            dispatchEvent(_local1);
        }

        private function editPassword():void
        {
            var _local1:UserInfoViewEvent;
            _local1 = new UserInfoViewEvent(UserInfoViewEvent.EDITPASSWORD);
            dispatchEvent(_local1);
        }

        private function outGame():void
        {
            var _local1:UserInfoViewEvent;
            _local1 = new UserInfoViewEvent(UserInfoViewEvent.OUT);
            dispatchEvent(_local1);
        }

        public function showUserInfo(_arg1:String, _arg2:Number, _arg3:String):void
        {
            this.txt_userName.text = _arg1;
            this.txt_userMoney.text = (_arg2 + "");
            if (_arg3 != null)
            {
                this.skin.txt_nickName.text = _arg3;
                // this.skin.txt_nickName.text = "小哥哥小";
				trace(_arg3);
            };
        }

        private function showGameHistory():void
        {
            dispatchEvent(new Event("showGameHistory"));
        }

        private function screenFun(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
            if (_local2 == this.skin.mc_p1)
            {
                this.skin.mc_p1.visible = false;
                this.skin.mc_p2.visible = true;
            }
            else
            {
                this.skin.mc_p1.visible = true;
                this.skin.mc_p2.visible = false;
                stage.displayState = StageDisplayState.NORMAL;
            };
        }

        private function btnOver(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
        }

        private function btnOut(_arg1:MouseEvent):void
        {
            var _local2:MovieClip = (_arg1.target as MovieClip);
        }

        private function btnFun(_arg1:MouseEvent):void
        {
            var _local3:UserInfoViewEvent;
            var _local2:MovieClip = (_arg1.target as MovieClip);
            switch (_local2.id)
            {
                case 4:
                    this.outGame();
                    return;
                case 1:
                    this.journalingPanel();
                    return;
                case 2:
                    this.editPassword();
                    return;
                case 0:
                    this.showGameHistory();
                    return;
                case 3:
                    if (stage.displayState == StageDisplayState.NORMAL)
                    {
                        stage.displayState = StageDisplayState.FULL_SCREEN;
                    }
                    else
                    {
                        stage.displayState = StageDisplayState.NORMAL;
                    };
                    return;
            };
        }

        public function addToStage():void
        {
            this.skin.x = 0;
            this.skin.y = 0;
            addChild(this.skin);
        }

        public function dispose():void
        {
            removeChild(this.skin);
        }


    }
}//package modules.gamePlatform.view
