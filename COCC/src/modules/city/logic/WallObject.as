package modules.city.logic
{
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.city.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class WallObject extends MapObject
    {
        public var info:DataWall;
        public var curP:Point;

        public function WallObject()
        {
            this.curP = new Point();
            type = BuildingType.WALL;
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getWallData(level);
            width = this.info.width;
            height = this.info.height;
            return;
        }// end function

        public function updateStatus() : void
        {
            if (MapMgr.getInstance().cityMap.getIsoType(posX, (posY - 1)) == BaseMap.IS_WALL && MapMgr.getInstance().cityMap.getIsoType((posX - 1), posY) == BaseMap.IS_WALL)
            {
                avatar.setAction(AnConst.STAND, 8);
            }
            else if (MapMgr.getInstance().cityMap.getIsoType((posX - 1), posY) == BaseMap.IS_WALL)
            {
                avatar.setAction(AnConst.STAND, 7);
            }
            else if (MapMgr.getInstance().cityMap.getIsoType(posX, (posY - 1)) == BaseMap.IS_WALL)
            {
                avatar.setAction(AnConst.STAND, 6);
            }
            else
            {
                avatar.setAction(AnConst.STAND, 5);
            }
            this.curP.x = avatar.x;
            this.curP.y = avatar.y;
            return;
        }// end function

        public function checkMax() : void
        {
            var _loc_1:* = Utility.getInfoToBuild(type, 1);
            if (_loc_1.curCount >= _loc_1.maxCount)
            {
                CityMgr.getInstance().guiNotify.addNewNotify(Localization.getInstance().getString("ReachMaxWallCapacity"));
                CityMgr.getInstance().guiBuildingAction.hide();
            }
            else
            {
                CityMgr.getInstance().addShopIconToMouse(type);
            }
            return;
        }// end function

        public function finishUpgrade() : void
        {
            finishBuilding(1);
            this.updateStatus();
            GameDataMgr.getInstance().freeBuilder(autoId);
            EffectDraw.play("construct_levelup", new Point(bgImage.x + MapMgr.getInstance().cityMap.MaxHalfWidth, bgImage.y + MapMgr.getInstance().cityMap.MaxHalfHeight), LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME));
            if (imgTooltip)
            {
                imgTooltip = null;
                imgTooltip = Utility.getTooltipMapObject(type, level);
            }
            return;
        }// end function

        public function effectHideWall() : void
        {
            if (avatar.anSetting.currAction == AnConst.STAND)
            {
                avatar.addFrameScript();
                avatar.setAction(AnConst.RUN, avatar.anSetting.currDir, 1, 2);
                avatar.anSetting.currFrame = 0;
            }
            return;
        }// end function

        public function onCompleteTween() : void
        {
            if (avatar == null)
            {
                return;
            }
            avatar.addFrameScript();
            return;
        }// end function

        override public function showSelected() : void
        {
            super.showSelected();
            if (avatar.anSetting.currAction == AnConst.RUN)
            {
                avatar.addFrameScript();
                avatar.setAction(AnConst.STAND, avatar.anSetting.currDir);
                avatar.anSetting.currFrame = 0;
            }
            return;
        }// end function

    }
}
