package network.receive
{
    import bitzero.net.data.*;

    public class BetaUserPromoteMsg extends BaseMsg
    {
        public var promoteG:int = 0;
        public var coin:int = 0;

        public function BetaUserPromoteMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.promoteG = readInt();
            this.coin = readInt();
            return true;
        }// end function

    }
}
