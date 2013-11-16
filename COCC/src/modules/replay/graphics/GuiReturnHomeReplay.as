package modules.replay.graphics
{
    import component.*;
    import flash.events.*;
    import modules.replay.*;
    import resMgr.*;

    public class GuiReturnHomeReplay extends BaseGui
    {
        public var bmpReturnHome:BitmapButton;
        private static const BMP_RETURN:String = "bmpReturnHome";

        public function GuiReturnHomeReplay()
        {
            super(ResMgr.getInstance().getMovieClip("GuiReturnHome"));
            autoAlign = AUTO_ALIGN_BOTTOM_LEFT;
            if (this.bmpReturnHome)
            {
                this.bmpReturnHome.setTooltip("Về nhà");
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_RETURN:
                {
                    ReplayMgr.getInstance().EffectReturnHome();
                    this.hideDisableScreen();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
