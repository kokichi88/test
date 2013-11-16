package modules.city.graphics.Others
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiPopup extends BaseGui
    {
        public var labelTitle:TextField;
        public var labelMessage:TextField;
        public var labelAction:TextField;
        public var bmpAction:BitmapButton;
        public var bmpClosePopup:BitmapButton;
        private var fnCallback:Function;
        private var fnClose:Function;
        private var param:Object;
        private var paramClose:Object;
        private var imageLoading:MovieClip = null;
        private var iconMoney:Sprite = null;
        private static const BMP_ACTION:String = "bmpAction";
        private static const BMP_CLOSE:String = "bmpClosePopup";

        public function GuiPopup()
        {
            super(ResMgr.getInstance().getMovieClip("PopupGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            this.imageLoading = ResMgr.getInstance().getMovieClip("Processing");
            this.bgImg.addChild(this.imageLoading);
            this.imageLoading.visible = false;
            this.imageLoading.stop();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            GlobalVar.SHOW_MESSAGE_BOX = true;
            super.show(param1, param2);
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            GlobalVar.SHOW_MESSAGE_BOX = false;
            super.hide(param1);
            return;
        }// end function

        private function hideComponents() : void
        {
            var _loc_1:int = 0;
            this.fnClose = null;
            this.imageLoading.visible = false;
            this.imageLoading.stop();
            this.bmpAction.visible = false;
            this.labelAction.text = "";
            this.bmpClosePopup.visible = false;
            if (this.iconMoney && this.iconMoney.parent != null)
            {
                _loc_1 = this.iconMoney.numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    this.iconMoney.removeChildAt(_loc_1);
                    _loc_1 = _loc_1 - 1;
                }
                this.iconMoney.parent.removeChild(this.iconMoney);
                this.iconMoney = null;
            }
            return;
        }// end function

        public function showMessageBox(param1:String, param2:String, param3:String, param4:Function, param5 = null, param6:Boolean = true) : void
        {
            this.hideComponents();
            this.fnCallback = param4;
            this.param = param5;
            this.labelTitle.text = param1.toUpperCase();
            this.labelMessage.text = param2;
            this.labelAction.text = param3.toUpperCase();
            this.bmpClosePopup.visible = param6;
            this.bmpAction.visible = true;
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP), true);
            return;
        }// end function

        public function showConfirmBox(param1:String, param2:String, param3:String, param4:Function, param5:Function, param6 = null, param7 = null) : void
        {
            this.hideComponents();
            this.fnCallback = param4;
            this.fnClose = param5;
            this.paramClose = param7;
            this.param = param6;
            this.labelTitle.text = param1.toUpperCase();
            this.labelMessage.text = param2;
            this.labelAction.text = param3.toUpperCase();
            this.bmpClosePopup.visible = true;
            this.bmpAction.visible = true;
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP), true);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    this.hide(true);
                    if (this.fnClose != null)
                    {
                        this.fnClose.apply(null, this.paramClose);
                    }
                    break;
                }
                case BMP_ACTION:
                {
                    this.hide(true);
                    if (this.fnCallback != null)
                    {
                        this.fnCallback.apply(null, this.param);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function showLoading(param1:String, param2:String) : void
        {
            this.hideComponents();
            this.labelTitle.text = param1;
            this.labelMessage.text = param2;
            this.imageLoading.visible = true;
            this.imageLoading.gotoAndPlay(0);
            this.imageLoading.x = this.widthBg / 2;
            this.imageLoading.y = this.labelMessage.y + this.labelMessage.textHeight + 50;
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP), true);
            return;
        }// end function

        public function showChargeCardSuccess(param1:int) : void
        {
            this.hideComponents();
            this.bmpAction.visible = true;
            this.labelAction.text = "ĐÓNG";
            this.labelTitle.text = Localization.getInstance().getString("ChargeCard0");
            this.labelMessage.text = Localization.getInstance().getString("ChargeCardSuccess");
            this.iconMoney = new Sprite();
            var _loc_2:* = new TooltipText(true, true, true);
            this.iconMoney.addChild(_loc_2);
            _loc_2.htmlText = "<font size=\'18\' color=\'" + GlobalVar.MONEY_COLOR["Coin"] + "\'>" + param1 + "</font>";
            _loc_2.x = 0;
            var _loc_3:* = ResMgr.getInstance().getMovieClip("image_Coin") as Sprite;
            _loc_3.x = _loc_2.x + _loc_2.width / 2 + _loc_2.textWidth / 2 + 5;
            _loc_3.y = _loc_2.y + (_loc_2.height - _loc_3.height) / 2;
            this.iconMoney.addChild(_loc_3);
            this.bgImg.addChild(this.iconMoney);
            this.iconMoney.x = (this.widthBg - this.iconMoney.width) / 2;
            this.iconMoney.y = this.labelMessage.y + this.labelMessage.textHeight + 15;
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP), true);
            this.fnCallback = null;
            return;
        }// end function

        public function showPromoSuccess(param1:int, param2:Number) : void
        {
            this.hideComponents();
            this.bmpAction.visible = true;
            this.labelAction.text = "ĐÓNG";
            this.labelTitle.text = Localization.getInstance().getString("ChargeCard0");
            this.labelMessage.text = Localization.getInstance().getString("PromoSuccess");
            this.labelMessage.text = this.labelMessage.text.replace("@promoG", param1);
            this.iconMoney = new Sprite();
            var _loc_3:* = new TooltipText(true, true, true);
            this.iconMoney.addChild(_loc_3);
            _loc_3.htmlText = "<font size=\'18\' color=\'" + GlobalVar.MONEY_COLOR["Coin"] + "\'>" + param2 + "</font>";
            _loc_3.x = 0;
            var _loc_4:* = ResMgr.getInstance().getMovieClip("image_Coin") as Sprite;
            (ResMgr.getInstance().getMovieClip("image_Coin") as Sprite).x = _loc_3.x + _loc_3.width / 2 + _loc_3.textWidth / 2 + 5;
            _loc_4.y = _loc_3.y + (_loc_3.height - _loc_4.height) / 2;
            this.iconMoney.addChild(_loc_4);
            this.bgImg.addChild(this.iconMoney);
            this.iconMoney.x = (this.widthBg - this.iconMoney.width) / 2;
            this.iconMoney.y = this.labelMessage.y + this.labelMessage.textHeight + 15;
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP), true);
            this.fnCallback = null;
            return;
        }// end function

    }
}
