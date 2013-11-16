package modules.city.graphics.effectSeed
{
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;
    import resMgr.*;

    public class IconEffectSeed extends Object
    {
        private var sp:Sprite;
        private var type:String;

        public function IconEffectSeed()
        {
            return;
        }// end function

        public function create(param1:String, param2:Point, param3:Point) : void
        {
            this.type = param1;
            this.sp = ResMgr.getInstance().getMovieClip(this.type) as Sprite;
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP).addChild(this.sp);
            this.sp.x = param2.x;
            this.sp.y = param2.y;
            TweenMax.to(this.sp, 1.2, {x:param3.x, y:param3.y, onComplete:this.onMoveDone});
            return;
        }// end function

        private function onMoveDone() : void
        {
            if (this.sp.parent)
            {
                this.sp.parent.removeChild(this.sp);
                this.sp.visible = false;
                this.sp = null;
            }
            return;
        }// end function

    }
}
