package modules.city.graphics.promoteG
{
    import component.*;
    import flash.events.*;
    import flash.text.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiPromoteG_1 extends BaseGui
    {
        public var labelPromoteG:TextField;

        public function GuiPromoteG_1()
        {
            super(ResMgr.getInstance().getMovieClip("PromoteG_1_Gui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            disableScreenAlpha = 0.35;
            return;
        }// end function

        public function setPromoteG(param1:int) : void
        {
            this.labelPromoteG.text = Utility.standardNumber(param1);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            hide(true);
            CityMgr.getInstance().sendBetaUserPromote();
            return;
        }// end function

    }
}
