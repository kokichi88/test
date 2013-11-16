package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class LoginCmd extends BaseCmd
    {
        public var id:int;
        public var signed_request:String;
        public var authorizationCode:String;

        public function LoginCmd()
        {
            this.id = Config.uId;
            this.signed_request = Config.signed_request;
            this.authorizationCode = Config.authorizationCode;
            super(Command.LOGIN);
            if (!this.signed_request)
            {
                this.signed_request = "";
            }
            if (!this.authorizationCode)
            {
                this.authorizationCode = "";
            }
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.id);
            this.bodys.writeUTF(this.signed_request);
            this.bodys.writeUTF(this.authorizationCode);
            return true;
        }// end function

    }
}
