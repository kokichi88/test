package modules.city.graphics.clan
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import gameData.clan.*;
    import modules.city.*;
    import mx.utils.*;
    import resMgr.*;
    import utility.*;

    public class GuiCreateClan extends BaseGui
    {
        public var labelClanNameInput:TextField;
        public var labelDescription:TextField;
        public var labelClanType:TextField;
        public var labelTropies:TextField;
        public var labelMoney:TextField;
        public var labelSave:TextField;
        public var bmpSave:BitmapButton;
        public var bmpCreateClan:BitmapButton;
        public var curType:int = 0;
        public var curTrophy:int = 0;
        public var curSymbolType:int = 0;
        private var symbolSprite:Sprite = null;
        public var imageBgIcon:MovieClip;
        private var maxRequiredTroophy:int;
        private static const BMP_CREATE:String = "bmpCreateClan";
        private static const BMP_SAVE:String = "bmpSave";
        private static const BMP_NEXT_CLAN_TYPE:String = "bmpNextClanType";
        private static const BMP_PREV_CLAN_TYPE:String = "bmpPrevClanType";
        private static const BMP_NEXT_TROPIES:String = "bmpNextTropies";
        private static const BMP_PREV_TROPIES:String = "bmpPrevTropies";
        private static const BMP_CHANGE_SYMBOL:String = "bmpChangeClanSymbol";
        private static const STEP_TROPHY:int = 200;

        public function GuiCreateClan()
        {
            super(ResMgr.getInstance().getMovieClip("CreateClanGui"));
            this.labelClanNameInput.type = TextFieldType.INPUT;
            this.labelClanNameInput.mouseEnabled = true;
            this.labelDescription.type = TextFieldType.INPUT;
            this.labelDescription.mouseEnabled = true;
            this.labelMoney.text = Utility.standardNumber(GlobalVar.CLAN_COST_TO_CREATE);
            return;
        }// end function

        public function loadCurrentSymbol() : void
        {
            if (this.symbolSprite && this.symbolSprite.parent != null)
            {
                this.symbolSprite.parent.removeChild(this.symbolSprite);
                this.symbolSprite = null;
            }
            this.symbolSprite = ResMgr.getInstance().getMovieClip("ClanSymbol_" + this.curSymbolType) as Sprite;
            this.symbolSprite.x = this.imageBgIcon.x + (this.imageBgIcon.width - this.symbolSprite.width) / 2;
            this.symbolSprite.y = this.imageBgIcon.y + (this.imageBgIcon.height - this.symbolSprite.height) / 2;
            this.img.addChild(this.symbolSprite);
            this.getMaxRequiredTrophy();
            return;
        }// end function

        private function getMaxRequiredTrophy() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().myInfo.trophy;
            var _loc_2:int = 0;
            while (_loc_2 < GlobalVar.CLAN_MAX_REQUIRED_TROPIES)
            {
                
                if (_loc_2 + STEP_TROPHY > _loc_1)
                {
                    break;
                }
                _loc_2 = _loc_2 + STEP_TROPHY;
            }
            this.maxRequiredTroophy = _loc_2;
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:ClanInfo = null;
            var _loc_4:ClanInfo = null;
            switch(param1)
            {
                case BMP_CREATE:
                {
                    if (this.validInput())
                    {
                        _loc_3 = new ClanInfo();
                        _loc_3.name = this.labelClanNameInput.text;
                        _loc_3.type = this.curType + 1;
                        _loc_3.icon = this.curSymbolType;
                        _loc_3.requiredTrophy = this.curTrophy;
                        _loc_3.description = this.labelDescription.text;
                        GameDataMgr.getInstance().clanInfo = _loc_3;
                        CityMgr.getInstance().createClan();
                    }
                    break;
                }
                case BMP_NEXT_CLAN_TYPE:
                {
                    this.curType = 2 - this.curType;
                    this.labelClanType.text = Localization.getInstance().getString("ClanType" + this.curType);
                    break;
                }
                case BMP_PREV_CLAN_TYPE:
                {
                    this.curType = 2 - this.curType;
                    this.labelClanType.text = Localization.getInstance().getString("ClanType" + this.curType);
                    break;
                }
                case BMP_NEXT_TROPIES:
                {
                    this.curTrophy = (this.curTrophy + STEP_TROPHY) % (this.maxRequiredTroophy + STEP_TROPHY);
                    this.labelTropies.text = this.curTrophy.toString();
                    break;
                }
                case BMP_PREV_TROPIES:
                {
                    this.curTrophy = (this.curTrophy + this.maxRequiredTroophy) % (this.maxRequiredTroophy + STEP_TROPHY);
                    this.labelTropies.text = this.curTrophy.toString();
                    break;
                }
                case BMP_CHANGE_SYMBOL:
                {
                    CityMgr.getInstance().guiClan.showGuiClanSymbols();
                    break;
                }
                case BMP_SAVE:
                {
                    if (this.validInput())
                    {
                        _loc_4 = new ClanInfo();
                        _loc_4.name = this.labelClanNameInput.text;
                        _loc_4.type = this.curType + 1;
                        _loc_4.icon = this.curSymbolType;
                        _loc_4.requiredTrophy = this.curTrophy;
                        _loc_4.description = this.labelDescription.text;
                        CityMgr.getInstance().editClan(_loc_4);
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

        public function showCreateClan() : void
        {
            this.labelClanNameInput.mouseEnabled = true;
            this.labelSave.visible = false;
            this.bmpSave.visible = false;
            this.bmpCreateClan.visible = true;
            this.labelMoney.visible = true;
            this.loadCurrentSymbol();
            return;
        }// end function

        public function showEditClan() : void
        {
            this.labelClanNameInput.mouseEnabled = false;
            this.labelSave.visible = true;
            this.bmpSave.visible = true;
            this.bmpCreateClan.visible = false;
            this.labelMoney.visible = false;
            var _loc_1:* = GameDataMgr.getInstance().myClanDetial;
            this.labelClanNameInput.text = _loc_1.name;
            this.curSymbolType = _loc_1.icon;
            this.loadCurrentSymbol();
            this.labelClanType.text = Localization.getInstance().getString("ClanType" + (_loc_1.type - 1));
            this.labelDescription.text = _loc_1.description;
            this.labelTropies.text = _loc_1.requiredTrophy.toString();
            this.curTrophy = _loc_1.requiredTrophy;
            return;
        }// end function

        private function validInput() : Boolean
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:String = null;
            this.labelClanNameInput.text = StringUtil.trim(this.labelClanNameInput.text);
            if (this.labelClanNameInput.text.length < GlobalVar.CLAN_NAME_MIN_CHARACTERS || this.labelClanNameInput.text.length > GlobalVar.CLAN_NAME_MAX_CHARACTERS)
            {
                _loc_1 = Localization.getInstance().getString("Title_TB");
                _loc_2 = Localization.getInstance().getString("ClanMsgInvalidClanName");
                _loc_2 = _loc_2.replace("@min", GlobalVar.CLAN_NAME_MIN_CHARACTERS.toString());
                _loc_2 = _loc_2.replace("@max", GlobalVar.CLAN_NAME_MAX_CHARACTERS.toString());
                CityMgr.getInstance().showMessage(_loc_1, _loc_2, "THỬ LẠI", null);
                return false;
            }
            if (this.labelDescription.text.length > GlobalVar.CLAN_DESCRIPTION_MAX_CHARACTERS)
            {
                _loc_3 = Localization.getInstance().getString("Title_TB");
                _loc_4 = Localization.getInstance().getString("ClanMsgInvalidClanDescription");
                _loc_4 = _loc_4.replace("@max", GlobalVar.CLAN_DESCRIPTION_MAX_CHARACTERS.toString());
                CityMgr.getInstance().showMessage(_loc_3, _loc_4, "THỬ LẠI", null);
                return false;
            }
            return true;
        }// end function

    }
}
