package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class SendGetCurTime extends BaseCmd
    {

        public function SendGetCurTime()
        {
            super(Command.GET_CURRENT_TIME);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
