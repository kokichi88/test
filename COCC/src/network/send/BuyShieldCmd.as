package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class BuyShieldCmd extends BaseCmd
    {
        public var shieldId:int = 0;

        public function BuyShieldCmd()
        {
            super(Command.BUY_SHIELD_TIME);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.shieldId);
            return true;
        }// end function

    }
}
