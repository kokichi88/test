package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class SetNameCmd extends BaseCmd
    {
        public var name:String = "";

        public function SetNameCmd()
        {
            super(Command.SET_NAME);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.name);
            return true;
        }// end function

    }
}
