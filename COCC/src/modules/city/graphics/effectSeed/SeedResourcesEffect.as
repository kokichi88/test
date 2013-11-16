package modules.city.graphics.effectSeed
{
    import com.greensock.*;
    import flash.display.*;

    public class SeedResourcesEffect extends Object
    {
        private var img:MovieClip;

        public function SeedResourcesEffect()
        {
            return;
        }// end function

        public function create(param1:MovieClip) : void
        {
            this.img = param1;
            return;
        }// end function

        public function runEffect() : void
        {
            TweenMax.killChildTweensOf(this.img);
            var _loc_1:int = 1;
            this.img.scaleY = 1;
            this.img.scaleX = _loc_1;
            TweenMax.to(this.img, 0.2, {scaleX:1.25, scaleY:1.25, onComplete:this.onScale1});
            return;
        }// end function

        private function onScale1() : void
        {
            TweenMax.to(this.img, 0.1, {scaleX:1.1, scaleY:1.1, onComplete:this.onScale2});
            return;
        }// end function

        private function onScale2() : void
        {
            TweenMax.to(this.img, 0.17, {scaleX:1.2, scaleY:1.2, onComplete:this.onScale3});
            return;
        }// end function

        private function onScale3() : void
        {
            TweenMax.to(this.img, 0.1, {scaleX:1, scaleY:1, onComplete:this.onScale4});
            return;
        }// end function

        private function onScale4() : void
        {
            TweenMax.to(this.img, 0.15, {scaleX:1.05, scaleY:1.05, onComplete:this.onScale5});
            return;
        }// end function

        private function onScale5() : void
        {
            TweenMax.to(this.img, 0.1, {scaleX:1, scaleY:1, onComplete:this.onScaleDone});
            return;
        }// end function

        private function onScaleDone() : void
        {
            return;
        }// end function

    }
}
