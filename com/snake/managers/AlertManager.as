package com.snake.managers
{
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import com.snake.utils.*;
    import com.snake.ui.core.*;

    public class AlertManager extends EventDispatcher 
    {

        private static var instance:AlertManager;
        private static var stageDic:Dictionary = new Dictionary();

        private var _stage:DisplayObjectContainer;
        private var objList:Array;
        private var _container:MSprite;
        private var _bg:uint = 0;
        private var _alpha:Number = 0.2;
        private var objects:Dictionary;
        private var filtersArr:Array;

        public function AlertManager()
        {
            this.filtersArr = new Array();
            super();
            this.objects = new Dictionary();
            this.objList = new Array();
            this._container = new MSprite();
            MSprite(this._container).autoSize = true;
            this._container.addEventListener(Event.RESIZE, function ():void
            {
                computShow();
            });
            this._container.addEventListener(Event.ADDED, this.ADDED);
            this._container.addEventListener(Event.REMOVED, this.REMOVED);
        }

        public static function getInstance(_arg1:Stage=null):AlertManager
        {
            var _local2:AlertManager;
            if (_arg1 == null)
            {
                if (instance == null)
                {
                    instance = new (AlertManager)();
                };
                return (instance);
            };
            if (stageDic[_arg1] != null)
            {
                return ((stageDic[_arg1] as AlertManager));
            };
            _local2 = new (AlertManager)();
            _local2.stage = _arg1;
            stageDic[_arg1] = _local2;
            return (_local2);
        }


        public function setBgAlpha(_arg1:Number):void
        {
            this._alpha = _arg1;
            this.computShow();
        }

        private function ADDED(_arg1:Event):void
        {
            if (_arg1.target == this._container)
            {
                return;
            };
            if (this.stage == null)
            {
                return;
            };
            var _local2:DisplayObject = DisplayObject(_arg1.target);
            var _local3:Object = this.objects[_local2];
            if (_local3 == null)
            {
                return;
            };
            this.stage.addChild(this._container);
            this._bg = _local3.bg;
            this.computShow();
        }

        private function REMOVED(_arg1:Event):void
        {
            if (_arg1.target == this._container)
            {
                return;
            };
            if (this.stage == null)
            {
                return;
            };
            if (this.objects[_arg1.target] == null)
            {
                return;
            };
            var _local2:DisplayObject = DisplayObject(_arg1.target);
            this.computShow(_local2);
            this.removeObjForArr(this.objList, _local2);
        }

        public function set stage(_arg1:DisplayObjectContainer):void
        {
            if (stageDic[_arg1] != null)
            {
                return;
            };
            if (this.stage)
            {
                return;
            };
            this._stage = _arg1;
            stageDic[_arg1] = this;
        }

        public function get stage():DisplayObjectContainer
        {
            return (this._stage);
        }

        private function computShow(_arg1:DisplayObject=null):void
        {
            var _local2:Object;
            var _local4:int;
            var _local5:DisplayObject;
            if (this.stage == null)
            {
                return;
            };
            var _local3:uint = this._container.numChildren;
            var _local6:Boolean;
            _local4 = 0;
            while (_local4 < _local3)
            {
                _local5 = this._container.getChildAt(_local4);
                _local2 = this.objects[_local5];
                if (_local2.bgBool)
                {
                    _local6 = true;
                    break;
                };
                _local4++;
            };
            if (_local6)
            {
                this._container.graphics.clear();
                this._container.graphics.beginFill(this._bg, this._alpha);
                this._container.graphics.drawRect(-(this.stage.stage.stageWidth), -(this.stage.stage.stageHeight), (this.stage.stage.stageWidth * 2), (this.stage.stage.stageHeight * 2));
            }
            else
            {
                this._container.graphics.clear();
                this._container.graphics.beginFill(0, 0);
                this._container.graphics.drawRect(-(this.stage.stage.stageWidth), -(this.stage.stage.stageHeight), (this.stage.stage.stageWidth * 2), (this.stage.stage.stageHeight * 2));
            };
            var _local7:Boolean;
            _local4 = 0;
            while (_local4 < _local3)
            {
                _local5 = this._container.getChildAt(_local4);
                _local2 = this.objects[_local5];
                if (_local2.filterBool)
                {
                    _local7 = true;
                    break;
                };
                _local4++;
            };
            if (_local7)
            {
                this.setFilters();
            }
            else
            {
                this.clearFilters();
            };
            if ((((((_local3 == 0)) || (((((_arg1) && ((_local3 == 1)))) && (this._container.contains(_arg1)))))) && (this.stage.contains(this._container))))
            {
                this.stage.removeChild(this._container);
                this.clearFilters();
            };
        }

        private function setFilters():void
        {
            var _local2:DisplayObject;
            var _local3:uint;
            if (!this.stage)
            {
                return;
            };
            var _local1:uint = this.stage.numChildren;
            _local3 = 0;
            while (_local3 < this.filtersArr.length)
            {
                _local2 = (this.filtersArr[_local3] as DisplayObject);
                if (_local2 != this._container)
                {
                    _local2.filters = [];
                };
                _local3++;
            };
            _local3 = 0;
            while (_local3 < _local1)
            {
                _local2 = this.stage.getChildAt(_local3);
                if (_local2 != this._container)
                {
                    _local2.filters = [MFilters.getBlurFilter()];
                    this.filtersArr.push(_local2);
                };
                _local3++;
            };
        }

        private function clearFilters():void
        {
            var _local2:DisplayObject;
            var _local3:uint;
            if (!this.stage)
            {
                return;
            };
            var _local1:uint = this.stage.numChildren;
            _local3 = 0;
            while (_local3 < this.filtersArr.length)
            {
                _local2 = (this.filtersArr[_local3] as DisplayObject);
                _local2.filters = [];
                _local3++;
            };
        }

        public function push(_arg1:DisplayObject, _arg2:Boolean=false, _arg3:Boolean=false, _arg4=null, _arg5:Number=0.2):void
        {
            var _local6:Object;
            if (!this.stage)
            {
                return;
            };
            this._alpha = _arg5;
            if (!this._container.contains(_arg1))
            {
                _local6 = {
                    "obj":_arg1,
                    "bgBool":_arg2,
                    "bg":_arg4,
                    "filterBool":_arg3
                };
                this.objList.push(_local6);
                this.objects[_arg1] = _local6;
                this._container.addChild(_arg1);
                if (this.stage)
                {
                    this.stage.addChild(this._container);
                };
            };
        }

        public function remove(_arg1:DisplayObject):void
        {
            if (!this.stage)
            {
                return;
            };
            if (this._container.contains(_arg1))
            {
                this._container.removeChild(_arg1);
            };
        }

        public function clear():void
        {
            var _local2:DisplayObject;
            var _local3:int;
            var _local1:Array = new Array();
            _local3 = 0;
            while (_local3 < this._container.numChildren)
            {
                _local2 = this._container.getChildAt(_local3);
                _local1.push(_local2);
                _local3++;
            };
            _local3 = 0;
            while (_local3 < _local1.length)
            {
                _local2 = _local1[_local3];
                if (this._container.contains(_local2))
                {
                    this._container.removeChild(_local2);
                };
                _local3++;
            };
        }

        public function inspectInList(_arg1:DisplayObject):Boolean
        {
            if (this.objList.length < 1)
            {
                return (false);
            };
            var _local2:uint;
            while (_local2 < this.objList.length)
            {
                if (_arg1 == this.objects[_local2])
                {
                    return (true);
                };
                _local2++;
            };
            return (false);
        }

        private function removeObjForArr(_arg1:Array, _arg2:Object):void
        {
            this.objects[_arg2] = null;
            var _local3:int;
            while (_local3 < _arg1.length)
            {
                if (_arg2 == _arg1[_local3])
                {
                    _arg1.splice(_local3, 1);
                    return;
                };
                _local3++;
            };
        }

        private function ObjONArr(_arg1:Array, _arg2:Object):Boolean
        {
            var _local3:Boolean;
            var _local4:int;
            while (_local4 < _arg1.length)
            {
                if (_arg2 == _arg1[_local4])
                {
                    _local3 = true;
                    break;
                };
                _local4++;
            };
            return (_local3);
        }


    }
}//package com.snake.managers
