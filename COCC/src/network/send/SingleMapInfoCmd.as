package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class SingleMapInfoCmd extends BaseCmd
    {

        public function SingleMapInfoCmd()
        {
            super(Command.SINGLE_BATTLE_INFO);
            return;
        }// end function

    }
}
