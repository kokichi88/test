package modules.replay.graphics
{
    import component.*;
    import flash.events.*;
    import modules.replay.*;
    import resMgr.*;
    import utility.*;

    public class GuiEndReplay extends BaseGui
    {
        public var bmpReturnHome:BitmapButton;
        public var bmpReplay:BitmapButton;
        private static const BMP_RETURN:String = "bmpReturnHome";
        private static const BMP_REPLAY:String = "bmpReplay";

        public function GuiEndReplay()
        {
            super(ResMgr.getInstance().getMovieClip("GuiEndReplay"));
            autoAlign = AUTO_ALIGN_CENTER;
            if (this.bmpReturnHome)
            {
                this.bmpReturnHome.setTooltipDisplayObj(Utility.getTooltipString("Về nhà"));
            }
            if (this.bmpReplay)
            {
                this.bmpReplay.setTooltipDisplayObj(Utility.getTooltipString("Xem lại"));
            }
            enableDisableScreen = true;
            showDisableScreen(0.4);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_RETURN:
                {
                    ReplayMgr.getInstance().EffectReturnHome();
                    hide();
                    break;
                }
                case BMP_REPLAY:
                {
                    hide();
                    ReplayMgr.getInstance().replay();
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
