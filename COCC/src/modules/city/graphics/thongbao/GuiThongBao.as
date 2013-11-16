package modules.city.graphics.thongbao
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiThongBao extends BaseGui
    {
        public var bmpNapG:BitmapButton;
        private static const BMP_NAP_G:String = "bmpNapG";

        public function GuiThongBao()
        {
            super(ResMgr.getInstance().getMovieClip("GuiThongBao"));
            autoAlign = AUTO_ALIGN_CENTER;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = true) : void
        {
            super.show(param1, param2);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_NAP_G:
                {
                    this.hide(true);
                    CityMgr.getInstance().guiNapThe.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
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
