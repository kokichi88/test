package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class QuestInfoCmd extends BaseCmd
    {

        public function QuestInfoCmd()
        {
            super(Command.GET_QUEST_INFO);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            return true;
        }// end function

    }
}
