package bitzero.controllers.system.cmd
{
    import bitzero.controllers.system.*;
    import bitzero.net.data.*;

    public class HandShakeCmd extends BaseCmd
    {
        public var token:String = "";

        public function HandShakeCmd(param1:String)
        {
            super(SystemRequest.Handshake);
            this.token = param1;
            ControllerId = 0;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            bodys.writeUTF(this.token);
            return true;
        }// end function

    }
}
