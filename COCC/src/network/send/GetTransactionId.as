package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class GetTransactionId extends BaseCmd
    {
        public var friendId:int = 0;

        public function GetTransactionId()
        {
            super(Command.GET_TRANS_ID);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.friendId);
            return true;
        }// end function

    }
}
