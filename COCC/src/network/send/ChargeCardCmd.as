package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class ChargeCardCmd extends BaseCmd
    {
        public var type:String = "";
        public var code:String = "";
        public var serial:String = "";

        public function ChargeCardCmd()
        {
            super(Command.CHARGE_CARD);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.type);
            this.bodys.writeUTF(this.code);
            this.bodys.writeUTF(this.serial);
            return true;
        }// end function

    }
}
