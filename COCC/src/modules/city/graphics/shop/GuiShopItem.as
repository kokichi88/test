package modules.city.graphics.shop
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import map.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiShopItem extends BaseGui
    {
        public var itemId:String = "SPE_1";
        public var labelWait:TextField;
        public var labelTime:TextField;
        public var labelItemName:TextField;
        public var labelPrice:TextField;
        public var bmpShopItem:BitmapButton;
        public var bmpInfo:BitmapButton;
        private var moneyType:MoneyType = null;
        private var saveDay:int;
        private var shieldId:int = -1;
        private static const BMP_ITEM:String = "bmpShopItem";
        private static const BMP_INFO:String = "bmpInfo";

        public function GuiShopItem()
        {
            super(ResMgr.getInstance().getMovieClip("ShopGui_Item"));
            this.labelWait.visible = false;
            this.labelTime.visible = false;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:MapObject = null;
            var _loc_4:MapObject = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_7:DataShield = null;
            switch(param1)
            {
                case BMP_INFO:
                {
                    if (TutorialMgr.getInstance().isTutorial)
                    {
                        return;
                    }
                    if (this.shieldId != -1)
                    {
                        CityMgr.getInstance().guiBuildingInfo.showInfoShield(this.shieldId);
                    }
                    else
                    {
                        _loc_3 = new MapObject();
                        _loc_3.type = this.itemId;
                        _loc_3.level = 1;
                        _loc_3.loadConfigData();
                        _loc_4 = MapMgr.copyMapObject(_loc_3);
                        CityMgr.getInstance().showBuildingInfo(_loc_4, true);
                    }
                    break;
                }
                default:
                {
                    if (!this.moneyType)
                    {
                        CityMgr.getInstance().addShopIconToMouse(this.itemId);
                    }
                    else
                    {
                        CityMgr.getInstance().guiShop.hide();
                        if (CityMgr.getInstance().guiShop.treasureShop.bgImg.visible)
                        {
                            CityMgr.getInstance().guiBuyResource.showGuiBuyResource(this.moneyType.type, this.moneyType.value, CityMgr.getInstance().acceptBuyResource, [this.moneyType.type, this.moneyType.value, null]);
                        }
                        else if (CityMgr.getInstance().guiShop.shieldShop.bgImg.visible)
                        {
                            _loc_5 = Localization.getInstance().getString("Title_TB");
                            _loc_6 = Localization.getInstance().getString("ShieldMsg");
                            _loc_7 = JsonMgr.getInstance().getShieldData(this.shieldId);
                            _loc_6 = _loc_6.replace("@number", _loc_7.days);
                            CityMgr.getInstance().guiBuyResource.showGuiByTime(_loc_5, _loc_6, _loc_7.coin, CityMgr.getInstance().acceptBuyShield, null, [this.shieldId]);
                        }
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function setIcon(param1:String) : void
        {
            this.moneyType = null;
            this.itemId = param1;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(this.itemId + "_Icon") as Sprite;
            if (!_loc_2)
            {
                return;
            }
            this.bmpShopItem.img.addChild(_loc_2);
            _loc_2.x = (img.width - _loc_2.width) / 2;
            _loc_2.y = (img.height - _loc_2.height) / 2;
            _loc_2.mouseChildren = false;
            _loc_2.mouseEnabled = false;
            this.labelItemName.text = Localization.getInstance().getString(this.itemId);
            return;
        }// end function

        public function updateState() : void
        {
            var _loc_4:Sprite = null;
            var _loc_1:* = Utility.getInfoToBuild(this.itemId, 1);
            var _loc_2:* = Utility.getShopItem(_loc_1);
            this.bmpShopItem.setTooltipDisplayObj(_loc_2);
            if (_loc_1.curCount >= _loc_1.maxCount)
            {
                this.bmpShopItem.enable = false;
            }
            else
            {
                this.bmpShopItem.enable = true;
            }
            var _loc_3:* = _loc_1.cost.value;
            switch(_loc_1.cost.type)
            {
                case MoneyType.ELIXIR:
                {
                    _loc_4 = ResMgr.getInstance().getMovieClip("Elixir_Smaller_Icon") as Sprite;
                    _loc_4.x = 88;
                    _loc_4.y = 115;
                    break;
                }
                case MoneyType.GOLD:
                {
                    _loc_4 = ResMgr.getInstance().getMovieClip("Gold_Smaller_Icon") as Sprite;
                    _loc_4.x = 88;
                    _loc_4.y = 117;
                    break;
                }
                case MoneyType.COIN:
                {
                    _loc_4 = ResMgr.getInstance().getMovieClip("Coin_Smaller_Icon") as Sprite;
                    _loc_4.x = 88;
                    _loc_4.y = 116;
                    break;
                }
                case MoneyType.DARK_ELIXIR:
                {
                    _loc_4 = ResMgr.getInstance().getMovieClip("DarkElixir_Smaller_Icon") as Sprite;
                    _loc_4.x = 88;
                    _loc_4.y = 115;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_5:* = GameDataMgr.getInstance().getMoney(_loc_1.cost.type);
            var _loc_6:* = GameDataMgr.getInstance().getMoney(_loc_1.cost.type) >= _loc_1.cost.value ? ("#FFFFFF") : ("#FF4040");
            this.labelPrice.htmlText = "<font color=\'" + _loc_6 + "\'> " + Utility.standardNumber(_loc_3) + " </font>";
            this.bmpShopItem.img.addChild(_loc_4);
            return;
        }// end function

        public function setIconTreasures(param1:String, param2:int, param3:int) : void
        {
            var _loc_9:TooltipText = null;
            this.moneyType = new MoneyType(param1, param2);
            this.bmpInfo.visible = false;
            this.itemId = param1;
            var _loc_4:* = ResMgr.getInstance().getMovieClip(param1 + "_" + param3 + "_Icon") as Sprite;
            if (!(ResMgr.getInstance().getMovieClip(param1 + "_" + param3 + "_Icon") as Sprite))
            {
                return;
            }
            this.bmpShopItem.img.addChild(_loc_4);
            _loc_4.x = (img.width - _loc_4.width) / 2;
            _loc_4.y = (img.height - _loc_4.height) / 2;
            _loc_4.mouseChildren = false;
            _loc_4.mouseEnabled = false;
            this.labelItemName.text = Localization.getInstance().getString("Treasure" + param3);
            var _loc_5:* = Utility.getCostToBuyResources(param2).value;
            var _loc_6:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN);
            var _loc_7:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN) >= _loc_5 ? ("#FFFFFF") : ("#FF4040");
            this.labelPrice.htmlText = "<font color=\'" + _loc_7 + "\'> " + Utility.standardNumber(_loc_5) + " </font>";
            var _loc_8:* = ResMgr.getInstance().getMovieClip("Coin_Smaller_Icon") as Sprite;
            (ResMgr.getInstance().getMovieClip("Coin_Smaller_Icon") as Sprite).x = 88;
            _loc_8.y = 116;
            this.bmpShopItem.img.addChild(_loc_8);
            _loc_9 = new TooltipText(true, true, true);
            _loc_9.text = Utility.standardNumber(param2);
            this.bmpShopItem.img.addChild(_loc_9);
            var _loc_10:* = ResMgr.getInstance().getMovieClip(param1 + "_Smaller_Icon") as Sprite;
            this.bmpShopItem.img.addChild(_loc_10);
            _loc_9.x = (this.bmpShopItem.width - _loc_9.width - 3 - _loc_10.width) / 2;
            _loc_9.y = this.labelItemName.y + this.labelItemName.textHeight + 3;
            _loc_10.x = _loc_9.x + _loc_9.width / 2 + _loc_9.textWidth / 2 + 3;
            _loc_10.y = _loc_9.y + (_loc_9.height - _loc_10.height) / 2;
            return;
        }// end function

        public function setShieldIcon(param1:int, param2:DataShield) : void
        {
            this.shieldId = param1;
            this.moneyType = new MoneyType(MoneyType.COIN, param2.coin);
            this.labelWait.visible = true;
            this.labelTime.visible = true;
            this.itemId = "Shield" + param1;
            var _loc_3:* = ResMgr.getInstance().getMovieClip("Shield" + "_" + param1 + "_Icon") as Sprite;
            if (!_loc_3)
            {
                return;
            }
            this.bmpShopItem.img.addChild(_loc_3);
            _loc_3.x = (img.width - _loc_3.width) / 2 + 5;
            _loc_3.y = (img.height - _loc_3.height) / 2 - 5;
            _loc_3.mouseChildren = false;
            _loc_3.mouseEnabled = false;
            var _loc_4:* = Localization.getInstance().getString("ShieldName");
            _loc_4 = Localization.getInstance().getString("ShieldName").replace("@number", param2.days.toString());
            this.labelItemName.text = _loc_4;
            var _loc_5:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN);
            var _loc_6:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN) >= param2.coin ? ("#FFFFFF") : ("#FF4040");
            this.labelPrice.htmlText = "<font color=\'" + _loc_6 + "\'> " + Utility.standardNumber(param2.coin) + " </font>";
            var _loc_7:* = ResMgr.getInstance().getMovieClip("Coin_Smaller_Icon") as Sprite;
            (ResMgr.getInstance().getMovieClip("Coin_Smaller_Icon") as Sprite).x = 88;
            _loc_7.y = 116;
            this.bmpShopItem.img.addChild(_loc_7);
            this.labelTime.text = param2.cdown + "d";
            this.saveDay = param2.cdown;
            return;
        }// end function

        public function enableShield() : void
        {
            this.bmpShopItem.enable = true;
            this.labelWait.text = "Thời gian chờ";
            this.labelTime.text = this.saveDay + "d";
            return;
        }// end function

        public function disableShieild() : void
        {
            this.bmpShopItem.enable = false;
            this.labelWait.text = "Mua tiếp sau";
            return;
        }// end function

        public function updateShieldState() : void
        {
            var _loc_1:* = JsonMgr.getInstance().getShieldData(this.shieldId);
            var _loc_2:* = GameDataMgr.getInstance().getMoney(MoneyType.COIN);
            var _loc_3:* = _loc_2 >= _loc_1.coin ? ("#FFFFFF") : ("#FF4040");
            this.labelPrice.htmlText = "<font color=\'" + _loc_3 + "\'> " + Utility.standardNumber(_loc_1.coin) + " </font>";
            return;
        }// end function

    }
}
