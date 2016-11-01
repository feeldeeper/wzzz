package 
{
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;
    import flash.geom.*;

    public class DebugOutput 
    {

        private static var dic:Dictionary = new Dictionary();
        public static var ui:DebugOutputUI;
        private static var stage:Stage;
        private static var pageLenght:uint = 10;
        private static var key:uint = 113;
        private static var ctrlKey:Boolean = false;


        public static function getDic():Dictionary
        {
            return (dic);
        }

        public static function add(... _args):void
        {
            if (_args.length > 1)
            {
                push("default", _args);
            }
            else
            {
                push("default", _args[0]);
            };
        }

        public static function pushXML(_arg1:String, _arg2):void
        {
            var _local3 = "";
            var _local4 = (XML(_arg2).toXMLString() + "\n");
            _local4 = _local4.replace(/[<]+/g, "&lt;");
            _local4 = _local4.replace(/[>]+/g, "&gt;");
            _local3 = (_local3 + _local4);
            push(_arg1, _local3);
        }

        public static function push(_arg1:String, _arg2):void
        {
            if (!dic[_arg1])
            {
                dic[_arg1] = new Array();
                if (ui)
                {
                    ui.upType();
                };
            };
            var _local3:Array = dic[_arg1];
            var _local4:Date = new Date();
            var _local5 = (((((((((((((('<FONT size="12" COLOR="#ff0000">' + _local4.fullYear) + "/") + (_local4.monthUTC + 1)) + "/") + _local4.dateUTC) + "/") + _local4.hours) + "/") + _local4.minutes) + "/") + _local4.seconds) + "/") + _local4.milliseconds) + "</FONT>:\n");
            if ((_arg2 is Array))
            {
                _local5 = (_local5 + ((_arg2 as Array).join(",") + "\n"));
            }
            else
            {
                _local5 = (_local5 + (_arg2.toString() + "\n"));
            };
            if (_local3.length > pageLenght)
            {
                dic[_arg1] = new Array();
                _local3 = dic[_arg1];
            };
            if (_local3[0] == null)
            {
                _local3[0] = new Array();
            };
            if ((_local3[(_local3.length - 1)] as Array).length > 20)
            {
                _local3.push(new Array());
            };
            (_local3[(_local3.length - 1)] as Array).push(_local5);
            if (ui)
            {
                ui.upData();
            };
        }

        public static function clearType(_arg1:String):void
        {
            if (!dic[_arg1])
            {
                return;
            };
            dic[_arg1] = new Array();
            var _local2:Array = dic[_arg1];
            _local2[0] = new Array();
            if (ui)
            {
                ui.upData();
            };
        }

        public static function clear():void
        {
            if (dic)
            {
                dic = null;
            };
            dic = new Dictionary();
        }

        public static function setLength(_arg1:uint):void
        {
            pageLenght = _arg1;
        }

        public static function getLength():uint
        {
            return (pageLenght);
        }

        public static function setKeyCode(_arg1:uint):void
        {
            key = _arg1;
        }

        public static function setStage(_arg1:Stage):void
        {
            if (stage)
            {
                return;
            };
            stage = _arg1;
            stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            stage.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
        }

        private static function mouseDown(_arg1:MouseEvent):void
        {
            if (((ctrlKey) && (new Rectangle(0, 0, 10, 10).contains(_arg1.stageX, _arg1.stageY))))
            {
                if (!ui)
                {
                    show();
                }
                else
                {
                    if (stage.contains(ui))
                    {
                        hit();
                    }
                    else
                    {
                        show();
                    };
                };
            };
        }

        private static function onFocusOut(_arg1:FocusEvent):void
        {
            ctrlKey = false;
        }

        private static function onKeyDown(_arg1:KeyboardEvent):void
        {
            if (!stage)
            {
                return;
            };
            if ((((_arg1.keyCode == key)) && ((_arg1.ctrlKey == true))))
            {
                if (!ui)
                {
                    show();
                }
                else
                {
                    if (stage.contains(ui))
                    {
                        hit();
                    }
                    else
                    {
                        show();
                    };
                };
            }
            else
            {
                if ((((((_arg1.keyCode == 112)) || ((_arg1.keyCode == 116)))) && ((_arg1.ctrlKey == true))))
                {
                    if (!ui)
                    {
                        show();
                    }
                    else
                    {
                        if (stage.contains(ui))
                        {
                            hit();
                        }
                        else
                        {
                            show();
                        };
                    };
                }
                else
                {
                    if ((((_arg1.keyCode == 114)) && ((_arg1.ctrlKey == true))))
                    {
                        if (ui)
                        {
                            ui.windowMaxMin();
                        };
                    };
                };
            };
            if (_arg1.ctrlKey == true)
            {
                ctrlKey = true;
            }
            else
            {
                ctrlKey = false;
            };
        }

        private static function onKeyUp(_arg1:KeyboardEvent):void
        {
            ctrlKey = false;
        }

        public static function setSize(_arg1:Number, _arg2:Number):void
        {
            if (!stage)
            {
                return;
            };
            if (!ui)
            {
                ui = new DebugOutputUI();
                ui.upType();
                ui.upData();
                ui.setSize(_arg1, _arg2);
            };
        }

        public static function show():void
        {
            if (!stage)
            {
                return;
            };
            if (!ui)
            {
                ui = new DebugOutputUI();
                ui.upType();
                ui.upData();
            };
            stage.addChild(ui);
            ui.x = 0;
            ui.y = 0;
        }

        public static function hit():void
        {
            if (((!(stage)) || (!(ui))))
            {
                return;
            };
            stage.removeChild(ui);
        }


    }
}//package 

