package bitzero.engine
{
    import bitzero.*;
    import bitzero.controllers.*;
    import bitzero.controls.*;
    import bitzero.exceptions.*;
    import bitzero.logging.*;
    import bitzero.util.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class EngineClient extends EventDispatcher
    {
        private var _lastIpAddress:String;
        private var _reconnectionDelayMillis:int = 1000;
        private var _connected:Boolean;
        private var _log:Logger;
        private var _compressionThreshold:int = 2000000;
        private var _attemptingReconnection:Boolean = false;
        private var _controllersInited:Boolean = false;
        private var _socket:Socket;
        private var _reconnectionSeconds:int = 0;
        private var _reconnectionTry:int = 0;
        private var _bz:BitZero;
        private var _controllers:Object;
        private var _ioHandler:IoHandler;
        private var _extController:ExtensionController;
        private var _lastTcpPort:int;
        private var _sysController:SystemController;

        public function EngineClient(param1:BitZero = null)
        {
            this._controllers = {};
            this._bz = param1;
            this._connected = false;
            this._log = Logger.getInstance();
            return;
        }// end function

        public function get bz() : BitZero
        {
            return this._bz;
        }// end function

        public function get compressionThreshold() : int
        {
            return this._compressionThreshold;
        }// end function

        private function initControllers() : void
        {
            this._sysController = new SystemController(this);
            this._extController = new ExtensionController(this);
            this.addController(0, this._sysController);
            this.addController(1, this._extController);
            return;
        }// end function

        public function get connected() : Boolean
        {
            return this._connected;
        }// end function

        public function getControllerById(param1:int) : IController
        {
            return this._controllers[param1];
        }// end function

        public function get reconnectionSeconds() : int
        {
            return this._reconnectionSeconds;
        }// end function

        public function set ioHandler(param1:IoHandler) : void
        {
            if (this._ioHandler != null)
            {
                throw new BZError("IOHandler is already set!");
            }
            this._ioHandler = param1;
            return;
        }// end function

        public function init() : void
        {
            if (!this._controllersInited)
            {
                this.initControllers();
                this._controllersInited = true;
            }
            this._socket = new Socket();
            this._socket.addEventListener(Event.CONNECT, this.onSocketConnect);
            this._socket.addEventListener(Event.CLOSE, this.onSocketClose);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketIOError);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketSecurityError);
            return;
        }// end function

        private function onSocketIOError(event:IOErrorEvent) : void
        {
            if (this._attemptingReconnection && this._reconnectionTry == 0)
            {
                dispatchEvent(new EngineEvent(EngineEvent.DISCONNECT, {reason:ClientDisconnectionReason.UNKNOWN}));
                return;
            }
            var _loc_2:* = new EngineEvent(EngineEvent.IO_ERROR);
            _loc_2.params = {message:event.toString()};
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function onSocketSecurityError(event:SecurityErrorEvent) : void
        {
            var _loc_2:* = new EngineEvent(EngineEvent.SECURITY_ERROR);
            _loc_2.params = {message:event.text};
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function send(param1:IMessage) : void
        {
            this._ioHandler.codec.onPacketWrite(param1);
            return;
        }// end function

        public function get systemController() : SystemController
        {
            return this._sysController;
        }// end function

        public function getController(param1:int) : IController
        {
            return this._controllers[param1] as IController;
        }// end function

        public function disconnect(param1:String = null) : void
        {
            this._socket.close();
            this.onSocketClose(new EngineEvent(EngineEvent.DISCONNECT, {reason:param1}));
            return;
        }// end function

        private function addController(param1:int, param2:IController) : void
        {
            if (param2 == null)
            {
                throw new ArgumentError("Controller is null, it can\'t be added.");
            }
            if (this._controllers[param1] != null)
            {
                throw new ArgumentError("A controller with id: " + param1 + " already exists! Controller can\'t be added: " + param2);
            }
            this._controllers[param1] = param2;
            return;
        }// end function

        public function addCustomController(param1:int, param2:Class) : void
        {
            var _loc_3:* = new param2()
            this.addController(param1, _loc_3);
            return;
        }// end function

        public function get reconnectionDelayMillis() : int
        {
            return this._reconnectionDelayMillis;
        }// end function

        public function get connectionIp() : String
        {
            if (!this.connected)
            {
                return "Not Connected";
            }
            return this._lastIpAddress;
        }// end function

        public function get extensionController() : ExtensionController
        {
            return this._extController;
        }// end function

        public function set reconnectionDelayMillis(param1:int) : void
        {
            this._reconnectionDelayMillis = param1;
            return;
        }// end function

        public function get ioHandler() : IoHandler
        {
            return this._ioHandler;
        }// end function

        public function set compressionThreshold(param1:int) : void
        {
            if (param1 > 100)
            {
                this._compressionThreshold = param1;
            }
            else
            {
                throw new ArgumentError("Compression threshold cannot be < 100 bytes.");
            }
            return;
        }// end function

        public function killConnection() : void
        {
            this._socket.close();
            this.onSocketClose(new Event(Event.CLOSE));
            return;
        }// end function

        private function onSocketConnect(event:Event) : void
        {
            this._connected = true;
            this._reconnectionTry = this._reconnectionSeconds * 1000 / this._reconnectionDelayMillis;
            if (this._attemptingReconnection)
            {
                FrameTimerManager.getTimer().remove(this.reconnect);
            }
            var _loc_2:* = new EngineEvent(EngineEvent.CONNECT);
            _loc_2.params = {success:true, _isReconnection:this._attemptingReconnection};
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function set reconnectionSeconds(param1:int) : void
        {
            if (param1 < 0)
            {
                this._reconnectionSeconds = 0;
            }
            else
            {
                this._reconnectionSeconds = param1;
            }
            return;
        }// end function

        private function onSocketClose(event:Event) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            var _loc_4:Event = null;
            var _loc_5:* = undefined;
            _loc_4 = event;
            this._connected = false;
            _loc_3 = !this._attemptingReconnection && this.bz.getReconnectionSeconds() == 0;
            _loc_2 = _loc_4 is EngineEvent && (_loc_4 as EngineEvent).params.reason == ClientDisconnectionReason.MANUAL;
            if (this._attemptingReconnection || _loc_3 || _loc_2)
            {
                if (_loc_4 is EngineEvent)
                {
                    dispatchEvent(_loc_4);
                }
                else
                {
                    dispatchEvent(new EngineEvent(EngineEvent.DISCONNECT, {reason:ClientDisconnectionReason.UNKNOWN}));
                }
                return;
            }
            this._attemptingReconnection = true;
            FrameTimerManager.getTimer().add(this._reconnectionDelayMillis / 1000, this._reconnectionTry, this.reconnect);
            FrameTimerManager.getTimer().add(this._reconnectionTry + 3, 1, this.checkConnect);
            return;
        }// end function

        private function checkConnect() : void
        {
            if (!this.connected)
            {
                this._log.info(" checkConnect : ", "FALSE ");
                dispatchEvent(new EngineEvent(EngineEvent.DISCONNECT, {reason:ClientDisconnectionReason.UNKNOWN}));
            }
            return;
        }// end function

        public function reconnect() : void
        {
            if (this._reconnectionTry == 0)
            {
                this._log.info("Disconnect try : ", this._reconnectionTry);
                FrameTimerManager.getTimer().remove(this.reconnect);
                dispatchEvent(new EngineEvent(EngineEvent.DISCONNECT, {reason:ClientDisconnectionReason.UNKNOWN}));
                return;
            }
            this.connect(this._lastIpAddress, this._lastTcpPort);
            dispatchEvent(new EngineEvent(EngineEvent.RECONNECTION_TRY, this._reconnectionTry));          
            this._reconnectionTry--;
            this._log.info("Reconnect : ", this._reconnectionTry);
            return;
        }// end function

        public function set isReconnecting(param1:Boolean) : void
        {
            this._attemptingReconnection = param1;
            return;
        }// end function

        public function connect(param1:String = "127.0.0.1", param2:int = 9339) : void
        {
            this._lastIpAddress = param1;
            this._lastTcpPort = param2;
            this._socket.connect(param1, param2);
            return;
        }// end function

        public function get socket() : Socket
        {
            return this._socket;
        }// end function

        public function get isReconnecting() : Boolean
        {
            return this._attemptingReconnection;
        }// end function

        public function destroy() : void
        {
            this._socket.removeEventListener(Event.CONNECT, this.onSocketConnect);
            this._socket.removeEventListener(Event.CLOSE, this.onSocketClose);
            this._socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
            this._socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onSocketIOError);
            this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketSecurityError);
            if (this._socket.connected)
            {
                this._socket.close();
            }
            this._socket = null;
            return;
        }// end function

        public function testDisconnect() : void
        {
            this._socket.close();
            this.onSocketClose(new Event("testDisconnect"));
            return;
        }// end function

        private function onSocketData(event:ProgressEvent) : void
        {
            var _loc_2:* = new ByteArray();
            this._socket.readBytes(_loc_2);
            this._ioHandler.onDataRead(_loc_2);
            return;
        }// end function

        public function get connectionPort() : int
        {
            if (!this.connected)
            {
                return -1;
            }
            return this._lastTcpPort;
        }// end function

    }
}
