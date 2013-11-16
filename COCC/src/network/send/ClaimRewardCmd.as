package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class ClaimRewardCmd extends BaseCmd
    {
        public var questId:int = 0;
        public var questType:String = "";

        public function ClaimRewardCmd()
        {
            super(Command.CLAIM_REWARD);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.questId);
            this.bodys.writeUTF(this.questType);
            return true;
        }// end function

    }
}
