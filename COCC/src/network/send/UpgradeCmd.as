package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class UpgradeCmd extends BaseCmd
    {
        public var autoId:int = 0;
        public var type:String = "";
        public var builder:int = 0;

        public function UpgradeCmd()
        {
            super(Command.UPGRADE_BUILDING);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.autoId);
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(this.builder);
            return true;
        }// end function

    }
}
