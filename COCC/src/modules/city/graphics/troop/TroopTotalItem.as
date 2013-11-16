package modules.city.graphics.troop
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import modules.battle.data.*;
    import resMgr.*;

    public class TroopTotalItem extends BaseGui
    {
        public const BMP_TROOP:String = "bmpTroop";
        public var labelNumber:TextField;

        public function TroopTotalItem()
        {
            super(ResMgr.getInstance().getMovieClip("TroopTotalItem"));
            return;
        }// end function

        public function setTroop(param1:Troop) : void
        {
            var _loc_3:Sprite = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:int = 0;
            var _loc_7:Sprite = null;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(param1.type + "_Research_Icon") as Sprite;
            img.addChildAt(_loc_2, 1);
            _loc_2.y = 6;
            _loc_2.x = (img.width - _loc_2.width) / 2;
            _loc_2.mouseEnabled = false;
            _loc_2.mouseChildren = false;
            if (param1.level > 1)
            {
                _loc_3 = ResMgr.getInstance().getMovieClip("TroopLevelBgBig") as Sprite;
                img.addChild(_loc_3);
                _loc_3.x = _loc_2.x + (_loc_2.width - _loc_3.width) / 2;
                _loc_3.y = _loc_2.y + _loc_2.height - _loc_3.height - 3;
                _loc_4 = 2.9;
                _loc_5 = 0.25;
                _loc_6 = 0;
                while (_loc_6 < param1.level)
                {
                    
                    _loc_7 = ResMgr.getInstance().getMovieClip("TroopLevel_IconBig") as Sprite;
                    _loc_7.x = _loc_4 + _loc_6 * (_loc_7.width - 0.5);
                    _loc_7.y = _loc_5;
                    _loc_7.mouseEnabled = false;
                    _loc_7.mouseChildren = false;
                    _loc_3.addChild(_loc_7);
                    _loc_6++;
                }
            }
            this.labelNumber.text = "x" + param1.num.toString();
            return;
        }// end function

    }
}
