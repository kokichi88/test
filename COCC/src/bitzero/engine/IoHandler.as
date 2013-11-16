package bitzero.engine
{
    import bitzero.protocol.*;
    import flash.utils.*;

    public interface IoHandler
    {

        public function IoHandler();

        function get codec() : IProtocolCodec;

        function onDataWrite(param1:IMessage) : void;

        function onDataRead(param1:ByteArray) : void;

    }
}
