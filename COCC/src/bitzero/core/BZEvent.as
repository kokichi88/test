package bitzero.core
{
    import flash.events.*;

    public class BZEvent extends BaseEvent
    {
        public static const OBJECT_MESSAGE:String = "objectMessage";
        public static const LOGOUT:String = "logout";
        public static const PRIVATE_MESSAGE:String = "privateMessage";
        public static const MODERATOR_MESSAGE:String = "moderatorMessage";
        public static const PUBLIC_MESSAGE:String = "publicMessage";
        public static const CONNECTION_RESUME:String = "connectionResume";
        public static const LOGIN:String = "login";
        public static const HANDSHAKE:String = "handshake";
        public static const PINGPONG:String = "pingpong";
        public static const CONNECTION:String = "connection";
        public static const EXTENSION_RESPONSE:String = "extensionResponse";
        public static const CONNECTION_LOST:String = "connectionLost";
        public static const ADMIN_MESSAGE:String = "adminMessage";
        public static const CONNECTION_RETRY:String = "connectionRetry";
        public static const LOGIN_ERROR:String = "loginError";
        public static const CONFIG_LOAD_FAILURE:String = "configLoadFailure";
        public static const CONFIG_LOAD_SUCCESS:String = "configLoadSuccess";
        public static const SYSTEM_MESSAGE:String = "systemMessage";

        public function BZEvent(param1:String, param2:Object)
        {
            super(param1);
            this.params = param2;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("BZEvent", "type", "bubbles", "cancelable", "eventPhase", "params");
        }// end function

        override public function clone() : Event
        {
            return new BZEvent(this.type, this.params);
        }// end function

    }
}
