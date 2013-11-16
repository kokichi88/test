package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class HarvestCmd extends BaseCmd
    {
        public var ResourceAutoId:int = 0;
        public var ResourceType:String = "";

        public function HarvestCmd()
        {
            super(Command.HARVEST);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.ResourceAutoId);
            this.bodys.writeUTF(this.ResourceType);
            return true;
        }// end function

    }
}
