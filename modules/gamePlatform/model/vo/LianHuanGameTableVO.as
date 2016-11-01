package modules.gamePlatform.model.vo
{
    import flash.events.*;

    public class LianHuanGameTableVO extends GameTableVO 
    {

        public function LianHuanGameTableVO(_arg1:IEventDispatcher=null)
        {
            super(_arg1);
            _gameType = "lianhuan";
            _gameClassName = "modules.LianHuan.LianHuanModule";
            _url = "modules/lianhuan/LianHuanModule.swf";
        }

    }
}//package modules.gamePlatform.model.vo