import flash.events.*;
import flash.display.*;
import flash.text.*;
import flash.utils.*;
import flash.geom.*;

class DebugOutputUI extends Sprite 
{

    /*private*/ var typeArr:Array;
    /*private*/ var typeBtnArr:Array;
    /*private*/ var type:String;
    /*private*/ var top:Sprite;
    /*private*/ var topBg:Sprite;
    /*private*/ var _width:Number = 250;
    /*private*/ var _height:Number = 200;
    /*private*/ var titleText:TextField;
    /*private*/ var nav:Sprite;
    /*private*/ var window:Sprite;
    /*private*/ var wtext:TextField;
    /*private*/ var htext:TextField;
    /*private*/ var bottom:Sprite;
    /*private*/ var bottomBtn:MovieClip;
    /*private*/ var pageNum:int = 0;
    /*private*/ var dataArr:Array;
    /*private*/ var pageText:TextField;
    /*private*/ var infoTxt:TextField;
    /*private*/ var infoScrollBar:Sprite;
    /*private*/ var infoScrollSlider:Sprite;
    /*private*/ var infoScrollBg:Sprite;
    /*private*/ var infoPanel:Sprite;
    /*private*/ var bg:Sprite;
    /*private*/ var fixedBool:Boolean = true;
    /*private*/ var windowMaxMinBool:Boolean = false;

    public function DebugOutputUI()
    {
        this.top = new Sprite();
        this.topBg = new Sprite();
        this.nav = new Sprite();
        this.window = new Sprite();
        this.bottom = new Sprite();
        this.infoScrollBar = new Sprite();
        this.infoScrollSlider = new Sprite();
        this.infoScrollBg = new Sprite();
        this.infoPanel = new Sprite();
        this.bg = new Sprite();
        super();
        addChild(this.bg);
        this.initTop();
        this.initNav();
        this.initWindow();
        this.initBottom();
        this.initInfoPanel();
        this.upSize();
    }

