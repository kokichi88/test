package map.AStar.findPath.heuristics
{
    import map.AStar.findPath.heuristics.*;

    public class IAStartHeuristic1 extends Object implements IAStartHeuristic
    {

        public function IAStartHeuristic1()
        {
            return;
        }// end function

        public function getEstimatedDistToGoal(param1:int, param2:int, param3:int, param4:int) : Number
        {
            var _loc_5:* = Math.abs(param3 - param1);
            var _loc_6:* = Math.abs(param4 - param2);
            return (_loc_5 + _loc_6) * 2;
        }// end function

    }
}
