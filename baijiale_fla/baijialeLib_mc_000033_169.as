package baijiale_fla
{
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import flash.geom.*;
    import fl.text.*;

    public dynamic class baijialeLib_mc_000033_169 extends MovieClip 
    {

        public var __id3_:TCMText;
        public var __checkFontName_:String;
        public var __cacheXMLSettings:Object;

        public function baijialeLib_mc_000033_169()
        {
            super();
            this.__checkFontName_ = "baijiale_fla.Font_0";
            if (!TCMRuntimeManager.checkTLFFontsLoaded(null, this.__checkFontName_, this.__registerTLFFonts))
            {
                addEventListener(Event.FRAME_CONSTRUCTED, TCMRuntimeManager.checkTLFFontsLoaded, false, 1);
            };
            this.__cacheXMLSettings = XML.settings();
            try
            {
                XML.ignoreProcessingInstructions = false;
                XML.ignoreWhitespace = false;
                XML.prettyPrinting = false;
                TCMRuntimeManager.getSingleton().addInstance(this, "__id3_", new Rectangle(0, 0, 44, 14), <tlfTextObject type="Point" editPolicy="readOnly" columnCount="auto" columnGap="20" verticalAlign="top" firstBaselineOffset="auto" paddingLeft="2" paddingTop="2" paddingRight="2" paddingBottom="2" background="false" backgroundColor="#ffffff" backgroundAlpha="1" border="false" borderColor="#000000" borderAlpha="1" borderWidth="1" paddingLock="false" multiline="true" antiAliasType="advanced" embedFonts="true"><TextFlow lineBreak="explicit" locale="zh_CN" whiteSpaceCollapse="preserve" version="2.0.0" xmlns="http://ns.adobe.com/textLayout/2008"><p direction="ltr" paragraphEndIndent="0" paragraphStartIndent="0" textAlign="start" textIndent="0"><span baselineShift="0" color="#ffffff" fontFamily="DFPHeiMedium-UN" fontSize="10" fontStyle="normal" fontWeight="normal" kerning="auto" lineHeight="116.500000%" trackingRight="0.000000%">全屏顯示</span></p></TextFlow></tlfTextObject>
                , null, undefined, 0, 0, "", false, true);
            }
            finally
            {
                XML.setSettings(this.__cacheXMLSettings);
            };
            TCMRuntimeManager.getSingleton().addInstanceComplete(this);
        }

        public function __registerTLFFonts():void
        {
            Font.registerFont(Font_0);
        }


    }
}//package baijiale_fla
