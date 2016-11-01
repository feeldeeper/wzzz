package modules.gamePlatform.view
{
    import flash.display.*;
    import modules.gamePlatform.view.events.*;
    import modules.gamePlatform.model.vo.*;

    public class GameTableView extends Sprite 
    {

        private var _tableVO:GameTableVO;

        public function GameTableView()
        {
            this.initDisplay();
        }

        public function get tableVO():GameTableVO
        {
            return (this._tableVO);
        }

        private function initDisplay():void
        {
        }

        public function setTableVO(_arg1:GameTableVO):void
        {
            this._tableVO = _arg1;
            dispatchEvent(new GameTableViewEvent(GameTableViewEvent.ADD_TABLEVO));
        }

        public function tableWaitGoToGame():void
        {
            if (this.tableVO)
            {
                dispatchEvent(new GameTableViewEvent(GameTableViewEvent.TABLE_WAIT_GOTO_GAME));
            };
        }

        public function dispose():void
        {
        }


    }
}//package modules.gamePlatform.view
