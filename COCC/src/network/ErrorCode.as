package network
{
    import flash.utils.*;

    public class ErrorCode extends Object
    {
        public static const UNKNOW:int = -2;
        public static const ACTION_FAILED:int = -1;
        public static const SUCCESS:int = 0;
        public static const USER_NOT_FOUND:int = 1;
        public static const INVALID_DATA:int = 2;
        public static const OVER_LIMIT:int = 3;
        public static const NOT_ENOUGH_COIN:int = 4;
        public static const NOT_ENOUGH_GOLD:int = 5;
        public static const NOT_ENOUGH_ELIXIR:int = 6;
        public static const NOT_ENOUGH_DARK_ELIXIR:int = 7;
        public static const NOT_ENOUGH_TROPHY:int = 8;
        public static const BUILDER_NOT_AVAILABLE:int = 9;
        public static const NOT_ENOUGH_TOWN_HALL_LEVEL:int = 10;
        public static const ITEM_NOT_FOUND:int = 11;
        public static const ARMY_CAMP_FULLED:int = 12;
        public static const MAP_NOT_AVAILABLE:int = 13;
        public static const LAB_NOT_AVAILABLE:int = 14;
        public static const NOT_ENOUGH_LAB_LEVEL:int = 15;
        public static const CANT_JOIN_2_CLAN:int = 16;
        public static const DB_ERROR:int = 17;
        public static const CLAN_NOT_FOUND:int = 18;
        public static const NEED_REBUILD_CLAN_CASTLE:int = 19;
        public static const NOT_ENOUGH_PERMISSION:int = 20;
        public static const CLAN_FULL:int = 21;
        public static const CLAN_CASTLE_FULLED:int = 22;
        public static const NOT_ENOUGH_BARRACK_LEVEL:int = 23;
        public static const RESEARCHING_NOT_FOUND:int = 24;
        public static const TRAINING_NULL:int = 25;
        public static const TUTORIAL_FINISHED:int = 26;
        public static const CONFIG_MISSING:int = 27;
        public static const NOT_ENOUGH_EXP:int = 28;
        public static const FINISHED_BUILDING:int = 29;

        public function ErrorCode()
        {
            return;
        }// end function

        public static function getReason(param1:int) : String
        {
            var _loc_3:XML = null;
            var _loc_2:* = describeType().descendants("constant");
            for each (_loc_3 in _loc_2)
            {
                
                if ([_loc_3.@name] == param1)
                {
                    return _loc_3.@name;
                }
            }
            return null;
        }// end function

    }
}
