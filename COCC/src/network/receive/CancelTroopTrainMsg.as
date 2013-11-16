package network.receive
{
    import bitzero.net.data.*;

    public class CancelTroopTrainMsg extends BaseMsg
    {
        public var startTime:Number;

        public function CancelTroopTrainMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.startTime = readLong();
            return true;
        }// end function

    }
}
