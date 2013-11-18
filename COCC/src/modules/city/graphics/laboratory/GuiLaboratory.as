package modules.city.graphics.laboratory
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.logic.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class GuiLaboratory extends BaseGui
    {
        private var listItem:Vector.<GuiLaboratotyItem>;
        public var labelLaboratory:TextField;
        public var bmpNext:BitmapButton;
        public var bmpPrev:BitmapButton;
        public var pageItem:PageMgr;
        private static const MAX_TROOP:int = 10;
        private static const MAX_SPELL:int = 5;
        private static const NUM_ROW:int = 2;
        private static const NUM_COL:int = 5;
        private static const BMP_CLOSE:String = "bmpClose";
        private static const BMP_NEXT:String = "bmpNext";
        private static const BMP_PREV:String = "bmpPrev";
        private static var padingX:Number = 9;
        private static var padingY:Number = 135;

        public function GuiLaboratory()
        {
            this.listItem = new Vector.<GuiLaboratotyItem>;
            super(ResMgr.getInstance().getMovieClip("LaboratoryGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 64;
            this.pageItem.y = 170;
            this.init();
            return;
        }// end function

        private function init() : void
        {
            var _loc_1:int = 0;
            var _loc_2:GuiLaboratotyItem = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            _loc_1 = 0;
            while (_loc_1 < MAX_TROOP)
            {
                
                _loc_2 = new GuiLaboratotyItem();
                _loc_2.disableItem();
                this.listItem.push(_loc_2);
                _loc_1++;
            }
            var _loc_3:Number = 560;
            var _loc_4:Number = 315;
            var _loc_5:Number = 6;
            var _loc_6:* = new Sprite();
            _loc_1 = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                _loc_7 = _loc_5 + _loc_1 % NUM_COL * (this.listItem[_loc_1].widthBg + padingX) + int(_loc_1 / 10) * _loc_3;
                _loc_8 = Math.floor(_loc_1 % 10 / NUM_COL) * padingY;
                _loc_6.addChild(this.listItem[_loc_1].bgImg);
                this.listItem[_loc_1].setPos(_loc_7, _loc_8);
                _loc_1++;
            }
            this.pageItem.setData(_loc_6, _loc_3, _loc_4, 0, PageMgr.HOZIRONTOL, true, 1);
            var _loc_9:* = this.pageItem.totalPage > 1;
            this.bmpPrev.visible = this.pageItem.totalPage > 1;
            this.bmpNext.visible = _loc_9;
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        private function loadTroopResearch() : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:TroopInfo = null;
            var _loc_8:int = 0;
            var _loc_9:TroopInfo = null;
            var _loc_1:* = JsonMgr.getInstance().troopBase;
            var _loc_2:* = Utility.getCurrentMaxBarrackLevel();
            var _loc_3:* = GameDataMgr.getInstance().laboratory;
            var _loc_4:int = 0;
            while (_loc_4 < MAX_TROOP)
            {
                
                _loc_5 = "ARM_" + (_loc_4 + 1);
                this.listItem[_loc_4].loadItem(_loc_5);
                if (_loc_4 >= 8)
                {
                    this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_COMING_SOON);
                }
                else
                {
                    _loc_6 = _loc_1[_loc_5]["barracksLevelRequired"];
                    if (_loc_2 < _loc_6)
                    {
                        this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_BARRACK_LEVEL_REQUIRED, _loc_6);
                    }
                    else
                    {
                        _loc_7 = JsonMgr.getInstance().getMaxConfigInfoTroop(_loc_5);
                        _loc_8 = GameDataMgr.getInstance().getTroopLevel(_loc_5);
                        if (_loc_8 == _loc_7.level)
                        {
                            this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_MAX_LEVEL);
                        }
                        else
                        {
                            _loc_9 = JsonMgr.getInstance().getInfoTroop(_loc_5, (_loc_8 + 1));
                            if (_loc_9.laboratoryLevelRequired > GameDataMgr.getInstance().laboratory.level)
                            {
                                this.listItem[_loc_4].disableItem(GuiLaboratotyItem.REASON_LABORATORY_LEVEL_REQUIRED, _loc_9.laboratoryLevelRequired);
                            }
                        }
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private function loadSpellResearch() : void
        {
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:DataSpell = null;
            var _loc_1:* = JsonMgr.getInstance().spellBase;
            var _loc_2:* = Utility.getSpellFactoryLevel();
            var _loc_3:* = GameDataMgr.getInstance().laboratory;
            var _loc_4:int = 0;
            while (_loc_4 < MAX_SPELL)
            {
                
                _loc_5 = "SPE_" + (_loc_4 + 1);
                this.listItem[MAX_TROOP + _loc_4].loadSpellItem(_loc_5);
                this.listItem[MAX_TROOP + _loc_4].enableItem();
                ;
                _loc_4++;
            }
            return;
        }// end function

        public function loadInfo() : void
        {
            var _loc_1:* = Localization.getInstance().getString(BuildingType.LABORATORY) + " CẤP " + GameDataMgr.getInstance().laboratory.level;
            this.labelLaboratory.text = _loc_1.toUpperCase();
            var _loc_2:* = Utility.getCurrentMaxBarrackLevel();
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.listItem[_loc_3].enableItem();
                _loc_3++;
            }
            this.loadTroopResearch();
            if (GameDataMgr.getInstance().spellFactory)
            {
                this.loadSpellResearch();
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_CLOSE:
                {
                    this.hide(true);
                    break;
                }
                case BMP_NEXT:
                {
                    this.pageItem.nextPage();
                    this.bmpNext.enable = this.pageItem.canNext();
                    this.bmpPrev.enable = this.pageItem.canPrev();
                    break;
                }
                case BMP_PREV:
                {
                    this.pageItem.prevPage();
                    this.bmpNext.enable = this.pageItem.canNext();
                    this.bmpPrev.enable = this.pageItem.canPrev();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:LaboratoryObject = null;
            super.hide(param1);
            if (param1)
            {
                _loc_2 = GameDataMgr.getInstance().laboratory;
                CityMgr.getInstance().showBuildingActionGui(_loc_2);
            }
            return;
        }// end function

    }
}
