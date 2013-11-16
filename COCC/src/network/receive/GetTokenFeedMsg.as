package network.receive
{
    import bitzero.net.data.*;

    public class GetTokenFeedMsg extends BaseMsg
    {
        public var token:String;
        public var feedId:int;
        public var userName:String;
        public var appId:int;

        public function GetTokenFeedMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.feedId = readInt();
            this.appId = readInt();
            this.userName = readStr();
            this.token = readStr();
            return true;
        }// end function

    }
}
