package map.AStar.findPath
{
    import __AS3__.vec.*;
    import map.AStar.findPath.heuristics.*;
    import modules.battle.*;

    public class AStar extends Object
    {
        public var map:AreaMap;
        private var openHeap:BinaryHeap;
        private var heuristic:IAStartHeuristic;
        private var heuristics:Vector.<IAStartHeuristic>;
        private var shortestPath:Path;
        private var srcDeepLv:int;
        private var realDeepLv:int;
        private var isAboutSearch:Boolean = false;
        private var tempList:Array;
        private var count:int;
        public static const MAX_RANGE_FIND:Number = 20;
        public static const MAX_COUNT_FIND:int = 5000;

        public function AStar(param1:AreaMap)
        {
            this.map = param1;
            this.openHeap = new BinaryHeap();
            this.tempList = new Array();
            this.shortestPath = new Path();
            this.heuristics = new Vector.<IAStartHeuristic>;
            this.count = 0;
            return;
        }// end function

        public function addHeuristic(param1:IAStartHeuristic) : void
        {
            this.heuristics.push(param1);
            return;
        }// end function

        public function findShortestPath(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false) : Path
        {
            var _loc_11:Node = null;
            var _loc_14:int = 0;
            var _loc_15:Node = null;
            var _loc_16:Node = null;
            var _loc_17:Path = null;
            var _loc_18:Number = NaN;
            var _loc_19:Boolean = false;
            this.isAboutSearch = param6;
            this.map.startLocationX = param1;
            this.map.startLocationY = param2;
            this.map.goalLocationX = param3;
            this.map.goalLocationY = param4;
            var _loc_10:* = this.map.getGoalNode();
            this.map.goalLocationId = _loc_10.idNode;
            this.srcDeepLv = param5;
            if (_loc_10 == null)
            {
                return null;
            }
            if (this.map.getGoalNode().isObstacle(this.srcDeepLv))
            {
            }
            if (param7)
            {
                this.heuristic = this.heuristics[0];
            }
            else
            {
                _loc_14 = BattleModule.getInstance().curLoop % this.heuristics.length;
                this.heuristic = this.heuristics[_loc_14];
            }
            if (GlobalVar.state == GlobalVar.STATE_MYHOME)
            {
                this.heuristic = this.heuristics[0];
            }
            this.openHeap.content.splice(0, this.openHeap.content.length);
            while (this.tempList.length)
            {
                
                _loc_11 = this.tempList.pop() as Node;
                _loc_11.distFromStart = 0;
                _loc_11.preNode = null;
                _loc_11.visited = false;
                _loc_11.closed = false;
                _loc_11.visited = false;
            }
            this.map.getStartNode().distFromStart = 0;
            this.map.getStartNode().heuristicDistFromGoal = this.heuristic.getEstimatedDistToGoal(this.map.startLocationX, this.map.startLocationY, this.map.goalLocationX, this.map.goalLocationY);
            this.openHeap.push(this.map.getStartNode());
            var _loc_12:int = 0;
            var _loc_13:String = "";
            while (this.openHeap.length != 0 && _loc_12 < MAX_COUNT_FIND)
            {
                
                if (param8)
                {
                    _loc_12++;
                }
                _loc_15 = this.openHeap.pop();
                if (_loc_15.x == this.map.goalLocationX && _loc_15.y == this.map.goalLocationY || this.map.goalLocationId >= 0 && _loc_15.idNode == this.map.goalLocationId && !param9)
                {
                    _loc_17 = this.reconstructPath(_loc_15);
                    return _loc_17;
                }
                _loc_15.closed = true;
                this.tempList.push(_loc_15);
                for each (_loc_16 in _loc_15.neighborList)
                {
                    
                    this.tempList.push(_loc_16);
                    if (_loc_16.closed || _loc_16.isObstacle(this.srcDeepLv) && (this.map.goalLocationId < 0 || _loc_16.idNode != this.map.goalLocationId))
                    {
                        continue;
                    }
                    _loc_18 = _loc_15.distFromStart + this.map.getDistWithNeighbor(_loc_15, _loc_16);
                    _loc_19 = _loc_16.visited;
                    if (!_loc_19 || _loc_18 < _loc_16.distFromStart)
                    {
                        _loc_16.visited = true;
                        _loc_16.preNode = _loc_15;
                        _loc_16.distFromStart = _loc_18;
                        _loc_16.heuristicDistFromGoal = this.heuristic.getEstimatedDistToGoal(_loc_16.x, _loc_16.y, this.map.goalLocationX, this.map.goalLocationY);
                        if (!_loc_19)
                        {
                            this.openHeap.push(_loc_16);
                            continue;
                        }
                        this.openHeap.update(_loc_16);
                    }
                }
                if (_loc_12 >= MAX_COUNT_FIND)
                {
                }
            }
            return null;
        }// end function

        private function tracePath(param1:Path) : void
        {
            var _loc_2:String = "path :";
            var _loc_3:int = 0;
            while (_loc_3 < param1.getLength())
            {
                
                _loc_2 = _loc_2 + ("(" + param1.getPoint(_loc_3).x + "," + param1.getPoint(_loc_3).y + ")");
                _loc_3++;
            }
            return;
        }// end function

        public function findTempGoalNode(param1:int, param2:int, param3:int, param4:int, param5:int) : Node
        {
            var _loc_7:Array = null;
            var _loc_10:Node = null;
            var _loc_11:Node = null;
            var _loc_6:int = 0;
            var _loc_8:* = this.map.getNode(param1, param2);
            var _loc_9:* = this.map.getNode(param3, param4);
            if (_loc_8 == null || _loc_9 == null)
            {
                return null;
            }
            while (_loc_6 < 6)
            {
                
                _loc_6++;
                _loc_7 = this.map.getNodeRange(_loc_9, _loc_6, param5);
                for each (_loc_10 in _loc_7)
                {
                    
                    _loc_10.distNode = this.map.getDistBetween(_loc_9, _loc_10);
                }
                _loc_7.sortOn("distNode", Array.NUMERIC);
                _loc_11 = _loc_7.shift();
                if (_loc_11 == null)
                {
                    continue;
                    continue;
                }
                return _loc_11;
            }
            return null;
        }// end function

        private function reconstructPath(param1:Node) : Path
        {
            var _loc_2:* = new Path();
            if (this.isAboutSearch)
            {
                while (param1.preNode != null)
                {
                    
                    if (param1.deepLv <= this.realDeepLv)
                    {
                        _loc_2.addToStart(param1);
                    }
                    param1 = param1.preNode;
                }
            }
            else
            {
                while (param1.preNode != null)
                {
                    
                    _loc_2.addToStart(param1);
                    param1 = param1.preNode;
                }
                if (_loc_2.getLength() == 0)
                {
                    _loc_2.addToStart(this.map.getStartNode());
                }
            }
            this.shortestPath = _loc_2;
            return _loc_2;
        }// end function

        public function printPath() : void
        {
            var _loc_1:Node = null;
            var _loc_3:String = null;
            var _loc_4:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.map.maxRow)
            {
                
                _loc_3 = "";
                _loc_4 = 0;
                while (_loc_4 < this.map.maxCol)
                {
                    
                    _loc_1 = this.map.getNode(_loc_4, _loc_2);
                    if (_loc_1.isObstacle(this.srcDeepLv))
                    {
                        _loc_3 = _loc_3 + "X ";
                    }
                    else if (_loc_1.isStart)
                    {
                        _loc_3 = _loc_3 + "S ";
                    }
                    else if (_loc_1.isGoal)
                    {
                        _loc_3 = _loc_3 + "G ";
                    }
                    else if (this.shortestPath.contains(_loc_1.x, _loc_1.y))
                    {
                        _loc_3 = _loc_3 + "* ";
                    }
                    else
                    {
                        _loc_3 = _loc_3 + "0 ";
                    }
                    _loc_4++;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function insertionSort() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Node = null;
            _loc_1 = 1;
            while (_loc_1 < this.openHeap.length)
            {
                
                _loc_3 = this.openHeap[_loc_1];
                _loc_2 = _loc_1;
                while (_loc_2 > 0 && (this.openHeap[(_loc_2 - 1)] as Node).totalDistFromGoal > _loc_3.totalDistFromGoal)
                {
                    
                    this.openHeap[_loc_2] = this.openHeap[(_loc_2 - 1)];
                    _loc_2 = _loc_2 - 1;
                }
                this.openHeap[_loc_2] = _loc_3;
                _loc_1++;
            }
            return;
        }// end function

    }
}
