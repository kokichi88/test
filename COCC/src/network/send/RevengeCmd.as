package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class RevengeCmd extends BaseCmd
    {
        public var id:int = 0;

        public function RevengeCmd()
        {
            super(Command.BATTLE_REVENGE);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.id);
            return true;
        }// end function

    }
}
