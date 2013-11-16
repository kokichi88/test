package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class DonateTroopCmd extends BaseCmd
    {
        public var friendId:int = 0;
        public var type:String;

        public function DonateTroopCmd()
        {
            super(Command.DONATE_TROOP);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.friendId);
            this.bodys.writeInt(1);
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(1);
            return true;
        }// end function

    }
}
