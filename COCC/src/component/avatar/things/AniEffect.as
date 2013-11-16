package component.avatar.things
{
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.geom.*;

    public class AniEffect extends Sprite
    {
        protected var _terminated:Boolean;
        protected var _loop:Boolean;
        protected var animation:AnimationBitmap;
        private var lastPoint:Point;
        private var checkCount:int;
        protected var _offset:Point;
        protected var _duration:int;

        public function AniEffect(param1:String) : void
        {
            this.name = param1;
            mouseChildren = false;
            mouseEnabled = false;
            this._terminated = true;
            this.animation = new AnimationBitmap();
            this._offset = new Point();
            this.animation.setSource(AnCategory.EFFECT, param1);
            addChild(this.animation);
            this.animation.load();
            return;
        }// end function

        private function frameScript() : void
        {
            if (this.animation)
            {
                this.animation.draw();
                this.animation.nextFrame();
            }
            if (this.animation.setting.reachEnding && !this._loop)
            {
                this.terminate();
            }
            return;
        }// end function

        public function terminate() : void
        {
            if (!this._terminated)
            {
                this._terminated = true;
                if (parent)
                {
                    parent.removeChild(this);
                }
                this.animation.clear();
                FrameTimerManager.getInstance().remove(this.frameScript);
            }
            return;
        }// end function

        private function checkLoaded() : void
        {
            var _loc_1:String = this;
            var _loc_2:* = this.checkCount + 1;
            _loc_1.checkCount = _loc_2;
            if (this.animation.data.ready)
            {
                this.play(null, this.lastPoint);
                this.lastPoint = null;
                FrameTimerManager.getTimer().remove(this.checkLoaded);
            }
            else if (this.checkCount > 180)
            {
                this.terminate();
                this.lastPoint = null;
                FrameTimerManager.getTimer().remove(this.checkLoaded);
            }
            return;
        }// end function

        public function play(param1:DisplayObjectContainer, param2:Point = null, param3:int = -1, param4:int = -1) : void
        {
            this._terminated = false;
            if (this.animation == null || !this.animation.defined)
            {
                this.terminate();
                return;
            }
            this.animation.setting.reset();
            this.animation.setting.offset.x = this._offset.x;
            this.animation.setting.offset.y = this._offset.y;
            this._duration = param3;
            var _loc_5:int = 1;
            if (param2)
            {
                if (param2 is Point)
                {
                    this.x = param2.x;
                    this.y = param2.y;
                }
            }
            else
            {
                this.x = 0;
                this.y = 0;
            }
            this.animation.setting.currDir = 1;
            this.updateDuration(param3);
            if (name == "healerhit")
            {
                param1.addChildAt(this, 0);
            }
            else if (param4 > 0)
            {
                param1.addChildAt(this, param4);
            }
            else
            {
                param1.addChild(this);
            }
            FrameTimerManager.getInstance().add(3, 0, this.frameScript);
            return;
        }// end function

        public function updateDuration(param1:int) : void
        {
            if (param1 > 0)
            {
                FrameTimerManager.getInstance().add(param1 / 1000 * 24, 1, this.terminate);
                this._loop = true;
            }
            else if (param1 == 0)
            {
                this._loop = true;
            }
            else
            {
                this._loop = false;
            }
            return;
        }// end function

    }
}
