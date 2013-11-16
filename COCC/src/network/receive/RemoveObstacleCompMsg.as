package network.receive
{
    import bitzero.net.data.*;

    public class RemoveObstacleCompMsg extends BaseMsg
    {
        public var autoId:int;
        public var exp:int;
        public var coin:int;

        public function RemoveObstacleCompMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.autoId = readInt();
            this.exp = readInt();
            this.coin = readInt();
            return true;
        }// end function

    }
}
