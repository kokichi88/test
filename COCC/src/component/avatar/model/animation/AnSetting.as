package component.avatar.model.animation
{
    import flash.geom.*;

    public class AnSetting extends Object
    {
        public var reversed:Boolean = false;
        public var speedRatio:Number = 1;
        public var scaleX:int = 1;
        public var offset:Point;
        public var currFrame:int = 0;
        public var abortFrame:int = -1;
        private var _currAction:int = 0;
        private var repeatedCount:int = 0;
        public var curFrameDelay:int;
        public var reachEnding:Boolean = false;
        private var _currDir:int = 5;
        public var frameCount:int = 0;

        public function AnSetting()
        {
            this.offset = new Point();
            return;
        }// end function

        public function get currAction() : int
        {
            return this._currAction;
        }// end function

        public function rewind() : void
        {
            this.curFrameDelay = 0;
            this.abortFrame = -1;
            this.reversed = false;
            return;
        }// end function

        public function set currAction(param1:int) : void
        {
            if (this._currAction == param1)
            {
                return;
            }
            this._currAction = param1;
            this.rewind();
            return;
        }// end function

        public function reset() : void
        {
            this.currFrame = 0;
            this.curFrameDelay = 0;
            this.speedRatio = 1;
            this.repeatedCount = 0;
            this.reachEnding = false;
            this.abortFrame = -1;
            this._currAction = AnConst.STAND;
            this.offset.x = 0;
            this.offset.y = 0;
            this.reversed = false;
            return;
        }// end function

        private function getFixSpeed(param1:int, param2)
        {
            return param2;
        }// end function

        public function setFrame(param1:AnLoadData) : void
        {
            var _loc_2:* = param1[this._currAction];
            if (!_loc_2)
            {
                this.reachEnding = true;
                return;
            }
            this.reachEnding = false;
            var _loc_4:String = this;
            var _loc_5:* = this.curFrameDelay + 1;
            _loc_4.curFrameDelay = _loc_5;
            var _loc_3:* = Math.ceil(_loc_2.speed / this.speedRatio);
            if (this._currAction == AnConst.RUN)
            {
            }
            this.frameCount = _loc_2.frameCount;
            if ((this.reversed ? (_loc_2.frameCount - this.currFrame - 1) : (this.currFrame)) == 0)
            {
                if (this.curFrameDelay < _loc_3 + (this.repeatedCount > 0 ? (_loc_2.repeatDelay) : (0)))
                {
                }
            }
            else if (_loc_2.secondFireEndFrame > 0 && this.currFrame >= _loc_2.secondFireEndFrame)
            {
                if (this.curFrameDelay < _loc_3 + 2)
                {
                }
            }
            else if (this.curFrameDelay < _loc_3)
            {
            }
            this.curFrameDelay = 0;
            var _loc_4:String = this;
            var _loc_5:* = this.currFrame + 1;
            _loc_4.currFrame = _loc_5;
            if (this.currFrame > (_loc_2.frameCount - 1) || this.currFrame == (this.abortFrame + 1))
            {
                this.currFrame = 0;
                var _loc_4:String = this;
                var _loc_5:* = this.repeatedCount + 1;
                _loc_4.repeatedCount = _loc_5;
                this.abortFrame = -1;
                this.reachEnding = true;
                if (_loc_2.swing)
                {
                    this.reversed = !this.reversed;
                    var _loc_4:String = this;
                    var _loc_5:* = this.currFrame + 1;
                    _loc_4.currFrame = _loc_5;
                }
            }
            else
            {
                this.reachEnding = false;
            }
            return;
        }// end function

        public function get currDir() : int
        {
            return this._currDir;
        }// end function

        public function set currDir(param1:int) : void
        {
            if (this.currDir == param1)
            {
                return;
            }
            this._currDir = param1;
            return;
        }// end function

    }
}
