package modules.city.graphics.build
{
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import resMgr.*;
    import utility.*;

    public class GuiUpgradeBuildingUnlockItem extends BaseGui
    {
        public var labelIncreaseIndex:TextField;
        public var imageBgUnlock:MovieClip;
        private var type:String;

        public function GuiUpgradeBuildingUnlockItem()
        {
            super(ResMgr.getInstance().getMovieClip("UpgradeBuildingUnlock_Item") as MovieClip);
            this.bgImg.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this.bgImg.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            return;
        }// end function

        public function loadUnlockBuildingItem(param1:String, param2:int) : void
        {
            this.type = param1;
            var _loc_3:* = ResMgr.getInstance().getMovieClip(param1 + "_Unlock_Icon") as Sprite;
            if (!_loc_3)
            {
                return;
            }
            _loc_3.x = (this.imageBgUnlock.width - _loc_3.width) / 2;
            _loc_3.y = (this.imageBgUnlock.height - _loc_3.height) / 2;
            this.imageBgUnlock.addChild(_loc_3);
            this.labelIncreaseIndex.text = "x" + param2.toString();
            return;
        }// end function

        private function onOut(event:MouseEvent) : void
        {
            ActiveTooltip.getInstance().clearTooltip();
            return;
        }// end function

        private function onOver(event:MouseEvent) : void
        {
            ActiveTooltip.getInstance().showNewTooltip(Utility.getTooltipString(Localization.getInstance().getString(this.type)), this.bgImg);
            return;
        }// end function

        public function loadUnlockWarrior(param1:String) : void
        {
            this.type = param1;
            var _loc_2:* = ResMgr.getInstance().getMovieClip(param1 + "_Research_Icon") as Sprite;
            if (!_loc_2)
            {
                return;
            }
            _loc_2.x = (this.widthBg - _loc_2.width) / 2;
            _loc_2.y = (this.heightBg - _loc_2.height) / 2;
            this.bgImg.addChild(_loc_2);
            this.labelIncreaseIndex.visible = false;
            return;
        }// end function

    }
}
