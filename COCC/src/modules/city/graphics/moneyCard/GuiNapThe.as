package modules.city.graphics.moneyCard
{
    import component.*;
    import flash.events.*;
    import flash.external.*;
    import resMgr.*;

    public class GuiNapThe extends BaseGui
    {
        private var guiSMS:GuiSMS;
        private var guiTelecomCard:GuiTelecomCard;
        private static const BMP_ZINGXU:String = "bmpZingXu";
        private static const BMP_TELECOMCARD:String = "bmpTelecomCard";
        private static const BMP_CLOSE:String = "bmpClose";
        private static const BMP_TUIZINGXU:String = "bmpTuiZingXu";
        private static const BMP_SMS:String = "bmpSMS";

        public function GuiNapThe()
        {
            super(ResMgr.getInstance().getMovieClip("NapGGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.guiSMS = new GuiSMS();
            this.guiTelecomCard = new GuiTelecomCard();
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    hide(true);
                    break;
                }
                case BMP_ZINGXU:
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("showPayment");
                    }
                    hide();
                    break;
                }
                case BMP_TELECOMCARD:
                {
                    this.guiTelecomCard.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
                    hide();
                    break;
                }
                case BMP_TUIZINGXU:
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("showDoiZingXu");
                    }
                    hide();
                    break;
                }
                case BMP_SMS:
                {
                    this.guiSMS.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
                    hide();
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
