package network.receive
{
    import bitzero.net.data.*;

    public class GetCurTimeMsg extends BaseMsg
    {
        public var curTime:Number = 0;

        public function GetCurTimeMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.curTime = readLong();
            return true;
        }// end function

    }
}
