package map.AStar.findPath.heuristics
{
    import map.*;
    import map.AStar.findPath.heuristics.*;

    public class TempHeuristics extends Object implements IAStartHeuristic
    {

        public function TempHeuristics()
        {
            return;
        }// end function

        public function getEstimatedDistToGoal(param1:int, param2:int, param3:int, param4:int) : Number
        {
            var _loc_5:* = param3 - param1;
            var _loc_6:* = param4 - param2;
            var _loc_7:* = MapMgr.getInstance().battleMap.maxCol;
            var _loc_8:* = param2 * _loc_7 + param1;
            var _loc_9:* = MapMgr.getInstance().battleMap.getCellType(_loc_8);
            var _loc_10:int = 0;
            if (_loc_9 > 1)
            {
                _loc_10 = _loc_9 * 35;
            }
            return _loc_5 * _loc_5 + _loc_6 * _loc_6 + _loc_10;
        }// end function

    }
}
