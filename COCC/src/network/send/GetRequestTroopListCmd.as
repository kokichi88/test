package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class GetRequestTroopListCmd extends BaseCmd
    {

        public function GetRequestTroopListCmd()
        {
            super(Command.GET_TROOP_REQUEST);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
