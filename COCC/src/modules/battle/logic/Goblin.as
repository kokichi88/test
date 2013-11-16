package modules.battle.logic
{
    import __AS3__.vec.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;

    public class Goblin extends DataTroop
    {

        public function Goblin()
        {
            objectType = DataObject.OBJTYPE_TROOP;
            numFrameAttack = 15 * DataObject.DELAY_FRAME;
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            var _loc_1:Number = 0;
            if (curTarget.objectType == OBJTYPE_RESOURCES)
            {
                _loc_1 = baseInfo.damagePerAttack * baseInfo.dmgScale;
            }
            else
            {
                _loc_1 = baseInfo.damagePerAttack;
            }
            curTarget.onDealDamage(this, _loc_1);
            return;
        }// end function

        override public function findTarget() : void
        {
            var _loc_1:Vector.<int> = null;
            var _loc_2:Vector.<int> = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Vector2D = null;
            var _loc_6:DataObject = null;
            _loc_1 = new Vector.<int>;
            curTarget = null;
            finalTarget = null;
            curTarget = MapMgr.getInstance().findNearestTarget(this, OBJTYPE_RESOURCES);
            if (curTarget)
            {
                if (deepLevel < 2)
                {
                    _loc_1 = getPath(curTarget, 0, BaseMap.IS_WALL);
                }
                _loc_2 = getPath(curTarget, _loc_1.length);
                if (deepLevel < 2 && (_loc_2.length <= 0 || _loc_2.length > _loc_1.length + BaseMap.BONUS_WALL))
                {
                    finalTarget = curTarget;
                    curTarget = null;
                    _loc_2 = new Vector.<int>;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_1.length)
                    {
                        
                        _loc_4 = _loc_1[_loc_3];
                        _loc_2.push(_loc_4);
                        _loc_5 = MapMgr.getInstance().battleMap.cellToIso(_loc_4);
                        _loc_5.x = int(_loc_5.x / 3) * 3;
                        _loc_5.y = int(_loc_5.y / 3) * 3;
                        _loc_4 = MapMgr.getInstance().battleMap.isoToCell(_loc_5.x, _loc_5.y);
                        _loc_6 = BattleModule.getInstance().battleData.getObjectCell(_loc_4);
                        if (_loc_6 && _loc_6.objectType == DataObject.OBJTYPE_WALL)
                        {
                            curTarget = _loc_6;
                            moveToPath(_loc_2);
                            break;
                        }
                        _loc_3++;
                    }
                }
                else
                {
                    moveToPath(_loc_2);
                }
            }
            super.findTarget();
            return;
        }// end function

    }
}
