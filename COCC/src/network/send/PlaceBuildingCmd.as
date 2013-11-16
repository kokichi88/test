package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class PlaceBuildingCmd extends BaseCmd
    {
        public var type:String = "";
        public var posX:int = 0;
        public var posY:int = 0;
        public var builder:int = 0;

        public function PlaceBuildingCmd()
        {
            super(Command.PLACE_BUILDING);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(this.posX);
            this.bodys.writeInt(this.posY);
            this.bodys.writeInt(this.builder);
            return true;
        }// end function

    }
}
