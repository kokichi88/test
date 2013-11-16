package bitzero.protocol
{
    import bitzero.engine.*;
    import flash.utils.*;

    public interface IProtocolCodec
    {

        public function IProtocolCodec();

        function onPacketWrite(param1:IMessage) : void;

        function get ioHandler() : IoHandler;

        function onPacketRead(param1:ByteArray) : void;

        function set ioHandler(param1:IoHandler) : void;

    }
}
