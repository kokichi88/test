package modules.city.graphics.fanpage
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiFanpage extends BaseGui
    {
        public var bmpFacebook:BitmapButton;
        public var bmpZingMe:BitmapButton;
        public var bmpSupport:BitmapButton;
        public var bmpFanpage:BitmapButton;
        public var imageBgSubFanpage:MovieClip;
        private static const BMP_FACEBOOK:String = "bmpFacebook";
        private static const BMP_ZINGME:String = "bmpZingMe";
        private static const BMP_SUPPORT:String = "bmpSupport";
        private static const BMP_FANPAGE:String = "bmpFanpage";

        public function GuiFanpage()
        {
            super(ResMgr.getInstance().getMovieClip("FanpageGui"));
            this.bmpFanpage.setTooltipDisplayObj(Utility.getTooltipString("Fanpage"));
            this.bmpFacebook.setTooltipDisplayObj(Utility.getTooltipString("Fanpage trên Facebook"));
            this.bmpZingMe.setTooltipDisplayObj(Utility.getTooltipString("Fanpage trên ZingMe"));
            this.bmpSupport.setTooltipDisplayObj(Utility.getTooltipString("Báo lỗi game"));
            this.showSubGui(false);
            var _loc_1:* = CityMgr.getInstance().guiMainSetting.getPos();
            setPos(_loc_1.x - this.widthBg - 10, _loc_1.y);
            return;
        }// end function

        private function showSubGui(param1:Boolean) : void
        {
            this.imageBgSubFanpage.visible = param1;
            this.bmpFacebook.visible = param1;
            this.bmpZingMe.visible = param1;
            this.bmpSupport.visible = param1;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().hideBuildingActionGui();
            switch(param1)
            {
                case BMP_FANPAGE:
                {
                    this.showSubGui(!this.imageBgSubFanpage.visible);
                    break;
                }
                case BMP_FACEBOOK:
                {
                    Utility.callURL(GlobalVar.URL_FANPAGE_FACEBOOK);
                    break;
                }
                case BMP_ZINGME:
                {
                    Utility.callURL(GlobalVar.URL_FANPAGE_ZINGME);
                    break;
                }
                case BMP_SUPPORT:
                {
                    Utility.callURL(GlobalVar.URL_SUPPORT);
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
