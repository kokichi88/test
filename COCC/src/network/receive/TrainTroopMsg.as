package network.receive
{
    import bitzero.net.data.*;

    public class TrainTroopMsg extends BaseMsg
    {
        public var barrackAutoId:int;
        public var startTime:Number;
        public var queueSize:int;

        public function TrainTroopMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.barrackAutoId = readInt();
            this.startTime = readLong();
            this.queueSize = readInt();
            return true;
        }// end function

    }
}
