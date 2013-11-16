package modules.city.graphics.setting
{
    import component.*;
    import flash.events.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class GuiMainSetting extends BaseGui
    {
        private const BMP_SETTING:String = "bmpSetting";
        public var guiSubSetting:GuiSubSetting;
        public var bmpSetting:BitmapButton;

        public function GuiMainSetting()
        {
            super(ResMgr.getInstance().getMovieClip("MainGui_Setting"));
            this.bmpSetting.setTooltipDisplayObj(Utility.getTooltipString("Tùy chỉnh"));
            setPos(GlobalVar.SCREEN_WIDTH - widthBg - 15, CityMgr.getInstance().guiMainTopRight.heightBg);
            this.guiSubSetting = new GuiSubSetting();
            addGui(this.guiSubSetting);
            this.guiSubSetting.setPos(this.bmpSetting.img.x + (this.bmpSetting.width - this.guiSubSetting.widthBg) / 2, this.bmpSetting.img.y + this.bmpSetting.height - 5);
            this.guiSubSetting.bgImg.visible = false;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().hideBuildingActionGui();
            switch(param1)
            {
                case this.BMP_SETTING:
                {
                    this.guiSubSetting.bgImg.visible = !this.guiSubSetting.bgImg.visible;
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
