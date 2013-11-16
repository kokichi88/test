package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class BuyResourceCmd extends BaseCmd
    {
        public var number:int = 0;
        public var type:String = "";
        public var cost:int = 0;

        public function BuyResourceCmd()
        {
            super(Command.BUY_RESOURCE);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.number);
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(this.cost);
            return true;
        }// end function

    }
}
