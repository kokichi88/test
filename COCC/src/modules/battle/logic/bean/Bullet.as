package modules.battle.logic.bean
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
    import modules.battle.*;
    import modules.battle.logic.*;
    import modules.sound.*;
    import resMgr.*;
    import utility.*;

    public class Bullet extends DataObject
    {
        public var arrow:Sprite;
        private var callBack:Function;
        private var dir:int;
        public var speed:Number = 600;
        private var time:Number;
        private var type:String;
        private var heightBonus:int = 0;
        public var radius:Number = 0;
        public var owner:DataObject;
        public var targetPoint:Point;
        public var startTime:Number;
        public var rotation:Number;
        private var targetP:Point;
        public static const ARCHER:String = "ARM_2";
        public static const CANNON:String = "DEF_1";
        public static const ARCHER_TOWER:String = "DEF_2";
        public static const MORTAR:String = "DEF_3";
        public static const WINZAR_TOWER:String = "DEF_4";
        public static const BALLOON:String = "ARM_6";
        public static const AIR_DEFENSES:String = "DEF_5";
        public static const HEALER:String = "ARM_8";
        public static const WIZART:String = "ARM_7";

        public function Bullet()
        {
            team = 0;
            objectType = OBJTYPE_BULLET;
            return;
        }// end function

        public function setType(param1:String, param2:int = 1) : void
        {
            var _loc_3:String = null;
            var _loc_4:Avatar = null;
            this.type = param1;
            switch(this.type)
            {
                case ARCHER:
                case ARCHER_TOWER:
                {
                    _loc_4 = new Avatar();
                    if (param2 < 3)
                    {
                        _loc_4.create(AnCategory.EFFECT, "arrow_small2", 0);
                    }
                    else
                    {
                        _loc_4.create(AnCategory.EFFECT, "arrow_small_burning", 0);
                    }
                    this.arrow = _loc_4;
                    this.speed = 600;
                    break;
                }
                case CANNON:
                {
                    this.speed = 900;
                    _loc_4 = new Avatar();
                    _loc_4.create(AnCategory.EFFECT, "canon_bullet", 0);
                    this.arrow = _loc_4;
                    this.arrow.alpha = 0.1;
                    break;
                }
                case MORTAR:
                {
                    this.speed = 250;
                    _loc_4 = new Avatar();
                    _loc_4 = new Avatar();
                    _loc_4.create(AnCategory.EFFECT, "mortal_bullet_normal", 0);
                    this.arrow = _loc_4;
                    break;
                }
                case WINZAR_TOWER:
                case WIZART:
                {
                    _loc_4 = new Avatar();
                    _loc_4.create(AnCategory.EFFECT, "mage_bullet", 0);
                    this.arrow = _loc_4;
                    this.speed = 600;
                    break;
                }
                case BALLOON:
                {
                    this.speed = 200;
                    _loc_3 = "cannon_bullet";
                    this.arrow = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "arrow/" + _loc_3 + ".png");
                    break;
                }
                case AIR_DEFENSES:
                {
                    _loc_4 = new Avatar();
                    _loc_4.create(AnCategory.EFFECT, "airdefender_bullet", 0);
                    this.arrow = _loc_4;
                    this.speed = 600;
                    break;
                }
                case HEALER:
                {
                    _loc_4 = new Avatar();
                    _loc_4.create(AnCategory.EFFECT, "healer_bullet", 0);
                    this.arrow = _loc_4;
                    this.speed = 350;
                    break;
                }
                default:
                {
                    _loc_3 = "arrow_small";
                    this.speed = 600;
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function fire(param1:Point, param2:Point, param3:int = 0) : void
        {
            var _loc_4:* = new Number();
            _loc_4 = Math.sqrt((param1.x - param2.x) * (param1.x - param2.x) + (param1.y - param2.y) * (param1.y - param2.y));
            this.heightBonus = _loc_4 / 3;
            this.time = _loc_4 / this.speed;
            numLoopAttack = this.time * GlobalVar.stage.frameRate;
            if (param3 > 0)
            {
                numLoopAttack = numLoopAttack + param3;
                this.arrow.visible = false;
            }
            curLoopAttack = 0;
            this.targetPoint = param2;
            this.startTime = Utility.getCurTime();
            return;
        }// end function

        public function playEffect(param1:int, param2:Point, param3:Point) : void
        {
            this.arrow.visible = true;
            var _loc_4:* = this.getSourcePoint(param1, param2, param3);
            param3.x = param3.x + Utility.randomNumber(-5, 5);
            param3.y = param3.y + Utility.randomNumber(-5, 5);
            var _loc_5:* = Math.atan2(param2.y - param3.y, param2.x - param3.x);
            this.rotation = _loc_5 * (180 / Math.PI);
            this.arrow.rotation = -90 + this.rotation;
            this.arrow.x = param2.x;
            this.arrow.y = param2.y;
            this.targetP = new Point();
            this.targetP.x = param3.x;
            this.targetP.y = param3.y;
            switch(this.type)
            {
                case ARCHER:
                case ARCHER_TOWER:
                case WIZART:
                case WINZAR_TOWER:
                {
                    param3.y = param3.y + Math.sin(_loc_5) * 32;
                    param3.x = param3.x + Math.cos(_loc_5) * 32;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.type)
            {
                case ARCHER:
                {
                    TweenMax.to(this.arrow, this.time, {bezier:[{x:param3.x, y:param3.y}], onComplete:this.onFinishTween, ease:Linear.easeNone});
                    break;
                }
                case ARCHER_TOWER:
                case WINZAR_TOWER:
                case AIR_DEFENSES:
                case HEALER:
                case WIZART:
                {
                    TweenMax.to(this.arrow, this.time, {bezier:[{x:_loc_4.x, y:_loc_4.y}, {x:param3.x, y:param3.y}], onComplete:this.onFinishTween, ease:Linear.easeNone});
                    break;
                }
                case CANNON:
                case BALLOON:
                {
                    TweenMax.to(this.arrow, this.time, {bezier:[{x:_loc_4.x, y:_loc_4.y}, {x:param3.x, y:param3.y}], alpha:1, onComplete:this.onFinishTween, ease:Linear.easeNone});
                    break;
                }
                case MORTAR:
                {
                    _loc_4.x = (param2.x + param3.x) / 2;
                    _loc_4.y = param2.y - this.heightBonus;
                    TweenMax.to(this.arrow, this.time, {bezierThrough:[{x:_loc_4.x, y:_loc_4.y}, {x:param3.x, y:param3.y}], orientToBezier:false, ease:Linear.easeNone, onComplete:this.onFinishTween, onUpdate:this.onUpdateTween});
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onFinishTweenMortar() : void
        {
            TweenMax.to(this.arrow, this.time, {bezierThrough:[{x:this.targetP.x, y:this.targetP.y}], orientToBezier:false, ease:Linear.easeOut, onComplete:this.onFinishTween, onUpdate:this.onUpdateTween});
            return;
        }// end function

        private function onUpdateTween() : void
        {
            var _loc_3:Avatar = null;
            var _loc_4:int = 0;
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            var _loc_2:int = 0;
            while (_loc_2 < 5)
            {
                
                _loc_3 = new Avatar();
                _loc_3.create(AnCategory.EFFECT, "mortalbullet_nrmfire", 0);
                _loc_4 = _loc_1.getChildIndex(this.arrow);
                _loc_1.addChildAt(_loc_3, _loc_4);
                _loc_3.x = this.arrow.x + Utility.randomNumber(-3, 3);
                _loc_3.y = this.arrow.y + Utility.randomNumber(1, 8);
                _loc_3.alpha = 0.3;
                TweenMax.to(_loc_3, 0.5, {alpha:0, scaleX:0.2, scaleY:0.2, onComplete:this.onFinishTweenUpdate, onCompleteParams:[_loc_3]});
                _loc_2++;
            }
            return;
        }// end function

        private function onFinishTweenUpdate(param1:Avatar) : void
        {
            param1.destroy();
            param1.parent.removeChild(param1);
            param1.visible = false;
            param1 = null;
            return;
        }// end function

        private function getSourcePoint(param1:int, param2:Point, param3:Point) : Point
        {
            var _loc_4:* = new Point(param2.x, param2.y);
            switch(param1)
            {
                case 1:
                {
                    _loc_4.x = param2.x;
                    _loc_4.y = param2.y;
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    break;
                }
                case 4:
                {
                    break;
                }
                case 5:
                {
                    break;
                }
                case 6:
                {
                    break;
                }
                case 7:
                {
                    break;
                }
                case 8:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

        override public function loop() : void
        {
            var _loc_1:Vector.<DataObject> = null;
            var _loc_2:Boolean = false;
            var _loc_3:int = 0;
            if (curLoopAttack >= numLoopAttack)
            {
                switch(this.type)
                {
                    case CANNON:
                    {
                        curTarget.onDealDamage(this, 0, 0);
                        break;
                    }
                    case MORTAR:
                    {
                        _loc_1 = MapMgr.getInstance().getObjectInAreaByType(this, this.targetPoint, this.radius, DataObject.OBJTYPE_TROOP, curTarget.objectArea);
                        _loc_3 = 0;
                        while (_loc_3 < _loc_1.length)
                        {
                            
                            _loc_1[_loc_3].onDealDamage(this);
                            _loc_3++;
                        }
                        break;
                    }
                    case WINZAR_TOWER:
                    {
                        _loc_1 = MapMgr.getInstance().getObjectInAreaByType(this, this.targetPoint, this.radius, DataObject.OBJTYPE_TROOP, curTarget.objectArea);
                        _loc_2 = true;
                        _loc_3 = 0;
                        while (_loc_3 < _loc_1.length)
                        {
                            
                            _loc_1[_loc_3].onDealDamage(this);
                            if (_loc_1[_loc_3] == curTarget)
                            {
                                _loc_2 = false;
                            }
                            _loc_3++;
                        }
                        if (_loc_2)
                        {
                            curTarget.onDealDamage(this);
                        }
                        break;
                    }
                    case WIZART:
                    {
                        _loc_1 = MapMgr.getInstance().getObjectInAreaByType(this, this.targetPoint, this.radius, -1, curTarget.objectArea);
                        _loc_3 = 0;
                        while (_loc_3 < _loc_1.length)
                        {
                            
                            _loc_1[_loc_3].onDealDamage(this);
                            _loc_3++;
                        }
                        break;
                    }
                    case BALLOON:
                    {
                        _loc_1 = MapMgr.getInstance().getObjectInAreaByType(this, this.targetPoint, this.radius, -1, DataObject.AREA_GROUND);
                        _loc_3 = 0;
                        while (_loc_3 < _loc_1.length)
                        {
                            
                            _loc_1[_loc_3].onDealDamage(this);
                            _loc_3++;
                        }
                        break;
                    }
                    case HEALER:
                    {
                        _loc_1 = MapMgr.getInstance().getObjectInAreaByType(this, this.targetPoint, this.radius, -1, DataObject.AREA_GROUND, true);
                        _loc_3 = 0;
                        while (_loc_3 < _loc_1.length)
                        {
                            
                            _loc_1[_loc_3].onHeal(this.baseInfo.damagePerAttack);
                            _loc_3++;
                        }
                        break;
                    }
                    default:
                    {
                        curTarget.onDealDamage(this);
                        break;
                        break;
                    }
                }
                BattleModule.getInstance().battleData.removeObj(this);
            }
            var _loc_5:* = curLoopAttack + 1;
            curLoopAttack = _loc_5;
            return;
        }// end function

        private function onFinishTween() : void
        {
            var _loc_2:Layer = null;
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
            switch(this.type)
            {
                case MORTAR:
                {
                    EffectDraw.play("mortalbullet_explosion", new Point(this.targetP.x, this.targetP.y), _loc_1);
                    this.showEffectExplosionSmoke();
                    _loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_BG);
                    EffectDraw.vibrateLayer(_loc_1, 5);
                    EffectDraw.vibrateLayer(_loc_2, 5);
                    break;
                }
                case WIZART:
                case WINZAR_TOWER:
                {
                    EffectDraw.play("wizard_tower_hit", new Point(this.targetP.x, this.targetP.y), _loc_1);
                    break;
                }
                case HEALER:
                {
                    EffectDraw.play("healerhit", new Point(this.targetP.x, this.targetP.y), _loc_1);
                    break;
                }
                case BALLOON:
                {
                    EffectDraw.play("explosion_1", new Point(this.targetP.x, this.targetP.y), _loc_1);
                    this.showEffectExplosionSmoke(false);
                    break;
                }
                case AIR_DEFENSES:
                {
                    EffectDraw.play("airdefender_hit", new Point(this.targetP.x, this.targetP.y), _loc_1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.arrow && this.arrow.parent)
            {
                if (this.arrow is Avatar)
                {
                    Avatar(this.arrow).destroy();
                }
                this.arrow.parent.removeChild(this.arrow);
                this.arrow.visible = false;
                this.arrow = null;
            }
            SoundModule.getInstance().playSound(SoundModule[this.type + "_HIT"]);
            return;
        }// end function

        private function showEffectExplosionSmoke(param1:Boolean = true) : void
        {
            var _loc_3:SeedEffect = null;
            var _loc_4:Layer = null;
            var _loc_5:Sprite = null;
            var _loc_6:Sprite = null;
            var _loc_2:int = 0;
            while (_loc_2 < 2)
            {
                
                _loc_3 = new SeedEffect();
                _loc_3.create("explosion_smoke", this.targetP.x, this.targetP.y, 0);
                _loc_3.avt.alpha = 0.3;
                _loc_2++;
            }
            if (param1)
            {
                _loc_4 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_5 = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/cracked.png") as Sprite;
                _loc_6 = new Sprite();
                _loc_6.addChild(_loc_5);
                _loc_5.x = -250 / 2;
                _loc_5.y = -150 / 2;
                _loc_4.addChildAt(_loc_6, 0);
                _loc_6.x = this.targetP.x;
                _loc_6.y = this.targetP.y;
                _loc_6.alpha = 0.7;
                var _loc_7:Number = 0.5;
                _loc_6.scaleY = 0.5;
                _loc_6.scaleX = _loc_7;
                TweenMax.to(_loc_6, 2.5, {alpha:0, onComplete:this.onFinishEffectExplosionSmoke, onCompleteParams:[_loc_6]});
                TweenMax.to(_loc_6, 0.25, {scaleX:1, scaleY:1});
            }
            return;
        }// end function

        private function onFinishEffectExplosionSmoke(param1:Sprite) : void
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
