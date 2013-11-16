package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class JoinClanCmd extends BaseCmd
    {
        public var clanId:int = 0;

        public function JoinClanCmd()
        {
            super(Command.JOIN_CLAN);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.clanId);
            return true;
        }// end function

    }
}
