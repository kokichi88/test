package modules.city.graphics.Others
{
    import component.*;
    import flash.events.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiReturnHome extends BaseGui
    {
        public var bmpReturnHome:BitmapButton;

        public function GuiReturnHome()
        {
            super(ResMgr.getInstance().getMovieClip("GuiReturnHome"));
            autoAlign = AUTO_ALIGN_BOTTOM_LEFT;
            this.bmpReturnHome.setTooltipDisplayObj(Utility.getTooltipString("Về nhà"));
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().hideBuildingActionGui();
            hide();
            CityMgr.getInstance().guiFriendsList.hide();
            CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().returnMyHome);
            return;
        }// end function

    }
}
