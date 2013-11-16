package modules.city.graphics.clan
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
	import gameData.clan.ClanInfo;
    import modules.city.*;
    import modules.city.graphics.clan.symbol.*;
    import resMgr.*;
    import utility.*;

    public class GuiClan extends BaseGui
    {
        public var bmpBack:BitmapButton;
        public var bmp2JoinClan:BitmapButton;
        public var bmp2CreateClan:BitmapButton;
        public var bmp2SearchClan:BitmapButton;
        public var bmp2MyClan:BitmapButton;
        public var guiJoinClan:GuiJoinClan;
        public var guiListClan:GuiListClan;
        public var guiCreateClan:GuiCreateClan;
        public var guiClanSymbol:GuiClanSymbols;
        public var guiSearchClan:GuiSearchClan;
        public var labelClanCastle:TextField;
        private static const BMP_CLOSE:String = "bmpClose";
        private static const BMP_BACK:String = "bmpBack";
        private static const BMP_JOIN_CLAN:String = "bmp2JoinClan";
        private static const BMP_CREATE_CLAN:String = "bmp2CreateClan";
        private static const BMP_SEARCH_CLAN:String = "bmp2SearchClan";
        private static const BMP_MY_CLAN:String = "bmp2MyClan";
        public static var startX:int = 29;
        public static var startY:int = 29;
        public static var startButtonX:int = 98;
        public static var startButtonY:int = 8;
        public static var padingButton:int = 2;

        public function GuiClan()
        {
            super(ResMgr.getInstance().getMovieClip("ClanGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.labelClanCastle.text = Localization.getInstance().getString(BuildingType.CLAN_CASTLE).toUpperCase();
            this.createButtons();
            this.guiJoinClan = new GuiJoinClan();
            addGui(this.guiJoinClan);
            this.guiJoinClan.bgImg.visible = false;
            this.guiListClan = new GuiListClan();
            addGui(this.guiListClan);
            this.guiCreateClan = new GuiCreateClan();
            this.guiCreateClan.setPos(58, 114);
            addGui(this.guiCreateClan);
            this.guiCreateClan.bgImg.visible = false;
            this.guiClanSymbol = new GuiClanSymbols();
            this.guiClanSymbol.setPos(38, 53);
            addGui(this.guiClanSymbol);
            this.guiClanSymbol.bgImg.visible = false;
            this.guiSearchClan = new GuiSearchClan();
            addGui(this.guiSearchClan);
            this.guiSearchClan.bgImg.visible = false;
            this.widthBg = 690;
            this.hideAllGuis();
            return;
        }// end function

        private function hideAllGuis() : void
        {
            this.guiJoinClan.bgImg.visible = false;
            this.guiListClan.bgImg.visible = false;
            this.guiCreateClan.bgImg.visible = false;
            this.guiClanSymbol.bgImg.visible = false;
            this.guiSearchClan.bgImg.visible = false;
            this.bmpBack.visible = false;
            this.guiJoinClan.removeEvent();
            return;
        }// end function

        private function setTabNormal() : void
        {
            this.bmp2CreateClan.setTabNormal();
            this.bmp2JoinClan.setTabNormal();
            this.bmp2MyClan.setTabNormal();
            this.bmp2SearchClan.setTabNormal();
            return;
        }// end function

        private function createButtons() : void
        {
            this.bmp2MyClan.img.x = 50;
            this.bmp2MyClan.img.y = 50;
            this.bmp2SearchClan.img.y = 50;
            return;
        }// end function

        public function showJoinClanButton() : void
        {
            this.bmpBack.visible = false;
            this.bmp2JoinClan.visible = true;
            this.bmp2CreateClan.visible = true;
            this.bmp2SearchClan.img.x = 443;
            this.bmp2MyClan.visible = false;
            return;
        }// end function

        public function showMyClanButton() : void
        {
            this.bmpBack.visible = false;
            this.bmp2JoinClan.visible = false;
            this.bmp2CreateClan.visible = false;
            this.bmp2MyClan.visible = true;
            this.bmp2SearchClan.img.x = 246;
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
                case BMP_BACK:
                {
                    if (this.guiJoinClan.bgImg.visible)
                    {
                        if (GameDataMgr.getInstance().myClanDetial.clanId == 0)
                        {
                            this.showListClan();
                        }
                        else
                        {
                            this.showGuiSearchClan();
                        }
                    }
                    else if (this.guiClanSymbol.bgImg.visible)
                    {
                        this.showCreateClan();
                    }
                    else if (this.guiCreateClan.bgImg.visible)
                    {
                        this.showMyClan();
                    }
                    break;
                }
                case BMP_JOIN_CLAN:
                {
                    this.showListClan();
                    break;
                }
                case BMP_CREATE_CLAN:
                {
                    this.showCreateClan();
                    break;
                }
                case BMP_SEARCH_CLAN:
                {
                    this.showGuiSearchClan();
                    break;
                }
                case BMP_MY_CLAN:
                {
                    this.showMyClan();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function showMyClan() : void
        {
            this.guiJoinClan.loadMyClan();
            this.showDetailClan();
            this.bmpBack.visible = false;
            this.setTabNormal();
            this.bmp2MyClan.setTabSelected();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), true);
            this.guiSearchClan.refresh();
            var _loc_3:* = GameDataMgr.getInstance().getClanId();
            if (_loc_3 > 0)
            {
                this.hideAllGuis();
                this.guiJoinClan.bgImg.visible = true;
                this.guiJoinClan.addEvent();
                this.showMyClanButton();
                CityMgr.getInstance().sendGetClanDetail(_loc_3);
                this.setTabNormal();
                this.bmp2MyClan.setTabSelected();
            }
            else
            {
                this.hideAllGuis();
                this.showJoinClanButton();
                this.guiListClan.bgImg.visible = true;
                CityMgr.getInstance().sendGetClansCmd();
                this.setTabNormal();
                this.bmp2JoinClan.setTabSelected();
            }
            return;
        }// end function

        public function loadListClans(param1:Vector.<ClanInfo>) : void
        {
            this.guiListClan.loadClans(param1);
            this.guiListClan.bgImg.visible = true;
            return;
        }// end function

        public function showListClan() : void
        {
            this.hideAllGuis();
            this.guiListClan.bgImg.visible = true;
            this.bmpBack.visible = false;
            this.setTabNormal();
            this.bmp2JoinClan.setTabSelected();
            return;
        }// end function

        public function showDetailClan() : void
        {
            this.hideAllGuis();
            this.guiJoinClan.addEvent();
            this.guiJoinClan.bgImg.visible = true;
            this.bmpBack.visible = true;
            return;
        }// end function

        public function showCreateClan() : void
        {
            this.hideAllGuis();
            this.guiCreateClan.showCreateClan();
            this.guiCreateClan.bgImg.visible = true;
            this.bmpBack.visible = false;
            this.setTabNormal();
            this.bmp2CreateClan.setTabSelected();
            return;
        }// end function

        public function showEditClan() : void
        {
            this.hideAllGuis();
            this.guiCreateClan.showEditClan();
            this.guiCreateClan.bgImg.visible = true;
            this.bmpBack.visible = true;
            return;
        }// end function

        public function showGuiClanSymbols() : void
        {
            this.hideAllGuis();
            this.guiClanSymbol.bgImg.visible = true;
            this.bmpBack.visible = true;
            return;
        }// end function

        public function showGuiSearchClan() : void
        {
            this.hideAllGuis();
            this.guiSearchClan.bgImg.visible = true;
            this.bmpBack.visible = false;
            this.setTabNormal();
            this.bmp2SearchClan.setTabSelected();
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            this.hideAllGuis();
            super.hide(param1);
            if (param1)
            {
                CityMgr.getInstance().showBuildingActionGui(GameDataMgr.getInstance().clanCastle);
            }
            return;
        }// end function

        override public function loop() : void
        {
            if (this.guiJoinClan.bgImg.visible)
            {
                this.guiJoinClan.loop();
            }
            if (this.guiListClan.bgImg.visible)
            {
                this.guiListClan.loop();
            }
            return;
        }// end function

    }
}
