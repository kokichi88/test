package modules.city.logic
{
    import component.avatar.model.animation.*;
    import gameData.*;
    import modules.battle.logic.bean.*;
    import modules.feed.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class DefenseObject extends MapObject
    {
        public var info:DataDefenses;
        private var hasAttackRange:Boolean = false;

        public function DefenseObject()
        {
            return;
        }// end function

        override public function loadConfigData() : void
        {
            this.info = JsonMgr.getInstance().getDefensesData(type, level);
            width = this.info.width;
            height = this.info.height;
            if ((level + 1) <= JsonMgr.getInstance().getConfigMaxLevel(type))
            {
                buildTimeNextLevel = JsonMgr.getInstance().defense[type][(level + 1)]["upgradeTime"];
            }
            else
            {
                buildTimeNextLevel = 0;
            }
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:int = 0;
            var _loc_3:* = countDownRun - 1;
            countDownRun = _loc_3;
            if (countDownRun <= 0)
            {
                _loc_1 = avatar.anSetting.currDir;
                if (_loc_1 <= 4)
                {
                    _loc_1 = _loc_1 - 1;
                    if (_loc_1 < 2)
                    {
                        _loc_1 = 5;
                    }
                }
                else
                {
                    _loc_1++;
                    if (_loc_1 > 8)
                    {
                        _loc_1 = 4;
                    }
                }
                avatar.addFrameScript();
                avatar.setAction(AnConst.RUN, _loc_1, 1, 4);
                avatar.anSetting.currFrame = 0;
                countDownRun = NUM_LOOP_RUN + Utility.randomNumber(-30, 30);
            }
            super.loop();
            return;
        }// end function

        override public function loadAvatar() : void
        {
            var _loc_1:* = type;
            super.loadAvatar();
            avatar.addShadow(type, level);
            avatar.updatefrs(4);
            var _loc_2:* = Utility.randomNumber(1, 8);
            avatar.setAction(AnConst.RUN, _loc_2, 1, 4);
            countDownRun = NUM_LOOP_RUN + Utility.randomNumber(-30, 30);
            return;
        }// end function

        public function loadMouseAvatar() : void
        {
            super.loadAvatar();
            avatar.addShadow(type, level);
            avatar.setAction(AnConst.STAND, 5);
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
            _loc_1.showAttackRange(avatar, this.info.maxRange * BaseInfo.WIDTH_CELL * BaseInfo.SCALE_MAP, this.info.minRange * BaseInfo.WIDTH_CELL * BaseInfo.SCALE_MAP);
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

        override public function finishBuilding(param1:int) : void
        {
            if (status == BUILDING)
            {
                switch(type)
                {
                    case BuildingType.MOTAR:
                    {
                        FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.BUILD_DEF_3);
                        break;
                    }
                    case BuildingType.XBOW:
                    {
                        FeedMgr.getInstance().sendRequestFeedWall(FeedMgr.BUILD_DEF_6);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            super.finishBuilding(param1);
            return;
        }// end function

    }
}
