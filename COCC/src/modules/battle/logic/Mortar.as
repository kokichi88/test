package modules.battle.logic
{
    import component.avatar.model.animation.*;
    import flash.geom.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;

    public class Mortar extends HouseDefenses
    {

        public function Mortar()
        {
            numFrameAttack = 3 * DELAY_FRAME;
            return;
        }// end function

        override public function create(param1:String, param2:String, param3:int) : void
        {
            super.create(param1, param2, param3);
            progressHp.y = progressHp.y - 70;
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            curFrameAttack = 0;
            if (curTarget && curTarget.avatar)
            {
                hasBullet = true;
                bullet = new Bullet();
                bullet.setType(Bullet.MORTAR);
                bullet.baseInfo.damagePerAttack = this.baseInfo.damagePerAttack;
                bullet.curTarget = this.curTarget;
                bullet.team = this.team;
                bullet.radius = this.baseInfo.attackRadius;
                bullet.listAreaTargets = this.listAreaTargets;
                bullet.fire(this.move.getPoint(), curTarget.move.getPoint(), numFrameAttack);
                BattleModule.getInstance().battleData.addObj(bullet);
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
                    _loc_1.x = avatar.x;
                    _loc_1.y = avatar.y - 115;
                    break;
                }
                case 2:
                {
                    _loc_1.x = avatar.x + 37;
                    _loc_1.y = avatar.y - 115;
                    break;
                }
                case 3:
                {
                    _loc_1.x = avatar.x + 40;
                    _loc_1.y = avatar.y - 100;
                    break;
                }
                case 4:
                {
                    _loc_1.x = avatar.x + 20;
                    _loc_1.y = avatar.y - 85;
                    break;
                }
                case 5:
                {
                    _loc_1.x = avatar.x;
                    _loc_1.y = avatar.y - 80;
                    break;
                }
                case 6:
                {
                    _loc_1.x = avatar.x - 20;
                    _loc_1.y = avatar.y - 85;
                    break;
                }
                case 7:
                {
                    _loc_1.x = avatar.x - 40;
                    _loc_1.y = avatar.y - 100;
                    break;
                }
                case 8:
                {
                    _loc_1.x = avatar.x - 37;
                    _loc_1.y = avatar.y - 115;
                    break;
                }
                default:
                {
                    break;
                }
            }
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

        public function showBullet() : void
        {
            var _loc_1:Layer = null;
            if (!hasBullet)
            {
                return;
            }
            hasBullet = false;
            if (bullet && bullet.arrow && curTarget.avatar)
            {
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_1.addChild(bullet.arrow);
                bullet.playEffect(curDir, this.getSourcePoint(), new Point(curTarget.avatar.x, curTarget.avatar.y));
            }
            return;
        }// end function

    }
}
