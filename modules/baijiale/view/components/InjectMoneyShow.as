package modules.baijiale.view.components
{
    import flash.display.*;
    import baijiale.*;
    import com.snake.game.*;

    public class InjectMoneyShow extends Sprite 
    {

        private var _type:String;
        private var _skin:Class = null;
        private var chipArrToString:String = "1,2,5,10,20,30,50,100,150,200,300,500,1000,2000,3000,5000,10000,20000,50000,100000,500000,1000000";
        private var _money:uint;
        private var label:MoneyLabelSkinNoFilter;

        public function InjectMoneyShow(_arg1:String="")
        {
            this.label = new MoneyLabelSkinNoFilter();
            super();
            this._type = _arg1;
        }

        public function get skin():Class
        {
            return (this._skin);
        }

        public function set skin(_arg1:Class):void
        {
            this._skin = _arg1;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get money():uint
        {
            return (this._money);
        }

        public function clear():void
        {
            this._money = 0;
            Tools.removeAllChild(this);
        }

        public function setMoney(_arg1:uint):void
        {
            var _local4:MovieClip;
            if (_arg1 == 0)
            {
                this.clear();
                return;
            };
            if (this._money == _arg1)
            {
                return;
            };
            this._money = _arg1;
            Tools.removeAllChild(this);
            var _local2:Array = ChipsUtils.getChipsArr(this.money, this.chipArrToString);
            var _local3:int;
            while (_local3 < _local2.length)
            {
                _local4 = this.createMoney(_local2[_local3]);
                _local4.y = (_local3 * -8);
                addChild(_local4);
                _local3++;
            };
            addChild(this.label);
            this.label.label.text = ("" + this.money);
            if (_local4)
            {
                this.label.y = (_local4.y - 15);
            }
            else
            {
                this.label.y = 0;
            };
        }

        public function addMoney(_arg1:uint):void
        {
            if (_arg1 == 0)
            {
                return;
            };
            this.setMoney((this._money + _arg1));
        }

        public function createMoney(_arg1:uint):MovieClip
        {
            var _local2:MovieClip;
            if (this.skin == null)
            {
                _local2 = new MoneySkin();
            }
            else
            {
                _local2 = new this.skin();
            };
            var _local3:Boolean = ChipsUtils.containChips(_arg1, this.chipArrToString);
            if (_local3)
            {
                _local2.gotoAndStop(("m" + _arg1));
            }
            else
            {
                _local2.gotoAndStop(1);
                _local2["label"].text = (_arg1 + "");
            };
            return (_local2);
        }

        public function showWin():void
        {
            var _local1:Sprite = new Sprite();
            while (this.numChildren > 0)
            {
                _local1.addChild(this.getChildAt(0));
            };
            addChild(_local1);
        }

        public function showLose():void
        {
            var _local1:Sprite = new Sprite();
            while (this.numChildren > 0)
            {
                _local1.addChild(this.getChildAt(0));
            };
            addChild(_local1);
        }


    }
}//package modules.baijiale.view.components
