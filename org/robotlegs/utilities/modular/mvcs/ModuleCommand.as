package org.robotlegs.utilities.modular.mvcs
{
    import flash.events.Event;
    
    import org.robotlegs.mvcs.Command;
    import org.robotlegs.utilities.modular.base.IModuleEvent;
    import org.robotlegs.utilities.modular.core.IModuleCommandMap;
    import org.robotlegs.utilities.modular.core.IModuleEventDispatcher;
    
    public class ModuleCommand extends Command
    {
        [Inject]
        public var moduleEventDispatcher:IModuleEventDispatcher;
        
        [Inject]
        public var moduleCommandMap:IModuleCommandMap;
        
        protected function dispatchToModules(event:IModuleEvent):Boolean
        {
            if(moduleEventDispatcher.hasEventListener(Event(event).type))
                return moduleEventDispatcher.dispatchEvent(Event(event));
            return true;
        }
    }
}