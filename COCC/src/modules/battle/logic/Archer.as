package modules.battle.logic
{
    import __AS3__.vec.*;
    import component.avatar.model.animation.*;
    import flash.geom.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.battle.logic.bean.*;
    import resMgr.*;

    public class Archer extends DataTroop
    {
        private var bullet:Bullet;

        public function Archer()
        {
            numFrameAttack = 7 * DataObject.DELAY_FRAME;
            listAreaTargets.push(DataObject.AREA_AIR);
            return;
        }// end function

        override public function beginAttackTarget() : void
        {
            super.beginAttackTarget();
            this.createBullet();
            curFrameAttack = 0;
            return;
        }// end function

        private function createBullet() : void
        {
            if (curTarget && curTarget.avatar)
            {
                hasBullet = true;
                this.bullet = new Bullet();
                this.bullet.setType(Bullet.ARCHER, level);
                this.bullet.baseInfo.damagePerAttack = this.baseInfo.damagePerAttack;
                this.bullet.curTarget = this.curTarget;
                this.bullet.fire(this.move.getPoint(), curTarget.move.getPoint(), numFrameAttack);
                BattleModule.getInstance().battleData.addObj(this.bullet);
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
            curFrameAttack = 0;
            if (curTarget && curTarget.avatar && this.bullet.arrow)
            {
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_1.addChild(this.bullet.arrow);
                _loc_2 = new Point(curTarget.avatar.x, curTarget.avatar.y);
                this.bullet.playEffect(curDir, this.getSourcePoint(), _loc_2);
            }
            return;
        }// end function

        private function getSourcePoint() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = avatar.x;
            _loc_1.y = avatar.y;
            switch(avatar.anSetting.currDir)
            {
                case 2:
                case 3:
                case 4:
                case 6:
                case 7:
                case 8:
                {
                    _loc_1.y = _loc_1.y - 15;
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
            var _loc_3:Vector.<int> = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Vector2D = null;
            var _loc_7:Point = null;
            var _loc_8:Point = null;
            var _loc_9:Number = NaN;
            var _loc_10:DataObject = null;
            var _loc_1:* = new Vector.<int>;
            var _loc_2:* = int.MAX_VALUE;
            curTarget = null;
            finalTarget = null;
            curTarget = MapMgr.getInstance().findNearestTarget(this);
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
                            if (_loc_4 > 0)
                            {
                                _loc_7 = MapMgr.getInstance().battleMap.cellToPoint(_loc_1[(_loc_4 - 1)]);
                            }
                            else
                            {
                                _loc_7 = MapMgr.getInstance().battleMap.cellToPoint(_loc_1[_loc_4]);
                            }
                            _loc_8 = MapMgr.getInstance().battleMap.cellToPoint(_loc_1[(_loc_1.length - 1)]);
                            _loc_9 = (_loc_8.x - _loc_7.x) * (_loc_8.x - _loc_7.x) + (_loc_8.y - _loc_7.y) * (_loc_8.y - _loc_7.y);
                            if (_loc_9 <= baseInfo.attackRange * baseInfo.attackRange)
                            {
                                _loc_3.push(curTarget.getCurCell());
                                _loc_3.pop();
                                moveToPath(_loc_3);
                            }
                            else
                            {
                                _loc_10 = BattleModule.getInstance().battleData.getObjectCell(_loc_5);
                                if (_loc_10 && _loc_10.objectType == DataObject.OBJTYPE_WALL)
                                {
                                    finalTarget = curTarget;
                                    finalTargetCell = _loc_1[(_loc_1.length - 1)];
                                    curTarget = _loc_10;
                                    moveToPath(_loc_3);
                                    break;
                                }
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

    }
}
