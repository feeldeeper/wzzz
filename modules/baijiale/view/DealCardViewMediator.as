package modules.baijiale.view
{
    import modules.baijiale.model.events.*;
    import modules.baijiale.model.*;
    import com.greensock.*;
    import org.robotlegs.mvcs.*;

    public class DealCardViewMediator extends Mediator 
    {

        [Inject]
        public var gameDataModel:GameDataModel;
        [Inject]
        public var baijialeModel:BaijialeModel;


        private function get view():DealCardView
        {
            return ((viewComponent as DealCardView));
        }

        override public function onRegister():void
        {
            addContextListener(GameDataModelEvent.UP_GAME_DEAL, this.upGameDeal);
            addContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            eventDispatcher.addEventListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.gameCloseFun);
            this.view.addToStage();
            this.view.visible = false;
        }

        override public function onRemove():void
        {
            super.onRemove();
            this.gameCloseFun();
            removeContextListener(GameDataModelEvent.UP_GAME_DEAL, this.upGameDeal);
            removeContextListener(GameDataModelEvent.UP_GAMESTATE, this.upGameState);
            eventDispatcher.removeEventListener(BaijialeModelEvent.GAME_SHOW_SERVERLINK, this.gameCloseFun);
        }

        private function upGameState(_arg1:GameDataModelEvent):void
        {
            this.view.upGameState(this.gameDataModel.gameState);
        }

        private function upGameDeal(_arg1:GameDataModelEvent):void
        {
            var _local2:Object;
            var _local3:uint;
            if (uint(this.baijialeModel.currentGameTable.gameid) < 80)
            {
                return;
            };
            if (this.view.gameState == 2)
            {
                this.view.visible = true;
                _local2 = _arg1.data;
                if (_local2 != null)
                {
                    _local3 = (_local2.length - 1);
                    if ((((_local3 == 3)) && ((_local2.dealEnd == false))))
                    {
                        if (_local2.addPokerFlag == false)
                        {
                            eventDispatcher.dispatchEvent(new BaijialeModelEvent(BaijialeModelEvent.GAME_SOUND_PLAYERADDPOKER));
                        }
                        else
                        {
                            eventDispatcher.dispatchEvent(new BaijialeModelEvent(BaijialeModelEvent.GAME_SOUND_BANKADDPOKER));
                        };
                    };
                    if ((((_local3 == 4)) && ((_local2.dealEnd == false))))
                    {
                        eventDispatcher.dispatchEvent(new BaijialeModelEvent(BaijialeModelEvent.GAME_SOUND_BANKADDPOKER));
                    };
                    TweenMax.delayedCall(1, this.view.upGameDeal, [_arg1.data]);
                };
            };
        }

        private function gameCloseFun(_arg1:BaijialeModelEvent=null):void
        {
            this.view.visible = false;
            this.view.dispose();
            TweenMax.killDelayedCallsTo(this.view.upGameDeal);
        }


    }
}//package modules.baijiale.view
