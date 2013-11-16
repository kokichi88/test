package map.AStar.findPath
{
    import __AS3__.vec.*;

    public class AreaMap extends Object
    {
        public var maxRow:int;
        public var maxCol:int;
        public var map:Array;
        public var startLocationX:int = 0;
        public var startLocationY:int = 0;
        public var goalLocationX:int = 0;
        public var goalLocationY:int = 0;
        public var goalLocationId:int = -1;

        public function AreaMap(param1:int, param2:int)
        {
            this.maxCol = param1;
            this.maxRow = param2;
            this.createMap();
            this.createEdge();
            return;
        }// end function

        public function createEdge() : void
        {
            var _loc_2:int = 0;
            var _loc_3:Node = null;
            var _loc_4:Node = null;
            var _loc_5:Vector.<Node> = null;
            var _loc_1:int = 0;
            while (_loc_1 < this.maxCol)
            {
                
                _loc_2 = 0;
                while (_loc_2 < this.maxRow)
                {
                    
                    _loc_3 = this.getNode(_loc_1, _loc_2);
                    _loc_5 = new Vector.<Node>;
                    if (_loc_2 != 0)
                    {
                        _loc_4 = this.getNode(_loc_1, (_loc_2 - 1));
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    if (_loc_2 != 0 && _loc_1 != this.maxCol)
                    {
                        _loc_4 = this.getNode((_loc_1 + 1), (_loc_2 - 1));
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    if (_loc_1 != this.maxCol)
                    {
                        _loc_4 = this.getNode((_loc_1 + 1), _loc_2);
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    if (_loc_1 != this.maxCol && _loc_2 != this.maxRow)
                    {
                        _loc_4 = this.getNode((_loc_1 + 1), (_loc_2 + 1));
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    if (_loc_2 != this.maxRow)
                    {
                        _loc_4 = this.getNode(_loc_1, (_loc_2 + 1));
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    if (_loc_1 != 0 && _loc_2 != this.maxRow)
                    {
                        _loc_4 = this.getNode((_loc_1 - 1), (_loc_2 + 1));
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    if (_loc_1 != 0)
                    {
                        _loc_4 = this.getNode((_loc_1 - 1), _loc_2);
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    if (_loc_1 != 0 && _loc_2 != 0)
                    {
                        _loc_4 = this.getNode((_loc_1 - 1), (_loc_2 - 1));
                        if (_loc_4 != null)
                        {
                            _loc_5.push(_loc_4);
                        }
                    }
                    _loc_3.makeNeighborList(_loc_5);
                    _loc_2++;
                }
                _loc_1++;
            }
            return;
        }// end function

        public function createMap() : void
        {
            var _loc_2:int = 0;
            this.map = new Array();
            var _loc_1:int = 0;
            while (_loc_1 < this.maxCol)
            {
                
                _loc_2 = 0;
                while (_loc_2 < this.maxRow)
                {
                    
                    this.map[_loc_1 + this.maxCol * _loc_2] = new Node(_loc_1, _loc_2);
                    _loc_2++;
                }
                _loc_1++;
            }
            return;
        }// end function

        public function getDistBetween(param1:Node, param2:Node) : Number
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            if (param1.x == param2.x || param1.y == param2.y)
            {
                return 1;
            }
            _loc_3 = param2.x - param1.x;
            _loc_4 = param2.y - param1.y;
            return _loc_3 * _loc_3 + _loc_4 * _loc_4;
        }// end function

        public function getDistWithNeighbor(param1:Node, param2:Node) : Number
        {
            if (param1.x == param2.x || param1.y == param2.y)
            {
                return 1;
            }
            return 2;
        }// end function

        public function clear() : void
        {
            this.map.splice(0, this.map.length);
            return;
        }// end function

        public function clearMap() : void
        {
            this.clear();
            this.createMap();
            this.createEdge();
            return;
        }// end function

        public function getNode(param1:int, param2:int) : Node
        {
            if (param1 >= this.maxCol || param2 >= this.maxRow)
            {
                return null;
            }
            return this.map[param1 + this.maxCol * param2] as Node;
        }// end function

        public function getStartNode() : Node
        {
            var _loc_1:* = this.startLocationX + this.maxCol * this.startLocationY;
            if (_loc_1 > (this.map.length - 1))
            {
                return null;
            }
            return this.map[_loc_1];
        }// end function

        public function getGoalNode() : Node
        {
            var _loc_1:* = this.goalLocationX + this.maxCol * this.goalLocationY;
            if (_loc_1 > (this.map.length - 1))
            {
                return null;
            }
            return this.map[_loc_1];
        }// end function

        public function getNodeRange(param1:Node, param2:int, param3:int) : Array
        {
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:Node = null;
            var _loc_4:Array = [];
            var _loc_5:* = param1.y;
            var _loc_6:* = param1.x;
            _loc_5 = _loc_5 - param2;
            _loc_6 = _loc_6 - param2;
            _loc_7 = _loc_5;
            while (_loc_7 <= _loc_5 + param2 * 2)
            {
                
                _loc_8 = _loc_6;
                while (_loc_8 <= _loc_6 + param2 * 2)
                {
                    
                    _loc_9 = this.getNode(_loc_8, _loc_7);
                    if (_loc_9 != null && !_loc_9.isObstacle(param3))
                    {
                        _loc_4.push(_loc_9);
                    }
                    _loc_8++;
                }
                _loc_7++;
            }
            return _loc_4;
        }// end function

    }
}
