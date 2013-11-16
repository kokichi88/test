package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class BattleInfoCmd extends BaseCmd
    {
        public var mode:int = 0;

        public function BattleInfoCmd(param1:int = 0)
        {
            super(Command.GET_BATTLE_INFO);
            this.mode = param1;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.mode);
            return true;
        }// end function

    }
}
