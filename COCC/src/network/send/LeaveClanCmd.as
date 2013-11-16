package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class LeaveClanCmd extends BaseCmd
    {

        public function LeaveClanCmd()
        {
            super(Command.LEAVE_CLAN);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
