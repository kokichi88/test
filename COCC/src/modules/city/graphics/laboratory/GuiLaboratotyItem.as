package modules.city.graphics.laboratory
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.*;
    import modules.city.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiLaboratotyItem extends BaseGui
    {
        public var bmpLaboratoryItem:BitmapButton;
        public var labelRequire:TextField;
        public var labelCost:TextField;
        public var imageBgCost:MovieClip;
        public var imageBgNotice:MovieClip;
        public var imageElixir:MovieClip;
        public var itemType:String;
        public var curLevel:int;
        private var iconTroop:Sprite = null;
        private var bgStar:Sprite = null;
        public static const REASON_BARRACK_LEVEL_REQUIRED:String = "LaboratoryReason0";
        public static const REASON_LABORATORY_LEVEL_REQUIRED:String = "LaboratoryReason1";
        public static const REASON_MAX_LEVEL:String = "LaboratoryReason2";
        public static const REASON_COMING_SOON:String = "LaboratoryReason3";
        private static const BMP_ITEM:String = "bmpLaboratoryItem";

        public function GuiLaboratotyItem()
        {
            super(ResMgr.getInstance().getMovieClip("LaboratoryGui_Item"));
            this.labelRequire.visible = false;
            return;
        }// end function

        public function loadItem(param1:String) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:int = 0;
            var _loc_7:Sprite = null;
            var _loc_8:TroopInfo = null;
            var _loc_9:int = 0;
            var _loc_10:String = null;
            this.itemType = param1;
            if (this.iconTroop)
            {
                this.iconTroop.parent.removeChild(this.iconTroop);
                this.iconTroop = null;
            }
            this.iconTroop = ResMgr.getInstance().getMovieClip(param1 + "_Training_Icon") as Sprite;
            if (this.iconTroop)
            {
                this.iconTroop.x = (this.widthBg - this.iconTroop.width) / 2;
                this.iconTroop.y = (this.heightBg - this.iconTroop.height) / 2;
                this.bmpLaboratoryItem.img.addChild(this.iconTroop);
                this.iconTroop.mouseChildren = false;
                this.iconTroop.mouseEnabled = false;
            }
            this.curLevel = GameDataMgr.getInstance().getTroopLevel(this.itemType);
            if (this.curLevel >= 1)
            {
                this.bgStar = new Sprite();
                img.addChild(this.bgStar);
                _loc_3 = 12.35;
                _loc_4 = 7;
                _loc_5 = 3.55;
                _loc_6 = 0;
                while (_loc_6 < this.curLevel)
                {
                    
                    _loc_7 = ResMgr.getInstance().getMovieClip("icLevel") as Sprite;
                    _loc_7.x = _loc_3 + _loc_6 * (_loc_7.width + _loc_5);
                    _loc_7.y = _loc_4;
                    _loc_7.mouseEnabled = false;
                    _loc_7.mouseChildren = false;
                    this.bgStar.addChild(_loc_7);
                    _loc_6++;
                }
            }
            var _loc_2:* = JsonMgr.getInstance().getConfigMaxLevel(param1);
            if (this.curLevel < _loc_2)
            {
                _loc_8 = JsonMgr.getInstance().getInfoTroop(param1, (this.curLevel + 1));
                if (_loc_8)
                {
                    _loc_9 = GameDataMgr.getInstance().getMoney(MoneyType.ELIXIR);
                    _loc_10 = _loc_9 >= _loc_8.researchCost ? ("#FFFFFF") : ("#FF4040");
                    this.labelCost.htmlText = "<font color=\'" + _loc_10 + "\'> " + Utility.standardNumber(_loc_8.researchCost) + " </font>";
                }
            }
            return;
        }// end function

        public function disableItem(param1:String = null, param2:int = 0) : void
        {
            var _loc_3:String = null;
            this.bmpLaboratoryItem.enable = false;
            this.imageBgCost.visible = false;
            this.imageBgNotice.visible = true;
            this.labelCost.visible = false;
            this.imageElixir.visible = false;
            if (param1)
            {
                this.labelRequire.visible = true;
                _loc_3 = Localization.getInstance().getString(param1);
                if (param2 > 0)
                {
                    _loc_3 = _loc_3 + (" " + param2);
                }
                this.labelRequire.text = _loc_3;
                this.labelRequire.x = this.imageBgNotice.x + (this.imageBgNotice.width - this.labelRequire.width) / 2;
                this.labelRequire.y = this.imageBgNotice.y + (this.imageBgNotice.height - this.labelRequire.textHeight) / 2 - 3;
                this.bgStar.visible = !(param1 == REASON_COMING_SOON || param1 == REASON_BARRACK_LEVEL_REQUIRED);
            }
            return;
        }// end function

        public function enableItem() : void
        {
            this.bmpLaboratoryItem.enable = true;
            this.labelRequire.visible = false;
            this.imageBgCost.visible = true;
            this.imageBgNotice.visible = false;
            this.imageElixir.visible = true;
            this.labelCost.visible = true;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_ITEM:
                {
                    ModuleMgr.getInstance().doFunction(CityMgr.HIDE_LABORATORY_GUI);
                    ModuleMgr.getInstance().doFunction(CityMgr.SHOW_TROOP_UPGRADE_GUI, this.itemType, this.curLevel);
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
