package modules.battle.logic
{
    import component.avatar.model.animation.*;
    import flash.geom.*;
    import map.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;
    import resMgr.data.*;

    public class HouseDefenses extends DataHouse
    {
        public var bullet:Bullet;

        public function HouseDefenses()
        {
            objectType = DataObject.OBJTYPE_DEFENSES;
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getDefensesData(param1, param2);
            baseInfo.setDefensesInfo(_loc_3);
            baseInfo.id = param1;
            baseInfo.level = param2;
            if (numFrameAttack == 0)
            {
                numFrameAttack = 3;
            }
            super.setInfo(param1, param2);
            avatar.addShadow(param1, param2);
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Point = null;
            var _loc_2:Number = NaN;
            if (mapObject.status == 1)
            {
                return;
            }
            super.loop();
            if (curTarget && this.objectStatus == AnConst.ATTACK)
            {
                if (curLoopAttack < numLoopAttack)
                {
                    var _loc_4:* = curLoopAttack + 1;
                    curLoopAttack = _loc_4;
                }
                else if (curTarget.objectStatus == AnConst.DIE)
                {
                    setAction(AnConst.STAND, curDir);
                    this.findTarget();
                }
                else
                {
                    _loc_1 = MapMgr.getInstance().battleMap.cellToPoint(curTarget.getCurCell());
                    _loc_2 = (move.x - _loc_1.x) * (move.x - _loc_1.x) + (move.y - _loc_1.y) * (move.y - _loc_1.y);
                    if (_loc_2 > baseInfo.attackRange * baseInfo.attackRange)
                    {
                        this.findTarget();
                        return;
                    }
                    if (baseInfo.minAttackRange > 0)
                    {
                        if (_loc_2 < baseInfo.minAttackRange * baseInfo.minAttackRange)
                        {
                            this.findTarget();
                        }
                        else
                        {
                            beginAttackTarget();
                        }
                    }
                    else
                    {
                        beginAttackTarget();
                    }
                }
            }
            else if (objId % COUNT_DOWN_FIND_TARGET == BattleModule.getInstance().curLoop % COUNT_DOWN_FIND_TARGET)
            {
                this.findTarget();
            }
            return;
        }// end function

        override public function findTarget() : void
        {
            curTarget = MapMgr.getInstance().findNearestTargetInRange(this);
            if (curTarget)
            {
                beginAttackTarget();
            }
            return;
        }// end function

    }
}
