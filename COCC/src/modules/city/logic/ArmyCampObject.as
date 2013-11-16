package modules.city.logic
{
    import __AS3__.vec.*;
    import component.avatar.controls.*;
    import flash.geom.*;
    import gameData.*;
    import modules.city.*;
    import modules.city.graphics.build.*;
    import resMgr.*;
    import resMgr.data.*;

    public class ArmyCampObject extends MapObject
    {
        public var info:DataArmyCamp;
        private var objConf:Object;
        public var statusIcon:GuiStatusBuilding;

        public function ArmyCampObject()
        {
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getArmyCampData(level);
            width = this.info.width;
            height = this.info.height;
            this.objConf = JsonMgr.getInstance().getArmyCampData(level);
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().armyCamp[type][(level + 1)]["buildTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            return;
        }// end function

        override public function loadAvatar() : void
        {
            super.loadAvatar();
            this.statusIcon = new GuiStatusBuilding();
            var _loc_1:* = (-this.statusIcon.widthBg) / 2;
            var _loc_2:* = -avatar.height - this.statusIcon.heightBg / 2;
            this.statusIcon.setPos(_loc_1, _loc_2);
            this.statusIcon.hide();
            switch(level)
            {
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                case 4:
                case 5:
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

        override public function addToCity(param1:Boolean = false) : void
        {
            super.addToCity(param1);
            if (status != BUILDING)
            {
                this.addeffectFire();
            }
            return;
        }// end function

        private function addeffectFire() : void
        {
            switch(level)
            {
                case 1:
                {
                    CityMgr.getInstance().effectList.push(EffectDraw.play("armycam_1", new Point(0, -20), avatar, 0));
                    break;
                }
                case 2:
                case 3:
                case 4:
                case 5:
                {
                    CityMgr.getInstance().effectList.push(EffectDraw.play("armycam_2", new Point(0, 0), avatar, 0));
                    break;
                }
                case 6:
                {
                    CityMgr.getInstance().effectList.push(EffectDraw.play("armycamp_puplefire", new Point(0, -20), avatar, 0));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function upgradeAvatar() : void
        {
            super.upgradeAvatar();
            this.addeffectFire();
            return;
        }// end function

        public function showStatusIcon(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (GlobalVar.state != GlobalVar.STATE_MYHOME)
            {
                return;
            }
            if (param1 == GuiStatusBuilding.NONE)
            {
                this.statusIcon.hide();
            }
            else
            {
                if (status != PRODUCING)
                {
                    return;
                }
                _loc_2 = avatar.x - this.statusIcon.widthBg / 2;
                _loc_3 = avatar.y - avatarHeight - this.statusIcon.heightBg / 2;
                this.statusIcon.setPos(_loc_2, _loc_3);
                this.statusIcon.setStatus(param1);
                this.statusIcon.show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_INFO));
            }
            return;
        }// end function

        override public function hide() : void
        {
            super.hide();
            if (statusBar.isShowing)
            {
                statusBar.hide();
            }
            if (this.statusIcon.isShowing)
            {
                this.statusIcon.hide();
            }
            return;
        }// end function

        override public function setPos(param1:int, param2:int) : void
        {
            super.setPos(param1, param2);
            if (CityMgr.getInstance().guiMainTop.isFull)
            {
                this.showStatusIcon(GuiStatusBuilding.FULL);
            }
            return;
        }// end function

        override public function finishBuilding(param1:int) : void
        {
            super.finishBuilding(param1);
            CityMgr.getInstance().guiMainTop.updateTotalTroop();
            var _loc_2:* = GameDataMgr.getInstance().barrackList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3].isStopped = false;
                _loc_3++;
            }
            return;
        }// end function

        override public function showStatusBar() : void
        {
            super.showStatusBar();
            if (status != PRODUCING)
            {
                this.statusIcon.hide();
            }
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            if (this.statusIcon)
            {
                this.statusIcon.destroyBaseGUI();
                this.statusIcon = null;
            }
            return;
        }// end function

    }
}
