﻿package network.receive
{
    import bitzero.net.data.*;

    public class RemoveObstacleMsg extends BaseMsg
    {

        public function RemoveObstacleMsg(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            errorCode = readInt();
            return true;
        }// end function

    }
}
