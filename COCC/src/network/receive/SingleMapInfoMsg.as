package network.receive
{
    import __AS3__.vec.*;
    import bitzero.net.data.*;
    import gameData.*;

    public class SingleMapInfoMsg extends BaseMsg
    {
        public var level:int;
        public var mapInfo:Vector.<PointMap>;

        public function SingleMapInfoMsg(param1:Object = null)
        {
            this.mapInfo = new Vector.<PointMap>;
            if (param1)
            {
                super(param1);
            }
            return;
        }// end function

        override public function parseBody() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            var _loc_4:PointMap = null;
            errorCode = readInt();
            this.level = readInt();
            _loc_1 = readInt();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_4 = new PointMap();
                _loc_4.pId = readInt();
                _loc_4.nStar = readInt();
                _loc_4.level = readInt();
                _loc_4.gold = readInt();
                _loc_4.elixir = readInt();
                this.mapInfo.push(_loc_4);
                _loc_2++;
            }
            return true;
        }// end function

    }
}
