package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class GetInfoReplayBattle extends BaseCmd
    {
        public var key:int = 0;
        public var mode:int = 0;

        public function GetInfoReplayBattle()
        {
            super(Command.REPLAY_BATTLE_INFO);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.key);
            this.bodys.writeInt(this.mode);
            return true;
        }// end function

    }
}
