package map.logic
{
    import __AS3__.vec.*;
    import component.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import gameData.*;
    import map.*;
    import map.AStar.findPath.*;
    import map.AStar.findPath.heuristics.*;
    import modules.*;
    import modules.city.*;
    import modules.city.logic.*;

    public class BaseMap extends Image
    {
        public var MaxOffsetX:Number = 2528;
        public var MaxOffsetY:Number = 483;
        public var MaxHalfWidth:Number = 38;
        public var MaxHalfHeight:Number = 28.5;
        public var titleHalfWidth:Number;
        public var titleHalfHeight:Number;
        public var screenOriginOffsetX:Number;
        public var screenOriginOffsetY:Number;
        public var maxRow:int = 44;
        public var maxCol:int = 44;
        public var mapCells:Vector.<int>;
        private var _isGridVisible:Boolean = false;
        public var pathFinder:AStar;
        public var areaMap:AreaMap;
        public static const BONUS_WALL:int = 30;
        public static const BONUS_FAVORITE:int = 2147483647;
        public static const CAN_BUILD:int = 0;
        public static const IS_HOUSE:int = 3;
        private static const TIME_TO_DRAG:int = 100;
        public static const CAN_DROP:int = 0;
        public static const CAN_MOVE:int = 1;
        public static const IS_WALL:int = 2;
        public static const CANT_MOVE:int = 3;
        public static const OBSTACLE:int = 4;
        public static var startDown:Number;

        public function BaseMap()
        {
            this.mapCells = new Vector.<int>;
            return;
        }// end function

        public function setEnableGridView(param1:Boolean) : void
        {
            this._isGridVisible = param1;
            if (param1)
            {
            }
            return;
        }// end function

        public function createMap() : void
        {
            this.areaMap = new AreaMap(this.maxCol, this.maxRow);
            this.pathFinder = new AStar(this.areaMap);
            this.pathFinder.addHeuristic(new ClosesHeuristic());
            return;
        }// end function

        public function updateOffset(param1:int, param2:int) : void
        {
            this.screenOriginOffsetX = this.MaxOffsetX * MapMgr.curScale + param1;
            this.screenOriginOffsetY = this.MaxOffsetY * MapMgr.curScale + param2;
            this.titleHalfWidth = this.MaxHalfWidth * MapMgr.curScale;
            this.titleHalfHeight = this.MaxHalfHeight * MapMgr.curScale;
            return;
        }// end function

        public function isoToPoint(param1:int, param2:int) : Point
        {
            var _loc_3:* = new Point();
            _loc_3.x = (param1 - param2) * this.MaxHalfWidth + this.MaxOffsetX;
            _loc_3.y = (param1 + param2) * this.MaxHalfHeight + this.MaxOffsetY;
            if (this is BattleMap)
            {
                _loc_3.y = _loc_3.y + this.MaxHalfHeight;
            }
            return _loc_3;
        }// end function

        public function pointToIso(param1:Number, param2:Number) : Point
        {
            var _loc_3:* = new Point();
            var _loc_4:* = param1 - this.MaxOffsetX;
            var _loc_5:* = param2 - this.MaxOffsetY;
            _loc_3.x = int((_loc_5 / this.MaxHalfHeight + _loc_4 / this.MaxHalfWidth) / 2);
            _loc_3.y = int((_loc_5 / this.MaxHalfHeight - _loc_4 / this.MaxHalfWidth) / 2);
            return _loc_3;
        }// end function

        public function pointToCell(param1:Number, param2:Number) : int
        {
            var _loc_3:* = this.pointToIso(param1, param2);
            return this.isoToCell(_loc_3.x, _loc_3.y);
        }// end function

        public function cellToPoint(param1:int) : Point
        {
            var _loc_2:* = this.cellToIso(param1);
            return this.isoToPoint(_loc_2.x, _loc_2.y);
        }// end function

        public function isoToCell(param1:int, param2:int) : int
        {
            var _loc_3:* = param1 + param2 * this.maxCol;
            return _loc_3;
        }// end function

        public function cellToIso(param1:int) : Vector2D
        {
            var _loc_2:* = param1 % this.maxCol;
            var _loc_3:* = param1 / this.maxCol;
            return new Vector2D(_loc_2, _loc_3);
        }// end function

        public function getCellType(param1:int) : int
        {
            if (param1 < 0 || param1 >= this.maxRow * this.maxCol)
            {
                return BaseMap.CANT_MOVE;
            }
            return this.mapCells[param1];
        }// end function

        public function setCellType(param1:int, param2:int) : void
        {
            if (param1 < 0 || param1 >= this.maxRow * this.maxCol)
            {
                return;
            }
            this.mapCells[param1] = param2;
            return;
        }// end function

        public function getIsoType(param1:int, param2:int) : int
        {
            if (param1 < 0 || param2 < 0 || param1 >= this.maxRow || param2 >= this.maxCol)
            {
                return BaseMap.CANT_MOVE;
            }
            var _loc_3:* = param1 + this.maxCol * param2;
            return this.getCellType(_loc_3);
        }// end function

        public function setIsoType(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = param1 + this.maxCol * param2;
            this.setCellType(_loc_4, param3);
            return;
        }// end function

        public function setCellData(param1:Vector.<int>, param2:int) : void
        {
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                this.mapCells[param1[_loc_3]] = param2;
                _loc_3++;
            }
            return;
        }// end function

        public function reset() : void
        {
            this.mapCells.splice(0, this.mapCells.length);
            return;
        }// end function

        public function loadMapData(param1:Vector.<int>) : void
        {
            return;
        }// end function

        public function getTempGoalNode(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = param1 % this.maxCol;
            var _loc_5:* = param1 / this.maxCol;
            var _loc_6:* = param2 % this.maxCol;
            var _loc_7:* = param2 / this.maxCol;
            var _loc_8:* = MapMgr.getInstance().battleMap.pathFinder.findTempGoalNode(_loc_4, _loc_5, _loc_6, _loc_7, param3);
            var _loc_9:* = MapMgr.getInstance().battleMap.pathFinder.findTempGoalNode(_loc_4, _loc_5, _loc_6, _loc_7, param3).y * this.maxCol + _loc_8.x;
            return MapMgr.getInstance().battleMap.pathFinder.findTempGoalNode(_loc_4, _loc_5, _loc_6, _loc_7, param3).y * this.maxCol + _loc_8.x;
        }// end function

        public function pathTo(param1:int, param2:int, param3:int, param4:Boolean = true, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : Vector.<int>
        {
            var _loc_15:int = 0;
            var _loc_8:* = new Vector.<int>;
            var _loc_9:* = param1 % this.maxCol;
            var _loc_10:* = param1 / this.maxCol;
            var _loc_11:* = param2 % this.maxCol;
            var _loc_12:* = param2 / this.maxCol;
            var _loc_13:* = this.pathFinder.findShortestPath(_loc_9, _loc_10, _loc_11, _loc_12, param3, false, param5, param6, param7);
            if (this.pathFinder.findShortestPath(_loc_9, _loc_10, _loc_11, _loc_12, param3, false, param5, param6, param7) == null)
            {
                return _loc_8;
            }
            var _loc_14:* = _loc_13.getWay();
            _loc_15 = 0;
            while (_loc_15 < _loc_14.length)
            {
                
                _loc_8.push(_loc_14[_loc_15].x + this.maxCol * _loc_14[_loc_15].y);
                _loc_15++;
            }
            if (param4)
            {
                _loc_8 = this.optimizePath(_loc_8);
            }
            if (_loc_8.length == 0)
            {
            }
            return _loc_8;
        }// end function

        public function optimizePath(param1:Vector.<int>) : Vector.<int>
        {
            var _loc_3:int = 0;
            var _loc_4:Vector2D = null;
            var _loc_5:Vector2D = null;
            var _loc_6:Vector2D = null;
            var _loc_7:Vector2D = null;
            var _loc_2:* = new Vector.<int>;
            if (param1.length <= 2)
            {
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_2.push(param1[_loc_3]);
                    _loc_3++;
                }
            }
            else
            {
                _loc_4 = new Vector2D(param1[1] % this.maxCol, int(param1[1] / this.maxCol));
                _loc_5 = new Vector2D(param1[0] % this.maxCol, int(param1[0] / this.maxCol));
                _loc_2.push(param1[0]);
                _loc_2.push(param1[1]);
                _loc_6 = _loc_4.sub(_loc_5);
                _loc_7 = new Vector2D();
                _loc_3 = 2;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_4.x = param1[_loc_3] % this.maxCol;
                    _loc_4.y = int(param1[_loc_3] / this.maxCol);
                    _loc_5.x = param1[(_loc_3 - 1)] % this.maxCol;
                    _loc_5.y = int(param1[(_loc_3 - 1)] / this.maxCol);
                    _loc_7 = _loc_4.sub(_loc_5);
                    if (_loc_7.x / _loc_7.y != _loc_6.x / _loc_6.y)
                    {
                        _loc_6.x = _loc_7.x;
                        _loc_6.y = _loc_7.y;
                        _loc_2.push(param1[_loc_3]);
                    }
                    else
                    {
                        _loc_2.pop();
                        _loc_2.push(param1[_loc_3]);
                    }
                    _loc_3++;
                }
            }
            return _loc_2;
        }// end function

        public function getDirToCell(param1:int, param2:int) : int
        {
            var _loc_3:* = param1 / this.maxCol;
            var _loc_4:* = param1 % this.maxCol;
            var _loc_5:* = param2 / this.maxCol;
            var _loc_6:* = param2 % this.maxCol;
            var _loc_7:* = param2 % this.maxCol - _loc_4;
            var _loc_8:* = _loc_5 - _loc_3;
            if (_loc_7 != 0)
            {
                _loc_7 = _loc_7 / Math.abs(_loc_7);
            }
            if (_loc_8 != 0)
            {
                _loc_8 = _loc_8 / Math.abs(_loc_8);
            }
            var _loc_9:* = new Vector2D(_loc_7, _loc_8);
            var _loc_10:int = 1;
            if (_loc_9.x == 0 && _loc_9.y == -1)
            {
                _loc_10 = 2;
            }
            if (_loc_9.x == 1 && _loc_9.y == -1)
            {
                _loc_10 = 3;
            }
            if (_loc_9.x == 1 && _loc_9.y == 0)
            {
                _loc_10 = 4;
            }
            if (_loc_9.x == 1 && _loc_9.y == 1)
            {
                _loc_10 = 5;
            }
            if (_loc_9.x == 0 && _loc_9.y == 1)
            {
                _loc_10 = 6;
            }
            if (_loc_9.x == -1 && _loc_9.y == 1)
            {
                _loc_10 = 7;
            }
            if (_loc_9.x == -1 && _loc_9.y == 0)
            {
                _loc_10 = 8;
            }
            if (_loc_9.x == -1 && _loc_9.y == -1)
            {
                _loc_10 = 1;
            }
            return _loc_10;
        }// end function

        override protected function onOver(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function onOut(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function onDown(event:MouseEvent) : void
        {
            if (GlobalVar.state == GlobalVar.STATE_BATTLE || GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
            {
                startDown = getTimer();
            }
            else
            {
                MapMgr.getInstance().dragMap(true);
            }
            return;
        }// end function

        override protected function onUp(event:MouseEvent) : void
        {
            var _loc_2:MapObject = null;
            if (!GameInput.getInstance().isDragging)
            {
                _loc_2 = GameDataMgr.getInstance().curObject;
                if (_loc_2 != null)
                {
                    if (MouseMgr.getInstance().mouseIcon && MouseMgr.getInstance().mouseIcon.mapObject && MouseMgr.getInstance().mouseIcon.mapObject.autoId == _loc_2.autoId)
                    {
                        MouseMgr.getInstance().mouseIcon.mapObject.onUp(null);
                    }
                }
                else
                {
                    ModuleMgr.getInstance().doFunction(CityMgr.HIDE_BUILDING_ACTION_GUI);
                }
            }
            MapMgr.getInstance().dragMap(false);
            GameInput.getInstance().isDragging = false;
            return;
        }// end function

        override protected function onClick(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function onEnterFrame(event:Event) : void
        {
            if (GlobalVar.state == GlobalVar.STATE_BATTLE || GlobalVar.state == GlobalVar.STATE_SINGLE_MAP)
            {
                if (GameInput.getInstance().isMouseDown)
                {
                    if (getTimer() - startDown > GameInput.TIME_DRAW)
                    {
                        MapMgr.getInstance().dragMap(true);
                    }
                }
            }
            return;
        }// end function

        public function clearMap() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.maxRow * this.maxCol)
            {
                
                this.setCellType(_loc_1, CAN_DROP);
                _loc_1++;
            }
            this.areaMap.clearMap();
            return;
        }// end function

        public function addLabelToIso(param1:int, param2:int) : void
        {
            var _loc_3:* = new TextField();
            _loc_3.text = this.getIsoType(param1, param2).toString();
            _loc_3.border = true;
            var _loc_4:* = this.isoToPoint(param1, param2);
            _loc_3.x = _loc_4.x;
            _loc_3.y = _loc_4.y + this.MaxHalfHeight / 2;
            this.img.addChild(_loc_3);
            return;
        }// end function

    }
}
