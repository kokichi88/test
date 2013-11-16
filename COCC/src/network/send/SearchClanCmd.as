package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class SearchClanCmd extends BaseCmd
    {
        public var key:String = "";

        public function SearchClanCmd()
        {
            super(Command.SEARCH_CLAN);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.key);
            return true;
        }// end function

    }
}
