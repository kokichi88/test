package modules.battle.logic
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import map.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;

    public class Balloon extends DataTroop
    {
        private var bullet:Bullet;

        public function Balloon()
        {
            objectArea = DataObject.AREA_AIR;
            deepLevel = 2;
            numFrameAttack = 0;
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            if (curTarget && curTarget.avatar)
            {
                this.bullet = new Bullet();
                this.bullet.setType(Bullet.BALLOON);
                this.bullet.baseInfo.damagePerAttack = this.baseInfo.damagePerAttack;
                this.bullet.curTarget = this.curTarget;
                this.bullet.team = this.team;
                this.bullet.radius = this.baseInfo.attackRadius;
                this.bullet.listAreaTargets = this.listAreaTargets;
                this.bullet.fire(this.move.getPoint(), curTarget.move.getPoint());
                BattleModule.getInstance().battleData.addObj(this.bullet);
                this.showBullet();
            }
            return;
        }// end function

        override public function loop() : void
        {
            super.loop();
            return;
        }// end function

        public function showBullet() : void
        {
            var _loc_1:Layer = null;
            if (this.bullet && this.bullet.arrow && curTarget.avatar)
            {
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_1.addChild(this.bullet.arrow);
                this.bullet.playEffect(curDir, this.getSourcePoint(), new Point(curTarget.avatar.x, curTarget.avatar.y));
                this.bullet.arrow.visible = false;
            }
            return;
        }// end function

        private function getSourcePoint() : Point
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
                    _loc_1.y = avatar.y - 2 * avatar.height / 3;
                    break;
                }
                case 2:
                {
                    _loc_1.x = avatar.x + 50;
                    _loc_1.y = avatar.y - 2 * avatar.height / 3;
                    break;
                }
                case 3:
                {
                    _loc_1.x = avatar.x + 50;
                    _loc_1.y = avatar.y - avatar.height / 2;
                    break;
                }
                case 4:
                {
                    _loc_1.x = avatar.x + 35;
                    _loc_1.y = avatar.y - avatar.height / 3;
                    break;
                }
                case 5:
                {
                    _loc_1.x = avatar.x + 10;
                    _loc_1.y = avatar.y - avatar.height / 3;
                    break;
                }
                case 6:
                {
                    _loc_1.x = avatar.x - 15;
                    _loc_1.y = avatar.y - avatar.height / 3;
                    break;
                }
                case 7:
                {
                    _loc_1.x = avatar.x - 35;
                    _loc_1.y = avatar.y - 5 * avatar.height / 12;
                    break;
                }
                case 8:
                {
                    _loc_1.x = avatar.x - 35;
                    _loc_1.y = avatar.y - avatar.height / 2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        override public function findTarget() : void
        {
            var _loc_3:Vector.<int> = null;
            var _loc_1:* = new Vector.<int>;
            var _loc_2:* = int.MAX_VALUE;
            curTarget = null;
            curTarget = MapMgr.getInstance().findNearestTarget(this, OBJTYPE_DEFENSES);
            if (curTarget)
            {
                _loc_3 = getPath(curTarget, 0);
                moveToPath(_loc_3);
            }
            super.findTarget();
            return;
        }// end function

    }
}
