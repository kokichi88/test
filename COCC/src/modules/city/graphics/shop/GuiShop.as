package modules.city.graphics.shop
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import resMgr.*;

    public class GuiShop extends BaseGui
    {
        public var treasureShop:GuiShopType;
        public var resourceShop:GuiShopType;
        public var defenseShop:GuiShopType;
        public var armyShop:GuiShopType;
        public var decorationShop:GuiShopType;
        public var shieldShop:GuiShopType;
        public var bmp2Decorations:BitmapButton;
        public var bmp2Shield:BitmapButton;
        public var bmp2Resources:BitmapButton;
        public var bmp2Army:BitmapButton;
        public var bmp2Defenses:BitmapButton;
        public var bmp2Treasure:BitmapButton;
        public var curShopType:int = 1;
        private static const BMP_TREASURE:String = "bmp2Treasure";
        private static const BMP_RESOURCES:String = "bmp2Resources";
        private static const BMP_ARMY:String = "bmp2Army";
        private static const BMP_DEFENSES:String = "bmp2Defenses";
        private static const BMP_DECORATIONS:String = "bmp2Decorations";
        private static const BMP_SHIELD:String = "bmp2Shield";
        private static const BMP_CLOSE:String = "bmpClose";
        public static const SHOP_TREASURE:int = 0;
        public static const SHOP_RESOURCES:int = 1;
        public static const SHOP_ARMY:int = 2;
        public static const SHOP_DEFENSES:int = 3;
        public static const SHOP_SHIELD:int = 4;
        private static var itemResources:Array = new Array("RES_1", "RES_2", "STO_1", "STO_2", "BDH_1");
        private static var itemArmy:Array = new Array("AMC_1", "BAR_1", "LAB_1");
        private static var itemDefenses:Array = new Array("WAL_1", "DEF_1", "DEF_2", "DEF_3", "DEF_5", "DEF_4", "TRA_1", "TRA_2", "TRA_4", "TRA_3");
        private static var itemDecorations:Array = new Array();
        private static var itemShields:Array = new Array("Shield_1", "Shield_2", "Shield_3");

        public function GuiShop()
        {
            super(ResMgr.getInstance().getMovieClip("ShopGui"));
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.initShops();
            this.bmp2Decorations.enable = false;
            setPos((GlobalVar.SCREEN_WIDTH - 690) / 2, (GlobalVar.SCREEN_HEIGHT - this.heightBg) / 2);
            this.curShopType = SHOP_RESOURCES;
            return;
        }// end function

        public function initShops() : void
        {
            var _loc_1:int = 48;
            var _loc_2:int = 116;
            this.treasureShop = new GuiShopType();
            this.treasureShop.setPos(_loc_1, _loc_2);
            addGui(this.treasureShop);
            this.treasureShop.bgImg.visible = false;
            this.resourceShop = new GuiShopType();
            this.resourceShop.initItem(itemResources);
            this.resourceShop.setPos(_loc_1, _loc_2);
            addGui(this.resourceShop);
            this.armyShop = new GuiShopType();
            this.armyShop.initItem(itemArmy);
            this.armyShop.setPos(_loc_1, _loc_2);
            addGui(this.armyShop);
            this.armyShop.bgImg.visible = false;
            this.defenseShop = new GuiShopType();
            this.defenseShop.initItem(itemDefenses);
            this.defenseShop.setPos(_loc_1, _loc_2);
            addGui(this.defenseShop);
            this.defenseShop.bgImg.visible = false;
            this.decorationShop = new GuiShopType();
            this.decorationShop.initItem(itemDecorations);
            this.decorationShop.setPos(_loc_1, _loc_2);
            addGui(this.decorationShop);
            this.decorationShop.bgImg.visible = false;
            this.shieldShop = new GuiShopType();
            this.shieldShop.initShieldShop();
            this.shieldShop.setPos(_loc_1, _loc_2);
            addGui(this.shieldShop);
            this.shieldShop.bgImg.visible = false;
            return;
        }// end function

        private function hideAllShop() : void
        {
            this.treasureShop.bgImg.visible = false;
            this.resourceShop.bgImg.visible = false;
            this.armyShop.bgImg.visible = false;
            this.defenseShop.bgImg.visible = false;
            this.decorationShop.bgImg.visible = false;
            this.shieldShop.bgImg.visible = false;
            return;
        }// end function

        public function updateShopState() : void
        {
            this.resourceShop.updateShopState();
            this.armyShop.updateShopState();
            this.defenseShop.updateShopState();
            this.decorationShop.updateShopState();
            this.shieldShop.updateShieldState();
            return;
        }// end function

        public function cancelPlaceBuilding() : void
        {
            if (MouseMgr.getInstance().mouseIcon != null)
            {
                MouseMgr.getInstance().removeMouseIcon();
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            this.setTabNormal();
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    hide(true);
                    this.cancelPlaceBuilding();
                    break;
                }
                case BMP_RESOURCES:
                {
                    this.showResourceShop();
                    break;
                }
                case BMP_ARMY:
                {
                    this.showArmyShop();
                    break;
                }
                case BMP_DEFENSES:
                {
                    this.showDefenseShop();
                    break;
                }
                case BMP_DECORATIONS:
                {
                    this.hideAllShop();
                    this.decorationShop.bgImg.visible = true;
                    break;
                }
                case BMP_SHIELD:
                {
                    this.hideAllShop();
                    this.showShieldShop();
                    break;
                }
                case BMP_TREASURE:
                {
                    this.hideAllShop();
                    this.showTreasureShop();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            this.updateShopState();
            this.treasureShop.getShopTreasures();
            this.bmp2Treasure.enable = this.treasureShop.listItem.length > 0;
            switch(this.curShopType)
            {
                case SHOP_RESOURCES:
                {
                    this.showResourceShop();
                    break;
                }
                case SHOP_ARMY:
                {
                    this.showArmyShop();
                    break;
                }
                case SHOP_DEFENSES:
                {
                    this.showDefenseShop();
                    break;
                }
                case SHOP_TREASURE:
                {
                    this.showTreasureShop();
                    break;
                }
                case SHOP_SHIELD:
                {
                    this.showShieldShop();
                    break;
                }
                default:
                {
                    break;
                }
            }
            super.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function showTreasureShop() : void
        {
            this.hideAllShop();
            this.treasureShop.bgImg.visible = true;
            this.setTabNormal();
            this.bmp2Treasure.setTabSelected();
            this.curShopType = SHOP_TREASURE;
            if (this.treasureShop.listItem.length == 0)
            {
                this.bmp2Treasure.enable = false;
                this.showResourceShop();
            }
            return;
        }// end function

        public function showShieldShop() : void
        {
            this.hideAllShop();
            this.shieldShop.bgImg.visible = true;
            this.setTabNormal();
            this.bmp2Shield.setTabSelected();
            this.curShopType = SHOP_SHIELD;
            return;
        }// end function

        public function showDefenseShop() : void
        {
            this.hideAllShop();
            this.defenseShop.bgImg.visible = true;
            this.setTabNormal();
            this.bmp2Defenses.setTabSelected();
            this.curShopType = SHOP_DEFENSES;
            return;
        }// end function

        public function showResourceShop() : void
        {
            this.hideAllShop();
            this.resourceShop.bgImg.visible = true;
            this.setTabNormal();
            this.bmp2Resources.setTabSelected();
            this.curShopType = SHOP_RESOURCES;
            return;
        }// end function

        public function showArmyShop() : void
        {
            this.hideAllShop();
            this.armyShop.bgImg.visible = true;
            this.setTabNormal();
            this.bmp2Army.setTabSelected();
            this.curShopType = SHOP_ARMY;
            return;
        }// end function

        private function setTabNormal() : void
        {
            this.bmp2Army.setTabNormal();
            this.bmp2Resources.setTabNormal();
            this.bmp2Defenses.setTabNormal();
            this.bmp2Treasure.setTabNormal();
            this.bmp2Shield.setTabNormal();
            return;
        }// end function

        override public function loop() : void
        {
            if (!isShowing)
            {
                return;
            }
            if (this.shieldShop.bgImg.visible)
            {
                this.shieldShop.updateShieldIcon();
            }
            return;
        }// end function

    }
}
