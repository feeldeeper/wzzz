package modules.gamePlatform.model.vo
{
    import flash.events.*;

    public class LonghuGameTableVO extends GameTableVO 
    {

        public var tableMax:Number;
        public var tableMin:Number;
        public var telMax:Number;
        public var telMin:Number;
        public var telTieMax:Number;
        public var telPairMax:Number;

        public function LonghuGameTableVO(_arg1:IEventDispatcher=null)
        {
            super(_arg1);
            _gameType = "longhu";
            _gameClassName = "modules.longhu.LonghuModule";
            _url = "modules/longhu/LonghuModule.swf?=0.14";
        }

        override public function setFMSData(_arg1:Object):void
        {
            this.tableMax = Number(_arg1.tableMax);
            this.tableMin = Number(_arg1.tableMin);
            this.telMax = Number(_arg1.telMax);
            this.telMin = Number(_arg1.telMin);
            this.telTieMax = Number(_arg1.telTieMax);
            this.telPairMax = Number(_arg1.telPairMax);
            super.setFMSData(_arg1);
        }


    }
}//package modules.gamePlatform.model.vo
