package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import gamePlatform.*;
    import flash.external.*;

    public class AlertDefaultView extends Sprite 
    {

        private var skin:AlertSkin;
        private var btn:MovieClip;
        private var txt_title:TextField;
        private var txt_info:TextField;
        private var url:String;

        public function AlertDefaultView()
        {
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.skin = new AlertSkin();
            addChild(this.skin);
            this.btn = this.skin.btn;
            Tools.setButton(this.btn);
            this.btn.addEventListener(MouseEvent.CLICK, this.btnFun);
            this.txt_title = this.skin.txt_title;
            this.txt_info = this.skin.txt_info;
        }

        public function initReSize():void
        {
            stage.addEventListener(Event.RESIZE, this.reSize);
            this.reSize();
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

        public function show(_arg1:String="", _arg2:String="提示", _arg3:String=""):void
        {
            this.txt_title.text = _arg2;
            this.txt_info.text = _arg1;
            this.url = _arg3;
        }

        protected function btnFun(_arg1:MouseEvent):void
        {
            this.close();
        }

        public function close():void
        {
            dispatchEvent(new Event("close"));
            if (this.url != "")
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("logout");
                };
            };
        }

        public function dispose():void
        {
            if (stage)
            {
                stage.removeEventListener(Event.RESIZE, this.reSize);
            };
        }


    }
}//package modules.gamePlatform.view
