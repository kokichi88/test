package map.AStar.findPath.heuristics
{
    import map.AStar.findPath.heuristics.*;

    public class IAStartHeuristic2 extends Object implements IAStartHeuristic
    {

        public function IAStartHeuristic2()
        {
            return;
        }// end function

        public function getEstimatedDistToGoal(param1:int, param2:int, param3:int, param4:int) : Number
        {
            var _loc_5:* = Math.abs(param3 - param1);
            var _loc_6:* = Math.abs(param4 - param2);
            return 2 * Math.max(_loc_5, _loc_6);
        }// end function

    }
}
