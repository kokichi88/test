package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class BetaUserPromoteCmd extends BaseCmd
    {

        public function BetaUserPromoteCmd()
        {
            super(Command.BETA_USER_PROMO_RECEIVED);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
