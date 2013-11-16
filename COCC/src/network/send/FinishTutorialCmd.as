package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class FinishTutorialCmd extends BaseCmd
    {

        public function FinishTutorialCmd()
        {
            super(Command.FINISH_TUT);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
