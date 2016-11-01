package modules.baijiale.view.components
{
    import modules.gamePlatform.model.vo.*;
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import baijiale.*;
    import flash.net.*;
    import flash.text.*;
    import com.snake.game.*;
    import daxiao.*;
    import longhu.*;

    public class SimulationInGotoGameTablePanel extends Sprite 
    {

        private var skin:MovieClip;
        private var _w:Number = 12;
        private var box:MovieClip;
        private var box1Stage:Sprite;
        private var hitTime:Number = 5000;
        private var time:Number = 0;
        private var bjlCardLog:BJLCardLog;
        private var lhCardLog:BJLCardLog;
        private var showBox:DisplayObjectContainer;
        private var _tableVo:GameTableVO;

        public function SimulationInGotoGameTablePanel(_arg1:MovieClip)
        {
            var _local6:Number;
            var _local7:Number;
            this.box1Stage = new Sprite();
            this.bjlCardLog = new BJLCardLog();
            this.lhCardLog = new BJLCardLog();
            super();
            this.skin = _arg1;
            this.x = this.skin.x;
            this.y = this.skin.y;
            this.skin.x = (this.skin.y = 0);
            addChild(this.skin);
            this.box = this.skin.box;
            var _local2:Number = this.box.width;
            var _local3:Number = this.box.height;
            var _local4:uint = (this.box.width / this._w);
            this.box.graphics.clear();
            this.box.graphics.lineStyle(0, 0);
            this.box.graphics.beginFill(0xFFFFFF, 0.8);
            var _local5:int;
            while (_local5 < (6 * _local4))
            {
                _local6 = (((_local5 / 6) >> 0) * this._w);
                _local7 = ((_local5 % 6) * this._w);
                this.box.graphics.drawRect(_local6, _local7, this._w, this._w);
                _local5++;
            };
            this.box.width = _local2;
            this.box.height = _local3;
            this.box.addChild(this.box1Stage);
            Tools.setButton(this.skin.mc_close);
            this.skin.mc_close.addEventListener(MouseEvent.CLICK, this.closeClick);
            this.initBoxMask(this.box, this.box.width, this.box.height);
        }

        private function initBoxMask(_arg1:Sprite, _arg2:uint, _arg3:uint):void
        {
            var _local4:Sprite = new Sprite();
            _local4.graphics.beginFill(0xFF0000);
            _local4.graphics.drawRect(0, 0, _arg2, _arg3);
            _arg1.addChildAt(_local4, 1);
            _arg1.mask = _local4;
        }

        public function get tableVo():GameTableVO
        {
            return (this._tableVo);
        }

        public function setShowBox(_arg1:DisplayObjectContainer):void
        {
            this.showBox = _arg1;
        }

        public function showGameTableVO(_arg1:GameTableVO):void
        {
            if (!this.showBox)
            {
                return;
            };
            Tools.clearTimeOut(this.time);
            this.showBox.addChild(this);
            this._tableVo = _arg1;
            this.showSimulation();
            this.time = Tools.setTimeOut(this.timeOutFun, this.hitTime);
        }

        public function showSimulation():void
        {
            var _local1:Class;
            var _local2:Sprite;
            var _local3:Array;
            this.box1Stage.x = 0;
            Tools.removeAllChild(this.box1Stage);
            if (!this.tableVo)
            {
                return;
            };
            if (this.tableVo.gameType == "baijiale")
            {
                _local1 = this.getClassByName("baijiale.DaLuMoiveSkin");
            };
            if (this.tableVo.gameType == "longhu")
            {
                _local1 = this.getClassByName("longhu.DaLuMoiveSkin");
            };
            if (this.tableVo.gameType == "daxiao")
            {
                _local1 = this.getClassByName("daxiao.BigLuMoiveSkin");
            };
            if (this.tableVo.gameType == "lunpan")
            {
                _local1 = this.getClassByName("baijiale.DaLuMoiveSkin");
            };
            if (_local1 == null)
            {
                return;
            };
            if (this.tableVo.gameType == "baijiale")
            {
                _local3 = this.clearTie(this.tableVo.gameHistory);
                if (_local3.length > 0)
                {
                    this.bjlCardLog.daLuShow(_local3, baijiale.DaLuMoiveSkin, 12, 12);
                    _local2 = this.bjlCardLog.daLuMc;
                    if (this.bjlCardLog.daLuLie > 30)
                    {
                        this.box1Stage.x = (this.box1Stage.x - ((this.bjlCardLog.daLuLie - 30) * 12));
                    };
                };
            };
            if (this.tableVo.gameType == "longhu")
            {
                _local3 = this.clearTie(this.tableVo.gameHistory);
                if (_local3.length > 0)
                {
                    this.lhCardLog.daLuShow(_local3, DaLuMoiveSkin, 12, 12);
                    _local2 = this.lhCardLog.daLuMc;
                    if (this.lhCardLog.daLuLie > 30)
                    {
                        this.box1Stage.x = (this.box1Stage.x - ((this.lhCardLog.daLuLie - 30) * 12));
                    };
                };
            };
            if (this.tableVo.gameType == "daxiao")
            {
                _local3 = DaxiaoCardlog.getLastArr(this.tableVo.gameHistory.concat([]));
                if (_local3.length > 0)
                {
                    _local2 = DaxiaoCardlog.showBigOrSmall(_local3, BigLuMoiveSkin, this._w, this._w);
                    if (DaxiaoCardlog.daLuLie > 30)
                    {
                        this.box1Stage.x = (this.box1Stage.x - ((DaxiaoCardlog.daLuLie - 30) * this._w));
                    };
                };
            };
            _local3 = null;
            if (this.tableVo.gameType == "lunpan")
            {
            };
            if (_local2 == null)
            {
                return;
            };
            this.box1Stage.addChild(_local2);
        }

        public function getClassByName(name:String):Class
        {
            if (name == "*")
            {
                name = "Object";
            };
            try
            {
                return ((getDefinitionByName(name) as Class));
            }
            catch(e:ReferenceError)
            {
            };
            return (null);
        }

        private function timeOutFun(_arg1=null):void
        {
            Tools.clearTimeOut(this.time);
            if (parent)
            {
                parent.removeChild(this);
            };
        }

        protected function closeClick(_arg1:MouseEvent):void
        {
            this.timeOutFun();
        }

        private function clearTie(_arg1:Array):Array
        {
            var _local4:Boolean;
            var _local2:Array = _arg1.concat([]);
            var _local3:uint;
            var _local5:uint;
            while (_local5 < _local2.length)
            {
                if (_local4 == false)
                {
                    if (_local2[_local5] > 7)
                    {
                        _local3++;
                    }
                    else
                    {
                        _local4 = true;
                        break;
                    };
                };
                _local5++;
            };
            _local2.splice(0, _local3);
            return (_local2);
        }

        public function upLimitInfo(_arg1:Object):void
        {
            if (_arg1.gameType == "baijiale")
            {
                this.skin.tableName.text = ("百家乐" + _arg1.gameid);
            };
            if (_arg1.gameType == "longhu")
            {
                this.skin.tableName.text = ("龙虎" + _arg1.gameid);
            };
            if (_arg1.gameType == "nnGame")
            {
                this.skin.tableName.text = ("牛牛" + _arg1.gameid);
            };
            if (_arg1.gameType == "daxiao")
            {
                this.skin.tableName.text = ("大小" + _arg1.gameid);
            };
            this.skin.limitMax.text = _arg1.tableLimitMax;
            this.skin.limitMin.text = _arg1.tableLimitMin;
        }


    }
}//package modules.baijiale.view.components
