package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class FinishTrainTroopCmd extends BaseCmd
    {
        public var troopType:String = "";
        public var barrackId:int = 0;

        public function FinishTrainTroopCmd()
        {
            super(Command.FINISH_TRAIN_TROOP);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.troopType);
            this.bodys.writeInt(this.barrackId);
            return true;
        }// end function

    }
}
