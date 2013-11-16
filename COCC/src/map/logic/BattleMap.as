package map.logic
{
    import __AS3__.vec.*;
    import map.AStar.findPath.*;
    import map.AStar.findPath.heuristics.*;

    public class BattleMap extends BaseMap
    {

        public function BattleMap()
        {
            MaxHalfWidth = 38 / 3;
            MaxHalfHeight = 28.5 / 3;
            maxRow = 132;
            maxCol = 132;
            return;
        }// end function

        public function initMapFinder(param1:int, param2:int) : void
        {
            var _loc_4:int = 0;
            areaMap = new AreaMap(param1, param2);
            var _loc_3:int = 0;
            while (_loc_3 < param1)
            {
                
                _loc_4 = 0;
                while (_loc_4 < param2)
                {
                    
                    areaMap.getNode(_loc_3, _loc_4).deepLv = getCellType(_loc_3 + maxCol * _loc_4);
                    areaMap.getNode(_loc_3, _loc_4).idNode = -1;
                    _loc_4++;
                }
                _loc_3++;
            }
            areaMap.createEdge();
            pathFinder = new AStar(areaMap);
            pathFinder.addHeuristic(new TempHeuristics());
            pathFinder.addHeuristic(new ClosesHeuristic());
            pathFinder.addHeuristic(new IAStartHeuristic1());
            pathFinder.addHeuristic(new IAStartHeuristic2());
            return;
        }// end function

        override public function loadMapData(param1:Vector.<int>) : void
        {
            var _loc_2:int = 0;
            if (param1 == null)
            {
                _loc_2 = 0;
                while (_loc_2 < maxRow * maxCol)
                {
                    
                    mapCells.push(0);
                    _loc_2++;
                }
            }
            this.initMapFinder(maxRow, maxCol);
            return;
        }// end function

        public function setBuilding(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int = -1, param8:int = 3) : void
        {
            var _loc_12:int = 0;
            var _loc_9:* = param8;
            var _loc_10:* = param6;
            var _loc_11:* = -_loc_9;
            while (_loc_11 < param3 + _loc_9)
            {
                
                _loc_12 = -_loc_9;
                while (_loc_12 < param4 + _loc_9)
                {
                    
                    if (_loc_11 <= (_loc_10 - 1) || _loc_12 <= (_loc_10 - 1) || _loc_11 >= param3 - _loc_10 || _loc_12 >= param4 - _loc_10)
                    {
                        if (_loc_11 == (_loc_10 - 1) && (_loc_12 >= (_loc_10 - 1) && _loc_12 <= param4 - _loc_10) || _loc_12 == (_loc_10 - 1) && (_loc_11 >= (_loc_10 - 1) && _loc_11 <= param3 - _loc_10) || _loc_11 == param3 - _loc_10 && (_loc_12 >= (_loc_10 - 1) && _loc_12 <= param4 - _loc_10) || _loc_12 == param4 - _loc_10 && (_loc_11 >= (_loc_10 - 1) && _loc_11 <= param3 - _loc_10))
                        {
                            areaMap.getNode(param1 + _loc_11, param2 + _loc_12).idNode = param7;
                        }
                        setIsoType(param1 + _loc_11, _loc_12 + param2, Math.max(getIsoType(param1 + _loc_11, param2 + _loc_12), BaseMap.CAN_MOVE));
                        areaMap.getNode(param1 + _loc_11, param2 + _loc_12).deepLv = Math.max(BaseMap.CAN_MOVE, areaMap.getNode(param1 + _loc_11, param2 + _loc_12).deepLv);
                    }
                    else
                    {
                        setIsoType(param1 + _loc_11, _loc_12 + param2, param5);
                        areaMap.getNode(param1 + _loc_11, param2 + _loc_12).deepLv = param5;
                        areaMap.getNode(param1 + _loc_11, param2 + _loc_12).idNode = param7;
                    }
                    _loc_12++;
                }
                _loc_11++;
            }
            return;
        }// end function

        public function setWall(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int = -1) : void
        {
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_7:int = 3;
            var _loc_8:* = -3;
            while (_loc_8 < param3 + _loc_7)
            {
                
                _loc_9 = -_loc_7;
                while (_loc_9 < param4 + _loc_7)
                {
                    
                    if (_loc_8 < 0 || _loc_9 < 0 || _loc_8 >= param3 || _loc_9 >= param4)
                    {
                        _loc_10 = Math.max(getIsoType(param1 + _loc_8, param2 + _loc_9), BaseMap.CAN_MOVE);
                        setIsoType(param1 + _loc_8, param2 + _loc_9, _loc_10);
                        areaMap.getNode(param1 + _loc_8, param2 + _loc_9).deepLv = _loc_10;
                    }
                    else
                    {
                        setIsoType(param1 + _loc_8, _loc_9 + param2, param5);
                        areaMap.getNode(param1 + _loc_8, param2 + _loc_9).deepLv = param5;
                        areaMap.getNode(param1 + _loc_8, param2 + _loc_9).idNode = param6;
                    }
                    _loc_9++;
                }
                _loc_8++;
            }
            return;
        }// end function

    }
}
