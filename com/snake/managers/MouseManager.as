package com.snake.managers
{
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import flash.ui.*;

    public class MouseManager extends EventDispatcher 
    {

        private static var instance:MouseManager;
        private static var stageDic:Dictionary = new Dictionary();
        public static var MOUSESTYLEOUT:String = "mouseStyleOut";
        public static var MOUSESTYLEOVER:String = "mouseStyleOver";

        private var _stage:Stage;
        public var _mouseStyle:DisplayObject;
        private var showTimer:Timer;
        private var currentObj:InteractiveObject;
        private var objects:Dictionary;
        private var _default:Object;

        public function MouseManager(_arg1:IEventDispatcher=null)
        {
            this._default = {
                "mouseStyle":null,
                "hide":true
            };
            super(_arg1);
            this.objects = new Dictionary();
            this.showTimer = new Timer(10, 0);
            this.showTimer.addEventListener(TimerEvent.TIMER, this.triggTimeConplete);
        }

        public static function getInstance(_arg1:Stage=null):MouseManager
        {
            var _local2:MouseManager;
            if (_arg1 == null)
            {
                if (instance == null)
                {
                    instance = new (MouseManager)();
                };
                return (instance);
            };
            if (stageDic[_arg1] != null)
            {
                return ((stageDic[_arg1] as MouseManager));
            };
            _local2 = new (MouseManager)();
            _local2.stage = _arg1;
            stageDic[_arg1] = _local2;
            return (_local2);
        }


        public function set stage(_arg1:Stage):void
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

        public function get stage():Stage
        {
            return (this._stage);
        }

        public function get dmouseStyle():DisplayObject
        {
            return (this._default.mouseStyle);
        }

        public function get dmouseHit():Boolean
        {
            return (this._default.hide);
        }

        public function setDefaultStyle(_arg1:Stage, _arg2:DisplayObject, _arg3:Boolean=true):void
        {
            if (!this.stage)
            {
                this.stage = _arg1;
            };
            if (this._default.mouseStyle == _arg2)
            {
                return;
            };
            this._default.hide = _arg3;
            if (this.dmouseStyle != null)
            {
                this.dmouseStyle.removeEventListener(Event.ENTER_FRAME, this.ENTER_FRAME);
                if (((_arg1) && (_arg1.contains(this.dmouseStyle))))
                {
                    _arg1.removeChild(this.dmouseStyle);
                };
            };
            this._default.mouseStyle = _arg2;
            if (this._default.mouseStyle)
            {
                if (((((_arg1) && (this._default.mouseStyle))) && (!(_arg1.contains(this._default.mouseStyle)))))
                {
                    _arg1.addChild(this._default.mouseStyle);
                };
                if (this.dmouseHit)
                {
                    Mouse.hide();
                }
                else
                {
                    Mouse.show();
                };
                this._default.mouseStyle.addEventListener(Event.ENTER_FRAME, this.ENTER_FRAME);
            }
            else
            {
                this._default.hide = false;
            };
        }

        private function ENTER_FRAME(_arg1:Event):void
        {
            if (this.stage)
            {
                this.dmouseStyle.x = this.stage.mouseX;
                this.dmouseStyle.y = this.stage.mouseY;
            };
        }

        public function getMouseStyle(_arg1:DisplayObject):DisplayObject
        {
            if (((!((this.objects[_arg1] == null))) && (!((this.objects[_arg1].mouseStyle == null)))))
            {
                return (this.objects[_arg1].mouseStyle);
            };
            return (null);
        }

        public function getMouseObj(_arg1:DisplayObject):Object
        {
            if (this.objects[_arg1] != null)
            {
                return (this.objects[_arg1]);
            };
            return (null);
        }

        public function setMouseObjHide(_arg1:DisplayObject, _arg2:Boolean):Object
        {
            var _local3:Object;
            if (this.objects[_arg1] != null)
            {
                _local3 = this.objects[_arg1];
                _local3.hide = _arg2;
                if (((this.currentObj) && ((this.currentObj == _arg1))))
                {
                    if (_local3.hide)
                    {
                        Mouse.hide();
                    }
                    else
                    {
                        Mouse.show();
                    };
                };
                return (_local3);
            };
            return (null);
        }

        public function push(_arg1:DisplayObject, _arg2:DisplayObject, _arg3:Boolean=true):void
        {
            var _local4:Object;
            if ((_arg1 is InteractiveObject))
            {
                if (((((!((this.stage == null))) && (!((_arg1.stage == null))))) && (!((_arg1.stage == this.stage)))))
                {
                    throw (new Error("#001 -(场景不匹配,一般发生在AIR情况下)"));
                };
                if (!_arg2)
                {
                    throw (new Error("#002 -(不能使用空对象作为鼠标样式)"));
                };
                if (this.objects[_arg1] == null)
                {
                    if ((((this.stage == null)) && (_arg1.stage)))
                    {
                        this.stage = _arg1.stage;
                    };
                    this.objects[_arg1] = new Object();
                    this.objects[_arg1].mouseStyle = _arg2;
                    this.objects[_arg1].hide = _arg3;
                    if ((this.objects[_arg1].mouseStyle is InteractiveObject))
                    {
                        InteractiveObject(this.objects[_arg1].mouseStyle).mouseEnabled = false;
                    };
                    _arg1.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHanlder);
                    _arg1.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutHanlder);
                    DisplayObject(_arg1).addEventListener(Event.REMOVED_FROM_STAGE, this.mouseOutHanlder);
                }
                else
                {
                    _local4 = this.objects[_arg1];
                    if (((_arg1) && (this.stage)))
                    {
                        if (this.stage.contains(_local4.mouseStyle))
                        {
                            this.stage.removeChild(_local4.mouseStyle);
                            this.stage.addChild(_arg2);
                        };
                    };
                    _local4.hide = _arg3;
                    _local4.mouseStyle = _arg2;
                    if ((_local4.mouseStyle is InteractiveObject))
                    {
                        InteractiveObject(_local4.mouseStyle).mouseEnabled = false;
                    };
                };
            };
        }

        public function remove(_arg1:DisplayObject):void
        {
            var _local2:Object;
            if (((!((this.objects[_arg1] == null))) && (_arg1)))
            {
                InteractiveObject(_arg1).removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHanlder);
                InteractiveObject(_arg1).removeEventListener(MouseEvent.MOUSE_OUT, this.mouseOutHanlder);
                _local2 = this.objects[_arg1];
                if (((_arg1) && (this.stage)))
                {
                    if (this.stage.contains(_local2.mouseStyle))
                    {
                        this.stage.removeChild(_local2.mouseStyle);
                    };
                    _arg1.dispatchEvent(new Event(MouseManager.MOUSESTYLEOUT));
                };
                if (this.dmouseStyle == null)
                {
                    Mouse.show();
                }
                else
                {
                    Mouse.hide();
                    this.stage.addChild(this.dmouseStyle);
                };
                this.showTimer.stop();
                this.objects[_arg1] = null;
            };
        }

        private function mouseOverHanlder(_arg1:MouseEvent):void
        {
            var _local2:Object;
            var _local3:int;
            var _local4:int;
            this.currentObj = InteractiveObject(_arg1.currentTarget);
            if (this.currentObj.stage)
            {
                if ((((this.stage == null)) && (this.currentObj.stage)))
                {
                    this.stage = this.currentObj.stage;
                };
                if (((((this.stage) && (this.dmouseStyle))) && (this.stage.contains(this.dmouseStyle))))
                {
                    this.stage.removeChild(this.dmouseStyle);
                };
                this.showTimer.start();
                _local2 = this.objects[this.currentObj];
                this._mouseStyle = (_local2.mouseStyle as DisplayObject);
                if (_local2.hide)
                {
                    Mouse.hide();
                }
                else
                {
                    Mouse.show();
                };
                if (this.currentObj.stage)
                {
                    _local3 = this.currentObj.stage.mouseX;
                    _local4 = this.currentObj.stage.mouseY;
                    this._mouseStyle.x = _local3;
                    this._mouseStyle.y = _local4;
                };
                this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stageMovie);
                this.currentObj.stage.addChildAt(this._mouseStyle, this.currentObj.stage.numChildren);
                this.currentObj.dispatchEvent(new Event(MouseManager.MOUSESTYLEOVER));
            };
            _arg1.stopPropagation();
        }

        private function mouseOutHanlder(_arg1:Event=null):void
        {
            if (_arg1.target != this.currentObj)
            {
                return;
            };
            if (((this.currentObj) && (this.currentObj.stage)))
            {
                if ((((this.stage == null)) && (this.currentObj.stage)))
                {
                    this.stage = this.currentObj.stage;
                };
                if (this.currentObj.stage.contains(this._mouseStyle))
                {
                    this.currentObj.stage.removeChild(this._mouseStyle);
                };
                this.currentObj.dispatchEvent(new Event(MouseManager.MOUSESTYLEOUT));
            };
            if (this.dmouseStyle == null)
            {
                Mouse.show();
            }
            else
            {
                if (this.dmouseHit)
                {
                    Mouse.hide();
                }
                else
                {
                    Mouse.show();
                };
                this.stage.addChild(this.dmouseStyle);
            };
            this.currentObj = null;
            this.showTimer.stop();
            _arg1.stopPropagation();
        }

        private function stageMovie(_arg1:MouseEvent):void
        {
            var _local2:Boolean;
            if ((this.currentObj is DisplayObjectContainer))
            {
                _local2 = DisplayObjectContainer(this.currentObj).contains((_arg1.target as DisplayObject));
            };
            if (((!((this.currentObj == _arg1.target))) && (!(_local2))))
            {
                if (((this.currentObj) && (this.currentObj.stage)))
                {
                    if ((((this.stage == null)) && (this.currentObj.stage)))
                    {
                        this.stage = this.currentObj.stage;
                    };
                    if (this.currentObj.stage.contains(this._mouseStyle))
                    {
                        this.currentObj.stage.removeChild(this._mouseStyle);
                    };
                    this.currentObj.dispatchEvent(new Event(MouseManager.MOUSESTYLEOUT));
                };
                if (this.dmouseStyle == null)
                {
                    Mouse.show();
                }
                else
                {
                    if (this.dmouseHit)
                    {
                        Mouse.hide();
                    }
                    else
                    {
                        Mouse.show();
                    };
                    this.stage.addChild(this.dmouseStyle);
                };
                this.currentObj = null;
                this.showTimer.stop();
                this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.stageMovie);
            };
            _arg1.stopPropagation();
        }

        private function triggTimeConplete(_arg1:TimerEvent):void
        {
            var _local2:int;
            var _local3:int;
            if (this.currentObj.stage)
            {
                if (((this._mouseStyle) && (this.currentObj.stage.contains(this._mouseStyle))))
                {
                    this.currentObj.stage.setChildIndex(this._mouseStyle, (this.currentObj.stage.numChildren - 1));
                };
                _local2 = this.currentObj.stage.mouseX;
                _local3 = this.currentObj.stage.mouseY;
                this._mouseStyle.x = _local2;
                this._mouseStyle.y = _local3;
            };
        }


    }
}//package com.snake.managers
