package modules.baijiale.view
{
    import modules.gamePlatform.model.vo.*;
    import flash.events.*;
    import flash.display.*;
    import baijiale.*;

    public class GotoTableBtnView extends Sprite 
    {

        private var _id:uint;
        private var _gameID:String;
        private var skin:BtnByGotoTableSkin;
        private var _select:Boolean = false;
        private var _tableVO:GameTableVO;

        public function GotoTableBtnView()
        {
            this.initDisplay();
        }

        public function get gameID():String
        {
            return (this._gameID);
        }

        public function set gameID(_arg1:String):void
        {
            this._gameID = _arg1;
        }

        public function get id():uint
        {
            return (this._id);
        }

        public function set id(_arg1:uint):void
        {
            this._id = _arg1;
        }

        private function initDisplay():void
        {
            this.skin = new BtnByGotoTableSkin();
            this.mouseChildren = false;
            this.buttonMode = true;
        }

        protected function outFun(_arg1:MouseEvent):void
        {
            if (this.select)
            {
                Tools.removeMovie(this.skin);
                this.skin.gotoAndStop(this.skin.totalFrames);
            }
            else
            {
                Tools.movieFrame(this.skin, 1);
            };
        }

        protected function overFun(_arg1:MouseEvent):void
        {
            if (this.select)
            {
                Tools.removeMovie(this.skin);
                this.skin.gotoAndStop(this.skin.totalFrames);
            }
            else
            {
                Tools.movieFrame(this.skin, (this.skin.totalFrames - 1));
            };
        }

        protected function clickFun(_arg1:MouseEvent):void
        {
            if (!this.select)
            {
                this.setSelect(!(this.select));
            };
        }

        public function setSelect(_arg1:Boolean):void
        {
            this.select = _arg1;
            dispatchEvent(new Event("upSelect"));
        }

        public function get select():Boolean
        {
            return (this._select);
        }

        public function set select(_arg1:Boolean):void
        {
            this._select = _arg1;
            if (this.select)
            {
                this.skin.gotoAndStop(this.skin.totalFrames);
            }
            else
            {
                this.skin.gotoAndStop(1);
            };
        }

        public function setTableVo(_arg1:GameTableVO):void
        {
            var _local2:String;
            this._tableVO = _arg1;
            this.skin.lh.visible = false;
            switch (this.tableVO.gameType)
            {
                case "baijiale":
                    _local2 = "";
                    break;
                case "longhu":
                    _local2 = "D";
                    break;
                case "lunpan":
                    _local2 = "R";
                    break;
                case "nnGame":
                    _local2 = "F";
                    break;
                case "daxiao":
                    _local2 = "B";
                    break;
                case "comic_bjl":
                    this.skin.tabelNum.visible = false;
                    this.skin.timeOut.visible = false;
                    this.skin.lh.visible = true;
                    break;
            };
            this.skin.tabelNum.text = (_local2 + this.tableVO.gameid);
            if (this.tableVO.gameState == 3)
            {
                this.skin.timeOut.text = "P";
            };
        }

        public function get tableVO():GameTableVO
        {
            return (this._tableVO);
        }

        public function upGameState():void
        {
            if (this.tableVO.gameState == 3)
            {
                this.skin.timeOut.text = "P";
            };
            if ((((this.tableVO.gameState == 0)) || ((this.tableVO.gameState == 2))))
            {
                this.skin.timeOut.text = "0";
            };
        }

        public function upTime():void
        {
            this.skin.timeOut.text = (this.tableVO.time + "");
        }

        public function addToStage():void
        {
            addChild(this.skin);
            addEventListener(MouseEvent.MOUSE_OVER, this.overFun);
            addEventListener(MouseEvent.MOUSE_OUT, this.outFun);
            addEventListener(MouseEvent.CLICK, this.clickFun);
        }

        public function dispose():void
        {
            removeChild(this.skin);
            removeEventListener(MouseEvent.MOUSE_OVER, this.overFun);
            removeEventListener(MouseEvent.MOUSE_OUT, this.outFun);
            removeEventListener(MouseEvent.CLICK, this.clickFun);
        }


    }
}//package modules.baijiale.view
