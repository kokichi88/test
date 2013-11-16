package modules.city.graphics.Others
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiLevelUp extends BaseGui
    {
        public var imageLevelUp:MovieClip;
        public var labelTextLevelUp:TextField;
        public var labelNewLevel:TextField;
        public var arr:Array = null;
        private var numLoop:int;
        private var listStar:Vector.<Sprite>;

        public function GuiLevelUp()
        {
            this.listStar = new Vector.<Sprite>;
            super(ResMgr.getInstance().getMovieClip("LevelUpGui"));
            this.bgImg.mouseChildren = false;
            this.bgImg.mouseEnabled = false;
            return;
        }// end function

        private function makeStarEffect() : void
        {
            var _loc_2:String = null;
            var _loc_3:Sprite = null;
            var _loc_1:int = 0;
            while (_loc_1 < 20)
            {
                
                _loc_2 = Utility.randomNumber(0, 10) < 5 ? ("SmallStar") : ("BigStar");
                _loc_3 = ResMgr.getInstance().getMovieClip(_loc_2) as Sprite;
                _loc_3.x = Utility.randomNumber(0, this.widthBg);
                _loc_3.y = Utility.randomNumber(0, this.heightBg);
                this.img.addChild(_loc_3);
                this.listStar.push(_loc_3);
                _loc_1++;
            }
            return;
        }// end function

        private function onLightDone() : void
        {
            return;
        }// end function

        private function runEffect() : void
        {
            this.removeAllItem();
            var _loc_2:Number = 0.8;
            this.bgImg.scaleY = 0.8;
            this.bgImg.scaleX = _loc_2;
            var _loc_1:Number = 1;
            this.bgImg.alpha = 0.2;
            TweenMax.to(this.bgImg, 0.2, {scaleX:_loc_1, scaleY:_loc_1, alpha:1, delay:0.1, ease:Back.easeOut, onComplete:this.onScaleInDone});
            return;
        }// end function

        private function onScaleInDone() : void
        {
            TweenMax.to(this.bgImg, 0.1, {scaleX:0.95, scaleY:0.95, onComplete:this.onScaleOutDone});
            return;
        }// end function

        private function onScaleOutDone() : void
        {
            TweenMax.to(this.bgImg, 0.1, {scaleX:1, scaleY:1, onComplete:this.hideEffect});
            return;
        }// end function

        private function hideEffect() : void
        {
            TweenMax.to(this.bgImg, 2, {alpha:0, delay:1, ease:Back.easeOut, onComplete:this.hideEffectDone});
            return;
        }// end function

        private function hideEffectDone() : void
        {
            hide();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            setPos(GlobalVar.SCREEN_WIDTH / 2, GlobalVar.SCREEN_HEIGHT / 2);
            super.show(param1, param2);
            this.runEffect();
            return;
        }// end function

        public function showLevelUp(param1:int) : void
        {
            this.labelNewLevel.text = param1.toString();
            this.show();
            return;
        }// end function

        private function removeAllItem() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listStar.length)
            {
                
                this.listStar[_loc_1].parent.removeChild(this.listStar[_loc_1]);
                this.listStar[_loc_1] = null;
                _loc_1++;
            }
            this.listStar.splice(0, this.listStar.length);
            this.listStar = new Vector.<Sprite>;
            return;
        }// end function

    }
}
