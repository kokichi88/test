package network.receive
{
    import bitzero.net.data.*;

    public class SendClanChatMsg extends BaseMsg
    {
        public var sender:int;
        public var msg:String;

        public function SendClanChatMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            this.sender = readInt();
            this.msg = readStr();
            return true;
        }// end function

    }
}