    /*private*/ function initInfoPanel():void
    {
        var _local1:MovieClip;
        addChild(this.infoPanel);
        _local1 = this.foundBtn("<<", 16, 16);
        _local1.addEventListener(MouseEvent.CLICK, this.ppBtn);
        this.infoPanel.addChild(_local1);
        _local1 = this.foundBtn("<", 16, 16);
        _local1.x = 18;
        _local1.addEventListener(MouseEvent.CLICK, this.ppBtn);
        this.infoPanel.addChild(_local1);
        _local1 = this.foundBtn(">", 16, 16);
        _local1.addEventListener(MouseEvent.CLICK, this.ppBtn);
        _local1.x = 115;
        this.infoPanel.addChild(_local1);
        _local1 = this.foundBtn(">>", 16, 16);
        _local1.x = 133;
        _local1.addEventListener(MouseEvent.CLICK, this.ppBtn);
        this.infoPanel.addChild(_local1);
        _local1 = this.foundBtn("clear", 30, 16);
        _local1.x = 152;
        _local1.addEventListener(MouseEvent.CLICK, this.clearFun);
        this.infoPanel.addChild(_local1);
        this.fixedBool = true;
        _local1 = this.foundBtn("▼", 16, 16);
        _local1.x = 187;
        _local1.addEventListener(MouseEvent.CLICK, this.fixedFun);
        this.infoPanel.addChild(_local1);
        this.pageText = this.foundText("--/--", 80, 10, false, false, 16);
        this.pageText.x = 42;
        this.pageText.autoSize = TextFieldAutoSize.CENTER;
        this.infoPanel.addChild(this.pageText);
        this.infoTxt = this.foundText("....", 100, 12, true, true, 16);
        this.infoTxt.border = true;
        this.infoTxt.borderColor = 0;
        this.infoTxt.wordWrap = true;
        addChild(this.infoTxt);
        addChild(this.infoScrollBar);
        this.infoScrollBar.addChild(this.infoScrollBg);
        this.infoScrollBg.graphics.beginFill(0, 0.5);
        this.infoScrollBg.graphics.drawRect(0, 0, 12, 100);
        this.infoScrollBar.addChild(this.infoScrollSlider);
        this.infoScrollSlider.graphics.beginFill(0, 0.5);
        this.infoScrollSlider.graphics.drawRect(0, 0, 10, 30);
        this.infoScrollSlider.x = 1;
        this.infoScrollSlider.addEventListener(MouseEvent.MOUSE_DOWN, this.sliderDown);
        this.infoScrollSlider.buttonMode = true;
    }

