package modules.city.logic
{
    import __AS3__.vec.*;
    import component.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import gameData.clan.*;
    import modules.battle.data.*;
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import modules.city.graphics.build.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class ClanObject extends MapObject
    {
        public var info:DataClanCastle;
        public var troopList:Vector.<Troop>;
        public var details:ClanInfo;
        public var title:int;
        public var clanIcon:Sprite;
        public var clanName:TextField;
        public var lastRequestTime:Number;
        public var statusIcon:GuiStatusBuilding;
        private var hasAttackRange:Boolean;
        public var isFull:Boolean;

        public function ClanObject()
        {
            this.troopList = new Vector.<Troop>;
            this.details = new ClanInfo();
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getClanCastleData(level);
            width = this.info.width;
            height = this.info.height;
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().clanCastle[BuildingType.CLAN_CASTLE][(level + 1)]["upgradeTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            return;
        }// end function

        override public function loadAvatar() : void
        {
            var _loc_1:* = BuildingType.CLAN_CASTLE;
            if (status == MapObject.BROKEN)
            {
                _loc_1 = _loc_1 + "_broken";
            }
            avatar.create(AnCategory.HOUSE, _loc_1, level);
            this.statusIcon = new GuiStatusBuilding();
            var _loc_2:* = (-this.statusIcon.widthBg) / 2;
            var _loc_3:* = -avatar.height - this.statusIcon.heightBg / 2;
            this.statusIcon.setPos(_loc_2, _loc_3);
            this.statusIcon.hide();
            return;
        }// end function

        public function showStatusIcon(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            return;
        }// end function

        override public function setPos(param1:int, param2:int) : void
        {
            super.setPos(param1, param2);
            if (this.isFull)
            {
                this.showStatusIcon(GuiStatusBuilding.FULL);
            }
            return;
        }// end function

        override public function showStatusBar() : void
        {
            super.showStatusBar();
            if (status != PRODUCING)
            {
                this.statusIcon.hide();
            }
            return;
        }// end function

        public function loadIcon(param1:int, param2:String) : void
        {
            var _loc_3:Sprite = null;
            var _loc_4:TooltipText = null;
            this.removeClanIcon();
            this.clanIcon = new Sprite();
            if (this.clanIcon.numChildren == 0)
            {
                _loc_3 = ResMgr.getInstance().getMovieClip("ClanSymbol_Big_" + param1) as Sprite;
                this.clanIcon.addChildAt(_loc_3, 0);
                this.clanIcon.x = (-this.clanIcon.width) / 2;
                this.clanIcon.y = (-this.clanIcon.height) / 2 - 10;
                avatar.addChild(this.clanIcon);
                _loc_4 = new TooltipText(true, true);
                _loc_4.htmlText = "<font size=\'24\'>" + param2.toUpperCase() + "</font>";
                _loc_4.x = (this.clanIcon.width - _loc_4.textWidth) / 2;
                _loc_4.y = _loc_3.height - 15;
                this.clanIcon.addChild(_loc_4);
            }
            return;
        }// end function

        public function removeClanIcon() : void
        {
            if (this.clanIcon && this.clanIcon.numChildren > 0)
            {
                this.clanIcon.removeChildAt(1);
                this.clanIcon.removeChildAt(0);
            }
            if (this.clanIcon && this.clanIcon.parent != null)
            {
                this.clanIcon.parent.removeChild(this.clanIcon);
                this.clanIcon = null;
            }
            return;
        }// end function

        public function finishRebuild() : void
        {
            status = PRODUCING;
            this.loadConfigData();
            upgradeAvatar();
            return;
        }// end function

        override public function removeAvatar() : void
        {
            super.removeAvatar();
            this.removeClanIcon();
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            super.finishBuilding(param1);
            if (GameDataMgr.getInstance().myClanDetial.clanId > 0)
            {
                this.loadSymbol();
            }
            return;
        }// end function

        override public function onClick(event:MouseEvent) : void
        {
            if (!parent)
            {
                if (status == MapObject.BROKEN && borderImage.visible)
                {
                    if (GlobalVar.state != GlobalVar.STATE_MYHOME)
                    {
                        return;
                    }
                    CityMgr.getInstance().prepareToRebuildClanCastle();
                    return;
                }
            }
            return;
        }// end function

        public function loadSymbol() : void
        {
            if (this.details.name != "")
            {
                this.loadIcon(this.details.icon, this.details.name);
            }
            return;
        }// end function

        public function checkFull() : void
        {
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.troopList.length)
            {
                
                _loc_1 = _loc_1 + this.troopList[_loc_2].num * Utility.getHousingSpace(this.troopList[_loc_2].type);
                _loc_2++;
            }
            if (_loc_1 >= this.info.troopCapacity)
            {
                this.showStatusIcon(GuiStatusBuilding.FULL);
                this.isFull = true;
            }
            else
            {
                this.isFull = false;
            }
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Vector.<GuiBuildingActioItem> = null;
            var _loc_3:int = 0;
            var _loc_4:Vector.<GuiBuildingActioItem> = null;
            var _loc_5:int = 0;
            return;
            return;
        }// end function

        override public function addToCity(param1:Boolean = false) : void
        {
            super.addToCity(param1);
            this.loadSymbol();
            this.checkFull();
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            if (this.statusIcon)
            {
                this.statusIcon.destroyBaseGUI();
                this.statusIcon = null;
            }
            return;
        }// end function

        override public function showSelected() : void
        {
            super.showSelected();
            this.showAttackRange();
            return;
        }// end function

        override public function hideSelected() : void
        {
            super.hideSelected();
            this.hideAttackRange();
            return;
        }// end function

        public function showAttackRange() : void
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            this.hasAttackRange = true;
            _loc_1.showAttackRange(avatar, this.info.range * BaseInfo.WIDTH_CELL * BaseInfo.SCALE_MAP);
            return;
        }// end function

        public function hideAttackRange(param1:Boolean = true) : void
        {
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            this.hasAttackRange = false;
            _loc_2.hideAttackRange(param1);
            return;
        }// end function

        override public function hide() : void
        {
            super.hide();
            this.hideAttackRange(false);
            if (this.statusIcon.isShowing)
            {
                this.statusIcon.hide();
            }
            return;
        }// end function

    }
}
