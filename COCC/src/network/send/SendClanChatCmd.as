package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class SendClanChatCmd extends BaseCmd
    {
        public var msg:String;

        public function SendClanChatCmd(param1:String)
        {
            super(Command.SEND_CLAN_CHAT);
            this.msg = param1;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.msg);
            return true;
        }// end function

    }
}
