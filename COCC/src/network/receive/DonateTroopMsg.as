package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import modules.battle.data.*;

    public class DonateTroopMsg extends BaseMsg
    {
        public var sender:int;
        public var receiver:int;
        public var troopList:Vector.<Troop>;

        public function DonateTroopMsg(param1:Object)
        {
            this.troopList = new Vector.<Troop>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_3:Troop = null;
            this.sender = readInt();
            this.receiver = readInt();
            var _loc_1:* = readInt();
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Troop();
                _loc_3.type = readStr();
                _loc_3.level = readInt();
                _loc_3.num = readInt();
                this.troopList.push(_loc_3);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
