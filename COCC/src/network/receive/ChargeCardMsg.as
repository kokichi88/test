﻿package network.receive
{
    import bitzero.net.data.*;

    public class ChargeCardMsg extends BaseMsg
    {
        public var coin:Number;

        public function ChargeCardMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            this.coin = readLong();
            return true;
        }// end function

    }
}
