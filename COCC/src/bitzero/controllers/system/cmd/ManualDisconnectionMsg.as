package bitzero.controllers.system.cmd
{
    import bitzero.controllers.system.*;
    import bitzero.net.data.*;

    public class ManualDisconnectionMsg extends BaseCmd
    {

        public function ManualDisconnectionMsg()
        {
            super(SystemRequest.ManualDisconnection);
            ControllerId = 0;
            return;
        }// end function

    }
}
