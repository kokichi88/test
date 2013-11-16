package modules.city.graphics.tutorial
{
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import resMgr.*;

    public class GuiNPC1 extends BaseGui
    {
        public var box:GuiNPC1Box;
        private var curStep:int;
        private var curAction:String;
        public var imageNPC1:MovieClip;
        public var imageNPC1Bg:MovieClip;
        private var startX:Number;

        public function GuiNPC1()
        {
            super(ResMgr.getInstance().getMovieClip("NPC1_Gui"));
            this.box = new GuiNPC1Box();
            addGui(this.box);
            this.startX = this.imageNPC1.x;
            this.box.setPos(295, 94);
            return;
        }// end function

        public function showTutorialStep(param1:int, param2:String = null, param3:Boolean = false) : void
        {
            setPos(0, GlobalVar.SCREEN_HEIGHT - this.heightBg + 20);
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP).ShowTutorialScreen(0, 0, 0, 0);
            this.curStep = param1;
            this.curAction = param2;
            show(_loc_4);
            TutorialMgr.getInstance().isMovingBox = true;
            if (!param3)
            {
                this.box.hide();
                var _loc_5:int = -400;
                this.imageNPC1Bg.x = -400;
                this.imageNPC1.x = _loc_5;
                TweenLite.to(this.imageNPC1, 0.3, {x:this.startX + 5, onComplete:this.movingDone1});
                TweenLite.to(this.imageNPC1Bg, 0.15, {x:-15, onComplete:this.beginScale});
            }
            else
            {
                this.movingOutBox();
            }
            return;
        }// end function

        private function beginScale() : void
        {
            TweenLite.to(this.imageNPC1Bg, 0.3, {scaleX:1.03, scaleY:1.01, onComplete:this.endScale});
            return;
        }// end function

        private function endScale() : void
        {
            TweenLite.to(this.imageNPC1Bg, 0.3, {scaleX:1, scaleY:1});
            return;
        }// end function

        private function movingDone1() : void
        {
            TweenLite.to(this.imageNPC1, 0.3, {x:this.startX, onComplete:this.moveInBox});
            return;
        }// end function

        private function movingDone() : void
        {
            var _loc_1:* = new Point(0, 0);
            if (this.curAction)
            {
                _loc_1.x = this.bgImg.x + this.box.bgImg.x + this.box.bmpActionTut.img.x + this.box.bmpActionTut.width;
                _loc_1.y = this.bgImg.y + this.box.bgImg.y + this.box.bmpActionTut.img.y + 5;
                TutorialMgr.getInstance().showLeftArrow(_loc_1.x, _loc_1.y);
            }
            TutorialMgr.getInstance().isMovingBox = false;
            return;
        }// end function

        public function moveOut(param1:Boolean = false) : void
        {
            var _loc_2:int = -400;
            TweenLite.to(this.bgImg, 0.1, {x:_loc_2, onComplete:this.movingOutDone});
            return;
        }// end function

        private function movingOutDone() : void
        {
            super.hide();
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            _loc_1.hideFog();
            TutorialMgr.getInstance().nextStep();
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            _loc_2.hideFog();
            return;
        }// end function

        private function movingOutBox() : void
        {
            TweenLite.to(this.box.bgImg, 0.3, {scaleX:0, scaleY:0, onComplete:this.moveInBox});
            TweenLite.to(this.box.bgImg, 0.3, {rotation:45});
            return;
        }// end function

        private function moveInBox() : void
        {
            this.box.showTutorialStep(this.curStep, this.curAction);
            this.box.show(this.bgImg);
            var _loc_1:int = 0;
            this.box.bgImg.scaleY = 0;
            this.box.bgImg.scaleX = _loc_1;
            this.box.bgImg.rotation = 45;
            TweenLite.to(this.box.bgImg, 0.3, {scaleX:1.05, scaleY:1.05, onComplete:this.scaleBoxDone2});
            TweenLite.to(this.box.bgImg, 0.3, {rotation:0});
            return;
        }// end function

        private function scaleBoxDone2() : void
        {
            TweenLite.to(this.box.bgImg, 0.2, {scaleX:1, scaleY:1, onComplete:this.scaleBoxDone3});
            return;
        }// end function

        private function scaleBoxDone3() : void
        {
            this.movingDone();
            return;
        }// end function

    }
}
