package modules.baijiale.view
{
    import modules.gamePlatform.model.vo.*;
    import flash.events.*;
    import flash.display.*;
    import modules.baijiale.view.events.*;
    import baijiale.*;
    import modules.baijiale.view.components.*;
    import flash.net.*;
    import flash.text.*;
    import com.greensock.*;

    public class GotoGameTableListView extends Sprite 
    {

        public var currentTable:GameTableVO;
        private var currentTableBtn:GotoTableBtnView;
        private var gotoTableBtnArr:Array;
        private var mc_gotoTable:MovieClip;
        private var skin:GotoGameTableListSkin;
        private var tableBox:Sprite;
        private var tabelH:Number = 26.5;
        private var showNum:int;
        private var showAll:Number;
        private var simulation:SimulationInGotoGameTablePanel;
        private var isInit:Boolean;

        public function GotoGameTableListView(_arg1:GotoGameTableListSkin)
        {
            this.skin = _arg1;
            this.initDisplay();
        }

        private function initDisplay():void
        {
            this.tableBox = this.skin.tableBox;
            Tools.setButton(this.skin.mc_up);
            Tools.setButton(this.skin.mc_down);
            this.skin.tableBox = this.skin.boxMask;
            this.simulation = new SimulationInGotoGameTablePanel(this.skin.simulation);
            this.simulation.setShowBox(this);
        }

        public function initTableBox(_arg1:Array, _arg2:GameTableVO):void
        {
            var _local4:GameTableVO;
            var _local5:int;
            var _local6:GotoTableBtnView;
            var _local7:GotoTableBtnView;
            var _local8:uint;
            var _local9:uint;
            this.showNum = 0;
            var _local3:uint;
            if (this.isInit == false)
            {
                Tools.removeAllChild(this.tableBox);
                this.gotoTableBtnArr = new Array();
                _local5 = 0;
                while (_local5 < _arg1.length)
                {
                    _local4 = (_arg1[_local5] as GameTableVO);
                    if (_local4.hidden != "true")
                    {
                        _local7 = new GotoTableBtnView();
                        _local7.setTableVo(_local4);
                        _local8 = (_local5 + 1);
                        _local7.id = _local8;
                        _local7.gameID = _local4.gameid;
                        _local7.y = (this.tabelH * uint((_local5 / 3)));
                        _local7.x = (uint((_local5 % 3)) * 80);
                        this.tableBox.addChild(_local7);
                        this.gotoTableBtnArr.push(_local7);
                        _local7.addEventListener("upSelect", this.selectTableFun);
                        _local7.addEventListener(MouseEvent.MOUSE_OVER, this.btnClick);
                        _local7.addEventListener(MouseEvent.MOUSE_OUT, this.hideSimulation);
                    };
                    _local5++;
                };
                this.simulation.visible = false;
                this.showAll = Math.floor((this.gotoTableBtnArr.length / 6));
                this.isInit = true;
            };
            this.showSelectBtn(_arg2.gameid);
            _local3 = this.currentTableBtn.id;
            this.showNum = Math.floor((_local3 / 6));
            if ((_local3 % 3) == 0)
            {
                this.showNum--;
            };
            this.showNum = (((this.showNum < 0)) ? 0 : this.showNum);
            this.showNum = (((this.showNum >= this.showAll)) ? (this.showAll - 1) : this.showNum);
            if (this.showNum < this.showAll)
            {
                this.showTabelBox((this.showNum * 2));
            };
        }

        private function hideSimulation(_arg1:MouseEvent):void
        {
            this.simulation.visible = false;
        }

        private function btnClick(_arg1:MouseEvent):void
        {
            var _local2:GotoTableBtnView = (_arg1.target as GotoTableBtnView);
            var _local3:GameTableVO = _local2.tableVO;
            if ((((((_local3.gameType == "baijiale")) || ((_local3.gameType == "longhu")))) || ((_local3.gameType == "daxiao"))))
            {
                this.simulation.showGameTableVO(_local3);
                this.simulation.upLimitInfo(_local3);
                this.simulation.visible = true;
            };
        }

        private function mouseWheelFun(_arg1:MouseEvent):void
        {
            if (_arg1.delta > 0)
            {
                this.upClick();
            }
            else
            {
                this.downClick();
            };
        }

        private function upClick(_arg1:MouseEvent=null):void
        {
            this.showNum--;
            if (this.showNum < 0)
            {
                this.showNum = 0;
            };
            this.showTabelBox((this.showNum * 2));
        }

        private function downClick(_arg1:MouseEvent=null):void
        {
            this.showNum++;
            if (this.showNum >= this.showAll)
            {
                this.showNum = (this.showAll - 1);
            };
            if (this.showNum < 0)
            {
                this.showNum = 0;
            };
            this.showTabelBox((this.showNum * 2));
        }

        private function showTabelBox(_arg1:uint):void
        {
            var _local2:Number = this.skin.boxMask.y;
            _local2 = (_local2 - (this.tabelH * _arg1));
            TweenMax.to(this.tableBox, 0.5, {"y":_local2});
        }

        private function selectTableFun(_arg1:Event):void
        {
            var _local4:GotoTableBtnView;
            var _local2:GotoTableBtnView = (_arg1.target as GotoTableBtnView);
            var _local3:int;
            while (_local3 < this.gotoTableBtnArr.length)
            {
                _local4 = (this.gotoTableBtnArr[_local3] as GotoTableBtnView);
                if (_local4 != _local2)
                {
                    _local4.select = false;
                };
                _local3++;
            };
            this.currentTable = _local2.tableVO;
            this.currentTableBtn = _local2;
            dispatchEvent(new GotoGameTableListViewEvent(GotoGameTableListViewEvent.UP_TABLE));
            dispatchEvent(new GotoGameTableListViewEvent(GotoGameTableListViewEvent.GOTO_TABLE));
        }

        private function gotoTable(_arg1:MouseEvent):void
        {
            if (_arg1.currentTarget != this.currentTableBtn)
            {
                dispatchEvent(new GotoGameTableListViewEvent(GotoGameTableListViewEvent.GOTO_TABLE));
            };
        }

        public function addToStage():void
        {
            var _local1:int;
            var _local2:GotoTableBtnView;
            addChild(this.skin);
            this.skin.mc_up.addEventListener(MouseEvent.CLICK, this.upClick);
            this.skin.mc_down.addEventListener(MouseEvent.CLICK, this.downClick);
            addEventListener(MouseEvent.MOUSE_WHEEL, this.mouseWheelFun);
            if (this.isInit == true)
            {
                _local1 = 0;
                while (_local1 < this.gotoTableBtnArr.length)
                {
                    _local2 = (this.gotoTableBtnArr[_local1] as GotoTableBtnView);
                    _local2.addEventListener("upSelect", this.selectTableFun);
                    _local2.addEventListener(MouseEvent.MOUSE_OVER, this.btnClick);
                    _local1++;
                };
            };
        }

        private function showSelectBtn(_arg1:String):void
        {
            var _local2:uint;
            while (_local2 < this.gotoTableBtnArr.length)
            {
                if (this.gotoTableBtnArr[_local2].gameID == _arg1)
                {
                    this.gotoTableBtnArr[_local2].select = true;
                    this.currentTableBtn = this.gotoTableBtnArr[_local2];
                }
                else
                {
                    this.gotoTableBtnArr[_local2].select = false;
                };
                _local2++;
            };
        }

        public function dispose():void
        {
            var _local2:GotoTableBtnView;
            this.skin.mc_up.removeEventListener(MouseEvent.CLICK, this.upClick);
            this.skin.mc_down.removeEventListener(MouseEvent.CLICK, this.downClick);
            removeEventListener(MouseEvent.MOUSE_WHEEL, this.mouseWheelFun);
            removeChild(this.skin);
            if (!this.gotoTableBtnArr)
            {
                return;
            };
            var _local1:int;
            while (_local1 < this.gotoTableBtnArr.length)
            {
                _local2 = (this.gotoTableBtnArr[_local1] as GotoTableBtnView);
                _local2.removeEventListener("upSelect", this.selectTableFun);
                _local2.removeEventListener(MouseEvent.MOUSE_OVER, this.btnClick);
                _local1++;
            };
        }


    }
}//package modules.baijiale.view
