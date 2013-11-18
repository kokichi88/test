package utility
{
    import __AS3__.vec.*;
    import com.adobe.crypto.*;
    import flash.events.*;
    import flash.net.*;

    public class VersionConfig extends Object
    {
        private var data:XML = null;
        public static var _instance:VersionConfig = null;
        public static const FILE_NAME:String = "versionConfig";
        public static const FILE_TYPE:String = ".xml";
        private static const SEPARATE:String = "_";

        public function VersionConfig()
        {
            return;
        }// end function

        public static function loadData(param1:Function = null) : void
        {
            var urlLoader:URLLoader;
            var afterLoading:* = param1;
            urlLoader = new URLLoader();
            var initSharedInstance:Function = function(event:Event):void
			{
				_instance = new VersionConfig();
				_instance.data = new XML(event.target.data);
				urlLoader.removeEventListener(Event.COMPLETE, initSharedInstance);
				urlLoader = null;
				if (afterLoading != null)
				{
					afterLoading();
				}
				return;
			} // end function
            
            urlLoader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                _instance = new VersionConfig();
                _instance.data = new XML(event.target.data);
                urlLoader.removeEventListener(Event.COMPLETE, initSharedInstance);
                urlLoader = null;
                if (afterLoading != null)
                {
                    afterLoading();
                }
                return;
            }// end function
            );
            urlLoader.load(new URLRequest(Config.getXmlUrlDir() + FILE_NAME + FILE_TYPE + "?v=" + Config.gameVersion));
            return;
        }// end function

        public static function getSwfList() : Vector.<String>
        {
            var _loc_3:XMLList = null;
            var _loc_4:XML = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_1:String = ".swf";
            var _loc_2:* = new Vector.<String>;
            if (_instance)
            {
                _loc_3 = _instance.data.SwfList.children();
                for each (_loc_4 in _loc_3)
                {
                    
                    _loc_5 = _loc_4;
                    _loc_6 = _loc_4.name() + _loc_5 + _loc_1 + "?v=" + Config.gameVersion;
                    _loc_6 = Config.getSwfUrlDir() + _loc_6;
                    _loc_2.push(_loc_6);
                }
            }
            return _loc_2;
        }// end function

        public static function getXmlList() : Vector.<String>
        {
            var _loc_3:XMLList = null;
            var _loc_4:XML = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_1:String = ".xml";
            var _loc_2:* = new Vector.<String>;
            if (_instance)
            {
                _loc_3 = _instance.data.XmlList.children();
                for each (_loc_4 in _loc_3)
                {
                    
                    _loc_5 = _loc_4;
                    _loc_6 = _loc_4.name() + _loc_5 + _loc_1 + "?v=" + Config.gameVersion;
                    _loc_6 = Config.getXmlUrlDir() + _loc_6;
                    _loc_2.push(_loc_6);
                }
            }
            return _loc_2;
        }// end function

        public static function getJsonList() : Vector.<String>
        {
            var _loc_3:XMLList = null;
            var _loc_4:XML = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_1:String = ".json";
            var _loc_2:* = new Vector.<String>;
            if (_instance)
            {
                _loc_3 = _instance.data.JsonList.children();
                for each (_loc_4 in _loc_3)
                {
                    
                    _loc_5 = _loc_4;
                    _loc_6 = _loc_4.name() + _loc_5 + _loc_1 + "?v=" + Config.gameVersion;
                    _loc_6 = Config.getJsonUrlDir() + _loc_6;
                    _loc_2.push(_loc_6);
                }
            }
            return _loc_2;
        }// end function

        public static function getAssetFullName(param1:String) : String
        {
            var _loc_3:String = null;
            var _loc_2:String = ".jta";
            var _loc_4:* = param1;
            var _loc_5:* = _instance.data.AssetList[_loc_4];
            if (_instance.data.AssetList[_loc_4] != "")
            {
                _loc_3 = _loc_4 + _loc_5;
            }
            else
            {
                _loc_3 = _loc_4;
            }
            if (!Config.DEV_MODE)
            {
                _loc_3 = MD5.hash(_loc_3);
            }
            _loc_3 = _loc_3 + _loc_2 + "?v=" + Config.gameVersion;
            return _loc_3;
        }// end function

        public static function getXmlFullName(param1:String) : String
        {
            var _loc_3:String = null;
            var _loc_2:String = ".xml";
            var _loc_4:* = _instance.data.XmlList[param1];
            if (_instance.data.XmlList[param1] != "")
            {
                _loc_3 = param1 + _loc_4;
            }
            else
            {
                _loc_3 = param1;
            }
            _loc_3 = _loc_3 + (_loc_2 + "?v=" + Config.gameVersion);
            return _loc_3;
        }// end function

        public static function getJsonFullName(param1:String) : String
        {
            var _loc_3:String = null;
            var _loc_2:String = ".json";
            var _loc_4:* = _instance.data.JsonList[param1];
            if (_instance.data.JsonList[param1] != "")
            {
                _loc_3 = param1 + _loc_4;
            }
            else
            {
                _loc_3 = param1;
            }
            _loc_3 = _loc_3 + (_loc_2 + "?v=" + Config.gameVersion);
            return _loc_3;
        }// end function

    }
}
