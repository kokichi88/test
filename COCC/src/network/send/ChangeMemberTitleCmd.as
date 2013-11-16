package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class ChangeMemberTitleCmd extends BaseCmd
    {
        public var memberId:int = 0;
        public var newTitle:int = 0;

        public function ChangeMemberTitleCmd()
        {
            super(Command.CHANGE_MEMBER_TITLE);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.memberId);
            this.bodys.writeInt(this.newTitle);
            return true;
        }// end function

    }
}
