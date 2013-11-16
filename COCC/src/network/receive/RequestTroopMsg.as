package network.receive
{
    import bitzero.net.data.*;

    public class RequestTroopMsg extends BaseMsg
    {
        public var sender:int;
        public var msg:String;
        public var curTroopCapacity:int;
        public var maxTroopCapacity:int;

        public function RequestTroopMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            this.sender = readInt();
            this.msg = readStr();
            this.curTroopCapacity = readInt();
            this.maxTroopCapacity = readInt();
            return true;
        }// end function

    }
}
