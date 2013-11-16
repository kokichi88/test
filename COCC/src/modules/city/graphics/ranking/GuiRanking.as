package modules.city.graphics.ranking
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import modules.city.*;
    import modules.city.graphics.clan.*;
    import network.receive.*;
    import resMgr.*;

    public class GuiRanking extends BaseGui
    {
        private var guiBack:int;
        public var bmpBack:BitmapButton;
        public var bmp2TopPlayers:BitmapButton;
        public var bmp2TopClans:BitmapButton;
        public var bmp2SearchClan2:BitmapButton;
        public var guiTopPlayers:GuiTopPlayers;
        public var guiSearchClan:GuiSearchClan;
        public var guiJoinClan:GuiJoinClan;
        private static const BMP_CLOSE:String = "bmpClose";
        private static const BMP_BACK:String = "bmpBack";
        private static const BMP_TOP_PLAYERS:String = "bmp2TopPlayers";
        private static const BMP_SEARCH_CLAN:String = "bmp2SearchClan2";
        private static const BMP_TOP_CLANS:String = "bmp2TopClans";
        private static const GUI_TOP_PLAYERS:int = 0;
        private static const GUI_SEARCH:int = 1;

        public function GuiRanking()
        {
            super(ResMgr.getInstance().getMovieClip("RankingGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.guiTopPlayers = new GuiTopPlayers();
            addGui(this.guiTopPlayers);
            this.guiJoinClan = new GuiJoinClan();
            addGui(this.guiJoinClan);
            this.guiJoinClan.bgImg.visible = false;
            this.guiSearchClan = new GuiSearchClan();
            addGui(this.guiSearchClan);
            this.guiSearchClan.bgImg.visible = false;
            this.bmp2TopClans.enable = false;
            this.widthBg = 690;
            return;
        }// end function

        private function hideAllGuis() : void
        {
            this.guiTopPlayers.bgImg.visible = false;
            this.guiTopPlayers.removeEvent();
            this.bmpBack.visible = false;
            this.guiJoinClan.bgImg.visible = false;
            this.guiJoinClan.removeEvent();
            this.guiSearchClan.bgImg.visible = false;
            return;
        }// end function

        private function setTabNormal() : void
        {
            this.bmp2SearchClan2.setTabNormal();
            this.bmp2TopClans.setTabNormal();
            this.bmp2TopPlayers.setTabNormal();
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
                    switch(this.guiBack)
                    {
                        case GUI_TOP_PLAYERS:
                        {
                            this.showTopPlayers();
                            break;
                        }
                        case GUI_SEARCH:
                        {
                            this.showGuiSearchClan();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case BMP_TOP_PLAYERS:
                {
                    this.showTopPlayers();
                    break;
                }
                case BMP_SEARCH_CLAN:
                {
                    this.showGuiSearchClan();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function showTopPlayers() : void
        {
            this.hideAllGuis();
            this.guiTopPlayers.bgImg.visible = true;
            this.guiTopPlayers.addEvent();
            this.bmpBack.visible = false;
            this.setTabNormal();
            this.bmp2TopPlayers.setTabSelected();
            this.guiBack = GUI_TOP_PLAYERS;
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

        public function showGuiSearchClan() : void
        {
            this.hideAllGuis();
            this.guiSearchClan.bgImg.visible = true;
            this.bmpBack.visible = false;
            this.setTabNormal();
            this.bmp2SearchClan2.setTabSelected();
            this.guiBack = GUI_SEARCH;
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            super.show(param1, param2);
            CityMgr.getInstance().sendGetRankingList();
            this.guiSearchClan.refresh();
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            this.hideAllGuis();
            super.hide(param1);
            return;
        }// end function

        public function loadTopPlayers(param1:RankingListMsg) : void
        {
            this.showTopPlayers();
            this.guiTopPlayers.loadTopPlayers(param1);
            return;
        }// end function

    }
}
