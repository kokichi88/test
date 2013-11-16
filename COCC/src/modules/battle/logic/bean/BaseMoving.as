package modules.battle.logic.bean
{
    import __AS3__.vec.*;
    import component.avatar.model.animation.*;
    import flash.geom.*;
    import map.*;

    public class BaseMoving extends Object
    {
        public var gx:Number;
        public var gy:Number;
        public var x:Number = 0;
        public var y:Number = 0;
        public var responeCell:int;
        public var numLoopRun:int;
        public var curLoopRun:int;
        private var moveSpeed:Number = 200;
        private var path:Vector.<int>;
        public var dir:int = 5;
        private var dxChange:Number = 5;
        private var dyChange:Number = 5;
        public var status:int;

        public function BaseMoving()
        {
            return;
        }// end function

        public function moveTo(param1:Vector.<int>, param2:Number) : void
        {
            this.path = param1;
            this.moveSpeed = param2;
            this.runToPath();
            return;
        }// end function

        public function updateLogic() : void
        {
            this.status = AnConst.RUN;
            if (this.curLoopRun < this.numLoopRun)
            {
                this.x = this.x + this.dxChange;
                this.y = this.y + this.dyChange;
                var _loc_1:String = this;
                var _loc_2:* = this.curLoopRun + 1;
                _loc_1.curLoopRun = _loc_2;
            }
            else if (this.path && this.path.length > 0)
            {
                this.runToPath();
            }
            else
            {
                this.status = AnConst.STAND;
            }
            return;
        }// end function

        public function set curCell(param1:int) : void
        {
            var _loc_2:Point = null;
            _loc_2 = MapMgr.getInstance().battleMap.cellToPoint(param1);
            this.x = _loc_2.x;
            this.y = _loc_2.y;
            return;
        }// end function

        public function get curCell() : int
        {
            return MapMgr.getInstance().battleMap.pointToCell(this.x, this.y);
        }// end function

        public function runToPath() : void
        {
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            if (this.path.length <= 0)
            {
                return;
            }
            var _loc_1:* = this.path[0];
            this.path.splice(0, 1);
            var _loc_2:* = MapMgr.getInstance().battleMap.getDirToCell(this.curCell, _loc_1);
            if (this.path.length > 0)
            {
                _loc_5 = 0;
                _loc_6 = MapMgr.getInstance().battleMap.getDirToCell(_loc_1, this.path[_loc_5]);
                while (_loc_6 == _loc_2 && _loc_5 < (this.path.length - 1))
                {
                    
                    _loc_1 = this.path[_loc_5];
                    _loc_5++;
                    _loc_6 = MapMgr.getInstance().battleMap.getDirToCell(_loc_1, this.path[_loc_5]);
                }
                this.path.splice(0, _loc_5);
            }
            var _loc_3:* = MapMgr.getInstance().battleMap.cellToPoint(_loc_1);
            var _loc_4:* = Math.sqrt((_loc_3.x - this.x) * (_loc_3.x - this.x) + (_loc_3.y - this.y) * (_loc_3.y - this.y));
            this.numLoopRun = int(_loc_4 / this.moveSpeed * GlobalVar.stage.frameRate);
            this.dxChange = (_loc_3.x - this.x) / this.numLoopRun;
            this.dyChange = (_loc_3.y - this.y) / this.numLoopRun;
            this.curLoopRun = 0;
            this.dir = _loc_2;
            return;
        }// end function

        public function getPoint() : Point
        {
            return new Point(this.x, this.y);
        }// end function

    }
}
