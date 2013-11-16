package modules.battle.logic
{
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import map.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;

    public class Cannon extends HouseDefenses
    {
        private var rotations:Object;
        private var pBullet:Object;

        public function Cannon()
        {
            this.rotations = {1:90, 2:135, 3:180, 4:-135, 5:-90, 6:-45, 7:0, 8:45};
            this.pBullet = {1:{1:{x:0, y:-79}, 2:{x:50, y:-60}, 3:{x:66, y:-23}, 4:{x:47, y:12}, 5:{x:0, y:25}, 6:{x:-47, y:12}, 7:{x:-66, y:-23}, 8:{x:-50, y:-60}}, 2:{1:{x:0, y:-88}, 2:{x:50, y:-70}, 3:{x:63, y:-36}, 4:{x:45, y:3}, 5:{x:0, y:11}, 6:{x:-45, y:3}, 7:{x:-63, y:-36}, 8:{x:-50, y:-70}}, 3:{1:{x:0, y:-108}, 2:{x:61, y:-92}, 3:{x:83, y:-46}, 4:{x:58, y:-4}, 5:{x:0, y:15}, 6:{x:-58, y:-4}, 7:{x:-83, y:-46}, 8:{x:-61, y:-92}}, 4:{1:{x:0, y:-103}, 2:{x:51, y:-84}, 3:{x:67, y:-45}, 4:{x:47, y:-11}, 5:{x:0, y:3}, 6:{x:-47, y:-11}, 7:{x:-67, y:-45}, 8:{x:-51, y:-84}}, 5:{1:{x:0, y:-103}, 2:{x:54, y:-85}, 3:{x:70, y:-45}, 4:{x:48, y:-9}, 5:{x:0, y:6}, 6:{x:-48, y:-9}, 7:{x:-70, y:-45}, 8:{x:-54, y:-85}}, 6:{1:{x:0, y:-131}, 2:{x:86, y:-101}, 3:{x:116, y:-37}, 4:{x:82, y:24}, 5:{x:0, y:47}, 6:{x:-82, y:24}, 7:{x:-116, y:-37}, 8:{x:-86, y:-101}}, 7:{1:{x:0, y:-137}, 2:{x:87, y:-106}, 3:{x:135, y:-45}, 4:{x:85, y:16}, 5:{x:0, y:41}, 6:{x:-86, y:16}, 7:{x:-135, y:-45}, 8:{x:-87, y:-106}}, 8:{1:{x:0, y:-138}, 2:{x:86, y:-110}, 3:{x:117, y:-46}, 4:{x:86, y:18}, 5:{x:0, y:43}, 6:{x:-86, y:18}, 7:{x:-117, y:-46}, 8:{x:-86, y:-110}}, 9:{1:{x:0, y:-138}, 2:{x:54, y:-85}, 3:{x:70, y:-45}, 4:{x:48, y:-9}, 5:{x:0, y:6}, 6:{x:-48, y:-9}, 7:{x:-70, y:-45}, 8:{x:-54, y:-85}}};
            numFrameAttack = 2 * DELAY_FRAME;
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            curFrameAttack = 0;
            var _loc_1:* = MapMgr.getInstance().cityMap.getDirToCell(MapMgr.getInstance().convertCellBattleToCellCity(this.getCurCell()), MapMgr.getInstance().convertCellBattleToCellCity(curTarget.getCurCell()));
            move.dir = _loc_1;
            this.createBullet();
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_3:* = EffectDraw.play("cannon_fire", this.getBulletPoint(), _loc_2);
            _loc_3.rotation = (curDir - 1) * 45;
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
                    this.showBullet();
                }
            }
            return;
        }// end function

        private function createBullet() : void
        {
            if (curTarget && curTarget.avatar)
            {
                hasBullet = true;
                bullet = new Bullet();
                bullet.setType(Bullet.CANNON);
                bullet.baseInfo.damagePerAttack = this.baseInfo.damagePerAttack;
                bullet.curTarget = this.curTarget;
                bullet.fire(this.move.getPoint(), curTarget.move.getPoint(), numFrameAttack);
                BattleModule.getInstance().battleData.addObj(bullet);
            }
            return;
        }// end function

        private function showBullet() : void
        {
            var _loc_1:Layer = null;
            var _loc_2:Point = null;
            if (!hasBullet)
            {
                return;
            }
            hasBullet = false;
            if (curTarget && curTarget.avatar)
            {
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_1.addChild(bullet.arrow);
                _loc_2 = new Point(curTarget.avatar.x, curTarget.avatar.y - curTarget.avatar.height / 6);
                bullet.playEffect(curDir, this.getBulletPoint(), _loc_2);
            }
            return;
        }// end function

        private function getBulletPoint() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = avatar.x;
            _loc_1.y = avatar.y;
            var _loc_2:* = this.pBullet[level][avatar.anSetting.currDir];
            _loc_1.x = _loc_1.x + _loc_2["x"];
            _loc_1.y = _loc_1.y + _loc_2["y"];
            return _loc_1;
        }// end function

        private function getBulletPoint2() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = avatar.x;
            _loc_1.y = avatar.y;
            var _loc_2:* = new Point();
            switch(avatar.anSetting.currDir)
            {
                case 1:
                {
                    _loc_1.x = avatar.x;
                    _loc_1.y = avatar.y - 90;
                    break;
                }
                case 2:
                {
                    _loc_1.x = avatar.x + 50;
                    _loc_1.y = avatar.y - 70;
                    break;
                }
                case 3:
                {
                    _loc_1.x = avatar.x + 70;
                    _loc_1.y = avatar.y - 30;
                    break;
                }
                case 4:
                {
                    _loc_1.x = avatar.x + 50;
                    _loc_1.y = avatar.y + 10;
                    break;
                }
                case 5:
                {
                    _loc_1.x = avatar.x;
                    _loc_1.y = avatar.y + 30;
                    break;
                }
                case 6:
                {
                    _loc_1.x = avatar.x - 50;
                    _loc_1.y = avatar.y + 20;
                    break;
                }
                case 7:
                {
                    _loc_1.x = avatar.x - 70;
                    _loc_1.y = avatar.y - 25;
                    break;
                }
                case 8:
                {
                    _loc_1.x = avatar.x - 50;
                    _loc_1.y = avatar.y - 55;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function getSourcePoint() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = avatar.x;
            _loc_1.y = avatar.y;
            var _loc_2:* = new Point();
            switch(avatar.anSetting.currDir)
            {
                case 1:
                {
                    _loc_1.x = avatar.x;
                    _loc_1.y = avatar.y - 100;
                    break;
                }
                case 2:
                {
                    _loc_1.x = avatar.x + 50;
                    _loc_1.y = avatar.y - 80;
                    break;
                }
                case 3:
                {
                    _loc_1.x = avatar.x + 80;
                    _loc_1.y = avatar.y - 40;
                    break;
                }
                case 4:
                {
                    _loc_1.x = avatar.x + 50;
                    _loc_1.y = avatar.y + 20;
                    break;
                }
                case 5:
                {
                    _loc_1.x = avatar.x;
                    _loc_1.y = avatar.y + 30;
                    break;
                }
                case 6:
                {
                    _loc_1.x = avatar.x - 50;
                    _loc_1.y = avatar.y + 20;
                    break;
                }
                case 7:
                {
                    _loc_1.x = avatar.x - 70;
                    _loc_1.y = avatar.y - 30;
                    break;
                }
                case 8:
                {
                    _loc_1.x = avatar.x - 50;
                    _loc_1.y = avatar.y - 80;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

    }
}
