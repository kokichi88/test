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

    public class Healer extends DataTroop
    {
        private var pBullet:Object;
        private var bullet:Bullet;

        public function Healer()
        {
            this.pBullet = {1:{x:0, y:-38}, 2:{x:6, y:-48}, 3:{x:8, y:-44}, 4:{x:9, y:-36}, 5:{x:0, y:-36}, 6:{x:-9, y:-36}, 7:{x:-8, y:-44}, 8:{x:-6, y:-48}};
            objectArea = AREA_AIR;
            numFrameAttack = 4 * DataObject.DELAY_FRAME;
            deepLevel = 2;
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            if (curTarget && curTarget.baseInfo.curHp == curTarget.baseInfo.maxHp)
            {
                curFrameAttack = 0;
                refindTarget();
                if (avatar.anSetting.currAction != AnConst.STAND)
                {
                    avatar.updatefrs(DataObject.DELAY_FRAME * 2);
                    avatar.setAction(AnConst.STAND, avatar.anSetting.currDir, -1, 3);
                }
                return;
            }
            super.beginAttackTarget();
            this.createBullet();
            curFrameAttack = 0;
            return;
        }// end function

        override public function setAction(param1:int, param2:int, param3:int = -1, param4:int = 0) : void
        {
            var _loc_5:int = 0;
            objectStatus = param1;
            curDir = avatar.anSetting.currDir;
            if (avatar)
            {
                avatar.updatefrs(DataObject.DELAY_FRAME);
                _loc_5 = avatar.anSetting.currFrame;
                avatar.setAction(param1, curDir, param3, 3);
            }
            return;
        }// end function

        private function createBullet() : void
        {
            hasBullet = true;
            if (curTarget && curTarget.avatar)
            {
                this.bullet = new Bullet();
                this.bullet.setType(Bullet.HEALER);
                this.bullet.baseInfo.damagePerAttack = this.baseInfo.healsPerAttack;
                this.bullet.curTarget = this.curTarget;
                this.bullet.team = this.team;
                this.bullet.radius = this.baseInfo.attackRadius;
                this.bullet.listAreaTargets = this.listAreaTargets;
                this.bullet.fire(this.move.getPoint(), curTarget.move.getPoint(), numFrameAttack);
                BattleModule.getInstance().battleData.addObj(this.bullet);
            }
            return;
        }// end function

        private function showBullet() : void
        {
            var _loc_1:int = 0;
            var _loc_2:Layer = null;
            var _loc_3:Point = null;
            if (!hasBullet)
            {
                return;
            }
            hasBullet = false;
            if (curTarget && curTarget.avatar && this.bullet && this.bullet.arrow)
            {
                _loc_1 = avatar.parent.getChildIndex(avatar);
                _loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_2.addChildAt(this.bullet.arrow, _loc_1);
                _loc_3 = new Point(curTarget.avatar.x, curTarget.avatar.y);
                this.bullet.playEffect(curDir, this.getSourcePoint(), _loc_3);
            }
            return;
        }// end function

        private function getSourcePoint() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = avatar.x;
            _loc_1.y = avatar.y;
            var _loc_2:* = this.pBullet[avatar.anSetting.currDir];
            _loc_1.x = _loc_1.x + _loc_2["x"];
            _loc_1.y = _loc_1.y + _loc_2["y"];
            return _loc_1;
        }// end function

        private function getSourcePoint2() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = avatar.x;
            _loc_1.y = avatar.y - avatar.height / 3;
            var _loc_2:* = new Point();
            switch(avatar.anSetting.currDir)
            {
                case 1:
                {
                    _loc_1.x = avatar.x - 20;
                    _loc_1.y = avatar.y - avatar.height / 3;
                    break;
                }
                case 2:
                {
                    _loc_1.x = avatar.x + 35;
                    _loc_1.y = avatar.y - avatar.height / 3;
                    break;
                }
                case 3:
                {
                    _loc_1.x = avatar.x + 35;
                    _loc_1.y = avatar.y - avatar.height / 3;
                    break;
                }
                case 4:
                {
                    _loc_1.x = avatar.x + 35;
                    _loc_1.y = avatar.y - avatar.height / 6;
                    break;
                }
                case 5:
                {
                    _loc_1.x = avatar.x + 10;
                    _loc_1.y = avatar.y + 5;
                    break;
                }
                case 6:
                {
                    _loc_1.x = avatar.x - 35;
                    _loc_1.y = avatar.y;
                    break;
                }
                case 7:
                {
                    _loc_1.x = avatar.x - 35;
                    _loc_1.y = avatar.y - avatar.height / 9;
                    break;
                }
                case 8:
                {
                    _loc_1.x = avatar.x - 35;
                    _loc_1.y = avatar.y - avatar.height / 6;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
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
                    this.showBullet();
                }
            }
            return;
        }// end function

        override public function findTarget() : void
        {
            var _loc_4:Vector.<int> = null;
            var _loc_5:Number = NaN;
            var _loc_6:Point = null;
            var _loc_7:int = 0;
            var _loc_1:* = new Vector.<int>;
            var _loc_2:* = int.MAX_VALUE;
            var _loc_3:* = curTarget;
            curTarget = null;
            finalTarget = null;
            curTarget = MapMgr.getInstance().findNearestTarget(this, -1, true);
            if (curTarget)
            {
                _loc_4 = getPath(curTarget, 0, -1);
                _loc_5 = new Number();
                _loc_6 = MapMgr.getInstance().battleMap.cellToPoint(curTarget.getCurCell());
                _loc_5 = (move.x - _loc_6.x) * (move.x - _loc_6.x) + (move.y - _loc_6.y) * (move.y - _loc_6.y);
                if (_loc_5 < baseInfo.attackRange * baseInfo.attackRange && curTarget.baseInfo.curHp == curTarget.baseInfo.maxHp)
                {
                    if (_loc_3 == null)
                    {
                        _loc_7 = MapMgr.getInstance().cityMap.getDirToCell(MapMgr.getInstance().convertCellBattleToCellCity(this.getCurCell()), MapMgr.getInstance().convertCellBattleToCellCity(curTarget.getCurCell()));
                        move.dir = _loc_7;
                        this.setAction(AnConst.STAND, _loc_7);
                        avatar.updatefrs(DataObject.DELAY_FRAME * 2);
                    }
                    return;
                }
                moveToPath(_loc_4);
            }
            super.findTarget();
            return;
        }// end function

        override public function create(param1:String, param2:String, param3:int) : void
        {
            var _loc_4:AniEffect = null;
            super.create(param1, param2, param3);
            _loc_4 = EffectDraw.play("healeraura", new Point(0, -60), avatar, 0);
            aniEffects.push(_loc_4);
            return;
        }// end function

    }
}
