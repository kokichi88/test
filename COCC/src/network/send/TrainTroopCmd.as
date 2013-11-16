package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class TrainTroopCmd extends BaseCmd
    {
        public var barrackAutoId:int = 0;
        public var troopType:String = "";
        public var troopNumber:int = 0;

        public function TrainTroopCmd()
        {
            super(Command.TRAIN_TROOP);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.barrackAutoId);
            this.bodys.writeUTF(this.troopType);
            this.bodys.writeInt(this.troopNumber);
            return true;
        }// end function

    }
}
