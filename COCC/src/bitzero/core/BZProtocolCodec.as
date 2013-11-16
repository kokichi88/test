package bitzero.core
{
    import bitzero.engine.*;
    import bitzero.exceptions.*;
    import bitzero.logging.*;
    import bitzero.protocol.*;
    import flash.utils.*;

    public class BZProtocolCodec extends Object implements IProtocolCodec
    {
        private var _ioHandler:IoHandler;
        private var log:Logger;
        private var ezClient:EngineClient;
        private static const ACTION_ID:String = "a";
        private static const PARAM_ID:String = "p";
        private static const CONTROLLER_ID:String = "c";

        public function BZProtocolCodec(param1:IoHandler, param2:EngineClient)
        {
            this._ioHandler = param1;
            this.log = Logger.getInstance();
            this.ezClient = param2;
            return;
        }// end function

        public function get ioHandler() : IoHandler
        {
            return this._ioHandler;
        }// end function

        public function onPacketRead(param1:ByteArray) : void
        {
            param1.position = 0;
            this.dispatchRequest(param1);
            return;
        }// end function

        public function set ioHandler(param1:IoHandler) : void
        {
            if (this._ioHandler != null)
            {
                throw new BZError("IOHandler is already defined for thir ProtocolHandler instance: " + this);
            }
            this._ioHandler = this.ioHandler;
            return;
        }// end function

        private function dispatchRequest(param1:ByteArray) : void
        {
            if (param1.length < 3)
            {
                throw new BZCodecError("Request rejected: No Controller ID in request!");
            }
            var _loc_2:* = new Message();
            _loc_2.targetController = param1.readByte();
            _loc_2.id = param1.readShort();
            _loc_2.content = param1;
            var _loc_3:* = this.ezClient.getController(_loc_2.targetController);
            if (_loc_3 == null)
            {
                throw new BZError("Cannot handle server response. Unknown controller, id: " + _loc_2.targetController);
            }
            _loc_3.handleMessage(_loc_2);
            return;
        }// end function

        public function onPacketWrite(param1:IMessage) : void
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeByte(param1.targetController);
            _loc_2.writeShort(param1.id);
            _loc_2.writeBytes(param1.content, 0, param1.content.length);
            param1.content = _loc_2;
            this.ioHandler.onDataWrite(param1);
            return;
        }// end function

    }
}
