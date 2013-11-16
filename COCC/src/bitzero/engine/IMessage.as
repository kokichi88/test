package bitzero.engine
{
    import flash.utils.*;

    public interface IMessage
    {

        public function IMessage();

        function get isEncrypted() : Boolean;

        function set content(param1:ByteArray) : void;

        function set isEncrypted(param1:Boolean) : void;

        function set id(param1:int) : void;

        function get content() : ByteArray;

        function set targetController(param1:int) : void;

        function get id() : int;

        function get targetController() : int;

    }
}
