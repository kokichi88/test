package bitzero.controllers.system
{

    public class SystemRequest extends Object
    {
        public static const PrivateMessage:int = 21;
        public static const ManualDisconnection:int = 26;
        public static const ObjectMessage:int = 10;
        public static const Logout:int = 2;
        public static const PublicMessage:int = 20;
        public static const Login:int = 1;
        public static const GenericMessage:int = 7;
        public static const KickUser:int = 24;
        public static const Handshake:int = 0;
        public static const AdminMessage:int = 23;
        public static const CallExtension:int = 13;
        public static const ModeratorMessage:int = 22;
        public static const BanUser:int = 25;
        public static const CreateBZGame:int = 302;
        public static const ClientDisconnection:int = 37;
        public static const PingPong:int = 50;

        public function SystemRequest()
        {
            return;
        }// end function

    }
}
