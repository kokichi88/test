package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class GetClanChatCmd extends BaseCmd
    {

        public function GetClanChatCmd()
        {
            super(Command.GET_CLAN_CHAT);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
