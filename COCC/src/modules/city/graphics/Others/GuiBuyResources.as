package modules.city.graphics.Others
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import resMgr.*;
    import utility.*;

    public class GuiBuyResources extends BaseGui
    {
        public var labelTitle:TextField;
        public var labelMessage:TextField;
        public var labelMoney:TextField;
        public var labelG:TextField;
        public var bmpBuyResource:BitmapButton;
        private var iconMoney:Sprite = null;
        private var fnCallback:Function;
        private var param:Object;
        private var fnClose:Function;
        private var paramClose:Object;
        private var gSpend:int;
        private var lackingMoney:MoneyType;
        public static const RESOURCE:String = "BuyResource0";
        public static const TIME_BUILD:String = "BuyResource1";
        public static const TIME_RESEARCH:String = "BuyResource2";
        public static const TIME_FREE_BUILDER:String = "BuyResource3";
        private static const BMP_BUY_RESOURCE:String = "bmpBuyResource";
        private static const BMP_CLOSE:String = "bmpClose";

        public function GuiBuyResources()
        {
            this.lackingMoney = new MoneyType();
            super(ResMgr.getInstance().getMovieClip("BuyResourceGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
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

        public function showGuiBuyResource(param1:String, param2:int, param3:Function, param4 = null) : void
        {
            this.fnClose = null;
            this.fnCallback = param3;
            this.param = param4;
            this.lackingMoney.type = param1;
            this.lackingMoney.value = param2;
            var _loc_5:* = Localization.getInstance().getString("NotEnoughMoney0");
            _loc_5 = Localization.getInstance().getString("NotEnoughMoney0").replace("@type@", Localization.getInstance().getString(param1));
            this.labelTitle.text = _loc_5.toUpperCase();
            var _loc_6:* = Localization.getInstance().getString("NotEnoughMoney1");
            this.labelMessage.text = _loc_6.replace("@type@", Localization.getInstance().getString(param1));
            this.labelMoney.text = Utility.standardNumber(param2);
            if (this.iconMoney)
            {
                this.iconMoney.parent.removeChild(this.iconMoney);
                this.iconMoney = null;
            }
            this.iconMoney = ResMgr.getInstance().getMovieClip(param1 + "_Medium_Icon") as Sprite;
            this.img.addChild(this.iconMoney);
            this.iconMoney.x = this.labelMoney.x + this.labelMoney.width / 2 + this.labelMoney.textWidth / 2 + 5;
            this.iconMoney.y = this.labelMoney.y + (this.labelMoney.height - this.iconMoney.height) / 2;
            this.gSpend = Utility.getCostToBuyResources(param2).value;
            this.labelG.textColor = GameDataMgr.getInstance().getMoney(MoneyType.COIN) >= this.gSpend ? (16776933) : (16728128);
            this.labelG.text = Utility.standardNumber(this.gSpend);
            this.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_POPUP), true);
            return;
        }// end function

        public function showGuiByTime(param1:String, param2:String, param3:int, param4:Function, param5:Function, param6 = null, param7 = null) : void
        {
            this.fnCallback = param4;
            this.param = param6;
            this.fnClose = param5;
            this.paramClose = param7;
            this.labelTitle.text = param1;
            this.labelMessage.text = param2;
            if (this.iconMoney)
            {
                this.iconMoney.parent.removeChild(this.iconMoney);
                this.iconMoney = null;
            }
            this.labelMoney.text = "";
            var _loc_8:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN);
            var _loc_9:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN) >= param3 ? ("#FFFFFF") : ("#FF4040");
            this.labelG.htmlText = "<font color=\'" + _loc_9 + "\'> " + Utility.standardNumber(param3) + " </font>";
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
                case BMP_BUY_RESOURCE:
                {
                    this.hide();
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

    }
}
