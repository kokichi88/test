package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class CancelPlacingCmd extends BaseCmd
    {
        public var type:String = "";
        public var autoId:int = 0;

        public function CancelPlacingCmd()
        {
            super(Command.CANCEL_PLACING);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.autoId);
            this.bodys.writeUTF(this.type);
            return true;
        }// end function

    }
}
