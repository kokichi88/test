package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class CreateClanCmd extends BaseCmd
    {
        public var name:String = "Test Clan";
        public var icon:int = 1;
        public var type:int = 1;
        public var requiredTrophy:int = 200;
        public var description:String = "test clan";

        public function CreateClanCmd()
        {
            super(Command.CREATE_CLAN);
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.name);
            this.bodys.writeInt(this.icon);
            this.bodys.writeInt(this.type);
            this.bodys.writeInt(this.requiredTrophy);
            this.bodys.writeUTF(this.description);
            return true;
        }// end function

    }
}
