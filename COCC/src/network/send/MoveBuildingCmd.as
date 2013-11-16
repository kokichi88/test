package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class MoveBuildingCmd extends BaseCmd
    {
        public var type:String = "";
        public var autoId:int = 0;
        public var posX:int = 0;
        public var posY:int = 0;

        public function MoveBuildingCmd()
        {
            super(Command.MOVE_BUILDING);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(this.autoId);
            this.bodys.writeInt(this.posX);
            this.bodys.writeInt(this.posY);
            return true;
        }// end function

    }
}
