package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class QuickFinishCmd extends BaseCmd
    {
        public var type:String;
        public var autoId:int;

        public function QuickFinishCmd()
        {
            super(Command.QUICK_FINISH);
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
