package gamePlatform
{
    import flash.display.*;
    import flash.text.*;

    public dynamic class LoginSkin extends MovieClip 
    {

        public var loginMc:MovieClip;
        public var text_error:TextField;
        public var loading:MovieClip;

        public function LoginSkin()
        {
            addFrameScript(0, this.frame1);
        }

        function frame1()
        {
            stop();
        }


    }
}//package gamePlatform
