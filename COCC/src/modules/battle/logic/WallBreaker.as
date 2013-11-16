package modules.battle.logic
{
    import __AS3__.vec.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.geom.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;

    public class WallBreaker extends DataTroop
    {

        public function WallBreaker()
        {
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            var _loc_1:* = this.baseInfo.damagePerAttack;
            var _loc_2:* = this.baseInfo.attackRadius;
            if (curTarget.objectType == OBJTYPE_WALL)
            {
                _loc_1 = _loc_1 * this.baseInfo.dmgScale;
                _loc_2 = _loc_2 + 0.5 * BaseInfo.WIDTH_CELL;
                Wall(curTarget).setTypeDamage(true);
            }
            var _loc_3:* = MapMgr.getInstance().getObjectInAreaByType(this, curTarget.move.getPoint(), _loc_2, curTarget.objectType, curTarget.objectArea);
            curTarget.onDealDamage(this, _loc_1);
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (curTarget.objId == _loc_3[_loc_4].objId)
                {
                }
                else
                {
                    if (_loc_3[_loc_4] is Wall)
                    {
                        Wall(_loc_3[_loc_4]).setTypeDamage(false);
                    }
                    _loc_3[_loc_4].onDealDamage(this, _loc_1);
                }
                _loc_4++;
            }
            this.death();
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Point = null;
            var _loc_3:int = 0;
            if (this.objectStatus == AnConst.RE_FIND)
            {
                this.findTarget();
            }
            if (this.objectStatus == AnConst.STAND)
            {
                this.findTarget();
            }
            if (this.objectStatus == AnConst.RUN)
            {
                if (curTarget == null || curTarget.objectStatus == AnConst.DIE)
                {
                    this.findTarget();
                    if (curTarget == null)
                    {
                        setAction(AnConst.STAND, move.dir);
                    }
                    return;
                }
                move.updateLogic();
                if (avatar)
                {
                    avatar.x = move.x;
                    avatar.y = move.y;
                    if (avatar.anSetting.currDir != move.dir)
                    {
                        avatar.anSetting.currDir = move.dir;
                    }
                }
                if (curTarget && this.objectStatus == AnConst.RUN && this.objectStatus != AnConst.DIE && curTarget.objectStatus != AnConst.DIE)
                {
                    _loc_1 = new Number();
                    _loc_2 = MapMgr.getInstance().battleMap.cellToPoint(desCell);
                    _loc_1 = (move.x - _loc_2.x) * (move.x - _loc_2.x) + (move.y - _loc_2.y) * (move.y - _loc_2.y);
                    if (_loc_1 <= baseInfo.attackRange * baseInfo.attackRange)
                    {
                        _loc_3 = MapMgr.getInstance().cityMap.getDirToCell(MapMgr.getInstance().convertCellBattleToCellCity(this.getCurCell()), MapMgr.getInstance().convertCellBattleToCellCity(curTarget.getCurCell()));
                        move.dir = _loc_3;
                        numLoopAttack = this.baseInfo.attackSpeed;
                        curLoopAttack = 5;
                        setAction(AnConst.ATTACK, _loc_3, 1);
                    }
                }
                if (team == 2)
                {
                    checkWall();
                }
                if (curTarget is DataTroop)
                {
                    var _loc_5:* = numFindTarget - 1;
                    numFindTarget = _loc_5;
                    if (numFindTarget < 0)
                    {
                        this.findTarget();
                        numFindTarget = COUNT_DOWN_FIND_TARGET * 2;
                    }
                }
            }
            if (curTarget && this.objectStatus == AnConst.ATTACK)
            {
                if (curLoopAttack < numLoopAttack)
                {
                    var _loc_5:* = curLoopAttack + 1;
                    curLoopAttack = _loc_5;
                }
                else if (curTarget.objectStatus == AnConst.DIE)
                {
                    setAction(AnConst.STAND, avatar.anSetting.currDir);
                    this.findTarget();
                }
                else
                {
                    this.beginAttackTarget();
                }
            }
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
            curTarget = MapMgr.getInstance().findWallNearest(this, OBJTYPE_WALL);
            if (curTarget == null)
            {
                curTarget = MapMgr.getInstance().findNearestTarget(this, OBJTYPE_WALL);
            }
            if (curTarget)
            {
                if (deepLevel < 2)
                {
                    _loc_1 = getPath(curTarget, 0, BaseMap.IS_WALL);
                }
                _loc_3 = getPath(curTarget, _loc_1.length);
                if (deepLevel < 2 && (_loc_3.length <= 0 || _loc_3.length > _loc_1.length + BaseMap.BONUS_WALL))
                {
                    curTarget = null;
                    _loc_3 = new Vector.<int>;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_1.length)
                    {
                        
                        _loc_5 = _loc_1[_loc_4];
                        _loc_3.push(_loc_5);
                        _loc_6 = MapMgr.getInstance().battleMap.cellToIso(_loc_5);
                        _loc_6.x = int(_loc_6.x / 3) * 3;
                        _loc_6.y = int(_loc_6.y / 3) * 3;
                        _loc_5 = MapMgr.getInstance().battleMap.isoToCell(_loc_6.x, _loc_6.y);
                        if (MapMgr.getInstance().battleMap.getCellType(_loc_5) == BaseMap.IS_WALL)
                        {
                            _loc_7 = BattleModule.getInstance().battleData.getObjectCell(_loc_5);
                            if (_loc_7 && _loc_7.objectType == DataObject.OBJTYPE_WALL)
                            {
                                curTarget = _loc_7;
                                moveToPath(_loc_3);
                                break;
                            }
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

        override public function death() : void
        {
            var _loc_1:Layer = null;
            if (avatar)
            {
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                EffectDraw.play("explosion_1", new Point(avatar.x, avatar.y), _loc_1);
            }
            super.death();
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            return;
        }// end function

    }
}
