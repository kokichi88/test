package modules.city.graphics.build
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiUpgradeBuildingItem extends BaseGui
    {
        public var labelUpgradeInfo:TextField;
        public var imageCurIndex:MovieClip;
        public var imageNextIndex:MovieClip;
        private var type:String;
        public var spMaskCurIndex:Sprite;
        public var spMaskNextIndex:Sprite;
        public static var ICON_HITPOINTS:String = "Hitpoints_Icon";
        public static var ICON_DAMAGE:String = "Damage_Icon";
        public static var ICON_GOLD_PRODUCTION_RATE:String = "Gold_ProductionRate_Icon";
        public static var ICON_ELIXIR_GOLD_PRODUCTION_RATE:String = "Elixir_ProductionRate_Icon";
        public static var ICON_TROOP_CAPACITY:String = "TroopCapacity_Icon";
        public static var ICON_GOLD_CAPACITY:String = "Gold_Capacity_Icon";
        public static var ICON_ELIXIR_CAPACITY:String = "Elixir_Capacity_Icon";
        public static var ICON_TRANING_COST:String = "TrainingCost_Icon";
        public static var ICON_SPELL_CAPACITY:String = "Spell_Capacity_Icon";
        public static var ICON_HEAL:String = "Heal_Icon";

        public function GuiUpgradeBuildingItem()
        {
            super(ResMgr.getInstance().getMovieClip("UpgradeBuildingGui_Item") as MovieClip);
            this.spMaskCurIndex = new Sprite();
            this.spMaskCurIndex.graphics.beginFill(16776960, 1);
            this.spMaskCurIndex.graphics.drawRoundRect(0, 0, this.imageCurIndex.width, this.imageCurIndex.height, 10);
            this.spMaskCurIndex.graphics.endFill();
            this.imageCurIndex.addChild(this.spMaskCurIndex);
            this.imageCurIndex.mask = this.spMaskCurIndex;
            this.spMaskNextIndex = new Sprite();
            this.spMaskNextIndex.graphics.beginFill(16776960, 1);
            this.spMaskNextIndex.graphics.drawRect(0, 0, this.imageNextIndex.width, this.imageNextIndex.height);
            this.spMaskNextIndex.graphics.endFill();
            this.imageNextIndex.addChild(this.spMaskNextIndex);
            this.imageNextIndex.mask = this.spMaskNextIndex;
            return;
        }// end function

        public function setPercentCurIndex(param1:Number) : void
        {
            var _loc_2:* = this.imageCurIndex.width * param1;
            this.spMaskCurIndex.graphics.clear();
            this.spMaskCurIndex.graphics.beginFill(16776960, 1);
            this.spMaskCurIndex.graphics.drawRect(0, 0, _loc_2, this.imageCurIndex.height);
            this.spMaskCurIndex.graphics.endFill();
            this.imageCurIndex.mask = this.spMaskCurIndex;
            return;
        }// end function

        public function setPercentNextIndex(param1:Number) : void
        {
            var _loc_2:* = this.imageNextIndex.width * param1;
            this.spMaskNextIndex.graphics.clear();
            this.spMaskNextIndex.graphics.beginFill(16776960, 1);
            this.spMaskNextIndex.graphics.drawRect(0, 0, _loc_2, this.imageNextIndex.height);
            this.spMaskNextIndex.graphics.endFill();
            this.imageNextIndex.mask = this.spMaskNextIndex;
            return;
        }// end function

        public function loadUpgradeItem(param1:String, param2:int, param3:int, param4:int = 0) : void
        {
            var _loc_5:* = ResMgr.getInstance().getMovieClip(param1) as Sprite;
            if (ResMgr.getInstance().getMovieClip(param1) as Sprite == null)
            {
                return;
            }
            _loc_5.x = 15 - _loc_5.width / 2;
            _loc_5.y = 27.8 - _loc_5.height / 2 + 5;
            this.bgImg.addChild(_loc_5);
            var _loc_6:* = Localization.getInstance().getString(param1) + ": " + param3;
            if (param4 > param3)
            {
                _loc_6 = _loc_6 + ("<font color=\'#00B700\'> (+" + (param4 - param3) + ") </font>");
            }
            if (param1 == ICON_ELIXIR_GOLD_PRODUCTION_RATE || param1 == ICON_GOLD_PRODUCTION_RATE)
            {
                _loc_6 = _loc_6 + " / h";
            }
            this.labelUpgradeInfo.htmlText = _loc_6;
            this.setPercentCurIndex(Math.min(1, param3 / param2));
            this.setPercentNextIndex(Math.min(1, param4 / param2));
            return;
        }// end function

        public function loadInfoItem(param1:String, param2:int, param3:int = 0, param4:Boolean = false) : void
        {
            var _loc_5:Sprite = null;
            this.type = param1;
            _loc_5 = ResMgr.getInstance().getMovieClip(param1) as Sprite;
            _loc_5.x = 15 - _loc_5.width / 2;
            _loc_5.y = 27.8 - _loc_5.height / 2 + 5;
            this.bgImg.addChild(_loc_5);
            var _loc_6:* = Localization.getInstance().getString(param1) + ": " + param2;
            if (param3 == 0)
            {
                param3 = param2;
            }
            if (!param4)
            {
                switch(param1)
                {
                    case ICON_HITPOINTS:
                    case ICON_ELIXIR_CAPACITY:
                    case ICON_GOLD_CAPACITY:
                    case ICON_SPELL_CAPACITY:
                    case ICON_TRANING_COST:
                    case ICON_TROOP_CAPACITY:
                    {
                        _loc_6 = _loc_6 + ("/" + param3);
                        break;
                    }
                    case ICON_GOLD_PRODUCTION_RATE:
                    case ICON_ELIXIR_GOLD_PRODUCTION_RATE:
                    {
                        _loc_6 = _loc_6 + " / h";
                        break;
                    }
                    case ICON_DAMAGE:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this.labelUpgradeInfo.text = _loc_6;
            this.setPercentCurIndex(Math.min(1, param2 / param3));
            this.imageNextIndex.visible = false;
            return;
        }// end function

        public function updateIndex(param1:int, param2:int) : void
        {
            this.labelUpgradeInfo.text = Localization.getInstance().getString(this.type) + ": " + param1 + "/" + param2;
            this.imageCurIndex.scaleX = Math.min(1, param1 / param2);
            return;
        }// end function

    }
}
