package bitzero
{
    import bitzero.controllers.system.cmd.*;
    import bitzero.controls.*;
    import bitzero.core.*;
    import bitzero.engine.*;
    import bitzero.logging.*;
    import bitzero.net.data.*;
    import bitzero.util.*;
    import flash.events.*;
    import flash.utils.*;

    public class BitZero extends EventDispatcher
    {
        private var _log:Logger;
        private var _currentZone:String;
        private var _subVersion:int = 6;
        private var _autoConnectOnConfig:Boolean = false;
        private var _isHttpMode:Boolean = false;
        private var _minVersion:int = 8;
        private var _majVersion:int = 0;
        private var _isConnected:Boolean = false;
        private var _isJoining:Boolean = false;
        private var _config:ConfigData;
        private var _debug:Boolean = false;
        private var _isConnecting:Boolean = false;
        private var _sessionToken:String = "";
        private var bzClient:EngineClient;
        private var _inited:Boolean = false;

        public function BitZero(param1:Boolean = false)
        {
            this._log = Logger.getInstance();
            this._log.enableEventDispatching = true;
            this._config = new ConfigData();
            this._debug = this._config.debug;
            this.initialize();
            return;
        }// end function

        public function get sessionToken() : String
        {
            return this._sessionToken;
        }// end function

        public function connect(param1:String = null, param2:int = -1) : void
        {
            if (this.isConnected)
            {
                this._log.warn("Already Connected");
                return;
            }
            if (this._isConnecting)
            {
                this._log.warn("A connection attempt is already running");
                return;
            }
            if (this.config != null)
            {
                if (param1 == null)
                {
                    param1 = this.config.host;
                }
                if (param2 == -1)
                {
                    param2 = this.config.port;
                }
            }
            if (param1 == null || param1.length == 0)
            {
                throw new ArgumentError("Invalid connection host/address");
            }
            if (param2 < 0 || param2 > 65535)
            {
                throw new ArgumentError("Invalid connection port");
            }
            this._isConnecting = true;
            this.bzClient.connect(param1, param2);
            return;
        }// end function

        public function get currentIp() : String
        {
            return this.bzClient.connectionIp;
        }// end function

        public function send(param1:BaseCmd) : void
        {
            if (!this.isConnected)
            {
                this._log.warn("Not conncted: can\'t send any request: " + param1);
                dispatchEvent(new BZEvent(BZEvent.CONNECTION_LOST, {reason:ClientDisconnectionReason.UNKNOWN}));
            }
            var _loc_2:* = new Message();
            _loc_2.targetController = param1.crlID;
            _loc_2.id = param1.TypeId;
            if (param1.createBody())
            {
                _loc_2.content = param1.getCmdBodys();
            }
            else
            {
                this._log.warn("Content Data Send Create Fail : " + param1);
            }
            this.bzClient.send(_loc_2);
            return;
        }// end function

        public function getSocketEngine() : EngineClient
        {
            return this.bzClient;
        }// end function

        private function handleHandShake(event:BZEvent) : void
        {
            var _loc_2:* = event.params as HandShakeMsg;
            this._sessionToken = _loc_2.token;
            this.setReconnectionSeconds(_loc_2.reconnectTime);
            if (this._sessionToken.length < 2)
            {
                this._isConnecting = false;
                this.logger.info(" handshaking fail ...");
                this.handleClientDisconnection(ClientDisconnectionReason.HANDSHAKE);
                return;
            }
            if (this.bzClient.isReconnecting)
            {
                this.bzClient.isReconnecting = false;
                dispatchEvent(new BZEvent(BZEvent.CONNECTION_RESUME, {}));
                this.logger.info(" handshaking sucess CONNECTION_RESUME ...");
            }
            else
            {
                this._isConnecting = false;
                dispatchEvent(new BZEvent(BZEvent.CONNECTION, {success:true}));
                this.logger.info(" handshaking sucess return token ...");
            }
            return;
        }// end function

        private function initialize() : void
        {
            if (this._inited)
            {
                return;
            }
            this.bzClient = new EngineClient(this);
            this.bzClient.ioHandler = new BZIOHandler(this.bzClient);
            this.bzClient.init();
            this.bzClient.addEventListener(EngineEvent.CONNECT, this.onSocketConnect);
            this.bzClient.addEventListener(EngineEvent.DISCONNECT, this.onSocketClose);
            this.bzClient.addEventListener(EngineEvent.RECONNECTION_TRY, this.onSocketReconnectionTry);
            this.bzClient.addEventListener(EngineEvent.IO_ERROR, this.onSocketIOError);
            this.bzClient.addEventListener(EngineEvent.SECURITY_ERROR, this.onSocketSecurityError);
            addEventListener(BZEvent.HANDSHAKE, this.handleHandShake);
            addEventListener(BZEvent.LOGIN, this.handleLogin);
            this._inited = true;
            this.reset();
            return;
        }// end function

        private function onConfigLoadFailure(event:BZEvent) : void
        {
            var _loc_2:* = event.target as ConfigLoader;
            _loc_2.removeEventListener(BZEvent.CONFIG_LOAD_SUCCESS, this.onConfigLoadSuccess);
            _loc_2.removeEventListener(BZEvent.CONFIG_LOAD_FAILURE, this.onConfigLoadFailure);
            var _loc_3:* = new BZEvent(BZEvent.CONFIG_LOAD_FAILURE, {});
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function onSocketClose(event:EngineEvent) : void
        {
            this.reset();
            dispatchEvent(new BZEvent(BZEvent.CONNECTION_LOST, {reason:event.params.reason}));
            return;
        }// end function

        private function onSocketSecurityError(event:EngineEvent) : void
        {
            if (this._isConnecting)
            {
                this.handleConnectionProblem(event);
            }
            return;
        }// end function

        public function get isJoining() : Boolean
        {
            return this._isJoining;
        }// end function

        public function get currentPort() : int
        {
            return this.bzClient.connectionPort;
        }// end function

        public function get logger() : Logger
        {
            return this._log;
        }// end function

        private function handleLogin(event:BZEvent) : void
        {
            return;
        }// end function

        public function get compressionThreshold() : int
        {
            return this.bzClient.compressionThreshold;
        }// end function

        private function onSocketReconnectionTry(event:EngineEvent) : void
        {
            dispatchEvent(new BZEvent(BZEvent.CONNECTION_RETRY, event.params));
            return;
        }// end function

        public function disconnect() : void
        {
            if (this.isConnected)
            {
                if (this.bzClient.reconnectionSeconds > 0)
                {
                    this.send(new ManualDisconnectionMsg());
                }
                setTimeout(function () : void
            {
                bzClient.disconnect(ClientDisconnectionReason.MANUAL);
                return;
            }// end function
            , 100);
            }
            else
            {
                this._log.info("You are not connected");
            }
            return;
        }// end function

        public function setReconnectionSeconds(param1:int) : void
        {
            this.bzClient.reconnectionSeconds = param1;
            return;
        }// end function

        public function handleClientDisconnection(param1:String) : void
        {
            this.bzClient.reconnectionSeconds = 0;
            this.bzClient.disconnect(param1);
            this.reset();
            return;
        }// end function

        private function onConfigLoadSuccess(event:BZEvent) : void
        {
            var _loc_2:* = event.target as ConfigLoader;
            var _loc_3:* = event.params.cfg as ConfigData;
            _loc_2.removeEventListener(BZEvent.CONFIG_LOAD_SUCCESS, this.onConfigLoadSuccess);
            _loc_2.removeEventListener(BZEvent.CONFIG_LOAD_FAILURE, this.onConfigLoadFailure);
            if (_loc_3.host == null || _loc_3.host.length == 0)
            {
                throw new ArgumentError("Invalid Host/IpAddress in external config file");
            }
            if (_loc_3.port < 0 || _loc_3.port > 65535)
            {
                throw new ArgumentError("Invalid TCP port in external config file");
            }
            if (_loc_3.zone == null || _loc_3.zone.length == 0)
            {
                throw new ArgumentError("Invalid Zone name in external config file");
            }
            this._config = _loc_3;
            var _loc_4:* = new BZEvent(BZEvent.CONFIG_LOAD_SUCCESS, {config:_loc_3});
            dispatchEvent(_loc_4);
            if (this._autoConnectOnConfig)
            {
                this.connect(this._config.host, this._config.port);
            }
            return;
        }// end function

        public function set debug(param1:Boolean) : void
        {
            this._debug = param1;
            return;
        }// end function

        public function get isConnected() : Boolean
        {
            var _loc_1:Boolean = false;
            if (this.bzClient != null)
            {
                _loc_1 = this.bzClient.connected;
            }
            return _loc_1;
        }// end function

        public function getReconnectionSeconds() : int
        {
            return this.bzClient.reconnectionSeconds;
        }// end function

        private function handleConnectionProblem(event:EngineEvent) : void
        {
            var _loc_2:Object = {success:false, errorMessage:event.params.message};
            dispatchEvent(new BZEvent(BZEvent.CONNECTION, _loc_2));
            this._isConnected = false;
            this._isConnecting = false;
            return;
        }// end function

        private function onSocketIOError(event:EngineEvent) : void
        {
            if (this._isConnecting)
            {
                this.handleConnectionProblem(event);
            }
            return;
        }// end function

        private function sendHandshakeRequest(param1:Boolean = false) : void
        {
            this.logger.info("Socket Connected .... handshaking ...");
            this.send(new HandShakeCmd(this.sessionToken));
            this._sessionToken = "";
            FrameTimerManager.getTimer().add(5, 1, this.checkConnect);
            return;
        }// end function

        private function checkConnect() : void
        {
            if (this.sessionToken == "")
            {
                this.bzClient.reconnectionSeconds = 0;
                this.disconnect();
            }
            return;
        }// end function

        public function loadConfig(param1:String = "bz-config.xml", param2:Boolean = true) : void
        {
            var _loc_3:* = new ConfigLoader();
            _loc_3.addEventListener(BZEvent.CONFIG_LOAD_SUCCESS, this.onConfigLoadSuccess);
            _loc_3.addEventListener(BZEvent.CONFIG_LOAD_FAILURE, this.onConfigLoadFailure);
            this._autoConnectOnConfig = param2;
            _loc_3.loadConfig(param1);
            return;
        }// end function

        private function reset() : void
        {
            this._isConnected = false;
            this._isJoining = false;
            this._currentZone = null;
            this._sessionToken = "";
            this.setReconnectionSeconds(this._config.reconnectSeconds);
            return;
        }// end function

        public function get config() : ConfigData
        {
            return this._config;
        }// end function

        public function get debug() : Boolean
        {
            return this._debug;
        }// end function

        public function handleLogout() : void
        {
            this._isJoining = false;
            this._currentZone = null;
            return;
        }// end function

        public function get version() : String
        {
            return "" + this._majVersion + "." + this._minVersion + "." + this._subVersion;
        }// end function

        public function killConnection() : void
        {
            this.bzClient.killConnection();
            return;
        }// end function

        public function testDisconnect() : void
        {
            this.bzClient.testDisconnect();
            return;
        }// end function

        public function get currentZone() : String
        {
            return this._currentZone;
        }// end function

        private function onSocketConnect(event:EngineEvent) : void
        {
            if (event.params.success)
            {
                this.sendHandshakeRequest(event.params._isReconnection);
            }
            else
            {
                this._log.warn("Connection attempt failed");
                this.handleConnectionProblem(event);
            }
            return;
        }// end function

    }
}
