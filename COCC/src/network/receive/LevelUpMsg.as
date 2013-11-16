package network.receive
{
    import bitzero.net.data.*;

    public class LevelUpMsg extends BaseMsg
    {
        public var level:int;
        public var exp:int;

        public function LevelUpMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.level = readInt();
            this.exp = readInt();
            return true;
        }// end function

    }
}
