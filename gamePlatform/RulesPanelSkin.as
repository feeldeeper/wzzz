package gamePlatform
{
    import flash.display.*;

    public dynamic class RulesPanelSkin extends MovieClip 
    {

        public var btn_close:SimpleButton;
        public var mc_mask:MovieClip;

        public function RulesPanelSkin()
        {
            addFrameScript(0, this.frame1);
        }

        function frame1()
        {
            stop();
        }


    }
}//package gamePlatform
