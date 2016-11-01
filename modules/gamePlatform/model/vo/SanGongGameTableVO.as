package modules.gamePlatform.model.vo
{
    import flash.events.*;

    public class SanGongGameTableVO extends GameTableVO 
    {

        public function SanGongGameTableVO(_arg1:IEventDispatcher=null)
        {
            super(_arg1);
            _gameType = "sangong";
            _gameClassName = "modules.sangong.SanGongModule";
            _url = "modules/sangong/SanGongModule.swf";
        }

    }
}//package modules.gamePlatform.model.vo
