package modules.city.graphics.clan.donate
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import gameData.*;
    import modules.city.*;
    import resMgr.*;

    public class GuiDonateTroopItem extends BaseGui
    {
        public var bmpDonateTroopItem:BitmapButton;
        public var labelTroopDonate:TextField;
        public var labelNumber:TextField;
        public var type:String;
        public var index:int;
        public var troopDonate:int;
        public var troopLeft:int;
        public var imageBgTroopLevelDonateItem:MovieClip;

        public function GuiDonateTroopItem()
        {
            super(ResMgr.getInstance().getMovieClip("DonateTroopItem"));
            this.imageBgTroopLevelDonateItem.mouseEnabled = false;
            this.imageBgTroopLevelDonateItem.mouseChildren = false;
            return;
        }// end function

        public function setTroop(param1:String) : void
        {
            this.type = param1;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(param1 + "_Research_Icon") as Sprite;
            if (!_loc_2)
            {
                return;
            }
            this.bmpDonateTroopItem.img.addChild(_loc_2);
            _loc_2.y = 6;
            _loc_2.x = (img.width - _loc_2.width) / 2;
            _loc_2.mouseEnabled = false;
            _loc_2.mouseChildren = false;
            return;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            this.bmpDonateTroopItem.enable = param1;
            this.labelTroopDonate.text = "0";
            this.labelNumber.text = "0";
            return;
        }// end function

        public function setDonationNumber(param1:int) : void
        {
            this.troopDonate = param1;
            this.labelTroopDonate.text = param1.toString();
            return;
        }// end function

        public function setTroopLeft(param1:int) : void
        {
            this.troopLeft = param1;
            this.labelNumber.text = "x" + param1.toString();
            if (this.troopLeft == 0)
            {
                this.setEnable(false);
            }
            return;
        }// end function

        override public function onMouseClick(param1:String, param2:MouseEvent) : void
        {
            CityMgr.getInstance().guiDonateTroop.onItemClick(this.index);
            return;
        }// end function

        public function updateStarLevel() : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:int = 0;
            var _loc_6:Sprite = null;
            var _loc_1:int = 1;
            while (_loc_1 < this.imageBgTroopLevelDonateItem.numChildren)
            {
                
                this.imageBgTroopLevelDonateItem.removeChildAt(_loc_1);
                _loc_1++;
            }
            var _loc_2:* = GameDataMgr.getInstance().getTroopLevel(this.type);
            if (_loc_2 >= 1)
            {
                _loc_3 = 3.3;
                _loc_4 = 1.4;
                _loc_5 = 0;
                while (_loc_5 < _loc_2)
                {
                    
                    _loc_6 = ResMgr.getInstance().getMovieClip("image_DonateTroopStar") as Sprite;
                    _loc_6.x = _loc_3 + _loc_5 * (_loc_6.width + 2.15);
                    _loc_6.y = _loc_4;
                    _loc_6.mouseEnabled = false;
                    _loc_6.mouseChildren = false;
                    this.imageBgTroopLevelDonateItem.addChild(_loc_6);
                    _loc_5++;
                }
            }
            return;
        }// end function

    }
}
