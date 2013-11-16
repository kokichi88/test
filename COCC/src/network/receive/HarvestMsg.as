package network.receive
{
    import bitzero.net.data.*;

    public class HarvestMsg extends BaseMsg
    {
        public var autoId:int = 0;
        public var income:int = 0;
        public var startTime:Number = 0;

        public function HarvestMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.autoId = readInt();
            this.income = readInt();
            this.startTime = readLong();
            return true;
        }// end function

    }
}
