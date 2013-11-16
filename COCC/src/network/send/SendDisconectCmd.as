package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class SendDisconectCmd extends BaseCmd
    {

        public function SendDisconectCmd()
        {
            super(Command.DISCONNECT);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
