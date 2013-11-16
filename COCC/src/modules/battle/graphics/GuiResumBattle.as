package modules.battle.graphics
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import resMgr.*;

    public class GuiResumBattle extends BaseGui
    {
        public var imageStar1:MovieClip;
        public var imageStar2:MovieClip;
        public var imageStar3:MovieClip;
        public var index:int = 0;
        public var labelPercent:TextField;

        public function GuiResumBattle()
        {
            super(ResMgr.getInstance().getMovieClip("GuiResumBattle"));
            autoAlign = AUTO_ALIGN_LEFT_CENTER;
            this.labelPercent.text = "0%";
            this.imageStar1.visible = false;
            this.imageStar2.visible = false;
            this.imageStar3.visible = false;
            return;
        }// end function

        public function updatePercent(param1:int) : void
        {
            this.labelPercent.text = param1.toString() + "%";
            return;
        }// end function

        public function updateStar(param1:int) : void
        {
            this.index = param1;
            switch(this.index)
            {
                case 1:
                {
                    this.imageStar1.visible = true;
                    break;
                }
                case 2:
                {
                    this.imageStar2.visible = true;
                    break;
                }
                case 3:
                {
                    this.imageStar3.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            this.resetData();
            super.show(param1);
            return;
        }// end function

        private function resetData() : void
        {
            this.labelPercent.text = "0%";
            this.imageStar1.visible = false;
            this.imageStar2.visible = false;
            this.imageStar3.visible = false;
            this.index = 0;
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            this.resetData();
            super.hide();
            return;
        }// end function

    }
}
