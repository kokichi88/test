package modules.battle.graphics
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.battle.*;
    import modules.battle.data.*;
    import modules.city.graphics.tutorial.*;
    import resMgr.*;
    import utility.*;

    public class ItemBattleTroop extends BaseGui
    {
        public const BMP_TROOP:String = "bmpTroop";
        public var labelNumber:TextField;
        public var _troop:Troop;
        public var bmpTroop:BitmapButton;
        public var index:int;
        public var type:int;
        public var iconClan:int = 0;
        public var imageBgStar:MovieClip;

        public function ItemBattleTroop(param1:int = 0)
        {
            this.type = param1;
            var _loc_2:String = "GuiItemTroop";
            switch(this.type)
            {
                case 1:
                {
                    _loc_2 = "GuiItemTroopSmall";
                    break;
                }
                case 2:
                {
                    _loc_2 = "LogIconTroop";
                    break;
                }
                default:
                {
                    break;
                }
            }
            super(ResMgr.getInstance().getMovieClip(_loc_2));
            return;
        }// end function

        public function set troop(param1:Troop) : void
        {
            var _loc_2:Sprite = null;
            var _loc_5:Sprite = null;
            var _loc_6:String = null;
            var _loc_7:Number = NaN;
            this._troop = param1;
            if (param1.type == "Clan")
            {
                this.setClan();
                return;
            }
            this.labelNumber.text = "x" + this._troop.num;
            var _loc_3:int = 6;
            var _loc_4:int = 95;
            switch(this.type)
            {
                case 0:
                {
                    _loc_2 = ResMgr.getInstance().getMovieClip(this._troop.type + "_Training_Icon") as Sprite;
                    _loc_2.x = this.bmpTroop.img.x + this.bmpTroop.img.width - _loc_2.width - 4;
                    _loc_2.y = this.bmpTroop.img.y + this.bmpTroop.img.height - _loc_2.height - 6;
                    _loc_6 = "image_Star";
                    _loc_7 = 16;
                    break;
                }
                case 1:
                {
                    _loc_2 = ResMgr.getInstance().getMovieClip(this._troop.type + "_Info_Icon") as Sprite;
                    _loc_3 = 2;
                    _loc_4 = 35;
                    _loc_2.y = (img.height - _loc_2.height) / 2;
                    _loc_2.x = (img.width - _loc_2.width) / 2;
                    _loc_6 = "icLevel";
                    _loc_7 = 11;
                    break;
                }
                case 2:
                {
                    _loc_2 = ResMgr.getInstance().getMovieClip(this._troop.type + "_Log_Icon") as Sprite;
                    _loc_3 = 2;
                    _loc_4 = 42;
                    _loc_2.y = (img.height - _loc_2.height) / 2;
                    _loc_2.x = (img.width - _loc_2.width) / 2;
                    _loc_6 = "icLevel";
                    _loc_7 = 11;
                    break;
                }
                default:
                {
                    break;
                }
            }
            img.addChildAt(_loc_2, 1);
            _loc_2.mouseEnabled = false;
            _loc_2.mouseChildren = false;
            var _loc_8:int = 0;
            while (_loc_8 < this._troop.level)
            {
                
                _loc_5 = ResMgr.getInstance().getMovieClip(_loc_6) as Sprite;
                _loc_5.x = _loc_3 + _loc_8 * _loc_7;
                _loc_5.y = _loc_4;
                _loc_5.mouseEnabled = false;
                _loc_5.mouseChildren = false;
                img.addChild(_loc_5);
                _loc_8++;
            }
            if (this.bmpTroop)
            {
                this.bmpTroop.setTooltipDisplayObj(Utility.getTooltipTroop(this._troop));
            }
            return;
        }// end function

        public function setClan() : void
        {
            var _loc_1:Sprite = null;
            var _loc_2:int = 0;
            this.labelNumber.text = "";
            this.bmpTroop.setTooltip("Quân bang hội");
            if (this.imageBgStar)
            {
                this.imageBgStar.visible = false;
            }
            switch(this.type)
            {
                case 1:
                {
                    if (GameDataMgr.getInstance().myClanDetial.icon < 0)
                    {
                        return;
                    }
                    _loc_1 = ResMgr.getInstance().getMovieClip("ClanSymbol_" + GameDataMgr.getInstance().myClanDetial.icon) as Sprite;
                    _loc_1.y = (img.height - _loc_1.height) / 2;
                    _loc_1.x = (img.width - _loc_1.width) / 2;
                    break;
                }
                case 2:
                {
                    if (this.troop.num < 0)
                    {
                        return;
                    }
                    _loc_2 = Math.min(this.troop.num, 27);
                    _loc_1 = ResMgr.getInstance().getMovieClip("ClanSymbol_" + _loc_2) as Sprite;
                    _loc_1.y = (img.height - _loc_1.height) / 2;
                    _loc_1.x = (img.width - _loc_1.width) / 2;
                    break;
                }
                default:
                {
                    if (GameDataMgr.getInstance().myClanDetial.icon < 0)
                    {
                        return;
                    }
                    _loc_1 = ResMgr.getInstance().getMovieClip("ClanSymbol_Big_" + GameDataMgr.getInstance().myClanDetial.icon) as Sprite;
                    _loc_1.y = (img.height - _loc_1.height) / 2 + 8;
                    _loc_1.x = (img.width - _loc_1.width) / 2;
                    break;
                    break;
                }
            }
            img.addChildAt(_loc_1, 1);
            _loc_1.mouseEnabled = false;
            _loc_1.mouseChildren = false;
            return;
        }// end function

        public function get troop() : Troop
        {
            return this._troop;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case this.BMP_TROOP:
                {
                    this.focus();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function destroy() : void
        {
            if (this.bgImg.parent)
            {
                this.bgImg.parent.removeChild(this.bgImg);
                this.bmpTroop.clearImage();
            }
            return;
        }// end function

        public function subTroop(param1:int) : void
        {
            this._troop.num = Math.max(0, this._troop.num);
            this.labelNumber.text = "x" + this._troop.num;
            if (this._troop.num <= 0)
            {
                img.filters = [BitmapButton.disableFilter];
            }
            return;
        }// end function

        public function focus() : void
        {
            if (this.type != 0)
            {
                return;
            }
            BattleModule.getInstance().guiBattleTroop.focusTroop(this.index);
            if (TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().showDeployTownhall();
            }
            return;
        }// end function

    }
}
