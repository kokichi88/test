package modules.battle.logic
{
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.geom.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;

    public class AirDefenses extends HouseDefenses
    {
        private var pBullet:Object;

        public function AirDefenses()
        {
            this.pBullet = {1:{1:{x:0, y:-102}, 2:{x:40, y:-89}, 3:{x:56, y:-59}, 4:{x:40, y:-29}, 5:{x:0, y:-16}, 6:{x:-40, y:-29}, 7:{x:-56, y:-59}, 8:{x:-40, y:-89}}, 2:{1:{x:0, y:-124}, 2:{x:47, y:-108}, 3:{x:66, y:-72}, 4:{x:46, y:-38}, 5:{x:0, y:-24}, 6:{x:-46, y:-38}, 7:{x:-66, y:-72}, 8:{x:-47, y:-108}}, 3:{1:{x:0, y:-123}, 2:{x:42, y:-108}, 3:{x:61, y:-76}, 4:{x:42, y:-45}, 5:{x:0, y:-33}, 6:{x:-42, y:-45}, 7:{x:-61, y:-76}, 8:{x:-42, y:-108}}, 4:{1:{x:0, y:-180}, 2:{x:62, y:-160}, 3:{x:86, y:-114}, 4:{x:60, y:-69}, 5:{x:0, y:-52}, 6:{x:-60, y:-69}, 7:{x:-86, y:-114}, 8:{x:-62, y:-160}}, 5:{1:{x:0, y:-180}, 2:{x:62, y:-160}, 3:{x:86, y:-114}, 4:{x:60, y:-69}, 5:{x:0, y:-52}, 6:{x:-60, y:-69}, 7:{x:-86, y:-114}, 8:{x:-62, y:-160}}, 6:{1:{x:0, y:-180}, 2:{x:62, y:-160}, 3:{x:86, y:-114}, 4:{x:60, y:-69}, 5:{x:0, y:-52}, 6:{x:-60, y:-69}, 7:{x:-86, y:-114}, 8:{x:-62, y:-160}}, 7:{1:{x:0, y:-180}, 2:{x:62, y:-160}, 3:{x:86, y:-114}, 4:{x:60, y:-69}, 5:{x:0, y:-52}, 6:{x:-60, y:-69}, 7:{x:-86, y:-114}, 8:{x:-62, y:-160}}, 8:{1:{x:0, y:-180}, 2:{x:62, y:-160}, 3:{x:86, y:-114}, 4:{x:60, y:-69}, 5:{x:0, y:-52}, 6:{x:-60, y:-69}, 7:{x:-86, y:-114}, 8:{x:-62, y:-160}}, 9:{1:{x:0, y:-180}, 2:{x:62, y:-160}, 3:{x:86, y:-114}, 4:{x:60, y:-69}, 5:{x:0, y:-52}, 6:{x:-60, y:-69}, 7:{x:-86, y:-114}, 8:{x:-62, y:-160}}};
            numFrameAttack = 6 * DataObject.DELAY_FRAME;
            listAreaTargets = new Vector.<int>;
            listAreaTargets.push(DataObject.AREA_AIR);
            return;
        }// end function

        override public function create(param1:String, param2:String, param3:int) : void
        {
            super.create(param1, param2, param3);
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            hasBullet = true;
            curFrameAttack = 0;
            if (curTarget && curTarget.avatar)
            {
                bullet = new Bullet();
                bullet.setType(Bullet.AIR_DEFENSES);
                bullet.baseInfo.damagePerAttack = this.baseInfo.damagePerAttack;
                bullet.curTarget = this.curTarget;
                bullet.fire(this.move.getPoint(), curTarget.move.getPoint(), numFrameAttack);
                BattleModule.getInstance().battleData.addObj(bullet);
            }
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_2:* = EffectDraw.play("airdefender_fire", this.getSourcePoint(), _loc_1);
            _loc_2.rotation = (curDir - 1) * 45;
            return;
        }// end function

        private function getSourcePoint() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = avatar.x;
            _loc_1.y = avatar.y;
            var _loc_2:* = this.pBullet[level][avatar.anSetting.currDir];
            if (_loc_2)
            {
                _loc_1.x = _loc_1.x + _loc_2["x"];
                _loc_1.y = _loc_1.y + _loc_2["y"];
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
                bullet.playEffect(curDir, this.getSourcePoint(), new Point(curTarget.avatar.x, curTarget.avatar.y - curTarget.avatar.height / 4));
            }
            return;
        }// end function

    }
}
