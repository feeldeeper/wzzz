package com.snake.gamefms
{
    public interface IFMSClient 
    {

        function set fmsBase(_arg1:FMSBase):void;
        function get fmsBase():FMSBase;
        function close():void;
        function fmsCall(_arg1:Object):void;

    }
}//package com.snake.gamefms
