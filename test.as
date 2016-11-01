package 
{
    import com.greensock.*;
    import com.greensock.events.*;
    import com.greensock.loading.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    
    import modules.gamePlatform.model.*;
	
	import modules.gamePlatform.view.components.*;
	import modules.gamePlatform.view.*;

    public class test extends MovieClip 
    {
		public function test()
		{
			var _local1:String;
			_local1 = "data/config.txt";
			var _local2:DataLoader = new DataLoader(_local1, {
                "name":"config",
                "onComplete":this.confingComplete,
                "noCache":true
            });
            _local2.load(true);
			
			 
			
			super();
		}
		private function confingComplete(_arg1:LoaderEvent):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("loadComplete");
            };
            this.otherLoad();
        }
		
		private function otherLoad():void
        {
            var _local1:String = (LoaderMax.getContent("config") as String);
            var _local2:FrameHashModel = new FrameHashModel("bfdbdb8f");
            var _local3:String = _local2.decrypt(_local1);
            var _local4:Object = Tools.json_decode(_local3);
			trace(_local4.httpUrl);
			//trace(_local4);
			//trace(JSON10.encode(_local4))
		}
		
	}
	
}