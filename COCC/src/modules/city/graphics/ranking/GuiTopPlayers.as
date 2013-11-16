package modules.city.graphics.ranking
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.clan.*;
    import modules.city.logic.*;
    import network.receive.*;
    import resMgr.*;
    import utility.*;

    public class GuiTopPlayers extends BaseGui
    {
        public var bmpPrev:BitmapButton;
        public var bmpNext:BitmapButton;
        public var bmp2TopTrophy:BitmapButton;
        public var bmp2TopLevel:BitmapButton;
        public var pageItem:PageMgr;
        private var trophyList:Vector.<PlayerInfo>;
        private var levelList:Vector.<PlayerInfo>;
        private var currentItem:int;
        private var guiToolTip:GuiClanMemberToolTip;
        public var listItem:Vector.<PlayerItem>;
        private var curList:Vector.<PlayerInfo>;
        private static const BMP_PREVIOUS:String = "bmpPrev";
        private static const BMP_NEXT:String = "bmpNext";
        private static const BMP_TOP_TROPHY:String = "bmp2TopTrophy";
        private static const BMP_TOP_LEVEL:String = "bmp2TopLevel";
        private static const NUM_ROW:int = 7;
        private static const NUM_COL:int = 1;

        public function GuiTopPlayers()
        {
            this.trophyList = new Vector.<PlayerInfo>;
            this.levelList = new Vector.<PlayerInfo>;
            this.listItem = new Vector.<PlayerItem>;
            super(ResMgr.getInstance().getMovieClip("TopPlayersGui"));
            this.pageItem = new PageMgr(img);
            this.pageItem.x = 47;
            this.pageItem.y = 141;
            this.bmpNext.visible = false;
            this.bmpPrev.visible = false;
            this.guiToolTip = CityMgr.getInstance().guiToolTip;
            this.currentItem = -1;
            return;
        }// end function

        public function loadTopPlayers(param1:RankingListMsg) : void
        {
            this.trophyList = param1.topTrophyList;
            this.levelList = param1.topLevelList;
            this.loadTopTrophy();
            return;
        }// end function

        private function loadTopTrophy() : void
        {
            this.setTabNormal();
            this.bmp2TopTrophy.setTabSelected();
            this.loadPlayers(this.trophyList);
            return;
        }// end function

        private function loadTopLevel() : void
        {
            this.setTabNormal();
            this.bmp2TopLevel.setTabSelected();
            this.loadPlayers(this.levelList);
            return;
        }// end function

        private function setTabNormal() : void
        {
            this.bmp2TopLevel.setTabNormal();
            this.bmp2TopTrophy.setTabNormal();
            return;
        }// end function

        private function removeAllItems() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.listItem.length)
            {
                
                this.listItem[_loc_1].destroyBaseGUI();
                this.listItem[_loc_1] = null;
                _loc_1++;
            }
            this.listItem.splice(0, this.listItem.length);
            this.listItem = new Vector.<PlayerItem>;
            return;
        }// end function

        private function loadPlayers(param1:Vector.<PlayerInfo>) : void
        {
            var _loc_10:PlayerItem = null;
            this.curList = param1;
            this.removeAllItems();
            var _loc_2:Number = 593;
            var _loc_3:Number = 305;
            var _loc_4:* = new Sprite();
            var _loc_5:Number = 2;
            var _loc_6:Number = 593;
            var _loc_7:Number = 7;
            var _loc_8:Number = -2.35;
            var _loc_9:int = 0;
            while (_loc_9 < param1.length)
            {
                
                _loc_10 = new PlayerItem();
                _loc_4.addChild(_loc_10.bgImg);
                _loc_10.setPos(_loc_5 + int(_loc_9 / NUM_ROW) * _loc_2, _loc_7 + Math.floor(_loc_9 % NUM_ROW / NUM_COL) * (_loc_10.heightBg + _loc_8));
                _loc_10.setInfo(_loc_9, param1[_loc_9]);
                this.listItem.push(_loc_10);
                _loc_9++;
            }
            this.pageItem.setData(_loc_4, _loc_2, _loc_3, 0, PageMgr.HOZIRONTOL, false, 1);
            var _loc_11:* = this.pageItem.totalPage > 1;
            this.bmpPrev.visible = this.pageItem.totalPage > 1;
            this.bmpNext.visible = _loc_11;
            this.bmpNext.enable = this.pageItem.canNext();
            this.bmpPrev.enable = this.pageItem.canPrev();
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            switch(param1)
            {
                case BMP_NEXT:
                {
                    this.pageItem.nextPage();
                    this.bmpNext.enable = this.pageItem.canNext();
                    this.bmpPrev.enable = this.pageItem.canPrev();
                    break;
                }
                case BMP_PREVIOUS:
                {
                    this.pageItem.prevPage();
                    this.bmpNext.enable = this.pageItem.canNext();
                    this.bmpPrev.enable = this.pageItem.canPrev();
                    break;
                }
                case BMP_TOP_TROPHY:
                {
                    this.loadTopTrophy();
                    break;
                }
                case BMP_TOP_LEVEL:
                {
                    this.loadTopLevel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function onItemClick(param1:int) : void
        {
            if (param1 == this.currentItem)
            {
                return;
            }
            this.currentItem = param1;
            this.guiToolTip.loadPlayerToolTip(this.curList[param1]);
            var _loc_2:* = this.listItem[param1].getPos();
            var _loc_3:* = CityMgr.getInstance().guiRanking.guiTopPlayers.getPos();
            var _loc_4:* = this.listItem[param1].getPos();
            _loc_4 = this.listItem[param1].bgImg.parent.localToGlobal(_loc_4);
            this.guiToolTip.setPos(_loc_3.x + this.bgImg.x + _loc_2.x + this.listItem[param1].widthBg / 2, _loc_3.y + this.bgImg.y + _loc_2.y + (this.listItem[param1].heightBg - this.guiToolTip.heightBg) / 2 + 100);
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
            var _loc_3:PlayerItem = null;
            var _loc_2:int = 0;
            while (_loc_2 < this.listItem.length)
            {
                
                _loc_3 = this.listItem[_loc_2];
                if (event.target == _loc_3.bmpPlayerItem.img)
                {
                    return;
                }
                _loc_2++;
            }
            this.guiToolTip.hide();
            this.currentItem = -1;
            return;
        }// end function

        public function onActionClick(param1:int) : void
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            if (this.currentItem == -1)
            {
                return;
            }
            switch(param1)
            {
                case GlobalVar.CLAN_ACTION_VISIT:
                {
                    CityMgr.getInstance().guiRanking.hide();
                    CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().visitPlayer, this.curList[this.currentItem].uId);
                    break;
                }
                case GlobalVar.CLAN_ACTION_VIEW:
                {
                    if (GameDataMgr.getInstance().clanCastle.status == MapObject.BROKEN)
                    {
                        _loc_2 = Localization.getInstance().getString("Title_TB");
                        _loc_3 = Localization.getInstance().getString("ClanMsg3");
                        CityMgr.getInstance().showMessage(_loc_2, _loc_3, "ĐỒNG Ý", null);
                        return;
                    }
                    CityMgr.getInstance().sendGetClanDetail(this.curList[this.currentItem].clanId);
                    CityMgr.getInstance().guiRanking.showDetailClan();
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
