package modules.city.graphics.effectSeed
{
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import modules.city.*;
    import resMgr.*;

    public class IdleEffectSeed extends Object
    {
        private var sp:Sprite;
        private var labelZ:TooltipText;
        private var posX:Number;
        private var posY:Number;
        private var delay:Number;
        private var deltaScale:Number;

        public function IdleEffectSeed()
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_EFFECT);
            this.sp = new Sprite();
            this.labelZ = new TooltipText(true, true, true);
            this.labelZ.htmlText = "<font size=\'26\'>Z </font>";
            this.sp.addChild(this.labelZ);
            this.sp.alpha = 0;
            _loc_1.addChild(this.sp);
            CityMgr.getInstance().spriteList.push(this.sp);
            return;
        }// end function

        public function setInfo(param1:int, param2:int, param3:Number, param4:Number = 0) : void
        {
            this.posX = param1 - this.sp.width / 2;
            this.posY = param2;
            this.delay = param3;
            this.deltaScale = param4;
            return;
        }// end function

        public function runEffect() : void
        {
            this.sp.x = this.posX;
            this.sp.y = this.posY;
            this.sp.alpha = 0;
            var _loc_1:* = 0.9 - this.deltaScale;
            this.sp.scaleY = 0.9 - this.deltaScale;
            this.sp.scaleX = _loc_1;
            TweenMax.to(this.sp, 0.2, {delay:this.delay, alpha:1, scaleX:1 - this.deltaScale, scaleY:1 - this.deltaScale, onComplete:this.scaleDone});
            return;
        }// end function

        private function scaleDone() : void
        {
            var _loc_1:Number = 130;
            var _loc_2:* = new Point(this.sp.x + 30, this.sp.y - _loc_1 / 3);
            var _loc_3:* = new Point(this.sp.x - 10, this.sp.y - _loc_1 * 2 / 3);
            var _loc_4:* = new Point(this.sp.x, this.sp.y - _loc_1);
            TweenMax.to(this.sp, 3, {bezier:[{x:_loc_2.x, y:_loc_2.y}, {x:_loc_3.x, y:_loc_3.y}, {x:_loc_4.x, y:_loc_4.y}], onComplete:this.moveDone});
            TweenMax.to(this.sp, 1.5, {alpha:0, delay:0.5});
            return;
        }// end function

        private function moveDone() : void
        {
            return;
        }// end function

        public function stop() : void
        {
            TweenMax.killChildTweensOf(this.sp);
            this.sp.alpha = 0;
            return;
        }// end function

        public function destroy() : void
        {
            if (this.sp && this.sp.parent != null)
            {
                this.sp.removeChild(this.labelZ);
                this.labelZ = null;
                this.sp.parent.removeChild(this.sp);
                this.sp = null;
            }
            return;
        }// end function

    }
}
