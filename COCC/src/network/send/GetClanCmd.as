package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class GetClanCmd extends BaseCmd
    {

        public function GetClanCmd()
        {
            super(Command.GET_CLANS);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
