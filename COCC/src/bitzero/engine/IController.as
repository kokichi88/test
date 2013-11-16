package bitzero.engine
{

    public interface IController
    {

        public function IController();

        function get id() : int;

        function set id(param1:int) : void;

        function handleMessage(param1:IMessage) : void;

    }
}
