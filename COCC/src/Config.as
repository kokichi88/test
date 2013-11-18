package 
{

    public class Config extends Object
    {
        public static const XML_DIR_NAME:String = "xml/";
        public static const JSON_DIR_NAME:String = "json/";
        public static const SWF_DIR_NAME:String = "swf/";
        public static var ASSET_DIR_NAME:String = "assets/";
        public static var staticURL:String = "http://cocc-static.apps.zing.vn/assets/";
        public static var server_ip:String = "10.198.48.33";
        public static var server_port:int = 443;
        public static var gameVersion:int = 1;
        public static var configVersion:int = 1;
        public static var hasFeed:Boolean = false;
        public static var uId:int = 2165568;
        public static var signed_request:String = "";
        public static var authorizationCode:String = "";
        private static var localResUrl:String = "../res/";
        public static const DEV_MODE:Boolean = true;
        public static const DEV_RESOURCE:Boolean = false;
        public static const TRY_TUTORIAL:int = 1;
        public static const FINAL_TUTORIAL_STEP:int = 70;

        public function Config()
        {
            return;
        }// end function

        public static function getStaticUrl() : String
        {
            if (DEV_RESOURCE)
            {
                return localResUrl;
            }
            return staticURL;
        }// end function

        public static function getXmlUrlDir() : String
        {
            if (DEV_RESOURCE)
            {
                return localResUrl + XML_DIR_NAME;
            }
            return staticURL + XML_DIR_NAME;
        }// end function

        public static function getJsonUrlDir() : String
        {
            if (DEV_RESOURCE)
            {
                return localResUrl + JSON_DIR_NAME;
            }
            return staticURL + JSON_DIR_NAME;
        }// end function

        public static function getAssetUrlDir() : String
        {
            if (DEV_RESOURCE)
            {
                return localResUrl + ASSET_DIR_NAME;
            }
            return staticURL + ASSET_DIR_NAME;
        }// end function

        public static function getSwfUrlDir() : String
        {
            if (DEV_RESOURCE)
            {
                return localResUrl + SWF_DIR_NAME;
            }
            return staticURL + SWF_DIR_NAME;
        }// end function

    }
}
