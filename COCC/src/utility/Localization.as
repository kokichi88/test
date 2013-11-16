package utility
{
    import flash.events.*;
    import flash.net.*;

    public class Localization extends Object
    {
        private var PRE_LOAD_SWF_TYPE:String = "swf";
        private var PRE_LOAD_JSON_TYPE:String = "json";
        private var PRE_LOAD_XML_TYPE:String = "xml";
        private var data:XML = null;
        private var _language:String;
        private static var instance:Localization = null;
        private static const FILE_NAME:String = "localization";
        private static const FILE_TYPE:String = ".xml";
        private static var _isLoaded:Boolean = false;

        public function Localization()
        {
            this.setLanguage("vn");
            return;
        }// end function

        public function setLanguage(param1:String) : void
        {
            this._language = param1;
            return;
        }// end function

        public function getLanguage() : String
        {
            return this._language;
        }// end function

        public function getString(param1:String) : String
        {
            var st:String;
            var id:* = param1;
            var _loc_4:int = 0;
            var _loc_7:int = 0;
            var _loc_8:* = this.data.language;
            var _loc_6:* = new XMLList("");
            for each (_loc_9 in _loc_8)
            {
                
                var _loc_10:* = _loc_8[_loc_7];
                with (_loc_8[_loc_7])
                {
                    if (@name == _language)
                    {
                        _loc_6[_loc_7] = _loc_9;
                    }
                }
            }
            var _loc_5:* = _loc_6.String;
            var _loc_3:* = new XMLList("");
            for each (_loc_6 in _loc_5)
            {
                
                var _loc_7:* = _loc_5[_loc_4];
                with (_loc_5[_loc_4])
                {
                    if (@id == id)
                    {
                        _loc_3[_loc_4] = _loc_6;
                    }
                }
            }
            st = _loc_3;
            st = st.split("\\n").join("\n");
            return st;
        }// end function

        public static function getInstance() : Localization
        {
            if (instance == null)
            {
                instance = new Localization;
            }
            return instance;
        }// end function

        public static function loadData(param1:Function = null) : void
        {
            var urlLoader:URLLoader;
            var afterLoading:* = param1;
            urlLoader = new URLLoader();
            with ({})
            {
                {}.initSharedInstance = function (event:Event) : void
            {
                instance = new Localization();
                instance.data = new XML(event.target.data);
                urlLoader.removeEventListener(Event.COMPLETE, initSharedInstance);
                urlLoader = null;
                _isLoaded = true;
                if (afterLoading != null)
                {
                    afterLoading();
                }
                return;
            }// end function
            ;
            }
            urlLoader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                instance = new Localization();
                instance.data = new XML(event.target.data);
                urlLoader.removeEventListener(Event.COMPLETE, initSharedInstance);
                urlLoader = null;
                _isLoaded = true;
                if (afterLoading != null)
                {
                    afterLoading();
                }
                return;
            }// end function
            );
            urlLoader.load(new URLRequest(Config.getXmlUrlDir() + VersionConfig.getXmlFullName(FILE_NAME)));
            return;
        }// end function

        public static function isLoaded() : Boolean
        {
            return _isLoaded;
        }// end function

    }
}
