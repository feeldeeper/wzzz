package modules.gamePlatform.model.vo
{
    import flash.events.*;

    public class BaijialeGameTableVO extends GameTableVO 
    {

        public var tableMax:Number;
        public var tableMin:Number;
        public var telMax:Number;
        public var telMin:Number;
        public var telTieMax:Number;
        public var telPairMax:Number;
        public var telDiffMax:Number;

        public function BaijialeGameTableVO(_arg1:IEventDispatcher=null)
        {
            super(_arg1);
            _gameType = "baijiale";
            _gameClassName = "modules.baijiale.BaijialeModule";
            _url = "BaijialeModule.swf?=0.19";
        }

        override public function setFMSData(_arg1:Object):void
        {
            this.tableMax = Number(_arg1.tableMax);
            this.tableMin = Number(_arg1.tableMin);
            this.telMax = Number(_arg1.telMax);
            this.telMin = Number(_arg1.telMin);
            this.telTieMax = Number(_arg1.telTieMax);
            this.telPairMax = Number(_arg1.telPairMax);
            this.telDiffMax = Number(_arg1.telDiffMax);
			// this.telTieMax = 2000;
            // this.telPairMax = 1000;
			trace("this.telmin"+this.telMin);
			trace("this.telMax"+this.telMax);
            super.setFMSData(_arg1);
        }


    }
}//package modules.gamePlatform.model.vo
