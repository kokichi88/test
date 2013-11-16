package network.receive
{
    import bitzero.net.data.*;

    public class NewUserJoinClanMsg extends BaseMsg
    {
        public var userId:int;
        public var trophy:int;
        public var level:int;
        public var name:String;

        public function NewUserJoinClanMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.userId = readInt();
            this.trophy = readInt();
            this.level = readInt();
            this.name = readStr();
            return true;
        }// end function

    }
}
