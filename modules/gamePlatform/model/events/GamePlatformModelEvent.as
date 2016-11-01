package modules.gamePlatform.model.events
{
    import flash.events.*;
    import modules.gamePlatform.model.vo.*;
    import modules.*;

    public class GamePlatformModelEvent extends Event 
    {

        public static var WAIT_GOTO_GAME:String = "waitGotoGame";
        public static var GOTO_GAME:String = "gotoGame";
        public static var GOTO_GAME_END:String = "gotoGameEnd";
        public static var GAME_START_LINK:String = "gameStartLink";
        public static var OLD_GAME_CLOSE_LINK:String = "oldGameCloseLink";
        public static var GOTO_PAGE:String = "gotoPage";
        public static var GOTO_PAGE_END:String = "gotoPageEnd";
        public static var GAME_CLASS_LOADEND:String = "gameClassLoadend";
        public static var CONFING_INIT:String = "confingInit";
        public static var SHOW_ERROR:String = "showError";
        public static var GAME_NEW:String = "gameNew";
        public static var UP_LANGUAGE:String = "upLanguage";
        public static var GAME_STATE_LIST:String = "gameStateList";
        public static var GAME_STATE:String = "gameState";
        public static var GAME_FARMER:String = "gameFarmer";
        public static var GAME_HISTORY_LIST:String = "gameHistoryList";
        public static var GAME_USER_SEAT_LIST:String = "gameUserSeatList";
        public static var GAME_HISTORY:String = "gameHistory";
        public static var SHOW_SYSTEM_PANEL:String = "showSystemPanel";
        public static var UP_SCREENSTATE:String = "up_screenState";
        public static var UP_StageReSize:String = "up_stageReSize";
        public static var CONTAINER_RESIZE:String = "containerResize";
        public static var PLAY_GENERAL_SOUND:String = "PlayGeneralSound_gamePlatform";
        public static var SHOW_JOURNALINGPANEL:String = "showJournalingPanel_gamePlatform";
        public static var SHOW_RESULTPANEL:String = "showResultpanel_gamePlatform";
        public static var UP_GAME_NOTICE:String = "up_gameNotice_gamePlatform";
        public static var SHOW_EDITPASSWORDPANEL:String = "showEditpasswordpanel_gamePlatform";
        public static var SHOW_EDITNICKNAMEPANEL:String = "showEditNickNamePanel_gamePlatform";
        public static var GAME_OTHER_USER_LOGIN:String = "gameOtherUserLogin_gamePlatform";
        public static var SHOW_GROUP_USER_SEAT_Panel:String = "showGroupUserSeatPanel_gamePlatform";
        public static var HIDE_GROUP_USER_SEAT_Panel:String = "hideGroupUserSeatPanel_gamePlatform";
        public static var REFRESH_MONEY_RESULT:String = "refersh_money_result_gamePlatform";
        public static var SHOW_GAME_LEFT_LIST:String = "showGameLeftList_gamePlatform";

        public var pageName:String;
        public var game:IGameModule;
        public var table:GameTableVO;
        public var data:Object;

        public function GamePlatformModelEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false)
        {
            super(_arg1, _arg2, _arg3);
        }

        override public function clone():Event
        {
            var _local1:GamePlatformModelEvent = new GamePlatformModelEvent(type, bubbles, cancelable);
            _local1.pageName = this.pageName;
            _local1.game = this.game;
            _local1.table = this.table;
            _local1.data = this.data;
            return (_local1);
        }


    }
}//package modules.gamePlatform.model.events
