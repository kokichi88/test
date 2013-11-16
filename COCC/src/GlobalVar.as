package 
{
    import component.avatar.controls.*;
    import flash.display.*;

    public class GlobalVar extends Object
    {
        public static var CONTENT_VERSION:String = "10";
        public static var SCREEN_WIDTH:int = 1280;
        public static var SCREEN_HEIGHT:int = 768;
        public static var MAP_WIDTH:int = 5100;
        public static var MAP_HEIGHT:int = 3900;
        public static var sign_user:Number = 21;
        public static var session_id:String = "D1F018988DF9724F927F3FDCB";
        public static var signed_request:String = "D1F018988DF9724F927F3FDCB";
        public static var code:String = "D1F018988DF9724F927F3FDCB";
        public static const GAME_TIMER:String = "game";
        public static var GATEWAY:String = "";
        public static var STATIC_URL:String = "";
        public static const LAYER_BG:int = 0;
        public static const LAYER_GAME:int = 1;
        public static const LAYER_EFFECT:int = 2;
        public static const LAYER_INFO:int = 3;
        public static const LAYER_MOVE:int = 4;
        public static const LAYER_GUI:int = 5;
        public static const LAYER_POPUP:int = 6;
        public static const LAYER_LOADING:int = 7;
        public static const NUM_LAYER:int = 8;
        public static const INIT_SCALE:Number = 0.5;
        public static const MAX_SCALE:Number = 1;
        public static const MIN_SCALE:Number = 0.2;
        public static var state:int = 0;
        public static const STATE_SAFE:int = -1;
        public static const STATE_MYHOME:int = 0;
        public static const STATE_BATTLE:int = 1;
        public static const STATE_FRIEND:int = 2;
        public static const STATE_GUEST:int = 3;
        public static const STATE_REPLAY:int = 4;
        public static const STATE_SINGLE_MAP:int = 5;
        public static const MAX_PARTY:int = 5;
        public static var rootSprite:Sprite;
        public static var stage:Stage;
        public static var mouseState:int = 0;
        public static const NONE_STATE:int = 0;
        public static const MOVE_MAP:int = 1;
        public static const NEW_BUILDING:int = 2;
        public static const MOVE_BUILDING:int = 3;
        public static const CLAN_COST_TO_CREATE:int = 40000;
        public static const CLAN_MAX_MEMBERS:int = 50;
        public static const CLAN_MAX_TYPE:int = 3;
        public static const CLAN_MAX_REQUIRED_TROPIES:int = 3000;
        public static const CLAN_ACTION:Object = {0:[0], 1:[0, 1, 2, 3, 4], 2:[0, 2, 4], 3:[0]};
        public static const CLAN_LEADER:int = 1;
        public static const CLAN_ELDER:int = 2;
        public static const CLAN_MEMBER:int = 3;
        public static const CLAN_ACTION_VISIT:int = 0;
        public static const CLAN_ACTION_PROMOTE_TO_LEADER:int = 1;
        public static const CLAN_ACTION_PROMOTE_TO_ELDER:int = 2;
        public static const CLAN_ACTION_DEMOTE_TO_MEMBER:int = 3;
        public static const CLAN_ACTION_KICK_OUT:int = 4;
        public static const CLAN_ACTION_VIEW:int = 5;
        public static const CLAN_BUTTON_JOIN:int = 0;
        public static const CLAN_BUTTON_CREATE:int = 1;
        public static const CLAN_BUTTON_SEARCH:int = 2;
        public static const CLAN_BUTTON_MINE:int = 3;
        public static const CLAN_MAX_DONATION:int = 5;
        public static const CLAN_TIMEOUT_REQUEST:int = 1200;
        public static const CLAN_NAME_MIN_CHARACTERS:int = 3;
        public static const CLAN_NAME_MAX_CHARACTERS:int = 15;
        public static const CLAN_DESCRIPTION_MAX_CHARACTERS:int = 100;
        public static const POINTS_PER_MAP:int = 10;
        public static const SIDE_QUEST:Object = {0:"TOQ", 1:"MPQ", 2:"SPQ"};
        public static const MAX_QUEST_TYPE:int = 3;
        public static const POSITIVE_COLOR:String = "#60E166";
        public static const NEGATIVE_COLOR:String = "#FF7D7D";
        public static const RED_COLOR:String = "#FF4040";
        public static const ELIXIR_COLOR:String = "#FF00FF";
        public static const GOLD_COLOR:String = "#FFFF00";
        public static const MONEY_COLOR:Object = {Gold:"#FFFF00", Elixir:"#FF00FF", DarkElixir:"#000000", Coin:"#1BFA26", Exp:"#17E6FD"};
        public static const RESOURCE_RANGE:Array = [100, 1000, 10000, 100000, 1000000, 10000000];
        public static const RESOURCE_COST:Array = [2, 10, 50, 250, 1200, 6000];
        public static const TIME_RANGE:Array = [60, 3600, 86400, 604800];
        public static const TIME_COST:Array = [2, 40, 520, 2000];
        public static const SINGLE_MAP_POINTS:Array = [9, 14, 20, 6];
        public static const QUICK_FINISH_TRAINING:String = "ARM";
        public static const QUICK_FINISH_RESEARCH:String = "R&D";
        public static const QUICK_FINISH_NEED_CONFIRM:Boolean = false;
        public static var SHOW_MESSAGE_BOX:Boolean = false;
        public static var animationManager:AnimationManager = new AnimationManager();
        public static const ANIMAL_TIMER:String = "animal";
        public static const URL_THOI_LOAN:String = "http://me.zing.vn/apps/thoiloan";
        public static const URL_FANPAGE_ZINGME:String = "http://me.zing.vn/b/thoiloan.gsn";
        public static const URL_FANPAGE_FACEBOOK:String = "https://www.facebook.com/gamethoiloan";
        public static const URL_SUPPORT:String = "https://docs.google.com/forms/d/1CIg0gyn0_ScTD-8fXXyF4v73fOU4wp-zYz1hZB1Q4hk/viewform?edit_requested=true";
        public static const SUBMIT_TRANS_URL:String = "https://sandbox.direct.pay.zing.vn/chonkenhthanhtoan";
        public static const TRANSID_HEADER:String = "transId";
        public static const APPID_HEADER:String = "appId";
        public static const APPDATA_HEADER:String = "appData";

        public function GlobalVar()
        {
            return;
        }// end function

        public static function get isDebugBuild() : Boolean
        {
            return true;
        }// end function

    }
}
