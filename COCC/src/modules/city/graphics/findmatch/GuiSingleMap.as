package modules.city.graphics.findmatch
{
    import __AS3__.vec.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.tutorial.*;
    import modules.feed.*;
    import resMgr.*;
    import utility.*;

    public class GuiSingleMap extends BaseGui
    {
        public var labelStarNumber:TextField;
        public var imageBg:MovieClip;
        public var pageMap:PageMgr;
        public var listItem:Vector.<MapItem>;
        public var bmpNextMap:BitmapButton;
        public var bmpPrevMap:BitmapButton;
        public var bmpAttack:BitmapButton;
        private var configPoint:Array;
        public var curPointMap:int = 0;
        public var guiAvaiableLoot:GuiAvaiableLoot;
        private var maxPoint:int;
        private static var BMP_CLOSE:String = "bmpClose";
        private static var BMP_FIND_MATCH:String = "bmpFindMatch";
        private static var BMP_NEXT:String = "bmpNextMap";
        private static var BMP_PREV:String = "bmpPrevMap";

        public function GuiSingleMap()
        {
            this.listItem = new Vector.<MapItem>;
            this.configPoint = new Array();
            super(ResMgr.getInstance().getMovieClip("SingleMapGui"));
            autoAlign = AUTO_ALIGN_CENTER;
            enableDisableScreen = true;
            enableClickOutToClose = true;
            this.pageMap = new PageMgr(this.imageBg);
            this.pageMap.x = 43;
            this.pageMap.y = 87;
            return;
        }// end function

        private function onClickAttack(event:MouseEvent) : void
        {
            if (TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().nextStep();
            }
            this.hide();
            CityMgr.getInstance().showTransitionEff(CityMgr.getInstance().sendAttackSingleMap, this.curPointMap);
            CityMgr.getInstance().setState(GlobalVar.STATE_SINGLE_MAP);
            return;
        }// end function

        public function initSingleMap() : void
        {
            var _loc_7:MapItem = null;
            this.maxPoint = JsonMgr.getInstance().getMaxConfigSingleBattle();
            var _loc_1:* = this.getItemIndex(this.maxPoint) + 1;
            var _loc_2:int = 0;
            var _loc_3:int = 820;
            var _loc_4:int = 443;
            var _loc_5:* = new Sprite();
            var _loc_6:int = 0;
            while (_loc_6 < _loc_1)
            {
                
                _loc_7 = new MapItem(_loc_6);
                _loc_5.addChild(_loc_7.bgImg);
                _loc_7.bgImg.x = _loc_7.widthBg * _loc_6;
                _loc_7.bgImg.y = 0;
                this.listItem.push(_loc_7);
                _loc_6++;
            }
            this.pageMap.setData(_loc_5, _loc_3, _loc_4, 0, PageMgr.HOZIRONTOL, true, 1);
            this.bmpNextMap.enable = this.pageMap.canNext();
            this.bmpPrevMap.enable = this.pageMap.canPrev();
            this.bmpAttack = new BitmapButton(ResMgr.getInstance().getMovieClip("bmp_AttackSingleMap"), 1);
            this.bmpAttack.img.addEventListener(MouseEvent.CLICK, this.onClickAttack);
            this.pageMap.addChild(this.bmpAttack.img);
            this.bmpAttack.visible = false;
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
                    this.pageMap.nextPage();
                    this.bmpNextMap.enable = this.pageMap.canNext();
                    this.bmpPrevMap.enable = this.pageMap.canPrev();
                    this.bmpAttack.visible = false;
                    break;
                }
                case BMP_PREV:
                {
                    this.pageMap.prevPage();
                    this.bmpPrevMap.enable = this.pageMap.canPrev();
                    this.bmpNextMap.enable = this.pageMap.canNext();
                    this.bmpAttack.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function autoGetMapItem() : void
        {
            var _loc_1:* = GameDataMgr.getInstance().singleMapLevel;
            var _loc_2:* = this.getItemIndex(_loc_1);
            this.pageMap.iPage = _loc_2;
            this.bmpPrevMap.enable = this.pageMap.canPrev();
            this.bmpNextMap.enable = this.pageMap.canNext();
            return;
        }// end function

        override public function show(param1:Sprite = null, param2:Boolean = false) : void
        {
            var _loc_3:BitmapButton = null;
            var _loc_4:Point = null;
            var _loc_5:Point = null;
            this.updateTotalStar();
            super.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GUI), param2);
            if (TutorialMgr.getInstance().isTutorial)
            {
                _loc_3 = this.listItem[0].getMapPoint(1);
                _loc_4 = getPos();
                _loc_5 = this.listItem[0].getPos();
                _loc_4.x = _loc_4.x + (_loc_3.img.x + _loc_3.width / 2 + _loc_5.x + this.imageBg.x + this.pageMap.x);
                _loc_4.y = _loc_4.y + (_loc_3.img.y + _loc_3.height / 2 + _loc_5.y + this.imageBg.y + this.pageMap.y);
                TutorialMgr.getInstance().layer.ShowTutorialScreen(_loc_4.x, _loc_4.y, 30, 0);
                TutorialMgr.getInstance().showArrow(_loc_4.x, _loc_4.y - 35);
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            this.bmpAttack.visible = false;
            super.hide(param1);
            return;
        }// end function

        private function getMapIndex(param1:Vector.<PointMap>, param2:int) : int
        {
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1[_loc_3].pId == param2)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function loadSingleMap(param1:Boolean = true) : void
        {
            var _loc_2:String = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:PointMap = null;
            var _loc_8:int = 0;
            var _loc_3:* = JsonMgr.getInstance().singleBattle;
            var _loc_4:* = GameDataMgr.getInstance().singleMapLevel;
            for (_loc_2 in _loc_3)
            {
                
                _loc_5 = _loc_3[_loc_2]["level"];
                _loc_6 = parseInt(_loc_2, 10);
                if (_loc_6 <= this.maxPoint && _loc_5 <= _loc_4)
                {
                    _loc_7 = GameDataMgr.getInstance().getPointSingleMapInfo(_loc_6);
                    _loc_8 = this.getItemIndex(_loc_6);
                    this.listItem[_loc_8].loadPointInfo(_loc_7);
                }
            }
            this.showComingSoonPoint();
            if (param1)
            {
                this.autoGetMapItem();
            }
            return;
        }// end function

        public function updateTotalStar() : void
        {
            var _loc_1:int = 0;
            var _loc_2:* = GameDataMgr.getInstance().singleMapInfo;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_1 = _loc_1 + _loc_2[_loc_3].nStar;
                _loc_3++;
            }
            this.labelStarNumber.text = _loc_1 + "/" + this.maxPoint * 3;
            if (_loc_1 >= FeedMgr.SINGE_MAP_STAR1 && _loc_1 < FeedMgr.SINGE_MAP_STAR2)
            {
                FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.SINGE_MAP_100Star);
            }
            if (_loc_1 > FeedMgr.SINGE_MAP_STAR2)
            {
                FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.SINGE_MAP_150Star);
            }
            return;
        }// end function

        public function getItemIndex(param1:int) : int
        {
            var _loc_2:int = 0;
            while (_loc_2 < GlobalVar.SINGLE_MAP_POINTS.length)
            {
                
                if (param1 <= GlobalVar.SINGLE_MAP_POINTS[_loc_2])
                {
                    return _loc_2;
                }
                param1 = param1 - GlobalVar.SINGLE_MAP_POINTS[_loc_2];
                _loc_2++;
            }
            return 0;
        }// end function

        public function choosePointMap(param1:int, param2:BitmapButton) : void
        {
            this.curPointMap = param1;
            this.bmpAttack.img.x = param2.img.x + (param2.width - this.bmpAttack.width) / 2;
            this.bmpAttack.img.y = param2.img.y + param2.height;
            this.bmpAttack.visible = true;
            if (TutorialMgr.getInstance().isTutorial)
            {
                TutorialMgr.getInstance().nextStep();
            }
            return;
        }// end function

        public function finishSingleMap(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = GameDataMgr.getInstance().singleMapInfo;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (_loc_5[_loc_6].pId == param1)
                {
                    if (_loc_5[_loc_6].nStar < param2)
                    {
                        _loc_5[_loc_6].nStar = param2;
                    }
                    _loc_5[_loc_6].gold = _loc_5[_loc_6].gold - param3;
                    _loc_5[_loc_6].gold = Math.max(0, _loc_5[_loc_6].gold);
                    _loc_5[_loc_6].elixir = _loc_5[_loc_6].elixir - param4;
                    _loc_5[_loc_6].elixir = Math.max(0, _loc_5[_loc_6].elixir);
                    break;
                }
                _loc_6++;
            }
            return;
        }// end function

        public function updateSingleMap(param1:int) : void
        {
            var _loc_2:* = GameDataMgr.getInstance().singleMapLevel < param1;
            GameDataMgr.getInstance().singleMapLevel = param1;
            this.loadSingleMap(_loc_2);
            return;
        }// end function

        private function showComingSoonPoint() : void
        {
            if (this.maxPoint == 49)
            {
                return;
            }
            var _loc_1:* = this.getItemIndex((this.maxPoint + 1));
            if (_loc_1 >= this.listItem.length)
            {
                return;
            }
            var _loc_2:* = this.listItem[_loc_1].bmpButtonList["MapPoint" + (this.maxPoint + 1)];
            if (!_loc_2)
            {
                return;
            }
            _loc_2.setTooltipDisplayObj(Utility.getTooltipString("SẮP RA MẮT"));
            return;
        }// end function

    }
}
