package modules.gamePlatform.model.vo
{
    import flash.events.*;

    public class LunpanGameTableVO extends GameTableVO 
    {

        public function LunpanGameTableVO(_arg1:IEventDispatcher=null)
        {
            super(_arg1);
            _gameType = "lunpan";
            _gameClassName = "modules.lunpan.LunpanModule";
            _url = "modules/lunpan/LunpanModule.swf";
        }

    }
}//package modules.gamePlatform.model.vo
