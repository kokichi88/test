package modules.battle.logic
{
    import __AS3__.vec.*;
    import component.avatar.model.animation.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;

    public class Giant extends DataTroop
    {

        public function Giant()
        {
            numFrameAttack = 8 * DataObject.DELAY_FRAME;
            return;
        }// end function

        override public function loop() : void
        {
            super.loop();
            if (curTarget && this.objectStatus == AnConst.ATTACK)
            {
                var _loc_2:* = curFrameAttack + 1;
                curFrameAttack = _loc_2;
                if (curFrameAttack == numFrameAttack)
                {
                    curTarget.onDealDamage(this);
                }
            }
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            hasBullet = true;
            curFrameAttack = 0;
            return;
        }// end function

        override public function findTarget() : void
        {
            var _loc_3:Vector.<int> = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Vector2D = null;
            var _loc_7:DataObject = null;
            var _loc_1:* = new Vector.<int>;
            var _loc_2:* = int.MAX_VALUE;
            curTarget = null;
            finalTarget = null;
            curTarget = MapMgr.getInstance().findNearestTarget(this, OBJTYPE_DEFENSES);
            if (curTarget)
            {
                if (deepLevel < 2)
                {
                    _loc_1 = getPath(curTarget, 0, BaseMap.IS_WALL);
                }
                _loc_3 = getPath(curTarget, _loc_1.length);
                if (deepLevel < 2 && (_loc_3.length <= 0 || _loc_3.length > _loc_1.length + BaseMap.BONUS_WALL))
                {
                    _loc_3 = new Vector.<int>;
                    finalTarget = curTarget;
                    curTarget = null;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_1.length)
                    {
                        
                        _loc_5 = _loc_1[_loc_4];
                        _loc_3.push(_loc_5);
                        _loc_6 = MapMgr.getInstance().battleMap.cellToIso(_loc_5);
                        _loc_6.x = int(_loc_6.x / 3) * 3;
                        _loc_6.y = int(_loc_6.y / 3) * 3;
                        _loc_5 = MapMgr.getInstance().battleMap.isoToCell(_loc_6.x, _loc_6.y);
                        _loc_7 = BattleModule.getInstance().battleData.getObjectCell(_loc_5);
                        if (_loc_7 && _loc_7.objectType == DataObject.OBJTYPE_WALL)
                        {
                            curTarget = _loc_7;
                            moveToPath(_loc_3);
                            break;
                        }
                        _loc_4++;
                    }
                }
                else
                {
                    moveToPath(_loc_3);
                }
            }
            super.findTarget();
            return;
        }// end function

    }
}
