package network.receive
{
    import bitzero.net.data.*;

    public class FinishTrainTroopMsg extends BaseMsg
    {
        public var barrackAutoId:int;
        public var startTime:Number;

        public function FinishTrainTroopMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.barrackAutoId = readInt();
            this.startTime = readLong();
            return true;
        }// end function

    }
}
