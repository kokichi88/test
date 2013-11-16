package network.receive
{
    import bitzero.net.data.*;

    public class PromoGMsg extends BaseMsg
    {
        public var promoG:int = 0;
        public var coin:int = 0;

        public function PromoGMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.promoG = readInt();
            this.coin = readInt();
            return true;
        }// end function

    }
}
