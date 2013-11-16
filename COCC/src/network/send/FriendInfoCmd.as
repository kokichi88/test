package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class FriendInfoCmd extends BaseCmd
    {
        public var friendId:int = 0;

        public function FriendInfoCmd()
        {
            super(Command.GET_FRIEND_INFO);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.friendId);
            return true;
        }// end function

    }
}
