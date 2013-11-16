package network.receive
{
    import bitzero.net.data.*;

    public class UpdateMoneyMsg extends BaseMsg
    {
        public var coin:int = 0;

        public function UpdateMoneyMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.coin = readInt();
            return true;
        }// end function

    }
}
