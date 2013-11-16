package modules.city.graphics.clan
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.*;
    import gameData.clan.*;
    import modules.city.*;
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class GuiJoinClan extends BaseGui
    {
        public var mouseDownTroopType:String = "";
        public var mouseDownType:String = "";
        public var mouseDownDelay:Number = 0;
        public var labelJoin:TextField;
        private var scrollView:ScrollBar;
        public var imageBgBar:MovieClip;
        public var bmpTopArrow:BitmapButton;
        public var bmpBottomArrow:BitmapButton;
        public var bmpSlider:BitmapButton;
        public var labelClanName:TextField;
        public var labelToatlPoints:TextField;
        public var labelMember:TextField;
        public var labelType:TextField;
        public var labelRequiredTropies:TextField;
        private var clanId:int;
        private var listItem:Vector.<GuiClanMemberItem>;
        public var currentItem:int;
        public var guiToolTip:GuiClanMemberToolTip;
        public var bgSprite:Sprite;
        private var clanSymbol:Sprite = null;
        public var guiDetailClan:GuiDetailClan;
        private var parentPos:Point;
        public static const MOUSE_DOWN_DELAY_TO_START:int = 50;
        private static const MOUSE_DOWN_DELAY:int = 20;
        public static const MOUSE_DOWN:String = "mouseDown";
        public static const MOUSE_UP:String = "mouseUp";
        public static var BMP_JOIN:String = "bmpJoin";

        public function GuiJoinClan()
        {
            this.listItem = new Vector.<GuiClanMemberItem>;
            super(ResMgr.getInstance().getMovieClip("JoinClanGui"));
            this.init();
            this.guiToolTip = CityMgr.getInstance().guiToolTip;
            return;
        }// end function

        public function init() : void
        {
            var _loc_1:* = new Rectangle(45, 100, 595, 345);
            this.scrollView = new ScrollBar(this.imageBgBar, this.bmpSlider.img, this.bmpBottomArrow.img, this.bmpTopArrow.img, _loc_1);
            this.bgSprite = new Sprite();
            this.img.addChild(this.bgSprite);
            this.currentItem = -1;
            return;
        }// end function

        public function loadClanDetail(param1:GetClanDetailMsg) : void
        {
            param1.clanObj.memberSize = param1.members.length;
            this.clanId = param1.clanObj.clanId;
            this.loadMembers(param1.clanObj, param1.members);
            return;
        }// end function

        private function compare(param1:ClanMemberInfo, param2:ClanMemberInfo) : int
        {
            if (param1.trophy > param2.trophy)
            {
                return -1;
            }
            if (param1.trophy < param2.trophy)
            {
                return 1;
            }
            if (param1.level > param2.level)
            {
                return -1;
            }
            if (param1.level < param2.level)
            {
                return 1;
            }
            return 0;
        }// end function

        private function removeAllItem() : void
        {
            if (this.guiDetailClan)
            {
                this.guiDetailClan.destroyBaseGUI();
                this.guiDetailClan = null;
            }
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].destroyBaseGUI();
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<GuiClanMemberItem>;
            return;
        }// end function

        public function loadMembers(param1:ClanInfo, param2:Vector.<ClanMemberInfo>) : void
        {
            var _loc_5:GuiClanMemberItem = null;
            this.removeAllItem();
            var _loc_3:* = new Sprite();
            this.bgSprite.addChild(_loc_3);
            this.bmpSlider.img.height = 317;
            this.guiDetailClan = new GuiDetailClan();
            this.guiDetailClan.setClanDetail(param1);
            this.guiDetailClan.bgImg.x = 2;
            this.guiDetailClan.bgImg.y = -5;
            _loc_3.addChild(this.guiDetailClan.bgImg);
            param2.sort(this.compare);
            var _loc_4:int = 0;
            while (_loc_4 < param2.length)
            {
                
                _loc_5 = new GuiClanMemberItem();
                _loc_5.setInfo((_loc_4 + 1), param2[_loc_4]);
                _loc_3.addChild(_loc_5.bgImg);
                _loc_5.setPos(this.guiDetailClan.bgImg.x + 4, _loc_4 * (_loc_5.heightBg - 4) + this.guiDetailClan.bgImg.y + this.guiDetailClan.heightBg);
                this.listItem.push(_loc_5);
                _loc_4++;
            }
            this.scrollView.setData(_loc_3, 45, 100, 317, this.bmpTopArrow.img.y + this.bmpTopArrow.img.height);
            return;
        }// end function

        public function loadMyClan() : void
        {
            var _loc_3:String = null;
            var _loc_4:ClanMemberInfo = null;
            var _loc_1:* = new Vector.<ClanMemberInfo>;
            var _loc_2:* = GameDataMgr.getInstance().myClanMembers;
            for (_loc_3 in _loc_2)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_1.push(_loc_4);
            }
            this.loadMembers(GameDataMgr.getInstance().myClanDetial, _loc_1);
            return;
        }// end function

        public function onItemClick(param1:int) : void
        {
            if (param1 == this.currentItem)
            {
                return;
            }
            this.currentItem = param1;
            this.guiToolTip.loadItemToolTip(this.listItem[param1].info);
            var _loc_2:* = this.listItem[param1].getPos();
            var _loc_3:* = CityMgr.getInstance().guiClan.getPos();
            var _loc_4:* = this.listItem[param1].getPos();
            _loc_4 = this.listItem[param1].bgImg.parent.localToGlobal(_loc_4);
            this.guiToolTip.setPos(_loc_4.x + this.listItem[param1].widthBg / 2, _loc_4.y + (this.listItem[param1].heightBg - this.guiToolTip.heightBg) / 2);
            this.guiToolTip.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            return;
        }// end function

        public function addEvent() : void
        {
            img.stage.addEventListener(MouseEvent.CLICK, this.onClickStage);
            return;
        }// end function

        public function removeEvent() : void
        {
            this.guiToolTip.hide();
            if (img.stage)
            {
                img.stage.removeEventListener(MouseEvent.CLICK, this.onClickStage);
            }
            return;
        }// end function

        private function onClickStage(event:MouseEvent) : void
        {
            var _loc_3:GuiClanMemberItem = null;
            var _loc_2:int = 0;
            while (_loc_2 < this.listItem.length)
            {
                
                _loc_3 = this.listItem[_loc_2];
                if (event.target == _loc_3.bmpClanMember.img)
                {
                    return;
                }
                _loc_2++;
            }
            this.guiToolTip.hide();
            this.currentItem = -1;
            return;
        }// end function

        public function onClanActionClick(param1:int) : void
        {
            var _loc_3:String = null;
            if (this.currentItem == -1)
            {
                return;
            }
            var _loc_2:* = Localization.getInstance().getString("Title_TB");
            switch(param1)
            {
                case GlobalVar.CLAN_ACTION_VISIT:
                {
                    CityMgr.getInstance().guiClan.hide();
                    CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().visitPlayer, this.listItem[this.currentItem].info.uId);
                    break;
                }
                case GlobalVar.CLAN_ACTION_PROMOTE_TO_LEADER:
                {
                    _loc_3 = Localization.getInstance().getString("ClanMsg6");
                    _loc_3 = _loc_3.replace("@name", this.listItem[this.currentItem].info.name);
                    _loc_3 = _loc_3.replace("@type", Localization.getInstance().getString("ClanTitle1"));
                    CityMgr.getInstance().guiPopup.showMessageBox(_loc_2, _loc_3, "ĐỒNG Ý", CityMgr.getInstance().sendChangeMemberTitle, [this.listItem[this.currentItem].info.uId, GlobalVar.CLAN_LEADER]);
                    break;
                }
                case GlobalVar.CLAN_ACTION_PROMOTE_TO_ELDER:
                {
                    _loc_3 = Localization.getInstance().getString("ClanMsg6");
                    _loc_3 = _loc_3.replace("@name", this.listItem[this.currentItem].info.name);
                    _loc_3 = _loc_3.replace("@type", Localization.getInstance().getString("ClanTitle2"));
                    CityMgr.getInstance().guiPopup.showMessageBox(_loc_2, _loc_3, "ĐỒNG Ý", CityMgr.getInstance().sendChangeMemberTitle, [this.listItem[this.currentItem].info.uId, GlobalVar.CLAN_ELDER]);
                    break;
                }
                case GlobalVar.CLAN_ACTION_DEMOTE_TO_MEMBER:
                {
                    _loc_3 = Localization.getInstance().getString("ClanMsg6");
                    _loc_3 = _loc_3.replace("@name", this.listItem[this.currentItem].info.name);
                    _loc_3 = _loc_3.replace("@type", Localization.getInstance().getString("ClanTitle3"));
                    CityMgr.getInstance().guiPopup.showMessageBox(_loc_2, _loc_3, "ĐỒNG Ý", CityMgr.getInstance().sendChangeMemberTitle, [this.listItem[this.currentItem].info.uId, GlobalVar.CLAN_MEMBER]);
                    break;
                }
                case GlobalVar.CLAN_ACTION_KICK_OUT:
                {
                    _loc_3 = Localization.getInstance().getString("ClanMsg5");
                    _loc_3 = _loc_3.replace("@name", " " + this.listItem[this.currentItem].info.name);
                    CityMgr.getInstance().guiPopup.showMessageBox(_loc_2, _loc_3, "ĐỒNG Ý", CityMgr.getInstance().kickMember, [this.listItem[this.currentItem].info.uId]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function onMouseDown(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case "bmpTopArrow":
                {
                    this.mouseDownType = MOUSE_UP;
                    this.mouseDownDelay = Utility.getCurTime() * 1000 + MOUSE_DOWN_DELAY_TO_START;
                    break;
                }
                case "bmpBottomArrow":
                {
                    this.mouseDownType = MOUSE_DOWN;
                    this.mouseDownDelay = Utility.getCurTime() * 1000 + MOUSE_DOWN_DELAY_TO_START;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function loop() : void
        {
            if (GameInput.getInstance().isMouseDown)
            {
                if (this.mouseDownType != "" && Utility.getCurTime() * 1000 > this.mouseDownDelay + MOUSE_DOWN_DELAY)
                {
                    if (this.mouseDownType == MOUSE_DOWN)
                    {
                        this.scrollView.onDownDown(null);
                    }
                    else if (this.mouseDownType == MOUSE_UP)
                    {
                        this.scrollView.onDownUp(null);
                    }
                    this.mouseDownDelay = Utility.getCurTime() * 1000;
                }
            }
            else
            {
                this.mouseDownType = "";
            }
            return;
        }// end function

    }
}
