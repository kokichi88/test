package bitzero.controllers.system.cmd
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;

    public class GenericMessageMsg extends BaseMsg
    {
        public var sender:String = "";
        public var message:String = "";
        public var params:Vector.<String>;

        public function GenericMessageMsg(param1:Object)
        {
            this.params = new Vector.<String>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            this.sender = readStr();
            this.message = readStr();
            this.params = readStringArray();
            return true;
        }// end function

    }
}
