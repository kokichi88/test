package bitzero
{
    import bitzero.controllers.system.*;
    import bitzero.core.*;
    import bitzero.engine.*;
    import bitzero.logging.*;
    import bitzero.net.data.*;
    import bitzero.net.events.*;
    import flash.events.*;
    import flash.utils.*;
    import modules.city.*;

    public class BZConnector extends Object
    {
        private var _bzClient:BitZero = null;
        private var _logger:Logger;
        private var _extenstionDispatcher:EventDispatcher;
        private static var logCommand:Boolean = true;
        private static var _instancesMap:Dictionary = new Dictionary();

        public function BZConnector()
        {
            this._logger = Logger.getInstance();
            this._extenstionDispatcher = new EventDispatcher();
            this._bzClient = new BitZero();
            this._bzClient.addEventListener(BZEvent.EXTENSION_RESPONSE, this.onServerResp);
            return;
        }// end function

        public function get bzClient() : BitZero
        {
            return this._bzClient;
        }// end function

        public function addEventListener(param1:String, param2:Function) : void
        {
            if (param1 != BZEvent.EXTENSION_RESPONSE)
            {
                this._bzClient.addEventListener(param1, param2);
            }
            return;
        }// end function

        public function dispatchEvent(param1:MsgInfo) : Boolean
        {
            return this._extenstionDispatcher.dispatchEvent(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function) : void
        {
            this._bzClient.removeEventListener(param1, param2);
            return;
        }// end function

        public function addResponseListener(param1:int, param2:Function, param3:int = 0) : void
        {
            this._extenstionDispatcher.addEventListener(param1.toString(), param2, false, param3);
            return;
        }// end function

        public function removeResponseListene(param1:int, param2:Function) : void
        {
            this._extenstionDispatcher.removeEventListener(param1.toString(), param2);
            return;
        }// end function

        public function loadConfig() : void
        {
            this._bzClient.loadConfig("bz-config.xml", true);
            return;
        }// end function

        public function testDisconnect() : void
        {
            this._bzClient.testDisconnect();
            return;
        }// end function

        public function connect(param1:String, param2:int) : void
        {
            var gameServer:* = param1;
            var port:* = param2;
            try
            {
                this._bzClient.connect(gameServer, port);
                this._logger.info("Connect IP - host ", gameServer, " - ", port);
            }
            catch (e:Error)
            {
                _logger.info("Ko Connect duoc");
            }
            return;
        }// end function

        public function disconnect() : void
        {
            this._bzClient.killConnection();
            this._bzClient.removeEventListener(BZEvent.EXTENSION_RESPONSE, this.onServerResp);
            return;
        }// end function

        public function send(param1:BaseCmd) : void
        {
            var _loc_4:int = 0;
            this._bzClient.send(param1);
            if (logCommand)
            {
                this._logger.info(" --> send cmd :", param1.TypeId);
            }
            var _loc_2:* = describeType(param1)..variable;
            var _loc_3:* = new Object();
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length())
            {
                
                _loc_3[_loc_2[_loc_4].@name] = param1[_loc_2[_loc_4].@name];
                _loc_4++;
            }
            CityMgr.getInstance().pushCmd(_loc_3);
            return;
        }// end function

        private function onServerResp(event:BZEvent) : void
        {
            var _loc_2:* = new MsgInfo(event.params as IMessage);
            if (logCommand)
            {
                this._logger.info(" <-- response msg : ", _loc_2.type);
            }
            this._extenstionDispatcher.dispatchEvent(_loc_2);
            return;
        }// end function

        public function pingpong() : void
        {
            var _loc_1:* = new BaseCmd(SystemRequest.PingPong);
            _loc_1.crlID = 0;
            this.send(_loc_1);
            return;
        }// end function

        public static function getInstance(param1:String = "default") : BZConnector
        {
            if (_instancesMap[param1] == null)
            {
                _instancesMap[param1] = new BZConnector;
            }
            return _instancesMap[param1];
        }// end function

        public static function freeInstance(param1:String = "default") : void
        {
            delete _instancesMap[param1];
            return;
        }// end function

    }
}
