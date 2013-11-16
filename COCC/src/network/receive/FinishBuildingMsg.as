package network.receive
{
    import bitzero.net.data.*;

    public class FinishBuildingMsg extends BaseMsg
    {
        public var autoId:int = 0;

        public function FinishBuildingMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.autoId = readInt();
            return true;
        }// end function

    }
}
