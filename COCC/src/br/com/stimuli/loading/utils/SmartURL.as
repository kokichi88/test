package br.com.stimuli.loading.utils
{

    public class SmartURL extends Object
    {
        public var rawString:String;
        public var protocol:String;
        public var port:int;
        public var host:String;
        public var path:String;
        public var queryString:String;
        public var queryObject:Object;
        public var queryLength:int = 0;
        public var fileName:String;

        public function SmartURL(param1:String)
        {
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            this.rawString = param1;
            var _loc_2:* = /((?P<protocol>[a-zA-Z]+: \/\/)   (?P<host>[^:\/]*) (:(?P<port>\d+))?)?  (?P<path>[^?]*)? ((?P<query>.*))? ""((?P<protocol>[a-zA-Z]+: \/\/)   (?P<host>[^:\/]*) (:(?P<port>\d+))?)?  (?P<path>[^?]*)? ((?P<query>.*))? /x;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3)
            {
                this.protocol = Boolean(_loc_3.protocol) ? (_loc_3.protocol) : ("http://");
                this.protocol = this.protocol.substr(0, this.protocol.indexOf("://"));
                this.host = _loc_3.host || null;
                this.port = _loc_3.port ? (int(_loc_3.port)) : (80);
                this.path = _loc_3.path;
                this.fileName = this.path.substring(this.path.lastIndexOf("/"), this.path.lastIndexOf("."));
                this.queryString = _loc_3.query;
                if (this.queryString)
                {
                    this.queryObject = {};
                    this.queryString = this.queryString.substr(1);
                    for each (_loc_6 in this.queryString.split("&"))
                    {
                        
                        _loc_5 = _loc_6.split("=")[0];
                        _loc_4 = _loc_6.split("=")[1];
                        this.queryObject[_loc_5] = _loc_4;
                        var _loc_9:String = this;
                        var _loc_10:* = this.queryLength + 1;
                        _loc_9.queryLength = _loc_10;
                    }
                }
            }
            else
            {
                trace("no match");
            }
            return;
        }// end function

        public function toString(... args) : String
        {
            if (args.length > 0 && args[0] == true)
            {
                return "[URL] rawString :" + this.rawString + ", protocol: " + this.protocol + ", port: " + this.port + ", host: " + this.host + ", path: " + this.path + ". queryLength: " + this.queryLength;
            }
            return this.rawString;
        }// end function

    }
}
