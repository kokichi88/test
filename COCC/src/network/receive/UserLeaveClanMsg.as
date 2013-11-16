package network.receive
{
    import bitzero.net.data.*;

    public class UserLeaveClanMsg extends BaseMsg
    {
        public var userId:int = 0;

        public function UserLeaveClanMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.userId = readInt();
            return true;
        }// end function

    }
}
