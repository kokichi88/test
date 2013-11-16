package bitzero.core
{
    import bitzero.engine.*;
    import bitzero.exceptions.*;
    import bitzero.logging.*;
    import bitzero.protocol.*;
    import bitzero.protocol.serialization.*;
    import flash.errors.*;
    import flash.utils.*;

    public class BZIOHandler extends Object implements IoHandler
    {
        private const EMPTY_BUFFER:ByteArray;
        private var ezClient:EngineClient;
        private var log:Logger;
        private var readState:int;
        private var protocolCodec:IProtocolCodec;
        private var pendingPacket:PendingPacket;
        public static const INT_BYTE_SIZE:int = 4;
        public static const SHORT_BYTE_SIZE:int = 2;

        public function BZIOHandler(param1:EngineClient)
        {
            this.EMPTY_BUFFER = new ByteArray();
            this.ezClient = param1;
            this.log = Logger.getInstance();
            this.readState = PacketReadState.WAIT_NEW_PACKET;
            this.protocolCodec = new BZProtocolCodec(this, param1);
            return;
        }// end function

        private function handleNewPacket(param1:ByteArray) : ByteArray
        {
            this.log.debug("Handling New Packet");
            var _loc_2:* = param1.readByte();
            if (!(_loc_2 & 128) > 0)
            {
                throw new BZError("Unexpected header byte: " + _loc_2);
            }
            var _loc_3:* = PacketHeader.fromBinary(_loc_2);
            this.pendingPacket = new PendingPacket(_loc_3);
            this.readState = PacketReadState.WAIT_DATA_SIZE;
            return this.resizeByteArray(param1, 1, (length - 1));
        }// end function

        private function handlePacketData(param1:ByteArray) : ByteArray
        {
            var _loc_2:* = this.pendingPacket.header.expectedLen - this.pendingPacket.buffer.length;
            var _loc_3:* = param1.length > _loc_2;
            this.log.debug("Handling Data: " + param1.length + ", previous state: " + this.pendingPacket.buffer.length + "/" + this.pendingPacket.header.expectedLen);
            if (param1.length >= _loc_2)
            {
                this.pendingPacket.buffer.writeBytes(param1, 0, _loc_2);
                this.log.debug("<<< Packet Complete >>>");
                if (this.pendingPacket.header.compressed)
                {
                    this.pendingPacket.buffer.uncompress();
                }
                this.protocolCodec.onPacketRead(this.pendingPacket.buffer);
                this.readState = PacketReadState.WAIT_NEW_PACKET;
            }
            else
            {
                this.pendingPacket.buffer.writeBytes(param1);
            }
            if (_loc_3)
            {
                param1 = this.resizeByteArray(param1, _loc_2, param1.length - _loc_2);
            }
            else
            {
                param1 = this.EMPTY_BUFFER;
            }
            return param1;
        }// end function

        private function handleDataSize(param1:ByteArray) : ByteArray
        {
            this.log.debug("Handling Header Size. Size: " + param1.length + " (" + (this.pendingPacket.header.bigSized ? ("big") : ("small")) + ")");
            var _loc_2:int = -1;
            var _loc_3:int = 2;
            if (this.pendingPacket.header.bigSized)
            {
                if (param1.length >= 4)
                {
                    _loc_2 = param1.readInt();
                }
                _loc_3 = 4;
            }
            else if (param1.length >= 2)
            {
                _loc_2 = param1.readShort();
            }
            if (_loc_2 == -1)
            {
                this.readState = PacketReadState.WAIT_DATA_SIZE_FRAGMENT;
                this.pendingPacket.buffer.writeBytes(param1);
                param1 = this.EMPTY_BUFFER;
            }
            else
            {
                this.pendingPacket.header.expectedLen = _loc_2;
                param1 = this.resizeByteArray(param1, _loc_3, param1.length - _loc_3);
                this.readState = PacketReadState.WAIT_DATA;
            }
            return param1;
        }// end function

        private function handleDataSizeFragment(param1:ByteArray) : ByteArray
        {
            var _loc_2:int = 0;
            this.log.debug("Handling Size fragment. Data: " + param1.length);
            var _loc_3:* = this.pendingPacket.header.bigSized ? (4 - this.pendingPacket.buffer.position) : (2 - this.pendingPacket.buffer.position);
            if (param1.length >= _loc_3)
            {
                this.pendingPacket.buffer.writeBytes(param1, 0, _loc_3);
                this.pendingPacket.buffer.position = 0;
                _loc_2 = this.pendingPacket.header.bigSized ? (this.pendingPacket.buffer.readInt()) : (this.pendingPacket.buffer.readShort());
                this.log.debug("DataSize is ready:", _loc_2, "bytes");
                this.pendingPacket.header.expectedLen = _loc_2;
                this.pendingPacket.buffer = new ByteArray();
                this.readState = PacketReadState.WAIT_DATA;
                if (param1.length > _loc_3)
                {
                    param1 = this.resizeByteArray(param1, _loc_3, param1.length - _loc_3);
                }
                else
                {
                    param1 = this.EMPTY_BUFFER;
                }
            }
            else
            {
                this.pendingPacket.buffer.writeBytes(param1);
                param1 = this.EMPTY_BUFFER;
            }
            return param1;
        }// end function

        public function onDataRead(param1:ByteArray) : void
        {
            if (this.ezClient.bz.debug)
            {
                this.log.info("Data Read: " + DefaultObjectDumpFormatter.hexDump(param1));
            }
            param1.position = 0;
            if (param1.length == 0)
            {
                throw new BZError("Unexpected empty packet data: no readable bytes available!");
            }
            while (param1.length > 0)
            {
                
                if (this.readState == PacketReadState.WAIT_NEW_PACKET)
                {
                    param1 = this.handleNewPacket(param1);
                }
                if (this.readState == PacketReadState.WAIT_DATA_SIZE)
                {
                    param1 = this.handleDataSize(param1);
                }
                if (this.readState == PacketReadState.WAIT_DATA_SIZE_FRAGMENT)
                {
                    param1 = this.handleDataSizeFragment(param1);
                }
                if (this.readState != PacketReadState.WAIT_DATA)
                {
                    continue;
                }
                param1 = this.handlePacketData(param1);
            }
            return;
        }// end function

        private function resizeByteArray(param1:ByteArray, param2:int, param3:int) : ByteArray
        {
            var _loc_4:* = new ByteArray();
            new ByteArray().writeBytes(param1, param2, param3);
            _loc_4.position = 0;
            return _loc_4;
        }// end function

        public function get codec() : IProtocolCodec
        {
            return this.protocolCodec;
        }// end function

        public function onDataWrite(param1:IMessage) : void
        {
            var binData:ByteArray;
            var message:IMessage;
            var sizeBytes:int;
            var isCompressed:Boolean;
            var packetHeader:PacketHeader;
            var writeBuffer:ByteArray;
            var loc1:*;
            var msg:* = param1;
            message = msg;
            writeBuffer = new ByteArray();
            binData = message.content;
            binData.position = 0;
            isCompressed;
            if (binData.length > this.ezClient.compressionThreshold)
            {
                binData.compress();
                isCompressed;
            }
            sizeBytes = SHORT_BYTE_SIZE;
            if (binData.length > 65535)
            {
                sizeBytes = INT_BYTE_SIZE;
            }
            packetHeader = new PacketHeader(message.isEncrypted, isCompressed, false, sizeBytes == INT_BYTE_SIZE);
            writeBuffer.writeByte(packetHeader.encode());
            if (sizeBytes > SHORT_BYTE_SIZE)
            {
                writeBuffer.writeInt(binData.length);
            }
            else
            {
                writeBuffer.writeShort(binData.length);
            }
            writeBuffer.writeBytes(binData);
            if (this.ezClient.socket.connected)
            {
                try
                {
                    this.ezClient.socket.writeBytes(writeBuffer);
                    this.ezClient.socket.flush();
                    if (this.ezClient.bz.debug)
                    {
                        this.log.info("Data written: " + message.content.toString());
                    }
                }
                catch (error:IOError)
                {
                    log.warn("Write operation failed due to I/O Error: " + error.toString());
                }
            }
            return;
        }// end function

    }
}
