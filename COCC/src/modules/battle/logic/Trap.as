package modules.battle.logic
{
    import __AS3__.vec.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import modules.battle.*;
    import modules.sound.*;
    import resMgr.*;
    import resMgr.data.*;

    public class Trap extends DataHouse
    {

        public function Trap()
        {
            objectType = DataObject.OBJTYPE_TRAP;
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getTrapData(param1);
            baseInfo.setTrapInfo(_loc_3);
            baseInfo.id = param1;
            baseInfo.level = param2;
            super.setInfo(param1, param2);
            avatar.addShadow(param1, param2);
            avatar.visible = false;
            numLoopAttack = baseInfo.attackSpeed;
            numFrameAttack = 5;
            return;
        }// end function

        override public function updatePosAvatar() : void
        {
            super.updatePosAvatar();
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Layer = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            super.loop();
            if (objectStatus == AnConst.ATTACK)
            {
                var _loc_5:* = curLoopAttack + 1;
                curLoopAttack = _loc_5;
                if (mapObject.type == BuildingType.TRA_2 && curLoopAttack == numLoopAttack - numFrameAttack)
                {
                    _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_EFFECT);
                    _loc_2 = avatar.parent.getChildIndex(avatar);
                    EffectDraw.play("landtrap", new Point(avatar.x + 8, avatar.y - 15), _loc_1, -1);
                    avatar.addFrameScript();
                }
                if (curLoopAttack == numLoopAttack)
                {
                    this.explosion();
                }
            }
            else
            {
                _loc_3 = COUNT_DOWN_FIND_TARGET / 5;
                if (objId % _loc_3 == BattleModule.getInstance().curLoop % _loc_3)
                {
                    this.findTarget();
                }
            }
            return;
        }// end function

        private function explosion() : void
        {
            var _loc_5:Layer = null;
            var _loc_1:* = this.baseInfo.attackRadius;
            var _loc_2:* = MapMgr.getInstance().getObjectInAreaByType(this, this.move.getPoint(), _loc_1, DataObject.OBJTYPE_TROOP, this.objectArea);
            var _loc_3:Boolean = false;
            if (baseInfo.numHousingSpace > 0)
            {
                _loc_3 = true;
            }
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                if (_loc_3)
                {
                    if (baseInfo.numHousingSpace <= 0)
                    {
                    }
                    baseInfo.numHousingSpace = baseInfo.numHousingSpace - _loc_2[_loc_4].baseInfo.numHousingSpace;
                }
                _loc_2[_loc_4].onDealDamage(this);
                _loc_4++;
            }
            if (mapObject.type != BuildingType.TRA_2)
            {
                _loc_5 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                EffectDraw.play("explosion_1", new Point(avatar.x, avatar.y), _loc_5);
            }
            else
            {
                SoundModule.getInstance().playSound(SoundModule.PUNCHTRAP_ACTIVE);
            }
            death();
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            numLoopAttack = this.baseInfo.attackSpeed;
            curLoopAttack = 0;
            objectStatus = AnConst.ATTACK;
            avatar.visible = true;
            if (mapObject.type == BuildingType.TRA_2)
            {
                setAction(AnConst.ATTACK, avatar.anSetting.currDir);
                avatar.anSetting.currFrame = 0;
                avatar.frameScript();
                avatar.removeFrameScript();
            }
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
