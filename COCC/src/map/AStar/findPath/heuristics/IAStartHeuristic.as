package map.AStar.findPath.heuristics
{

    public interface IAStartHeuristic
    {

        public function IAStartHeuristic();

        function getEstimatedDistToGoal(param1:int, param2:int, param3:int, param4:int) : Number;

    }
}
