package modules.baijiale
{
    import org.robotlegs.core.*;
    import modules.gamePlatform.model.vo.*;
    import flash.system.*;
    import flash.display.*;
    import org.robotlegs.utilities.modular.core.*;
    import modules.baijiale.model.events.*;

    public class BaijialeModule extends Sprite implements IBaijialeModule 
    {

        protected var context:IModuleContext;

        public function BaijialeModule()
        {
            //Security.allowDomain("*");
            //Security.allowInsecureDomain("*");
        }

        public function dispose():void
        {
        }

        [Inject]
        public function set parentInjector(_arg1:IInjector):void
        {
            this.context = new BaijialeContext(this, true, _arg1);
        }

        public function cloesLink(_arg1:GameTableVO):void
        {
            var _local2:BaijialeModelEvent;
            if (this.context)
            {
                _local2 = new BaijialeModelEvent(BaijialeModelEvent.CLOSE_LINK);
                _local2.table = _arg1;
                this.context.eventDispatcher.dispatchEvent(_local2);
            };
        }

        public function startLink(_arg1:GameTableVO, _arg2:IInjector):void
        {
            if (this.context == null)
            {
                this.context = new BaijialeContext(this, true, _arg2);
            };
            var _local3:BaijialeModelEvent = new BaijialeModelEvent(BaijialeModelEvent.START_LINK);
            _local3.table = _arg1;
            this.context.eventDispatcher.dispatchEvent(_local3);
        }


    }
}//package modules.baijiale
