package bitzero.net.events
{
    import bitzero.engine.*;
    import flash.events.*;
    import flash.utils.*;

    public class MsgInfo extends Event
    {
        private var msg:IMessage;
        private var err:int = -1000;

        public function MsgInfo(param1:IMessage = null)
        {
            super(param1.id.toString());
            this.msg = param1;
            return;
        }// end function

        public function get Data() : ByteArray
        {
            return this.msg.content;
        }// end function

        public function get ErrorCode() : int
        {
            if (this.err == -1000)
            {
                this.err = this.msg.content.readByte();
                var _loc_1:* = this.msg.content;
                var _loc_2:* = this.msg.content.position - 1;
                _loc_1.position = _loc_2;
            }
            return this.err;
        }// end function

        override public function toString() : String
        {
            return formatToString("MsgInfo", "type", "bubbles", "cancelable", "eventPhase", "params");
        }// end function

        override public function clone() : Event
        {
            return new MsgInfo(this.msg);
        }// end function

    }
}
