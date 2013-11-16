package map.logic
{
    import __AS3__.vec.*;
    import map.AStar.findPath.*;

    public class CityMap extends BaseMap
    {

        public function CityMap()
        {
            MaxHalfWidth = 38;
            MaxHalfHeight = 28.5;
            maxRow = 44;
            maxCol = 44;
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
            return;
        }// end function

        public function checkValidBuilding(param1:int, param2:int, param3:int, param4:int) : int
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_5:int = 0;
            while (_loc_5 < param3)
            {
                
                _loc_6 = 0;
                while (_loc_6 < param4)
                {
                    
                    if (param1 + _loc_5 < 2 || param2 + _loc_6 < 2 || param1 + _loc_5 >= maxRow - 2 || param2 + _loc_6 >= maxCol - 2)
                    {
                        return CANT_MOVE;
                    }
                    _loc_7 = getIsoType(param1 + _loc_5, param2 + _loc_6);
                    if (_loc_7 != CAN_BUILD)
                    {
                        return _loc_7;
                    }
                    _loc_6++;
                }
                _loc_5++;
            }
            return CAN_BUILD;
        }// end function

        public function setBuilding(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int = -1) : void
        {
            var _loc_8:int = 0;
            var _loc_7:int = 0;
            while (_loc_7 < param3)
            {
                
                _loc_8 = 0;
                while (_loc_8 < param4)
                {
                    
                    setIsoType(param1 + _loc_7, param2 + _loc_8, param5);
                    areaMap.getNode(param1 + _loc_7, param2 + _loc_8).idNode = param6;
                    _loc_8++;
                }
                _loc_7++;
            }
            return;
        }// end function

        override public function clearMap() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < maxRow * maxCol)
            {
                
                setCellType(_loc_1, CAN_BUILD);
                _loc_1++;
            }
            areaMap.clearMap();
            return;
        }// end function

        public function getViewRange() : Vector.<DataCell>
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:DataCell = null;
            var _loc_1:* = maxCol * maxRow;
            var _loc_2:* = new Vector.<DataCell>;
            var _loc_3:int = 1;
            while (_loc_3 < (maxCol - 1))
            {
                
                _loc_4 = 1;
                while (_loc_4 < (maxRow - 1))
                {
                    
                    if (getIsoType(_loc_3, _loc_4) != 1)
                    {
                    }
                    else
                    {
                        _loc_5 = _loc_3 + _loc_4 * maxCol;
                        _loc_6 = new DataCell();
                        _loc_6.isoCell.x = _loc_3;
                        _loc_6.isoCell.y = _loc_4;
                        if (getIsoType(_loc_3, (_loc_4 - 1)) == 0)
                        {
                            if (getIsoType((_loc_3 - 1), _loc_4) == 0)
                            {
                                _loc_6.value = 1;
                                _loc_2.push(_loc_6);
                            }
                            if (getIsoType((_loc_3 + 1), _loc_4) == 0)
                            {
                                _loc_6.value = 3;
                                _loc_2.push(_loc_6);
                            }
                            _loc_6.value = 2;
                            _loc_2.push(_loc_6);
                        }
                        else if (getIsoType(_loc_3, (_loc_4 + 1)) == 0)
                        {
                            if (getIsoType((_loc_3 - 1), _loc_4) == 0)
                            {
                                _loc_6.value = 7;
                                _loc_2.push(_loc_6);
                            }
                            if (getIsoType((_loc_3 + 1), _loc_4) == 0)
                            {
                                _loc_6.value = 5;
                                _loc_2.push(_loc_6);
                            }
                            _loc_6.value = 6;
                            _loc_2.push(_loc_6);
                        }
                        else if (getIsoType((_loc_3 + 1), _loc_4) == 0)
                        {
                            _loc_6.value = 4;
                            _loc_2.push(_loc_6);
                        }
                        else if (getIsoType((_loc_3 - 1), _loc_4) == 0)
                        {
                            _loc_6.value = 8;
                            _loc_2.push(_loc_6);
                            ;
                        }
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

    }
}
