package modules.gamePlatform.model.vo
{
    import flash.events.*;

    public class PaiJiuGameTableVO extends GameTableVO 
    {

        public function PaiJiuGameTableVO(_arg1:IEventDispatcher=null)
        {
            super(_arg1);
            _gameType = "paijiu";
            _gameClassName = "modules.PaiJiu.PaiJiuModule";
            _url = "modules/paijiu/PaiJiuModule.swf";
        }

    }
}//package modules.gamePlatform.model.vo
