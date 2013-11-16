package bitzero.util
{

    public class ConfigData extends Object
    {
        public var port:int = 443;
        public var host:String = "127.0.0.1";
        public var httpPort:int = 8080;
        public var bboxPort:int = 8080;
        public var zone:String;
        public var bboxHost:String;
        public var debug:Boolean = false;
        public var useBBox:Boolean = false;
        public var bboxPollingRate:int = 700;
        public var reconnectSeconds:int = 5;

        public function ConfigData()
        {
            return;
        }// end function

    }
}
