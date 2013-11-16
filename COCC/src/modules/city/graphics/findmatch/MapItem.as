package modules.city.graphics.findmatch
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class MapItem extends BaseGui
    {
        public var pageMap:int = 0;

        public function MapItem(param1:int)
        {
            var _loc_4:int = 0;
            var _loc_5:BitmapButton = null;
            var _loc_6:PointMap = null;
            var _loc_7:DisplayObject = null;
            super(ResMgr.getInstance().getMovieClip("SingleMap_" + param1));
            this.pageMap = param1;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            _loc_3 = 0;
            while (_loc_3 < param1)
            {
                
                _loc_2 = _loc_2 + GlobalVar.SINGLE_MAP_POINTS[_loc_3];
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < GlobalVar.SINGLE_MAP_POINTS[this.pageMap])
            {
                
                _loc_4 = _loc_2 + _loc_3 + 1;
                _loc_5 = this.getMapPoint(_loc_4);
                if (_loc_5)
                {
                    _loc_5.enable = false;
                    _loc_6 = GameDataMgr.getInstance().getPointSingleMapInfo(_loc_4);
                    if (_loc_6)
                    {
                        _loc_7 = Utility.getTooltipMapPoint("Phó bản " + _loc_4, _loc_6.gold, _loc_6.elixir);
                        _loc_5.setTooltipDisplayObj(_loc_7);
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        public function getMapPoint(param1:int) : BitmapButton
        {
            return this.bmpButtonList["MapPoint" + param1];
        }// end function

        public function loadPointInfo(param1:PointMap) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Sprite = null;
            var _loc_6:Sprite = null;
            var _loc_2:* = this.bmpButtonList["MapPoint" + param1.pId];
            _loc_2.enable = true;
            if (param1.nStar > 0)
            {
                _loc_4 = 0;
                _loc_4 = 0;
                while (_loc_4 < 3)
                {
                    
                    _loc_5 = ResMgr.getInstance().getMovieClip("Bg_Star_Icon") as Sprite;
                    _loc_5.x = (_loc_4 - 1) * 20 + (_loc_2.width - _loc_5.width) / 2;
                    _loc_5.y = -_loc_5.height + (_loc_4 == 1 ? (-5) : (0));
                    _loc_2.img.addChild(_loc_5);
                    _loc_4++;
                }
                _loc_4 = 0;
                while (_loc_4 < param1.nStar)
                {
                    
                    _loc_6 = ResMgr.getInstance().getMovieClip("Star_Icon") as Sprite;
                    _loc_6.x = (_loc_4 - 1) * 20 + (_loc_2.width - _loc_6.width) / 2;
                    _loc_6.y = -_loc_6.height + (_loc_4 == 1 ? (-5) : (0));
                    _loc_2.img.addChild(_loc_6);
                    _loc_4++;
                }
            }
            var _loc_3:* = Utility.getTooltipMapPoint("Phó bản " + param1.pId, param1.gold, param1.elixir);
            _loc_2.setTooltipDisplayObj(_loc_3);
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            var _loc_3:* = param1.split("bmpMapPoint");
            var _loc_4:* = parseInt(_loc_3[1], 10);
            var _loc_5:* = this.getMapPoint(_loc_4);
            CityMgr.getInstance().guiFindMath.guiSingleMap.choosePointMap(_loc_4, _loc_5);
            return;
        }// end function

    }
}
