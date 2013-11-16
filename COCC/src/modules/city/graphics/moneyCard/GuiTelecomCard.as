package modules.city.graphics.moneyCard
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiTelecomCard extends BaseGui
    {
        public var bmp2Mobifone:BitmapButton;
        public var bmp2Viettel:BitmapButton;
        public var bmp2Vinaphone:BitmapButton;
        public var bmp2BuyCard:BitmapButton;
        public var labelSeri:TextField;
        public var labelCardCode:TextField;
        public var curType:String;
        public static const MOBI:String = "VMS";
        public static const VIETTEL:String = "VTT";
        public static const VINA:String = "VNP";
        private static const BMP_MOBI:String = "bmp2Mobifone";
        private static const BMP_VIETTEL:String = "bmp2Viettel";
        private static const BMP_VINA:String = "bmp2Vinaphone";
        private static const BMP_NAPTHE:String = "bmp2BuyCard";
        private static const BMP_CLOSE:String = "bmpClose";

        public function GuiTelecomCard()
        {
            super(ResMgr.getInstance().getMovieClip("TelecomCardGui"));
            setPos((GlobalVar.SCREEN_WIDTH - 690) / 2, (GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2);
            this.curType = MOBI;
            this.labelCardCode.type = TextFieldType.INPUT;
            this.labelCardCode.mouseEnabled = true;
            this.labelSeri.type = TextFieldType.INPUT;
            this.labelSeri.mouseEnabled = true;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(param1, param2);
            switch(this.curType)
            {
                case VINA:
                {
                    this.onMouseClick(BMP_VINA, null);
                    break;
                }
                case MOBI:
                {
                    this.onMouseClick(BMP_MOBI, null);
                    break;
                }
                case VIETTEL:
                {
                    this.onMouseClick(BMP_VIETTEL, null);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setNormal() : void
        {
            this.bmp2Mobifone.setTabNormal();
            this.bmp2Viettel.setTabNormal();
            this.bmp2Vinaphone.setTabNormal();
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_MOBI:
                {
                    this.setNormal();
                    this.bmp2Mobifone.setTabSelected();
                    this.curType = MOBI;
                    break;
                }
                case BMP_VIETTEL:
                {
                    this.setNormal();
                    this.bmp2Viettel.setTabSelected();
                    this.curType = VIETTEL;
                    break;
                }
                case BMP_VINA:
                {
                    this.setNormal();
                    this.bmp2Vinaphone.setTabSelected();
                    this.curType = VINA;
                    break;
                }
                case BMP_NAPTHE:
                {
                    CityMgr.getInstance().sendChargeCard(this.curType, this.labelCardCode.text, this.labelSeri.text);
                    break;
                }
                case BMP_CLOSE:
                {
                    hide(true);
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
