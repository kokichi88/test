package network.receive
{
    import bitzero.net.data.*;

    public class CreateClansMsg extends BaseMsg
    {
        public var clanId:int = 0;

        public function CreateClansMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.clanId = readInt();
            return true;
        }// end function

    }
}
