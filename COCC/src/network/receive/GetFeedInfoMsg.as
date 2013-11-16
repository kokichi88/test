package network.receive
{
    import bitzero.net.data.*;

    public class GetFeedInfoMsg extends BaseMsg
    {
        public var feed:String;

        public function GetFeedInfoMsg(param1:Object)
        {
            this.feed = new String();
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.feed = readStr();
            return true;
        }// end function

    }
}
