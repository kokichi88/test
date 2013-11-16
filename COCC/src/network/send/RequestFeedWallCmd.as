package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class RequestFeedWallCmd extends BaseCmd
    {
        public var idFeed:int;

        public function RequestFeedWallCmd(param1:int)
        {
            super(Command.GET_TOKEN_FEED);
            this.idFeed = param1;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.idFeed);
            return true;
        }// end function

    }
}
