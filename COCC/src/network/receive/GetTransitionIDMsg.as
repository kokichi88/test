package network.receive
{
    import bitzero.net.data.*;

    public class GetTransitionIDMsg extends BaseMsg
    {
        public var transId:Number = 0;
        public var appId:int = 0;
        public var appData:String = "";

        public function GetTransitionIDMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.transId = readLong();
            this.appId = readInt();
            this.appData = readStr();
            return true;
        }// end function

    }
}
