package map.AStar.findPath
{
    import __AS3__.vec.*;

    public class BinaryHeap extends Object
    {
        public var content:Vector.<Node>;

        public function BinaryHeap()
        {
            this.content = new Vector.<Node>;
            return;
        }// end function

        public function push(param1:Node) : void
        {
            this.content.push(param1);
            this.bubbleUp((this.content.length - 1));
            return;
        }// end function

        public function pop() : Node
        {
            var _loc_1:* = this.content[0];
            var _loc_2:* = this.content.pop();
            if (this.content.length > 0)
            {
                this.content[0] = _loc_2;
                this.sinkDown(0);
            }
            return _loc_1;
        }// end function

        private function remove(param1:Node) : void
        {
            var _loc_4:Node = null;
            var _loc_2:* = this.content.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this.content[_loc_3] == param1)
                {
                    _loc_4 = this.content.pop();
                    if (_loc_3 != (_loc_2 - 1))
                    {
                        this.content[_loc_3] = _loc_4;
                        if (_loc_4.totalDistFromGoal < param1.totalDistFromGoal)
                        {
                            this.bubbleUp(_loc_3);
                        }
                        else
                        {
                            this.sinkDown(_loc_3);
                        }
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        private function bubbleUp(param1:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:Node = null;
            var _loc_2:* = this.content[param1];
            while (param1 > 0)
            {
                
                _loc_3 = (param1 + 1) / 2 - 1;
                _loc_4 = this.content[_loc_3];
                if (_loc_2.totalDistFromGoal < _loc_4.totalDistFromGoal)
                {
                    this.content[_loc_3] = _loc_2;
                    this.content[param1] = _loc_4;
                    param1 = _loc_3;
                    continue;
                }
                break;
            }
            return;
        }// end function

        private function sinkDown(param1:int) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Node = null;
            var _loc_8:Node = null;
            var _loc_2:* = this.content.length;
            var _loc_3:* = this.content[param1];
            while (true)
            {
                
                _loc_4 = (param1 + 1) * 2;
                _loc_5 = _loc_4 - 1;
                _loc_6 = -1;
                _loc_7 = null;
                _loc_8 = null;
                if (_loc_5 < _loc_2)
                {
                    _loc_7 = this.content[_loc_5];
                    if (_loc_7.totalDistFromGoal < _loc_3.totalDistFromGoal)
                    {
                        _loc_6 = _loc_5;
                    }
                }
                if (_loc_4 < _loc_2)
                {
                    _loc_8 = this.content[_loc_4];
                    if (_loc_8.totalDistFromGoal < (_loc_6 == -1 ? (_loc_3.totalDistFromGoal) : (_loc_7.totalDistFromGoal)))
                    {
                        _loc_6 = _loc_4;
                    }
                }
                if (_loc_6 != -1)
                {
                    this.content[param1] = this.content[_loc_6];
                    this.content[_loc_6] = _loc_3;
                    param1 = _loc_6;
                    continue;
                }
                break;
            }
            return;
        }// end function

        public function update(param1:Node) : void
        {
            var _loc_2:* = this.content.indexOf(param1);
            if (_loc_2 > 0)
            {
                this.sinkDown(_loc_2);
            }
            return;
        }// end function

        public function get length() : int
        {
            return this.content.length;
        }// end function

    }
}
