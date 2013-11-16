package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class GetClanDetailCmd extends BaseCmd
    {
        public var clanId:int = 0;

        public function GetClanDetailCmd()
        {
            super(Command.GET_CLAN_DETAIL);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.clanId);
            return true;
        }// end function

    }
}
