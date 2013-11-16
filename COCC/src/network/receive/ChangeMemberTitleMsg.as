package network.receive
{
    import bitzero.net.data.*;

    public class ChangeMemberTitleMsg extends BaseMsg
    {

        public function ChangeMemberTitleMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            return true;
        }// end function

    }
}
