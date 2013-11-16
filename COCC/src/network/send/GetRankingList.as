package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class GetRankingList extends BaseCmd
    {

        public function GetRankingList()
        {
            super(Command.RANKING_LIST);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
