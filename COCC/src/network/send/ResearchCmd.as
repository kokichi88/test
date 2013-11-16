package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class ResearchCmd extends BaseCmd
    {
        public var troopType:String = "";

        public function ResearchCmd()
        {
            super(Command.RESEARCH);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.troopType);
            return true;
        }// end function

    }
}
