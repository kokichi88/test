package map.logic
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.AStar.findPath.*;
    import map.AStar.findPath.heuristics.*;
    import utility.*;

    public class RangeMap extends BaseMap
    {
        public var countView:int = 0;
        private var my_shape:Shape;
        private static const COUNT_DOWN_VIEW:int = 180;

        public function RangeMap()
        {
            this.my_shape = new Shape();
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
            pathFinder = new AStar(areaMap);
            pathFinder.addHeuristic(new ClosesHeuristic());
            return;
        }// end function

        public function setBuilding(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String, param7:int = -1, param8:Boolean = true, param9:Boolean = false) : void
        {
            var _loc_12:int = 0;
            var _loc_10:int = 2;
            if (Utility.getTypeObject(param6) == BuildingType.TRA)
            {
                if (param8)
                {
                    this.showViewRange();
                }
                return;
            }
            if (param6 == BuildingType.WALL)
            {
                _loc_10 = 16;
            }
            if (param8 == false)
            {
            }
            var _loc_11:int = -1;
            while (_loc_11 < (param3 + 1))
            {
                
                _loc_12 = -1;
                while (_loc_12 < (param4 + 1))
                {
                    
                    if (_loc_11 == -1 || _loc_12 == -1 || _loc_11 == param3 || _loc_12 == param4)
                    {
                        if (param8)
                        {
                            setIsoType(param1 + _loc_11, param2 + _loc_12, getIsoType(param1 + _loc_11, param2 + _loc_12) + param5);
                            areaMap.getNode(param1 + _loc_11, param2 + _loc_12).deepLv = getIsoType(param1 + _loc_11, param2 + _loc_12);
                        }
                    }
                    else
                    {
                        setIsoType(param1 + _loc_11, param2 + _loc_12, getIsoType(param1 + _loc_11, param2 + _loc_12) + param5 * _loc_10);
                        areaMap.getNode(param1 + _loc_11, param2 + _loc_12).deepLv = getIsoType(param1 + _loc_11, param2 + _loc_12);
                        if (areaMap.getNode(param1 + _loc_11, param2 + _loc_12).deepLv > 30)
                        {
                        }
                        areaMap.getNode(param1 + _loc_11, param2 + _loc_12).idNode = param7;
                    }
                    _loc_12++;
                }
                _loc_11++;
            }
            if (param8 && !param9)
            {
                this.showViewRange();
            }
            return;
        }// end function

        override public function clearMap() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < maxRow * maxCol)
            {
                
                setCellType(_loc_1, CAN_DROP);
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
                    
                    if (getIsoType(_loc_3, _loc_4) == 0)
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

        public function showViewRange() : void
        {
            var _loc_5:DataCell = null;
            var _loc_6:Point = null;
            var _loc_7:Point = null;
            var _loc_8:Point = null;
            var _loc_1:* = this.getViewRange();
            this.my_shape.graphics.clear();
            var _loc_2:Number = 16728128;
            switch(GlobalVar.state)
            {
                case GlobalVar.STATE_MYHOME:
                case GlobalVar.STATE_FRIEND:
                {
                    _loc_2 = 14737632;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.my_shape.graphics.lineStyle(1, _loc_2, 1);
            var _loc_3:* = MapMgr.getInstance().curMap;
            _loc_3.img.addChild(this.my_shape);
            var _loc_4:int = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                _loc_5 = _loc_1[_loc_4];
                switch(_loc_1[_loc_4].value)
                {
                    case 1:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, (_loc_5.isoCell.y + 1));
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, _loc_5.isoCell.y);
                        _loc_8 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), _loc_5.isoCell.y);
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        this.my_shape.graphics.lineTo(_loc_8.x, _loc_8.y);
                        break;
                    }
                    case 2:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, _loc_5.isoCell.y);
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), _loc_5.isoCell.y);
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        break;
                    }
                    case 3:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, _loc_5.isoCell.y);
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), _loc_5.isoCell.y);
                        _loc_8 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), (_loc_5.isoCell.y + 1));
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        this.my_shape.graphics.lineTo(_loc_8.x, _loc_8.y);
                        break;
                    }
                    case 4:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), _loc_5.isoCell.y);
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), (_loc_5.isoCell.y + 1));
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        break;
                    }
                    case 5:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, (_loc_5.isoCell.y + 1));
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), (_loc_5.isoCell.y + 1));
                        _loc_8 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), _loc_5.isoCell.y);
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        this.my_shape.graphics.lineTo(_loc_8.x, _loc_8.y);
                        break;
                    }
                    case 6:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, (_loc_5.isoCell.y + 1));
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), (_loc_5.isoCell.y + 1));
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        break;
                    }
                    case 7:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, _loc_5.isoCell.y);
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, (_loc_5.isoCell.y + 1));
                        _loc_8 = MapMgr.getInstance().cityMap.isoToPoint((_loc_5.isoCell.x + 1), (_loc_5.isoCell.y + 1));
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        this.my_shape.graphics.lineTo(_loc_8.x, _loc_8.y);
                        break;
                    }
                    case 8:
                    {
                        _loc_6 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, _loc_5.isoCell.y);
                        _loc_7 = MapMgr.getInstance().cityMap.isoToPoint(_loc_5.isoCell.x, (_loc_5.isoCell.y + 1));
                        this.my_shape.graphics.moveTo(_loc_6.x, _loc_6.y);
                        this.my_shape.graphics.lineTo(_loc_7.x, _loc_7.y);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4++;
            }
            this.countView = 0;
            this.my_shape.cacheAsBitmap = true;
            return;
        }// end function

        public function loop() : void
        {
            if (this.countView > COUNT_DOWN_VIEW)
            {
                return;
            }
            var _loc_1:String = this;
            var _loc_2:* = this.countView + 1;
            _loc_1.countView = _loc_2;
            if (this.countView >= COUNT_DOWN_VIEW)
            {
                this.hideViewRange();
            }
            return;
        }// end function

        public function hideViewRange() : void
        {
            this.countView = COUNT_DOWN_VIEW + 1;
            TweenMax.to(this.my_shape, 0.5, {alpha:0.1, onComplete:this.onCompleteTweenShow});
            return;
        }// end function

        private function onCompleteTweenShow() : void
        {
            this.my_shape.graphics.clear();
            this.my_shape.alpha = 1;
            return;
        }// end function

        public function canPathTo(param1:int, param2:int, param3:int) : Boolean
        {
            param1 = MapMgr.getInstance().convertCellBattleToCellCity(param1);
            param2 = MapMgr.getInstance().convertCellBattleToCellCity(param2);
            var _loc_4:* = param1 % maxCol;
            var _loc_5:* = param1 / maxCol;
            var _loc_6:* = param2 % maxCol;
            var _loc_7:* = param2 / maxCol;
            var _loc_8:int = 15;
            var _loc_9:* = pathFinder.findShortestPath(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, false, true, false);
            if (pathFinder.findShortestPath(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, false, true, false) == null)
            {
                return false;
            }
            var _loc_10:* = _loc_9.getLength();
            if (_loc_9.getLength() * 3 - 2 * BaseMap.BONUS_WALL > param3)
            {
                return false;
            }
            if (_loc_9.getLength() > 0)
            {
                return true;
            }
            return false;
        }// end function

    }
}
