package modules.city.logic
{
    import modules.battle.logic.bean.*;
    import modules.city.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class TrapObject extends MapObject
    {
        public var info:DataTrap;
        private var hasAttackRange:Boolean = false;

        public function TrapObject()
        {
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getTrapData(type);
            width = this.info.width;
            height = this.info.height;
            return;
        }// end function

        public function checkMax() : void
        {
            var _loc_2:String = null;
            var _loc_1:* = Utility.getInfoToBuild(type, 1);
            if (_loc_1.curCount >= _loc_1.maxCount)
            {
                _loc_2 = Localization.getInstance().getString("ReachMaxBuildingCapacity");
                _loc_2 = _loc_2.replace("@name", Localization.getInstance().getString(type));
                CityMgr.getInstance().guiNotify.addNewNotify(_loc_2);
                CityMgr.getInstance().guiBuildingAction.hide();
            }
            else
            {
                CityMgr.getInstance().addShopIconToMouse(type);
            }
            return;
        }// end function

        override public function showSelected() : void
        {
            super.showSelected();
            this.showAttackRange();
            return;
        }// end function

        override public function hideSelected() : void
        {
            super.hideSelected();
            this.hideAttackRange();
            return;
        }// end function

        public function showAttackRange() : void
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            this.hasAttackRange = true;
            _loc_1.showAttackRange(avatar, this.info.triggerRadius * BaseInfo.WIDTH_CELL * BaseInfo.SCALE_MAP);
            return;
        }// end function

        public function hideAttackRange(param1:Boolean = true) : void
        {
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            this.hasAttackRange = false;
            _loc_2.hideAttackRange(param1);
            return;
        }// end function

        override public function hide() : void
        {
            super.hide();
            this.hideAttackRange(false);
            return;
        }// end function

    }
}
