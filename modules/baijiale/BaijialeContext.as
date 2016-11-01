package modules.baijiale
{
    import org.robotlegs.core.*;
    import flash.display.*;
    import org.robotlegs.base.*;
    import org.robotlegs.utilities.modular.mvcs.*;
    import modules.baijiale.controller.startup.*;

    public class BaijialeContext extends ModuleContext 
    {

        private var isInit:Boolean;

        public function BaijialeContext(_arg1:DisplayObjectContainer, _arg2:Boolean, _arg3:IInjector)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function startup():void
        {
            commandMap.mapEvent(ContextEvent.STARTUP, BaijialeStartupCommand);
            commandMap.mapEvent(ContextEvent.SHUTDOWN, BaijialeShutdownCommand);
            dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
            super.startup();
        }

        override public function dispose():void
        {
            dispatchEvent(new ContextEvent(ContextEvent.SHUTDOWN));
        }


    }
}//package modules.baijiale
