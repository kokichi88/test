package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class RequestTroopCmd extends BaseCmd
    {
        public var msg:String = "";

        public function RequestTroopCmd()
        {
            super(Command.REQUEST_TROOP);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.msg);
            return true;
        }// end function

    }
}
