package modules.battle.logic
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.geom.*;
    import map.*;
    import map.logic.*;
    import modules.battle.*;
    import modules.battle.graphics.*;
    import modules.battle.logic.bean.*;
    import modules.city.graphics.tutorial.*;
    import modules.sound.*;
    import resMgr.*;
    import utility.*;

    public class DataObject extends Object
    {
        public var objectType:int = -1;
        public var objectStatus:int;
        public var objectArea:int = 1;
        public var objId:int = -1;
        public var progressHp:BarProgress;
        public var team:int = 1;
        public var curTarget:DataObject;
        public var level:int;
        public var baseInfo:BaseInfo;
        public var curDir:int = 5;
        public var avatar:Avatar;
        public var numLoopAttack:int;
        public var curLoopAttack:int;
        public var curPointInPath:int;
        public var path:Vector.<int>;
        public var numFrameAttack:int = 0;
        public var curFrameAttack:int = 0;
        public var finalTarget:DataObject;
        public var deepLevel:int = 1;
        public var numLoopProgres:int = 0;
        public var move:BaseMoving;
        public var desCell:int;
        public var finalTargetCell:int;
        public var numFindTarget:int = 20;
        public var listAreaTargets:Vector.<int>;
        public var aniEffects:Vector.<AniEffect>;
        public var hasBullet:Boolean = false;
        public var displayImage:DisplayObjectContainer;
        public var killer:String = "";
        public static const BARBARIAN:String = "ARM_1";
        public static const ARCHER:String = "ARM_2";
        public static const GOBLIN:String = "ARM_3";
        public static const GIANT:String = "ARM_4";
        public static const WALL_BREAKER:String = "ARM_5";
        public static const BALLOON:String = "ARM_6";
        public static const WINZAR:String = "ARM_7";
        public static const HEALER:String = "ARM_8";
        public static const OBJTYPE_TEMPLE:int = 0;
        public static const OBJTYPE_HOUSE:int = 1;
        public static const OBJTYPE_DEFENSES:int = 2;
        public static const OBJTYPE_WALL:int = 3;
        public static const OBJTYPE_TROOP:int = 4;
        public static const OBJTYPE_RESOURCES:int = 5;
        public static const OBJTYPE_BULLET:int = 6;
        public static const OBJTYPE_OBSTACLE:int = 7;
        public static const OBJTYPE_TRAP:int = 8;
        public static const OBJTYPE_SPELL:int = 9;
        public static const AREA_NONE:int = 0;
        public static const AREA_GROUND:int = 1;
        public static const AREA_AIR:int = 2;
        public static const AREA_GROUND_AIR:int = 3;
        public static const SCALE:int = 0;
        public static const DELAY_FRAME:int = 2;
        public static const COUNT_DOWN_PROGRES:int = 30;
        public static const COUNT_DOWN_FIND_TARGET:int = 20;

        public function DataObject()
        {
            this.baseInfo = new BaseInfo();
            this.path = new Vector.<int>;
            this.move = new BaseMoving();
            this.listAreaTargets = new Vector.<int>;
            this.aniEffects = new Vector.<AniEffect>;
            this.objectArea = DataObject.AREA_GROUND;
            this.listAreaTargets.push(DataObject.AREA_GROUND);
            return;
        }// end function

        public function setInfo(param1:String, param2:int) : void
        {
            return;
        }// end function

        public function create(param1:String, param2:String, param3:int) : void
        {
            this.avatar = new Avatar();
            this.avatar.create(param1, param2, param3);
            this.setDisplayImage(this.avatar);
            var _loc_4:* = Math.random() * 8 + 1;
            if (this is DataHouse)
            {
                _loc_4 = 5;
            }
            this.avatar.setAction(AnConst.STAND, _loc_4);
            this.progressHp = new BarProgress(this.team);
            this.avatar.addChild(this.progressHp);
            this.progressHp.setPos((-this.progressHp.width) / 2, -this.avatar.sprite.height);
            this.progressHp.setPercent(1);
            this.level = param3;
            this.progressHp.visible = false;
            this.avatar.mouseChildren = false;
            this.avatar.mouseEnabled = false;
            return;
        }// end function

        public function setDisplayImage(param1:DisplayObjectContainer) : void
        {
            this.displayImage = param1;
            return;
        }// end function

        public function setAction(param1:int, param2:int, param3:int = -1, param4:int = 0) : void
        {
            this.objectStatus = param1;
            this.curDir = param2;
            if (this.avatar && this.avatar.anSetting)
            {
                this.avatar.addFrameScript();
                this.avatar.setAction(param1, param2, param3, param4);
                ;
            }
            return;
        }// end function

        public function loop() : void
        {
            if (BattleModule.getInstance().curLoop % 5 != this.objId % 5)
            {
                return;
            }
            
            this.numLoopProgres--;
            if (this.numLoopProgres < 0)
            {
                if (this.progressHp)
                {
                    this.progressHp.visible = false;
                }
            }
            return;
        }// end function

        public function findTarget() : void
        {
            return;
        }// end function

        public function onDealDamage(param1:DataObject, param2:Number = 0, param3:int = -1) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Layer = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:Sprite = null;
            var _loc_13:Number = NaN;
            if (this.progressHp == null)
            {
                return;
            }
            this.progressHp.visible = true;
            if (param2 == 0)
            {
                _loc_4 = this.getDamage(param1);
            }
            else
            {
                _loc_4 = param2;
            }
            this.baseInfo.curHp = this.baseInfo.curHp - _loc_4;
            this.numLoopProgres = COUNT_DOWN_PROGRES;
            this.progressHp.setPercent(Number(this.baseInfo.curHp / this.baseInfo.maxHp));
            SoundModule.getInstance().playSound(SoundModule[param1.baseInfo.id + "_HIT"]);
            if (this.avatar)
            {
                _loc_5 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_6 = int(Math.random() * 100);
                _loc_7 = Math.random() * 50 - 25;
                _loc_8 = Math.random() * 50 - 25;
                if (_loc_6 < 30 && param3 < 0)
                {
                    _loc_6 = -1;
                }
                else if (_loc_6 < 60)
                {
                    _loc_6 = 0;
                }
                else if (_loc_6 < 90)
                {
                    _loc_6 = 1;
                }
                else
                {
                    _loc_6 = 2;
                }
                if (param3 < 0)
                {
                    if (_loc_6 >= 0)
                    {
                        EffectDraw.play("hit_0" + _loc_6.toString(), new Point(this.avatar.x + _loc_7, this.avatar.y - 40 + _loc_8), _loc_5);
                    }
                }
                else
                {
                    _loc_9 = 0;
                    while (_loc_9 < 10)
                    {
                        
                        _loc_6 = Math.random() * 2 + 1;
                        _loc_10 = Utility.randomNumber(-25, 25);
                        _loc_11 = Utility.randomNumber(-25, 25);
                        _loc_12 = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/burningsmoke_" + _loc_6 + ".png");
                        var _loc_14:Number = 0.5;
                        _loc_12.scaleY = 0.5;
                        ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/burningsmoke_" + _loc_6 + ".png").scaleX = _loc_14;
                        _loc_12.x = this.avatar.x - 30;
                        _loc_12.y = this.avatar.y - 30;
                        _loc_12.alpha = 0.5;
                        _loc_13 = 1;
                        _loc_5.addChild(_loc_12);
                        TweenMax.to(_loc_12, 1, {scaleX:_loc_13, scaleY:_loc_13, alpha:0, bezier:[{x:_loc_12.x + _loc_10, y:_loc_12.y + _loc_11}], ease:Linear.easeNone, onComplete:this.onFinishTween, onCompleteParams:[_loc_12]});
                        _loc_9++;
                    }
                    EffectDraw.play("cannon_hit", new Point(this.avatar.x, this.avatar.y - 20), _loc_5);
                }
            }
            if (this.baseInfo.curHp <= 0)
            {
                this.killer = param1.baseInfo.id;
                this.death();
            }
            return;
        }// end function

        private function onFinishTween(param1:Sprite) : void
        {
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
                param1.visible = false;
                param1 = null;
            }
            return;
        }// end function

        public function onHeal(param1:Number) : void
        {
            var _loc_2:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            EffectDraw.play("healtarget", new Point(this.avatar.x, this.avatar.y - 20), _loc_2);
            this.baseInfo.curHp = this.baseInfo.curHp + param1;
            this.baseInfo.curHp = Math.min(this.baseInfo.maxHp, this.baseInfo.curHp);
            this.numLoopProgres = COUNT_DOWN_PROGRES;
            this.progressHp.setPercent(Number(this.baseInfo.curHp / this.baseInfo.maxHp));
            if (this.progressHp == null)
            {
                return;
            }
            this.progressHp.visible = true;
            TweenMax.to(this.avatar, 0.2, {colorMatrixFilter:{contrast:1.2, brightness:1.3}, onComplete:this.onFinishTweenHeal});
            return;
        }// end function

        private function onFinishTweenHeal() : void
        {
            if (this.avatar)
            {
                TweenMax.to(this.avatar, 0.2, {colorMatrixFilter:{contrast:1, brightness:1}});
            }
            return;
        }// end function

        public function death() : void
        {
            this.setAction(AnConst.DIE, this.curDir);
            if (TutorialMgr.getInstance().isTutorial)
            {
                if (TutorialMgr.getInstance().curStep == 11)
                {
                    var _loc_1:* = TutorialMgr.getInstance();
                    var _loc_2:* = TutorialMgr.getInstance().numGoblin - 1;
                    _loc_1.numGoblin = _loc_2;
                    if (TutorialMgr.getInstance().numGoblin == 0)
                    {
                        TutorialMgr.getInstance().endScene11();
                    }
                }
            }
            BattleModule.getInstance().battleData.removeObj(this);
            SoundModule.getInstance().playSound(SoundModule[this.baseInfo.id + "_DEAD"]);
            return;
        }// end function

        public function getDamage(param1:DataObject) : int
        {
            return param1.baseInfo.damagePerAttack;
        }// end function

        public function moveToTarget(param1:DataObject) : void
        {
            this.path = this.getPath(param1, 0);
            if (this.path.length > 2)
            {
                this.curPointInPath = 0;
                this.runToPath();
            }
            return;
        }// end function

        public function moveToPath(param1:Vector.<int>) : void
        {
            this.path = param1;
            this.setAction(AnConst.RUN, this.move.dir);
            if (this.path.length > 0)
            {
                this.runToPath();
            }
            return;
        }// end function

        public function runToPath() : void
        {
            this.desCell = this.path[(this.path.length - 1)];
            this.move.moveTo(this.path, this.baseInfo.moveSpeed);
            return;
        }// end function

        public function set responeCell(param1:int) : void
        {
            this.move.responeCell = param1;
            this.move.curCell = this.move.responeCell;
            return;
        }// end function

        public function moveToWall(param1:DataObject) : void
        {
            this.path = this.getPath(param1, BaseMap.IS_WALL);
            if (this.path.length > 2)
            {
                this.curPointInPath = 0;
                this.runToPath();
                this.setAction(AnConst.RUN, this.move.dir);
            }
            return;
        }// end function

        public function getPath(param1:DataObject, param2:int, param3:int = -1) : Vector.<int>
        {
            var _loc_9:Boolean = false;
            var _loc_4:* = new Vector.<int>;
            var _loc_5:* = param1.getCurCell();
            var _loc_6:* = this.getCurCell();
            var _loc_7:Boolean = true;
            var _loc_8:Boolean = false;
            if (this is Healer)
            {
                _loc_8 = true;
            }
            if (param3 < 0 && this.deepLevel < BaseMap.IS_WALL)
            {
                _loc_7 = MapMgr.getInstance().rangeMap.canPathTo(_loc_6, _loc_5, param2);
            }
            if (param3 > 0)
            {
                _loc_8 = true;
            }
            if (param3 < 0)
            {
                param3 = this.deepLevel;
            }
            if (_loc_7)
            {
                _loc_9 = false;
                if (param1.objectType == DataObject.OBJTYPE_TROOP)
                {
                    _loc_9 = true;
                }
                _loc_4 = MapMgr.getInstance().battleMap.pathTo(_loc_6, _loc_5, param3, false, _loc_8, false, _loc_9);
                if (_loc_4.length <= 0)
                {
                }
            }
            return _loc_4;
        }// end function

        public function getCurCell() : int
        {
            return this.move.curCell;
        }// end function

        public function beginAttackTarget() : void
        {
            if (this.curTarget == null)
            {
                return;
            }
            var _loc_1:* = MapMgr.getInstance().cityMap.getDirToCell(MapMgr.getInstance().convertCellBattleToCellCity(this.getCurCell()), MapMgr.getInstance().convertCellBattleToCellCity(this.curTarget.getCurCell()));
            this.move.dir = _loc_1;
            this.numLoopAttack = this.baseInfo.attackSpeed;
            this.curLoopAttack = 0;
            switch(this.baseInfo.id)
            {
                case DataObject.BALLOON:
                case DataObject.GIANT:
                {
                    this.setAction(AnConst.ATTACK, this.move.dir, 1, 1);
                    break;
                }
                default:
                {
                    this.setAction(AnConst.ATTACK, this.move.dir, 1);
                    break;
                    break;
                }
            }
            SoundModule.getInstance().playSound(SoundModule[this.baseInfo.id + "_ATK"]);
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.aniEffects.length)
            {
                
                if (this.aniEffects[_loc_1])
                {
                    this.aniEffects[_loc_1].terminate();
                    this.aniEffects[_loc_1] = null;
                }
                _loc_1++;
            }
            this.objectStatus = AnConst.DIE;
            if (this.progressHp && this.progressHp.parent)
            {
                this.progressHp.parent.removeChild(this.progressHp);
                this.progressHp.visible = false;
                this.progressHp = null;
            }
            if (this.avatar != null && this.avatar.parent != null)
            {
                this.avatar.destroy();
            }
            if (this.displayImage != null && this.displayImage.parent != null)
            {
                this.displayImage.parent.removeChild(this.displayImage);
            }
            return;
        }// end function

        public function updateStatus(param1:int = 0) : void
        {
            switch(param1)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    if (this.curTarget && this.curTarget.objectType == DataObject.OBJTYPE_WALL && this.objectType == DataObject.OBJTYPE_TROOP)
                    {
                        this.refindTarget();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function refindTarget() : void
        {
            this.objectStatus = AnConst.RE_FIND;
            this.avatar.setAction(AnConst.STAND, this.avatar.anSetting.currDir);
            return;
        }// end function

        public function continueWithFinalTarget() : void
        {
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this.avatar.visible = param1;
            if (this is DataHouse)
            {
                if (DataHouse(this).bgImage)
                {
                    DataHouse(this).bgImage.visible = param1;
                }
            }
            return;
        }// end function

        public function checkTargetArea(param1:int) : Boolean
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.listAreaTargets.length)
            {
                
                if (param1 == this.listAreaTargets[_loc_2])
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

    }
}
