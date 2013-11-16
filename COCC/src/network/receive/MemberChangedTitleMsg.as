package network.receive
{
    import bitzero.net.data.*;

    public class MemberChangedTitleMsg extends BaseMsg
    {
        public var memberId:int = 0;
        public var newTitle:int = 0;
        public var promotingId:int = 0;

        public function MemberChangedTitleMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.memberId = readInt();
            this.newTitle = readInt();
            this.promotingId = readInt();
            return true;
        }// end function

    }
}
