package modules
{
    import org.robotlegs.core.*;
    import org.robotlegs.utilities.modular.core.*;
    import modules.gamePlatform.model.vo.*;

    public interface IGameModule extends IModule 
    {

        function cloesLink(_arg1:GameTableVO):void;
        function startLink(_arg1:GameTableVO, _arg2:IInjector):void;

    }
}//package modules
