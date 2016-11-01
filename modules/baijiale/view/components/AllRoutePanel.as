package modules.baijiale.view.components
{
    import modules.gamePlatform.model.vo.*;
    import flash.display.*;
    import baijiale.*;
    import modules.gamePlatform.model.vo.events.*;
    import com.snake.game.*;

    public class AllRoutePanel extends Sprite 
    {

        private var loger:BJLCardLog;
        private var box1:Sprite;
        private var box2:Sprite;
        private var box1Stage:Sprite;
        private var box2Stage:Sprite;
        private var _tablevo:GameTableVO;
        private var _id:uint;

        public function AllRoutePanel(_arg1:GameTableVO)
        {
            var _local9:Number;
            var _local10:Number;
            this.loger = new BJLCardLog();
            this.box1 = new Sprite();
            this.box2 = new Sprite();
            this.box1Stage = new Sprite();
            this.box2Stage = new Sprite();
            super();
            this._tablevo = _arg1;
            var _local2:AllRouteListSkin = new AllRouteListSkin();
            addChild(_local2);
            var _local3:Number = 12;
            var _local4:Number = _local2.box.width;
            var _local5:Number = _local2.box.height;
            var _local6:uint = (_local2.box.width / _local3);
            var _local7:Sprite = new Sprite();
            _local7.x = _local2.box.x;
            _local7.y = _local2.box.y;
            _local7.graphics.clear();
            _local7.graphics.lineStyle(0, 0);
            _local7.graphics.beginFill(0xFFFFFF);
            var _local8:int;
            while (_local8 < (6 * 40))
            {
                _local9 = (((_local8 / 6) >> 0) * _local3);
                _local10 = ((_local8 % 6) * _local3);
                _local7.graphics.drawRect(_local9, _local10, _local3, _local3);
                _local8++;
            };
            this.box1.addChildAt(this.box1Stage, 0);
            this.box2.addChildAt(this.box2Stage, 0);
            this.box2.x = 144;
            _local7.addChild(this.box1);
            _local7.addChild(this.box2);
            this._tablevo.addEventListener(GameTableVOEvent.UP_GAME_HISTORY, this.routeListUpHistory);
            this.box1Stage.addChild(this.loger.zhuZaiMc);
            this.box2Stage.addChild(this.loger.daLuMc);
            this.showLog(this._tablevo.gameHistory);
            this.initBoxMask(this.box1, 144, 72);
            this.initBoxMask(this.box2, 324, 72);
            _local2.tableName.text = this._tablevo.gameid;
            _local2.limitMax.text = String(this._tablevo.tableLimitMax);
            _local2.limitMin.text = String(this._tablevo.tableLimitMin);
            addChild(_local7);
        }

        public function get id():uint
        {
            return (this._id);
        }

        public function set id(_arg1:uint):void
        {
            this._id = _arg1;
        }

        private function routeListUpHistory(_arg1:GameTableVOEvent):void
        {
            this.showLog(this._tablevo.gameHistory);
        }

        private function showLog(_arg1:Array):void
        {
            var _local2:uint;
            while (_local2 < _arg1.length)
            {
                if (_arg1[_local2] >= 20)
                {
                    _arg1[_local2] = (_arg1[_local2] - 20);
                };
                _local2++;
            };
            var _local3:Array = _arg1.concat(new Array());
            var _local4:uint;
            var _local5:Boolean;
            _local2 = 0;
            while (_local2 < _local3.length)
            {
                if (_local5 == false)
                {
                    if (_local3[_local2] > 7)
                    {
                        _local4++;
                    }
                    else
                    {
                        _local5 = true;
                        break;
                    };
                };
                _local2++;
            };
            _local3.splice(0, _local4);
            this.loger.zhuzaiLuShow(_arg1, BigLuMoiveSkin, 12, 12);
            this.loger.daLuShow(_local3, DaLuMoiveSkin, 12, 12);
            this.box1Stage.x = (this.box2Stage.x = 0);
            if (this.loger.zhuZaiLuLie > 12)
            {
                this.box1Stage.x = (this.box1Stage.x - ((this.loger.zhuZaiLuLie - 12) * 12));
            };
            if (this.loger.daLuLie > 27)
            {
                this.box2Stage.x = (this.box2Stage.x - ((this.loger.daLuLie - 27) * 12));
            };
        }

        private function initBoxMask(_arg1:Sprite, _arg2:uint, _arg3:uint):void
        {
            var _local4:Sprite = new Sprite();
            _local4.graphics.beginFill(0xFF0000);
            _local4.graphics.drawRect(0, 0, _arg2, _arg3);
            _arg1.addChild(_local4);
            _arg1.mask = _local4;
        }


    }
}//package modules.baijiale.view.components
