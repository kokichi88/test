package modules.city.graphics.moneyCard
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import resMgr.*;

    public class GuiSMS extends BaseGui
    {
        public var labelZingID:TextField;
        public var labelUID:TextField;
        public var labelUID2:TextField;
        public var labelSoanTinNhan:TextField;
        private static const BMP_CLOSE:String = "bmpClose";

        public function GuiSMS()
        {
            super(ResMgr.getInstance().getMovieClip("SMSGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            this.labelZingID.text = GameDataMgr.getInstance().myInfo.uName;
            var _loc_3:* = GameDataMgr.getInstance().myInfo.uId.toString();
            this.labelUID2.text = GameDataMgr.getInstance().myInfo.uId.toString();
            this.labelUID.text = _loc_3;
            super.show(param1, param2);
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
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
