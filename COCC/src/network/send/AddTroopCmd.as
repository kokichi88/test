package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class AddTroopCmd extends BaseCmd
    {
        public var type:String;
        public var cell:int;
        public var nLoop:int;

        public function AddTroopCmd(param1:String, param2:int, param3:int)
        {
            super(Command.BATTLE_PUT_TROOP);
            this.type = param1;
            this.cell = param2;
            this.nLoop = param3;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(this.cell);
            this.bodys.writeInt(this.nLoop);
            return true;
        }// end function

    }
}
