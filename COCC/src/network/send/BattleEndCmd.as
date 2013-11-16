package network.send
{
    import bitzero.net.data.*;
    import network.*;

    public class BattleEndCmd extends BaseCmd
    {
        public var endLoop:int = 0;
        public var numStar:int = 0;
        public var goldRop:int = 0;
        public var elixirRop:int = 0;
        public var darkElixirRop:int = 0;
        public var trophyRop:int = 0;
        public var percentLife:int = 0;
        public var str:String = "";

        public function BattleEndCmd(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:String)
        {
            super(Command.BATTLE_END);
            this.endLoop = param1;
            this.numStar = param2;
            this.goldRop = param3;
            this.elixirRop = param4;
            this.darkElixirRop = param5;
            this.trophyRop = param6;
            this.percentLife = param7;
            this.str = param8;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeInt(this.endLoop);
            this.bodys.writeInt(this.numStar);
            this.bodys.writeInt(this.goldRop);
            this.bodys.writeInt(this.elixirRop);
            this.bodys.writeInt(this.darkElixirRop);
            this.bodys.writeInt(this.trophyRop);
            this.bodys.writeInt(this.percentLife);
            this.bodys.writeUTF(this.str);
            return true;
        }// end function

    }
}
