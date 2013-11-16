package modules.city.graphics.promoteG
{
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiPromoteG_2 extends BaseGui
    {
        public var labelPromoteG:TextField;
        public var labelTotalCoin:TextField;

        public function GuiPromoteG_2()
        {
            super(ResMgr.getInstance().getMovieClip("PromoteG_2_Gui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            disableScreenAlpha = 0.35;
            return;
        }// end function

        public function setPromoteG(param1:int) : void
        {
            this.labelTotalCoin.text = Utility.standardNumber(param1);
            this.labelPromoteG.text = Utility.standardNumber(Math.floor(param1 * 1.2));
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            hide(true);
            CityMgr.getInstance().sendBetaPayUserPromote();
            return;
        }// end function

    }
}
