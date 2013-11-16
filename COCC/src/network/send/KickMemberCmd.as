package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class KickMemberCmd extends BaseCmd
    {
        public var memberId:int = 0;

        public function KickMemberCmd()
        {
            super(Command.KICK_MEMBER);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.memberId);
            return true;
        }// end function

    }
}
