package bitzero.util
{

    public class ClientDisconnectionReason extends Object
    {
        public static const KICK:String = "kick";
        public static const UNKNOWN:String = "unknown";
        public static const MANUAL:String = "manual";
        public static const IDLE:String = "idle";
        public static const BAN:String = "ban";
        public static const LOGIN:String = "login";
        public static const HANDSHAKE:String = "handshake";
        private static var reasons:Array = [IDLE, KICK, BAN, LOGIN, UNKNOWN, HANDSHAKE];

        public function ClientDisconnectionReason()
        {
            reasons = [IDLE, KICK, BAN, LOGIN, UNKNOWN, HANDSHAKE];
            return;
        }// end function

        public static function getReason(param1:int) : String
        {
            return reasons[param1];
        }// end function

    }
}
