package component.avatar.controls
{

    public class URLManager extends Object
    {
        public static var imgAvatarURL:String = "resource/";
        public static var resURL:String = "assets/";
        public static var frameList:Array = [9, 7, 9, 9, 8];
        public static var dirArr:Array = [UP, DOWN, LEFT_DOWN, LEFT, LEFT_UP];
        public static const RIGHT_DOWN:int = 4;
        public static const LEFT:int = 7;
        public static const ATTACK:int = 2;
        public static const RUN:int = 1;
        public static var actionArr:Array = [STAND, RUN, ATTACK, ATTACKED, DIE, WALK, BUILD];
        public static const LEFT_UP:int = 8;
        public static const REST:int = 5;
        public static var PEOPLE_HEIGHT:int = 120;
        public static var PEOPLE_WIDTH:int = 120;
        public static const LEFT_DOWN:int = 6;
        public static const UP:int = 1;
        public static const DIE:int = 4;
        public static const WALK:int = 5;
        public static const BUILD:int = 5;
        public static const ATTACKED:int = 3;
        public static const DOWN:int = 5;
        public static const RIGHT:int = 3;
        public static const STAND:int = 0;
        public static const RIGHT_UP:int = 2;

        public function URLManager()
        {
            return;
        }// end function

        public static function getURL(param1:String, param2:String) : String
        {
            return Config.getStaticUrl() + resURL + param1 + "/" + param2 + ".jta" + "?v=" + Config.gameVersion;
        }// end function

        public static function getEquipAn(param1:String, param2:int, param3:int) : String
        {
            return param1 + "_" + param2 + "_" + param3;
        }// end function

        public static function getImage(param1:String, param2:int, param3:int, param4:int) : String
        {
            if (param3 == 1)
            {
                param3 = 9;
            }
            param3 = (param3 - 4) % 8 - 1;
            var _loc_5:* = param3 * frameList[param2] + param4;
            return imgAvatarURL + param1 + "/act" + param2 + "/img_" + _loc_5 + ".png" + "?v=" + Config.gameVersion;
        }// end function

        public static function getInfoUrl(param1:String) : String
        {
            return imgAvatarURL + param1 + "/info.json" + "?v=" + Config.gameVersion;
        }// end function

        public static function getUrl(param1:String) : String
        {
            return imgAvatarURL + param1 + "?v=" + Config.gameVersion;
        }// end function

        public static function getInfoEffUrl(param1:String) : String
        {
            return imgAvatarURL + "fx/" + param1 + "/info.json" + "?v=" + Config.gameVersion;
        }// end function

    }
}
