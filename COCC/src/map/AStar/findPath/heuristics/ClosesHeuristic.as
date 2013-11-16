package map.AStar.findPath.heuristics
{
    import map.AStar.findPath.heuristics.*;

    public class ClosesHeuristic extends Object implements IAStartHeuristic
    {

        public function ClosesHeuristic()
        {
            return;
        }// end function

        public function getEstimatedDistToGoal(param1:int, param2:int, param3:int, param4:int) : Number
        {
            var _loc_5:* = param3 - param1;
            var _loc_6:* = param4 - param2;
            return _loc_5 * _loc_5 + _loc_6 * _loc_6;
        }// end function

    }
}
