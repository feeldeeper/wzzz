package modules.gamePlatform.view
{
    import flash.events.*;
    import flash.display.*;
    import modules.gamePlatform.model.vo.*;

    public class GameListView extends Sprite 
    {

        private var tableList:Array;
        public var _initTableBool:Boolean = false;
        public var tableW:Number = 542;
        public var tableH:Number = 180;
        public var bjlPanel:Sprite;
        public var lhPanel:Sprite;
        public var sbjlPanel:Sprite;
        public var otherPanel:Sprite;
        public var niuPanel:Sprite;

        public function GameListView()
        {
            this.tableList = [];
            this.bjlPanel = new Sprite();
            this.lhPanel = new Sprite();
            this.sbjlPanel = new Sprite();
            this.otherPanel = new Sprite();
            this.niuPanel = new Sprite();
            super();
            this.initDisplay();
        }

        private function initDisplay():void
        {
        }

        public function get initTableBool():Boolean
        {
            return (this._initTableBool);
        }

        public function initTable(_arg1:Array):void
        {
            if (this.initTableBool)
            {
                return;
            };
            this._initTableBool = true;
            var _local2:GameTableView;
            var _local3:GameTableVO;
            var _local4:uint;
            var _local5:uint;
            while (_local4 < _arg1.length)
            {
                _local3 = (_arg1[_local4] as GameTableVO);
                if (_local3.gameType == "baijiale")
                {
                    _local2 = new GameTableBaijialeView();
                };
                if (_local3.gameType == "longhu")
                {
                    _local2 = new GameTableLonghuView();
                };
                if ((((_local3.gameSubType == "sbjl")) || ((_local3.gameSubType == "slh"))))
                {
                    if (_local2 != null)
                    {
                        _local2.setTableVO(_local3);
                        DebugOutput.add("init Table List:", _local2.tableVO.gameType, ("子类型：" + _local2.tableVO.gameSubType));
                        this.otherPanel.addChild(_local2);
                        _local2.x = (uint((_local5 % 2)) * this.tableW);
                        _local2.y = (((_local5 / 2) >> 0) * this.tableH);
                    };
                    _local2 = null;
                    _local5++;
                };
                _local4++;
            };
            _local4 = 0;
            _local5 = 0;
            while (_local4 < _arg1.length)
            {
                _local3 = (_arg1[_local4] as GameTableVO);
                if ((((_local3.gameSubType == "bjl")) || ((_local3.gameSubType == "lhbjl"))))
                {
                    if (_local3.gameType == "baijiale")
                    {
                        _local2 = new GameTableBaijialeView();
                    };
                    if (_local3.gameType == "comic_bjl")
                    {
                        _local2 = new GameTableComicBJLView();
                    };
                    if (_local2 != null)
                    {
                        _local2.setTableVO(_local3);
                        this.bjlPanel.addChild(_local2);
                        _local2.x = (uint((_local5 % 2)) * this.tableW);
                        _local2.y = (((_local5 / 2) >> 0) * this.tableH);
                    };
                    _local2 = null;
                    _local5++;
                };
                _local4++;
            };
            _local4 = 0;
            _local5 = 0;
            while (_local4 < _arg1.length)
            {
                _local3 = (_arg1[_local4] as GameTableVO);
                if (_local3.gameSubType == "lh")
                {
                    _local2 = new GameTableLonghuView();
                    if (_local2 != null)
                    {
                        _local2.setTableVO(_local3);
                        this.lhPanel.addChild(_local2);
                        _local2.x = (uint((_local5 % 2)) * this.tableW);
                        _local2.y = (((_local5 / 2) >> 0) * this.tableH);
                    };
                    _local2 = null;
                    _local5++;
                };
                _local4++;
            };
            _local4 = 0;
            _local5 = 0;
            while (_local4 < _arg1.length)
            {
                _local3 = (_arg1[_local4] as GameTableVO);
                if ((((_local3.gameType == "nnGame")) || ((_local3.gameType == "daxiao"))))
                {
                    if (_local3.gameType == "nnGame")
                    {
                        _local2 = new GameTableNNGameView();
                    };
                    if (_local3.gameType == "daxiao")
                    {
                        _local2 = new GameTableDaxiaoView();
                    };
                    if (_local2 != null)
                    {
                        _local2.setTableVO(_local3);
                        this.niuPanel.addChild(_local2);
                        _local2.x = (uint((_local5 % 2)) * this.tableW);
                        _local2.y = (((_local5 / 2) >> 0) * 322);
                    };
                    _local2 = null;
                    _local5++;
                };
                _local4++;
            };
            addChild(this.bjlPanel);
            dispatchEvent(new Event("initOK"));
        }

        public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
