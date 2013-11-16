package network.receive
{
    import bitzero.net.data.*;

    public class PlaceBuildingMsg extends BaseMsg
    {
        public var buildingAutoId:int;
        public var startTime:Number;

        public function PlaceBuildingMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.buildingAutoId = readInt();
            this.startTime = readLong();
            return true;
        }// end function

    }
}
