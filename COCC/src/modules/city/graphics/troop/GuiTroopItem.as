package modules.city.graphics.troop
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import modules.battle.*;
    import modules.battle.data.*;
    import resMgr.*;

    public class GuiTroopItem extends BaseGui
    {
        public const BMP_TROOP:String = "bmpTroop";
        public var labelIncreaseIndex:TextField;
        private var _troop:Troop;
        public var bmpTroop:BitmapButton;
        public var index:int;

        public function GuiTroopItem()
        {
            super(ResMgr.getInstance().getMovieClip("TroopItemGui"));
            return;
        }// end function

        public function setTroop(param1:Troop) : void
        {
            var _loc_3:Sprite = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:int = 0;
            var _loc_7:Sprite = null;
            this._troop = param1;
            this.labelIncreaseIndex.text = "x" + this._troop.num;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(this._troop.type + "_Research_Icon") as Sprite;
            img.addChildAt(_loc_2, 1);
            _loc_2.y = (img.height - _loc_2.height) / 2;
            _loc_2.x = (img.width - _loc_2.width) / 2;
            _loc_2.mouseEnabled = false;
            _loc_2.mouseChildren = false;
            if (this._troop.level >= 1)
            {
                _loc_3 = ResMgr.getInstance().getMovieClip("TroopLevelBg") as Sprite;
                img.addChild(_loc_3);
                _loc_3.x = _loc_2.x + (_loc_2.width - _loc_3.width) / 2;
                _loc_3.y = _loc_2.y + _loc_2.height - _loc_3.height - 3;
                _loc_4 = 0.75;
                _loc_5 = -1;
                _loc_6 = 0;
                while (_loc_6 < this._troop.level)
                {
                    
                    _loc_7 = ResMgr.getInstance().getMovieClip("TroopLevel_Icon") as Sprite;
                    _loc_7.x = _loc_4 + _loc_6 * (_loc_7.width - 3.3);
                    _loc_7.y = _loc_5;
                    _loc_7.mouseEnabled = false;
                    _loc_7.mouseChildren = false;
                    _loc_3.addChild(_loc_7);
                    _loc_6++;
                }
            }
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
            this.labelIncreaseIndex.text = "x" + this._troop.num;
            if (this._troop.num <= 0)
            {
                img.filters = [BitmapButton.disableFilter];
            }
            return;
        }// end function

        public function focus() : void
        {
            BattleModule.getInstance().guiBattleTroop.focusTroop(this.index);
            return;
        }// end function

    }
}