    /*private*/ function sliderDown(_arg1:MouseEvent):void
    {
        stage.addEventListener(MouseEvent.MOUSE_UP, this.sliderUp);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.sliderMovie);
        this.infoScrollSlider.startDrag(false, new Rectangle(1, 0, 0, (this.infoScrollBg.height - this.infoScrollSlider.height)));
    }

    /*private*/ function sliderMovie(_arg1:MouseEvent):void
    {
        this.upSliderToTextShow();
    }

    /*private*/ function upTextToSliderShow():void
    {
        var _local1:Number = (this.infoScrollBg.height - this.infoScrollSlider.height);
        var _local2:Number = (this.infoTxt.scrollV / this.infoTxt.maxScrollV);
        if (_local2 < 0.95)
        {
            this.infoScrollSlider.y = ((_local2 * _local1) >> 0);
        }
        else
        {
            this.infoScrollSlider.y = _local1;
        };
    }

    /*private*/ function upSliderToTextShow():void
    {
        var _local1:Number = (this.infoScrollBg.height - this.infoScrollSlider.height);
        var _local2:Number = this.infoScrollSlider.y;
        if ((_local2 / _local1) < 0.95)
        {
            this.infoTxt.scrollV = ((this.infoTxt.maxScrollV * _local2) / _local1);
        }
        else
        {
            this.infoTxt.scrollV = this.infoTxt.maxScrollV;
        };
    }

    /*private*/ function sliderUp(_arg1:MouseEvent):void
    {
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.sliderUp);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.sliderMovie);
        this.infoScrollSlider.stopDrag();
    }

    /*private*/ function fixedFun(_arg1:MouseEvent):void
    {
        var _local2:MovieClip = (_arg1.target as MovieClip);
        var _local3:TextField = (_local2.text as TextField);
        if (this.fixedBool)
        {
            this.fixedBool = false;
            _local3.text = "▲";
        }
        else
        {
            this.fixedBool = true;
            _local3.text = "▼";
        };
    }

    /*private*/ function initBottom():void
    {
        addChild(this.bottom);
        this.bottomBtn = this.foundBtn(">", 16, 16);
        this.bottomBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.startDragWindowSize);
        this.bottomBtn.text.x = 2;
        addChild(this.bottomBtn);
    }

    /*private*/ function startDragWindowSize(_arg1:MouseEvent):void
    {
        if (this.windowMaxMinBool)
        {
            return;
        };
        stage.addEventListener(MouseEvent.MOUSE_UP, this.stopDragWindow);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.moveWindow);
        this.bottomBtn.startDrag(false, new Rectangle((250 - 16), (200 - 16), stage.stageWidth, stage.stageHeight));
    }

    /*private*/ function moveWindow(_arg1:MouseEvent):void
    {
        graphics.clear();
        graphics.beginFill(0, 0);
        graphics.lineStyle(0.1, 0, 0.5);
        graphics.drawRect(0, 0, (this.bottomBtn.x + 16), (this.bottomBtn.y + 16));
    }

    /*private*/ function stopDragWindow(_arg1:MouseEvent):void
    {
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.stopDragWindow);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveWindow);
        graphics.clear();
        this.bottomBtn.stopDrag();
        var _local2:int = (this.bottomBtn.x + 16);
        var _local3:int = (this.bottomBtn.y + 16);
        this.setSize(_local2, _local3);
    }

    /*private*/ function initTop():void
    {
        addChild(this.top);
        this.top.alpha = 0.8;
        this.topBg.graphics.beginFill(0xFFFFFF, 0.6);
        this.topBg.graphics.lineStyle(0.1, 0x515151);
        this.topBg.graphics.drawRect(0, 0, 100, 22);
        this.top.addChild(this.topBg);
        this.topBg.addEventListener(MouseEvent.MOUSE_DOWN, this.stratDargFun);
        this.titleText = this.foundText("debug", 40, 10, false);
        this.titleText.x = (this.titleText.y = 3);
        this.top.addChild(this.titleText);
    }

    /*private*/ function initNav():void
    {
        this.nav.x = 100;
        addChild(this.nav);
    }

    /*private*/ function initWindow():void
    {
        var text:TextField;
        var btn:MovieClip;
        this.window.y = 3;
        addChild(this.window);
        text = this.foundText("w", 12, 10, false, false);
        text.x = 0;
        this.window.addChild(text);
        this.wtext = this.foundText("100", 35, 10, true, true);
        this.wtext.type = TextFieldType.INPUT;
        this.wtext.x = 14;
        this.wtext.height = 16;
        this.wtext.background = true;
        this.wtext.backgroundColor = 0xEAEAEA;
        this.wtext.border = true;
        this.wtext.borderColor = 0x454545;
        this.window.addChild(this.wtext);
        text = this.foundText("h", 12, 10, false, false);
        text.x = 53;
        this.window.addChild(text);
        this.htext = this.foundText("100", 35, 10, true, true);
        this.htext.type = TextFieldType.INPUT;
        this.htext.x = 66;
        this.htext.height = 16;
        this.htext.background = true;
        this.htext.backgroundColor = 0xEAEAEA;
        this.htext.border = true;
        this.htext.borderColor = 0x454545;
        this.window.addChild(this.htext);
        btn = this.foundBtn("r", 15, 15, "r");
        btn.text.y = -2;
        btn.text.x = 3;
        btn.x = 104;
        this.window.addChild(btn);
        btn.addEventListener(MouseEvent.CLICK, this.reSize);
        btn = this.foundBtn("m", 15, 15, "r");
        btn.text.y = -2;
        btn.text.x = 3;
        btn.x = 121;
        btn.bool = false;
        this.window.addChild(btn);
        btn.addEventListener(MouseEvent.CLICK, function ():void
        {
            windowMaxMin();
        });
        btn = this.foundBtn("x", 15, 15, "r");
        btn.text.y = -2;
        btn.text.x = 3;
        btn.x = 137;
        this.window.addChild(btn);
        btn.addEventListener(MouseEvent.CLICK, function ():void
        {
            hit();
        });
    }

    /*private*/ function reSize(_arg1:MouseEvent):void
    {
        this.setSize(Number(this.wtext.text), Number(this.htext.text));
    }

    /*private*/ function stratDargFun(_arg1:MouseEvent):void
    {
        if (this.windowMaxMinBool)
        {
            return;
        };
        stage.addEventListener(MouseEvent.MOUSE_UP, this.stopDargFun);
        this.startDrag();
    }

    /*private*/ function stopDargFun(_arg1:MouseEvent):void
    {
        if (!stage)
        {
            return;
        };
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.stopDargFun);
        this.stopDrag();
    }

    /*private*/ function foundText(_arg1:String, _arg2:Number=100, _arg3:int=10, _arg4:Boolean=true, _arg5:Boolean=false, _arg6:Number=16):TextField
    {
        var _local7:TextField = new TextField();
        _local7.setTextFormat(new TextFormat(null, _arg3));
        _local7.selectable = _arg5;
        _local7.mouseEnabled = _arg4;
        _local7.width = _arg2;
        _local7.height = _arg6;
        _local7.text = _arg1;
        return (_local7);
    }

    /*private*/ function foundBtn(_arg1:String="", _arg2:int=100, _arg3:int=16, _arg4=null):MovieClip
    {
        var _local5:MovieClip = new MovieClip();
        var _local6:TextField = this.foundText(_arg1, _arg2, 10, false, false, _arg3);
        _local5.addChild(_local6);
        _local5.text = _local6;
        _local5.data = _arg4;
        _local5.value = _arg1;
        _local5.mouseChildren = false;
        _local5.buttonMode = true;
        _local5.graphics.beginFill(0xCCCCCC);
        _local5.graphics.lineStyle(0.1, 0x515151);
        _local5.graphics.drawRect(0, 0, _arg2, _arg3);
        return (_local5);
    }

    public function show():void
    {
        DebugOutput.show();
        this.setSize(stage.stageWidth, stage.height);
    }

    public function hit():void
    {
        DebugOutput.hit();
    }

    public function upData():void
    {
        if (!this.dataDic)
        {
            return;
        };
        this.dataArr = (this.dataDic[this.type] as Array);
        this.upPage();
    }

    public function upPage():void
    {
        if (((!(this.dataArr)) || ((this.dataArr.length == 0))))
        {
            return;
        };
        if (this.pageNum >= this.dataArr.length)
        {
            this.pageNum = (this.dataArr.length - 1);
        };
        if (this.fixedBool)
        {
            this.pageNum = (this.dataArr.length - 1);
        };
        this.pageText.text = (((this.pageNum + 1) + "/") + this.dataArr.length);
        this.infoTxt.htmlText = (this.dataArr[this.pageNum] as Array).join("");
        if (this.fixedBool)
        {
            this.infoTxt.scrollV = this.infoTxt.maxScrollV;
            this.upTextToSliderShow();
        };
    }

    /*private*/ function ppBtn(_arg1:MouseEvent):void
    {
        var _local2:MovieClip = (_arg1.target as MovieClip);
        var _local3:String = _local2.text.text;
        if (_local3 == "<<")
        {
            this.pageNum = 0;
        }
        else
        {
            if (_local3 == "<")
            {
                this.pageNum = ((((this.pageNum - 1) >= 0)) ? (this.pageNum - 1) : 0);
            }
            else
            {
                if (_local3 == ">")
                {
                    this.pageNum = ((((this.pageNum + 1) < this.dataArr.length)) ? (this.pageNum + 1) : (this.dataArr.length - 1));
                }
                else
                {
                    if (_local3 == ">>")
                    {
                        this.pageNum = (this.dataArr.length - 1);
                    };
                };
            };
        };
        this.upData();
    }

    public function upType():void
    {
        var _local1:TextField;
        var _local3:MovieClip;
        var _local5:*;
        var _local6:int;
        while (this.nav.numChildren > 0)
        {
            this.nav.removeChildAt(0);
        };
        var _local2:uint;
        this.typeArr = new Array();
        var _local4:int;
        for (_local5 in DebugOutput.getDic())
        {
            _local6 = String(_local5).length;
            _local3 = this.foundBtn(String(_local5), ((_local6 * 8) + 3), 16, _local5);
            this.typeArr.push(_local3);
            _local3.x = _local4;
            _local3.text.x = 1;
            _local4 = (_local4 + ((_local6 * 8) + 4));
            this.nav.addChild(_local3);
            _local3.addEventListener(MouseEvent.CLICK, this.btnClick);
        };
        if (((this.typeArr) && (!((this.typeArr[0] == null)))))
        {
            _local3 = this.typeArr[0];
            this.selectType((_local3.data as String));
        };
    }

    /*private*/ function btnClick(_arg1:MouseEvent):void
    {
        var _local2:MovieClip = (_arg1.target as MovieClip);
        this.selectType((_local2.data as String));
    }

    public function selectType(_arg1:String):void
    {
        if (this.titleText)
        {
            this.titleText.text = _arg1;
        };
        this.type = _arg1;
        this.pageNum = 0;
        this.upData();
    }

    public function get dataDic():Dictionary
    {
        return (DebugOutput.getDic());
    }

    /*private*/ function clearFun(_arg1:MouseEvent):void
    {
        DebugOutput.clearType(this.type);
    }

    public function windowMaxMin():void
    {
        if (!this.windowMaxMinBool)
        {
            if (stage)
            {
                this.setSize(stage.stageWidth, stage.stageHeight);
                x = (y = 0);
            };
            this.windowMaxMinBool = true;
        }
        else
        {
            this.setSize(250, 100);
            this.windowMaxMinBool = false;
        };
    }

    public function setSize(_arg1:Number, _arg2:Number):void
    {
        if (((!((_arg1 == this._width))) || (!((_arg2 == this._height)))))
        {
            if (_arg1 != this._width)
            {
                if (_arg1 < 250)
                {
                    _arg1 = 250;
                };
                this._width = _arg1;
            };
            if (_arg2 != this._height)
            {
                if (_arg2 < 200)
                {
                    _arg2 = 200;
                };
                this._height = _arg2;
            };
            this.upSize();
        };
    }

    override public function set height(_arg1:Number):void
    {
        if (_arg1 < 0)
        {
            return;
        };
        this.setSize(this._width, _arg1);
    }

    override public function get height():Number
    {
        return (this._height);
    }

    override public function set width(_arg1:Number):void
    {
        if (_arg1 < 0)
        {
            return;
        };
        this.setSize(_arg1, this._height);
    }

    override public function get width():Number
    {
        return (this._width);
    }

    public function upSize():void
    {
        this.topBg.width = this.width;
        this.window.x = (this.width - 160);
        this.wtext.text = (this.width + "");
        this.htext.text = (this.height + "");
        this.bottom.y = (this.height - 16);
        this.bottomBtn.x = (this.width - 16);
        this.bottomBtn.y = (this.height - 16);
        this.bg.graphics.clear();
        this.bg.graphics.lineStyle(0.1, 0, 0.5);
        this.bg.graphics.beginFill(0xFFFFFF, 0.6);
        this.bg.graphics.drawRect(0, 0, this.width, this.height);
        this.bg.graphics.beginFill(0, 0);
        this.bg.graphics.drawRect(0, (this.height - 16), this.width, 16);
        this.infoPanel.y = 24;
        this.infoPanel.x = (this.width - 220);
        this.infoTxt.y = 43;
        this.infoTxt.width = (this.width - 20);
        this.infoTxt.x = 5;
        this.infoTxt.height = (this.height - ((this.infoTxt.y + 16) + 4));
        this.infoScrollBg.height = this.infoTxt.height;
        this.infoScrollBar.x = ((this.infoTxt.x + this.infoTxt.width) + 2);
        this.infoScrollBar.y = this.infoTxt.y;
        this.nav.x = 5;
        this.nav.y = (this.height - 16);
        this.upTextToSliderShow();
    }


}
