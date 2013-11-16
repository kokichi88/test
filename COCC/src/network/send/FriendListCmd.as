package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class FriendListCmd extends BaseCmd
    {
        public var isNewest:Boolean = true;

        public function FriendListCmd()
        {
            super(Command.GET_FRIEND_LIST);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeBoolean(this.isNewest);
            return true;
        }// end function

    }
}
