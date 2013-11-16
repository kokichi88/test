package network.receive
{
    import bitzero.net.data.*;

    public class SingleEndMsg extends BaseMsg
    {
        public var currentLevel:int = 0;

        public function SingleEndMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.currentLevel = readInt();
            return true;
        }// end function

    }
}
