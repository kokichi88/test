package network.receive
{
    import bitzero.net.data.*;

    public class UpgradeMsg extends BaseMsg
    {
        public var autoId:int;
        public var startTime:Number;

        public function UpgradeMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.autoId = readInt();
            this.startTime = readLong();
            return true;
        }// end function

    }
}
