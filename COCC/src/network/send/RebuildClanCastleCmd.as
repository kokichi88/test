package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class RebuildClanCastleCmd extends BaseCmd
    {

        public function RebuildClanCastleCmd()
        {
            super(Command.REBUILD_CLAN_CASTLE);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
