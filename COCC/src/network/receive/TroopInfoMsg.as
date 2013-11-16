package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import modules.battle.data.*;

    public class TroopInfoMsg extends BaseMsg
    {
        public var troopList:Vector.<Troop>;

        public function TroopInfoMsg(param1:Object)
        {
            this.troopList = new Vector.<Troop>;
            super(param1);
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Troop = null;
            errorCode = readInt();
            _loc_1 = readInt();
            _loc_2 = 0;
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
