package map.AStar.findPath
{
    import __AS3__.vec.*;

    public class Path extends Object
    {
        private var wayPoints:Vector.<Node>;

        public function Path()
        {
            this.wayPoints = new Vector.<Node>;
            return;
        }// end function

        public function getLength() : int
        {
            return this.wayPoints.length;
        }// end function

        public function getPoint(param1:int) : Node
        {
            return this.wayPoints[param1];
        }// end function

        public function getWay() : Vector.<Node>
        {
            return this.wayPoints;
        }// end function

        public function appendPoint(param1:Node) : void
        {
            this.wayPoints.push(param1);
            return;
        }// end function

        public function addToStart(param1:Node) : void
        {
            this.wayPoints.unshift(param1);
            return;
        }// end function

        public function contains(param1:int, param2:int) : Boolean
        {
            var _loc_4:Node = null;
            var _loc_3:int = 0;
            while (_loc_3 < this.wayPoints.length)
            {
                
                _loc_4 = this.wayPoints[_loc_3];
                if (_loc_4.x == param1 && _loc_4.y == param2)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function reverse() : void
        {
            this.wayPoints = this.wayPoints.reverse();
            return;
        }// end function

    }
}
