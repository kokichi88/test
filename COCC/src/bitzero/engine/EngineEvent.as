package bitzero.engine
{
    import bitzero.core.*;

    public class EngineEvent extends BaseEvent
    {
        public static const SECURITY_ERROR:String = "securityError";
        public static const CONNECT:String = "connect";
        public static const DISCONNECT:String = "disconnect";
        public static const RECONNECTION_TRY:String = "reconnectionTry";
        public static const IO_ERROR:String = "ioError";

        public function EngineEvent(param1:String, param2:Object = null)
        {
            super(param1);
            this.params = param2;
            return;
        }// end function

    }
}
