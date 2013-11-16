package network.receive
{
    import bitzero.net.data.*;

    public class UserKickedMsg extends BaseMsg
    {
        public var userId:int = 0;

        public function UserKickedMsg(param1:Object)
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
