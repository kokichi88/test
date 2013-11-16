package modules.battle.logic
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.sound.*;
    import resMgr.*;
    import resMgr.data.*;
    import utility.*;

    public class DataTroop extends DataObject
    {
        private var showEffectTarget:Boolean = true;
        public var numChangeTarget:int = 0;
        public var delayAttack:int = 5;
        private var pCity:Point;
        public static const COUNT_DOWN_CHANGE_TARGET:int = 30;
        public static const DELAY_FRAME:int = 20;

        public function DataTroop()
        {
            this.pCity = new Point(0, 0);
            objectType = DataObject.OBJTYPE_TROOP;
            objectArea = DataObject.AREA_GROUND;
            return;
        }// end function

        override public function setInfo(param1:String, param2:int) : void
        {
            var _loc_3:* = JsonMgr.getInstance().getInfoTroop(param1, param2);
            baseInfo.setTroopInfo(_loc_3);
            create(AnCategory.AVATAR, param1, param2);
            return;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Point = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            super.loop();
            if (this.objectStatus == AnConst.RE_FIND)
            {
                if (objId % DELAY_FRAME != BattleModule.getInstance().curLoop % DELAY_FRAME)
                {
                    return;
                }
                this.findTarget();
            }
            if (this.objectStatus == AnConst.STAND)
            {
                this.findTarget();
            }
            if (curTarget && curTarget.objectStatus == AnConst.DIE)
            {
                refindTarget();
                return;
            }
            if (curTarget && curTarget.objectType == OBJTYPE_WALL)
            {
                if (finalTarget == null || finalTarget.objectStatus == AnConst.DIE)
                {
                    refindTarget();
                    return;
                }
            }
            if (this.objectStatus == AnConst.RUN)
            {
                if (curTarget == null || curTarget.objectStatus == AnConst.DIE)
                {
                    refindTarget();
                    return;
                }
                move.updateLogic();
                avatar.x = move.x;
                avatar.y = move.y;
                if (avatar.anSetting.currDir != move.dir)
                {
                    avatar.anSetting.currDir = move.dir;
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
                        curLoopAttack = numLoopAttack - 5;
                        setAction(AnConst.STAND, _loc_3);
                        this.objectStatus = AnConst.ATTACK;
                        numFindTarget = COUNT_DOWN_FIND_TARGET;
                    }
                }
                if (curTarget is DataTroop)
                {
                    var _loc_6:* = numFindTarget - 1;
                    numFindTarget = _loc_6;
                    if (numFindTarget < 0)
                    {
                        this.findTarget();
                        numFindTarget = COUNT_DOWN_FIND_TARGET * 2;
                    }
                }
                if (team == 2)
                {
                    this.checkWall();
                }
            }
            if (curTarget && this.objectStatus == AnConst.ATTACK)
            {
                if (curTarget.objectStatus == AnConst.DIE)
                {
                    refindTarget();
                    return;
                }
                if (curLoopAttack < numLoopAttack)
                {
                    var _loc_6:* = curLoopAttack + 1;
                    curLoopAttack = _loc_6;
                }
                else
                {
                    avatar.addFrameScript();
                    beginAttackTarget();
                }
                if (curTarget is DataTroop)
                {
                    _loc_4 = curTarget.getCurCell();
                    _loc_2 = MapMgr.getInstance().battleMap.cellToPoint(_loc_4);
                    _loc_1 = (move.x - _loc_2.x) * (move.x - _loc_2.x) + (move.y - _loc_2.y) * (move.y - _loc_2.y);
                    if (_loc_1 > baseInfo.attackRange * baseInfo.attackRange)
                    {
                        refindTarget();
                    }
                    else
                    {
                        this.numChangeTarget = 0;
                    }
                }
            }
            return;
        }// end function

        public function checkWall() : void
        {
            var _loc_2:int = 0;
            var _loc_3:DataObject = null;
            var _loc_1:* = MapMgr.getInstance().battleMap.pointToIso(move.x, move.y);
            _loc_1.x = int(_loc_1.x / 3) * 3;
            _loc_1.y = int(_loc_1.y / 3) * 3;
            if (_loc_1.x != this.pCity.x || _loc_1.y != this.pCity.y)
            {
                this.pCity.x = _loc_1.x;
                this.pCity.y = _loc_1.y;
                _loc_2 = MapMgr.getInstance().battleMap.isoToCell(_loc_1.x, _loc_1.y);
                _loc_3 = BattleModule.getInstance().battleData.getObjectCell(_loc_2);
                if (_loc_3 is Wall)
                {
                    Wall(_loc_3).effectHideWall();
                }
            }
            return;
        }// end function

        override public function continueWithFinalTarget() : void
        {
            var _loc_1:Vector.<int> = null;
            var _loc_2:Vector.<int> = null;
            if (finalTarget && finalTarget.objectStatus != AnConst.DIE)
            {
                _loc_1 = getPath(finalTarget, 0, BaseMap.IS_WALL);
                _loc_2 = getPath(finalTarget, _loc_1.length);
                if (_loc_2.length < _loc_1.length + BaseMap.BONUS_WALL)
                {
                    curTarget = finalTarget;
                    moveToTarget(curTarget);
                }
            }
            return;
        }// end function

        override public function findTarget() : void
        {
            var _loc_1:Layer = null;
            curLoopAttack = 0;
            if (curTarget && curTarget.avatar && this.showEffectTarget)
            {
                this.showEffectTarget = false;
                _loc_1 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                EffectDraw.play("target", new Point(curTarget.avatar.x, curTarget.avatar.y), _loc_1);
            }
            return;
        }// end function

        override public function death() : void
        {
            var _loc_1:AnLoadData = null;
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_5:BitmapData = null;
            var _loc_6:Bitmap = null;
            var _loc_7:Layer = null;
            var _loc_8:Point = null;
            var _loc_9:Point = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            if (killer != BuildingType.TRA_2)
            {
                this.playEffectDie();
            }
            else
            {
                _loc_1 = avatar.bodyBitmap.coreObj.data;
                _loc_2 = _loc_1[AnConst.DIE];
                _loc_3 = _loc_2.dirData[5];
                _loc_4 = _loc_3.frames[0];
                if (_loc_4 && _loc_4.bitmapData)
                {
                    _loc_5 = new BitmapData(_loc_4.rect.width, _loc_4.rect.height, true, 0);
                    _loc_5.copyPixels(_loc_4.bitmapData, _loc_4.bitmapData.rect, new Point(0, 0), null, null, true);
                    _loc_6 = new Bitmap();
                    _loc_6.bitmapData = _loc_5;
                    _loc_7 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                    _loc_7.addChild(_loc_6);
                    _loc_6.x = avatar.x + _loc_4.rect.x;
                    _loc_6.y = avatar.y + _loc_4.rect.y;
                    _loc_8 = new Point();
                    _loc_9 = new Point();
                    _loc_10 = Utility.randomNumber(1, 5);
                    _loc_11 = 1;
                    _loc_12 = 1;
                    switch(_loc_10)
                    {
                        case 1:
                        {
                            _loc_11 = -1;
                            _loc_12 = -1;
                            break;
                        }
                        case 2:
                        {
                            _loc_11 = 1;
                            _loc_12 = -1;
                            break;
                        }
                        case 3:
                        {
                            _loc_11 = 1;
                            _loc_12 = 1;
                            break;
                        }
                        case 4:
                        {
                            _loc_11 = -1;
                            _loc_12 = 1;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_8.x = _loc_6.x + 400 * _loc_11 + Utility.randomNumber(-10, 10);
                    _loc_8.y = _loc_6.y + 400 + Utility.randomNumber(0, 10);
                    _loc_9.x = (_loc_6.x + _loc_8.x) / 2;
                    _loc_13 = new Number();
                    _loc_13 = Math.sqrt((_loc_6.x - _loc_8.x) * (_loc_6.x - _loc_8.x) + (_loc_6.y - _loc_8.y) * (_loc_6.y - _loc_8.y));
                    _loc_14 = _loc_13;
                    _loc_9.y = _loc_6.y - _loc_14;
                    TweenMax.to(_loc_6, 1, {scaleX:1.6, scaleY:1.6, rotation:180, bezierThrough:[{x:_loc_9.x, y:_loc_9.y}, {x:_loc_8.x, y:_loc_8.y}], orientToBezier:false, ease:Linear.easeNone, onComplete:this.onFinishTween, onCompleteParams:[_loc_6]});
                }
            }
            super.death();
            if (team == 1)
            {
                BattleModule.getInstance().troopDie();
            }
            return;
        }// end function

        private function onFinishTween(param1:Bitmap) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
                param1.visible = false;
                param1 = null;
            }
            SoundModule.getInstance().playSound(SoundModule.PUNCHTRAP_DROP);
            return;
        }// end function

        private function playEffectDie() : void
        {
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_2:* = ResMgr.getInstance().getMovieClip("ImageGhost") as Sprite;
            _loc_1.addChild(_loc_2);
            _loc_2.x = avatar.x;
            _loc_2.y = avatar.y;
            TweenMax.to(_loc_2, 1, {alpha:0, bezier:[{x:avatar.x, y:avatar.y - 60}], ease:Linear.easeNone, onComplete:this.onFinishTweenAlPha, onCompleteParams:[_loc_2]});
            var _loc_3:* = MapMgr.getInstance().cityMap.pointToCell(avatar.x, avatar.y);
            var _loc_4:* = MapMgr.getInstance().cityMap.cellToPoint(_loc_3);
            MapMgr.getInstance().cityMap.cellToPoint(_loc_3).y = MapMgr.getInstance().cityMap.cellToPoint(_loc_3).y + (MapMgr.getInstance().cityMap.MaxHalfHeight + 5);
            _loc_4.x = _loc_4.x - 5;
            var _loc_5:* = BattleModule.getInstance().battleData.imageRIPList;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                if (_loc_5[_loc_6].x == _loc_4.x && _loc_5[_loc_6].y == _loc_4.y)
                {
                    return;
                }
                _loc_6++;
            }
            var _loc_7:* = ResMgr.getInstance().getMovieClip("ImageRIP") as Sprite;
            (ResMgr.getInstance().getMovieClip("ImageRIP") as Sprite).x = _loc_4.x;
            _loc_7.y = _loc_4.y;
            _loc_1.addChildAt(_loc_7, 0);
            BattleModule.getInstance().battleData.imageRIPList.push(_loc_7);
            return;
        }// end function

        private function onFinishTweenAlPha(param1:Sprite) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
                param1.visible = false;
                param1 = null;
            }
            return;
        }// end function

    }
}
