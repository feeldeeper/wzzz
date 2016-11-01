package modules.baijiale.model.events
{
    import modules.gamePlatform.model.vo.*;
    import flash.events.*;

    public class BaijialeModelEvent extends Event 
    {

        public static var CLOSE_LINK:String = "cloesLink_baijiale";
        public static var START_LINK:String = "startLink_baijiale";
        public static var ROOM_GAME_HISTORY:String = "roomGameHistory_baijiale";
        public static var ROOM_GAME_STATE:String = "roomGameState_baijiale";
        public static var GAME_BETING_STATE:String = "game_beting_state_baijiale";
        public static var GAME_SOUND_BANKADDPOKER:String = "game_sound_bankAddPoker_baijiale";
        public static var GAME_SOUND_PLAYERADDPOKER:String = "game_sound_playerAddPoker_baijiale";
        public static var GAME_SOUND_PLAYERBYNAME:String = "game_sound_playerByName_baijiale";
        public static var GAME_INFO_PANEL_SHOW:String = "game_info_panel_show_baijiale";
        public static var UP_SIMULATIONS_PANEL:String = "upSimulationsPanel_baijiale";
        public static var SYSTEM_PANEL:String = "systemPanel_baijiale";
        public static var SEAT_SELECT_PANEL:String = "seatSelectPanel_baijiale";
        public static var GAME_RULES_PANEL:String = "gameRulesPanel_baijiale";
        public static var GAME_RECORD_PANEL:String = "gameRecordPanel_baijiale";
        public static var GAME_SHOW_SERVERLINK:String = "gameShowServerLink_baijiale";
        public static var GAME_HIDE_SERVERLINK:String = "gameHideServerLink_baijiale";
        public static var SHOW_ALL_ROUTE_PANEL:String = "SHOW_ALL_ROUTE_PANEL_baijiale";
        public static var UP_SERVER_LINE_SELECT:String = "upServerLineSelect_baijiale";

        public var table:GameTableVO;
        public var data:Object;

        public function BaijialeModelEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:BaijialeModelEvent = new BaijialeModelEvent(type, bubbles, cancelable);
            _local1.table = this.table;
            _local1.data = this.data;
            return (_local1);
        }


    }
}//package modules.baijiale.model.events
