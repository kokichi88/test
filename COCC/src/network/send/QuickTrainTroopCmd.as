package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class QuickTrainTroopCmd extends BaseCmd
    {
        public var barrackId:int = 0;

        public function QuickTrainTroopCmd()
        {
            super(Command.QUICK_TRAINING);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.barrackId);
            return true;
        }// end function

    }
}
