package map.AStar.findPath
{
    import __AS3__.vec.*;

    public class Node extends Object
    {
        public var distFromStart:Number;
        public var heuristicDistFromGoal:Number;
        public var preNode:Node;
        public var x:int;
        public var y:int;
        private var _isObstacle:Boolean;
        public var deepLv:int;
        public var idNode:int = -1;
        public var isStart:Boolean;
        public var isGoal:Boolean;
        public var visited:Boolean;
        public var closed:Boolean;
        private var _list:Vector.<Node>;
        public var distNode:Number;

        public function Node(param1:int, param2:int, param3:Boolean = false, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
        {
            this.x = param1;
            this.y = param2;
            this.visited = param3;
            this.distFromStart = 0;
            this.heuristicDistFromGoal = 0;
            this.isStart = param5;
            this.isGoal = param6;
            this.deepLv = 0;
            param3 = false;
            this.closed = false;
            return;
        }// end function

        public function get totalDistFromGoal() : Number
        {
            return this.heuristicDistFromGoal + this.distFromStart;
        }// end function

        public function get neighborList() : Vector.<Node>
        {
            return this._list;
        }// end function

        public function makeNeighborList(param1:Vector.<Node>) : void
        {
            this._list = param1;
            return;
        }// end function

        public function isObstacle(param1:int) : Boolean
        {
            return this.deepLv > param1;
        }// end function

    }
}
