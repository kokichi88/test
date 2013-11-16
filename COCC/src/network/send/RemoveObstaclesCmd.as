package network.send
{
    import bitzero.net.data.*;

    public class RemoveObstaclesCmd extends BaseCmd
    {
        public var type:String;
        public var autoId:int;
        public var builderId:int;

        public function RemoveObstaclesCmd(param1:int, param2:String, param3:int, param4:int)
        {
            super(param1);
            this.type = param2;
            this.autoId = param3;
            this.builderId = param4;
            return;
        }// end function

        override public function createBody() : Boolean
        {
            this.bodys.writeUTF(this.type);
            this.bodys.writeInt(this.autoId);
            this.bodys.writeInt(this.builderId);
            return true;
        }// end function

    }
}
