package modules.gamePlatform.model.vo
{
    public class GameMoneyGroup 
    {

        public var type:String = "";
        private var _moneyTypeGroup:Array;
        private var data:Object;


        public function setMoneyGroup(_arg1:Array, _arg2:Object):void
        {
            this._moneyTypeGroup = _arg1;
            this.data = _arg2;
            var _local3:int;
            while (_local3 < _arg1.length)
            {
                this.data[("m" + _arg1[_local3])] = String(this.data[("c" + _arg1[_local3])]).split(",");
                _local3++;
            };
        }

        public function get moneyTypeGroup():Array
        {
            return (this._moneyTypeGroup.concat(new Array()));
        }

        public function getMoneyGroup(_arg1:String):Array
        {
            return ((this.data[("m" + _arg1)] as Array));
        }


    }
}//package modules.gamePlatform.model.vo
