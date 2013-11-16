package network.receive
{
    import bitzero.net.data.*;

    public class ServerMaintainMsg extends BaseMsg
    {
        public var time:int;

        public function ServerMaintainMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.time = readInt();
            return true;
        }// end function

    }
}
