package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class AckBattleCmd extends BaseCmd
    {
        public var nLoop:int;

        public function AckBattleCmd(param1:int)
        {
            super(Command.BATTLE_ACK);
            this.nLoop = param1;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.nLoop);
            return true;
        }// end function

    }
}
