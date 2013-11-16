package bitzero.controllers.system.cmd
{
    import bitzero.net.data.*;

    public class HandShakeMsg extends BaseMsg
    {
        public var token:String = "";
        public var reconnectTime:int = 5;

        public function HandShakeMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            this.token = readStr();
            this.reconnectTime = readInt();
            return true;
        }// end function

    }
}
