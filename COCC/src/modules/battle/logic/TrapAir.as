package modules.battle.logic
{
    import __AS3__.vec.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import map.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;
    import resMgr.data.*;

    public class TrapAir extends DataHouse
    {
        private var typeTrap:int = 0;

        public function TrapAir()
        {
            objectType = DataObject.OBJTYPE_TRAP;
            deepLevel = 3;
            listAreaTargets = new Vector.<int>;
            listAreaTargets.push(DataObject.AREA_AIR);
            baseInfo.moveSpeed = 6 * GlobalVar.stage.frameRate;
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_3:* = param1.split("_");
            this.typeTrap = _loc_3[1];
            var _loc_4:* = JsonMgr.getInstance().getTrapData(param1);
            baseInfo.setTrapInfo(_loc_4);
            baseInfo.id = param1;
            baseInfo.level = param2;
            super.setInfo(param1, param2);
            avatar.addShadow(param1, param2);
            avatar.visible = false;
            return;
        }// end function

        override public function updatePosAvatar() : void
        {
            super.updatePosAvatar();
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Vector.<int> = null;
            var _loc_2:Point = null;
            var _loc_3:AniEffect = null;
            var _loc_4:AniEffect = null;
            var _loc_5:Number = NaN;
            var _loc_6:Point = null;
            var _loc_7:int = 0;
            super.loop();
            if (objectStatus == AnConst.ATTACK)
            {
                var _loc_9:* = curLoopAttack + 1;
                curLoopAttack = _loc_9;
                if (curLoopAttack == numLoopAttack)
                {
                    _loc_1 = getPath(curTarget, 0, 10);
                    moveToPath(_loc_1);
                    _loc_2 = new Point(0, -150);
                    _loc_3 = EffectDraw.play("airboom", _loc_2, avatar, 0);
                    _loc_4 = EffectDraw.play("airboom", new Point(0, 0), avatar, 0);
                    aniEffects.push(_loc_3);
                    aniEffects.push(_loc_4);
                }
                return;
            }
            if (objectStatus == AnConst.RUN)
            {
                move.updateLogic();
                avatar.x = move.x;
                avatar.y = move.y;
                if (avatar.anSetting.currDir != move.dir)
                {
                    avatar.anSetting.currDir = move.dir;
                }
                if (this.objectStatus != AnConst.DIE)
                {
                    _loc_5 = new Number();
                    _loc_6 = MapMgr.getInstance().battleMap.cellToPoint(desCell);
                    _loc_5 = (move.x - _loc_6.x) * (move.x - _loc_6.x) + (move.y - _loc_6.y) * (move.y - _loc_6.y);
                    if (_loc_5 <= BaseInfo.WIDTH_CELL * BaseInfo.WIDTH_CELL / 4)
                    {
                        this.explosion();
                    }
                }
                if (curTarget && curTarget is DataTroop)
                {
                    var _loc_9:* = numFindTarget - 1;
                    numFindTarget = _loc_9;
                    if (numFindTarget < 0)
                    {
                        this.findTarget();
                        if (curTarget && curTarget.objectStatus != AnConst.DIE)
                        {
                            _loc_1 = getPath(curTarget, 0);
                            moveToPath(_loc_1);
                        }
                        numFindTarget = COUNT_DOWN_FIND_TARGET * 2;
                    }
                }
            }
            else
            {
                _loc_7 = COUNT_DOWN_FIND_TARGET / 5;
                if (objId % _loc_7 == BattleModule.getInstance().curLoop % _loc_7)
                {
                    this.findTarget();
                }
            }
            return;
        }// end function

        private function explosion() : void
        {
            var _loc_5:int = 0;
            var _loc_1:* = this.baseInfo.attackRadius;
            var _loc_2:* = MapMgr.getInstance().getObjectInAreaByType(this, this.move.getPoint(), _loc_1, DataObject.OBJTYPE_TROOP, this.objectArea);
            var _loc_3:Boolean = false;
            if (baseInfo.numHousingSpace > 0)
            {
                _loc_3 = true;
            }
            if (_loc_1 == 0)
            {
                if (curTarget && curTarget.objectStatus != AnConst.DIE)
                {
                    curTarget.onDealDamage(this);
                }
            }
            else
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_2.length)
                {
                    
                    if (_loc_3)
                    {
                        if (baseInfo.numHousingSpace <= 0)
                        {
                        }
                        baseInfo.numHousingSpace = baseInfo.numHousingSpace - _loc_2[_loc_5].baseInfo.numHousingSpace;
                    }
                    _loc_2[_loc_5].onDealDamage(this);
                    _loc_5++;
                }
            }
            var _loc_4:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            EffectDraw.play("explosion_1", new Point(avatar.x, avatar.y), _loc_4);
            this.death();
            return;
        }// end function

        override public function death() : void
        {
            super.death();
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            avatar.visible = true;
            numLoopAttack = this.baseInfo.attackSpeed;
            curLoopAttack = 0;
            objectStatus = AnConst.ATTACK;
            setAction(AnConst.ATTACK, 5, 1);
            return;
        }// end function

        override public function findTarget() : void
        {
            curTarget = MapMgr.getInstance().findNearestTargetInRange(this);
            if (curTarget)
            {
                this.beginAttackTarget();
            }
            return;
        }// end function

    }
}
