package network
{

    public class Command extends Object
    {
        public static const LOGIN:int = 1;
        public static const INFO:int = 2;
        public static const READY:int = 3;
        public static const GET_PLAYER_INFO:int = 1001;
        public static const GET_BUILDING_INFO:int = 1002;
        public static const GET_TROOPER_INFO:int = 1003;
        public static const GET_FRIEND_INFO:int = 1006;
        public static const GET_FRIEND_LIST:int = 1007;
        public static const BUY_RESOURCE:int = 1008;
        public static const FINISH_TUT:int = 1009;
        public static const UPDATE_COIN:int = 1010;
        public static const SET_NAME:int = 1011;
        public static const GET_QUEST_INFO:int = 1012;
        public static const LEVEL_UP:int = 1013;
        public static const CHARGE_CARD:int = 1014;
        public static const GET_CURRENT_TIME:int = 1015;
        public static const RANKING_LIST:int = 1016;
        public static const BUY_SHIELD_TIME:int = 1018;
        public static const UPDATE_MONEY:int = 1019;
        public static const GET_TRANS_ID:int = 1020;
        public static const TRANS_RESULT:int = 1021;
        public static const DISCONNECT:int = 1022;
        public static const GET_TOKEN_FEED:int = 1023;
        public static const GET_FEED_INFO:int = 1024;
        public static const PROMO_G:int = 1025;
        public static const BETA_USER_PROMO:int = 1026;
        public static const BETA_PAY_USER_PROMO:int = 1027;
        public static const UPDATE_SOUND_SETTING:int = 1028;
        public static const UPDATE_MUSIC_SETTING:int = 1029;
        public static const PLACE_BUILDING:int = 2001;
        public static const MOVE_BUILDING:int = 2002;
        public static const UPGRADE_BUILDING:int = 2003;
        public static const TRAIN_TROOP:int = 2004;
        public static const HARVEST:int = 2005;
        public static const QUICK_FINISH:int = 2006;
        public static const RESEARCH:int = 2007;
        public static const CANCEL_TRAIN_TROOP:int = 2008;
        public static const REBUILD_CLAN_CASTLE:int = 2009;
        public static const CANCEL_PLACING:int = 2010;
        public static const CANCEL_UPGRADING:int = 2011;
        public static const CANCEL_RESEARCHING:int = 2012;
        public static const QUICK_TRAINING:int = 2013;
        public static const REMOVE_OBSTACLES:int = 2014;
        public static const REMOVE_OBSTACLES_COMPLETED:int = 2015;
        public static const FINISH_TRAIN_TROOP:int = 2016;
        public static const FINISH_BUILDING:int = 2017;
        public static const CLEAR_RIP:int = 2018;
        public static const MULTI_IDS_CLAN:int = 3000;
        public static const DONATE_TROOP:int = 3001;
        public static const REQUEST_TROOP:int = 3002;
        public static const CREATE_CLAN:int = 3003;
        public static const GET_CLANS:int = 3004;
        public static const JOIN_CLAN:int = 3005;
        public static const LEAVE_CLAN:int = 3006;
        public static const INVITE_CLAN:int = 3007;
        public static const KICK_MEMBER:int = 3008;
        public static const CHANGE_MEMBER_TITLE:int = 3009;
        public static const GET_CLAN_DETAIL:int = 3010;
        public static const ACCEPT_CLAN_INVITE:int = 3011;
        public static const REJECT_CLAN_INVITE:int = 3012;
        public static const GET_TROOP_REQUEST:int = 3013;
        public static const EDIT_CLAN:int = 3014;
        public static const REQUEST_TROOP_MSG:int = 3015;
        public static const DONATE_TROOP_MSG:int = 3016;
        public static const SEARCH_CLAN:int = 3017;
        public static const USER_JOIN_CLAN:int = 3018;
        public static const USER_LEAVE_CLAN:int = 3019;
        public static const USER_KICKED:int = 3020;
        public static const MEMBER_CHANGED_TITLE:int = 3021;
        public static const GET_BATTLE_INFO:int = 9001;
        public static const BATTLE_PUT_TROOP:int = 9002;
        public static const BATTLE_END:int = 9003;
        public static const END_ATTACK:int = 9007;
        public static const SINGLE_END:int = 9008;
        public static const SINGLE_BATTLE_INFO:int = 9009;
        public static const REPLAY_BATTLE_LIST:int = 9010;
        public static const REPLAY_BATTLE_INFO:int = 9011;
        public static const BATTLE_ACK:int = 9012;
        public static const BATTLE_REVENGE:int = 9013;
        public static const SEND_CLAN_CHAT:int = 4001;
        public static const SEND_CLAN_CHAT_MSG:int = 4002;
        public static const GET_CLAN_CHAT:int = 4003;
        public static const CHEAT_PLAYER_INFO:int = 5001;
        public static const SERVER_MAINTAIN:int = 5006;
        public static const CLAIM_REWARD:int = 6001;
        public static const BETA_USER_PROMO_RECEIVED:int = 7001;
        public static const BETA_PAY_USER_PROMO_RECEIVED:int = 7002;

        public function Command()
        {
            return;
        }// end function

    }
}
