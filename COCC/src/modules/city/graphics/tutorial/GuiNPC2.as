package modules.city.graphics.tutorial
{
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.geom.*;
    import modules.sound.*;
    import resMgr.*;

    public class GuiNPC2 extends BaseGui
    {
        public var box:GuiNPC2Box;
        private var curStep:int;
        private var curAction:String;
        public var imageNPC2:MovieClip;
        public var imageNPC2Bg:MovieClip;
        private var startX:Number;

        public function GuiNPC2()
        {
            super(ResMgr.getInstance().getMovieClip("NPC2_Gui"));
            this.box = new GuiNPC2Box();
            this.box.bgImg.visible = false;
            addGui(this.box);
            this.startX = this.imageNPC2.x;
            this.box.setPos(250, 243);
            return;
        }// end function

        public function showTutorialStep(param1:int, param2:String = null, param3:Boolean = false) : void
        {
            setPos(GlobalVar.SCREEN_WIDTH - this.widthBg + 10, GlobalVar.SCREEN_HEIGHT - this.heightBg + 20);
            SoundModule.getInstance().playSound(SoundModule.GOBLIN_TALK);
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP);
            LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP).ShowTutorialScreen(0, 0, 0, 0);
            this.curStep = param1;
            this.curAction = param2;
            show(_loc_4);
            if (!param3)
            {
                this.box.bgImg.visible = false;
                var _loc_5:* = GlobalVar.SCREEN_WIDTH + 500;
                this.imageNPC2Bg.x = GlobalVar.SCREEN_WIDTH + 500;
                this.imageNPC2.x = _loc_5;
                TweenLite.to(this.imageNPC2, 0.3, {x:this.startX - 5, onComplete:this.movingDone1});
                TweenLite.to(this.imageNPC2Bg, 0.15, {x:464, onComplete:this.beginScale});
            }
            else
            {
                this.movingOutBox();
            }
            return;
        }// end function

        private function beginScale() : void
        {
            TweenLite.to(this.imageNPC2Bg, 0.3, {scaleX:1.01, scaleY:1.02, onComplete:this.endScale});
            return;
        }// end function

        private function endScale() : void
        {
            TweenLite.to(this.imageNPC2Bg, 0.3, {scaleX:1, scaleY:1});
            return;
        }// end function

        private function movingDone1() : void
        {
            TweenLite.to(this.imageNPC2, 0.3, {x:this.startX, onComplete:this.moveInBox});
            return;
        }// end function

        private function movingDone() : void
        {
            var _loc_1:* = new Point(0, 0);
            if (this.curAction)
            {
                _loc_1.x = this.bgImg.x + this.box.bgImg.x + this.box.bmpActionTut.img.x;
                _loc_1.y = this.bgImg.y + this.box.bgImg.y + this.box.bmpActionTut.img.y + this.box.bmpActionTut.height / 2;
                TutorialMgr.getInstance().showRightArrow(_loc_1.x, _loc_1.y);
            }
            return;
        }// end function

        public function moveOut() : void
        {
            var _loc_1:* = GlobalVar.SCREEN_WIDTH + 500;
            TweenLite.to(this.bgImg, 0.3, {x:_loc_1, onComplete:this.movingOutDone});
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
            this.box.bgImg.rotation = -45;
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
