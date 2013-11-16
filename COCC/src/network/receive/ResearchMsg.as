package network.receive
{
    import bitzero.net.data.*;

    public class ResearchMsg extends BaseMsg
    {
        public var startTime:Number;

        public function ResearchMsg(param1:Object)
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
