package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class FinishBuildingCmd extends BaseCmd
    {
        public var type:String = "";
        public var autoId:int = 0;

        public function FinishBuildingCmd()
        {
            super(Command.FINISH_BUILDING);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(this.autoId);
            return true;
        }// end function

    }
}
