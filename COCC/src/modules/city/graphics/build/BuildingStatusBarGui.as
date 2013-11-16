package modules.city.graphics.build
{
    import component.*;
    import flash.display.*;
    import flash.text.*;
    import modules.*;
    import modules.city.*;
    import resMgr.*;
    import utility.*;

    public class BuildingStatusBarGui extends BaseGui
    {
        public var labelTime:TextField;
        public var imageStatusBar:MovieClip;
        public var troopIcon:Sprite = null;
        private var curTroopType:String = null;

        public function BuildingStatusBarGui()
        {
            super(ResMgr.getInstance().getMovieClip("BuildingStatusBarGui"));
            this.bgImg.mouseChildren = false;
            this.bgImg.mouseEnabled = false;
            return;
        }// end function

        public function showStatusBar(param1:Number, param2:Number) : void
        {
            if (this.troopIcon && this.troopIcon.parent != null)
            {
                this.troopIcon.parent.removeChild(this.troopIcon);
                this.troopIcon = null;
            }
            this.imageStatusBar.scaleX = param1 / param2;
            this.labelTime.text = Utility.convertTimeToShortString(param2 - param1);
            return;
        }// end function

        public function showTroopStatus(param1:String, param2:Number, param3:Number) : void
        {
            var _loc_5:int = 0;
            this.imageStatusBar.scaleX = Math.min(1, (param3 - param2) / param3);
            this.labelTime.text = Utility.convertTimeToShortString(param2);
            ModuleMgr.getInstance().doFunction(CityMgr.TROOP_UPGRADING_GUI_UPDATE_TIME, this.labelTime.text);
            if (this.curTroopType == param1)
            {
                return;
            }
            this.curTroopType = param1;
            if (this.troopIcon && this.troopIcon.parent != null)
            {
                _loc_5 = this.troopIcon.numChildren - 1;
                while (_loc_5 >= 0)
                {
                    
                    this.troopIcon.removeChildAt(_loc_5);
                    _loc_5 = _loc_5 - 1;
                }
                this.troopIcon.parent.removeChild(this.troopIcon);
                this.troopIcon = null;
            }
            this.troopIcon = ResMgr.getInstance().getMovieClip(param1) as Sprite;
            this.troopIcon.x = -this.troopIcon.width + 5;
            this.troopIcon.y = (this.heightBg - this.troopIcon.height) / 2 + 10;
            bgImg.addChild(this.troopIcon);
            this.troopIcon.mouseChildren = false;
            this.troopIcon.mouseEnabled = false;
            var _loc_4:* = ResMgr.getInstance().getMovieClip("imageTroopTrainBg") as Sprite;
            (ResMgr.getInstance().getMovieClip("imageTroopTrainBg") as Sprite).x = (this.troopIcon.width - _loc_4.width) / 2;
            _loc_4.y = (this.troopIcon.height - _loc_4.height) / 2;
            this.troopIcon.addChildAt(_loc_4, 0);
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            this.curTroopType = null;
            if (this.troopIcon)
            {
                this.troopIcon.removeChildAt(0);
                this.troopIcon.parent.removeChild(this.troopIcon);
                this.troopIcon = null;
            }
            super.hide();
            return;
        }// end function

    }
}
