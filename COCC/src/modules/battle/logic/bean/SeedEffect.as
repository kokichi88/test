package modules.battle.logic.bean
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.avatar.model.animation.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.geom.*;
    import gameData.*;
    import resMgr.*;

    public class SeedEffect extends Object
    {
        public var type:String;
        public var sp:Sprite;
        public var avt:Avatar;

        public function SeedEffect()
        {
            return;
        }// end function

        public function create(param1:String, param2:Number, param3:Number, param4:int = -1) : void
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:Layer = null;
            var _loc_11:Layer = null;
            var _loc_12:Number = NaN;
            this.type = param1;
            var _loc_5:* = new Point(param2 + this.getRandom(-200, 200), param3 - this.getRandom(250, 450));
            var _loc_6:* = this.getRandom(0.3, 1);
            switch(this.type)
            {
                case MoneyType.ELIXIR:
                {
                    _loc_8 = this.getRandom(0, 100);
                    _loc_9 = 3;
                    if (_loc_8 > 50)
                    {
                        _loc_9 = 2;
                    }
                    if (_loc_8 > 80)
                    {
                        _loc_9 = 1;
                    }
                    this.sp = ResMgr.getInstance().getMovieClip(Config.getStaticUrl() + "image/elixir_0" + _loc_9 + ".png");
                    this.sp.alpha = this.getRandom(0.5, 1);
                    _loc_5 = new Point(param2 + this.getRandom(-200, 200), param3 - this.getRandom(200, 300));
                    break;
                }
                case MoneyType.GOLD:
                {
                    this.avt = new Avatar();
                    _loc_9 = 1 + Math.random() * 3;
                    this.avt.create(AnCategory.EFFECT, "coindrop_" + _loc_9, 0);
                    this.sp = this.avt;
                    break;
                }
                case "upLevelBuilding":
                {
                    _loc_6 = this.getRandom(1, 2);
                    _loc_5 = new Point(param2 + this.getRandom(-200, 200), param3 - this.getRandom(100, 200));
                    _loc_8 = Math.random() * 2 + 1;
                    this.avt = new Avatar();
                    this.avt.create(AnCategory.EFFECT, "lightspark_" + _loc_8, 0);
                    this.sp = this.avt;
                    break;
                }
                case "explosionElements":
                {
                    _loc_8 = Math.random() * 4 + 1;
                    this.avt = new Avatar();
                    this.avt.create(AnCategory.EFFECT, "explosion_elements_" + _loc_8, 0);
                    this.sp = this.avt;
                    var _loc_13:* = this.getRandom(0.5, 2.5);
                    this.sp.scaleY = this.getRandom(0.5, 2.5);
                    this.sp.scaleX = _loc_13;
                    _loc_6 = this.getRandom(0.5, 2);
                    break;
                }
                case "explosion_smoke":
                case "explosion_smoke_Wall":
                {
                    _loc_8 = Math.random() * 2 + 1;
                    this.avt = new Avatar();
                    this.avt.create(AnCategory.EFFECT, "explosion_smoke_" + _loc_8, 0);
                    this.sp = this.avt;
                    var _loc_13:* = this.getRandom(0.7, 1);
                    this.sp.scaleY = this.getRandom(0.7, 1);
                    this.sp.scaleX = _loc_13;
                    _loc_6 = this.getRandom(2, 5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.sp.mouseChildren = false;
            this.sp.mouseEnabled = false;
            this.sp.x = param2;
            this.sp.y = param3;
            if (param4 >= 0)
            {
                _loc_10 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
                _loc_10.addChildAt(this.sp, param4);
            }
            else
            {
                _loc_11 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_EFFECT);
                _loc_11.addChild(this.sp);
            }
            var _loc_7:* = new Shape();
            new Shape().graphics.beginFill(65280);
            _loc_7.graphics.drawCircle(0, 0, 8);
            _loc_7.graphics.endFill();
            _loc_7.x = param2;
            _loc_7.y = param3;
            switch(this.type)
            {
                case "explosion_smoke":
                {
                    _loc_5 = new Point(param2 + this.getRandom(-400, 400), param3 - this.getRandom(30, 70));
                    _loc_12 = this.getRandom(1.2, 2);
                    TweenMax.to(this.sp, _loc_6, {scaleX:_loc_12, scaleY:_loc_12, bezier:[{x:(param2 + _loc_5.x) / 2, y:this.getRandom(_loc_5.y - 100, _loc_5.y - 150)}, {x:_loc_5.x, y:_loc_5.y}], ease:Linear.easeNone, onComplete:this.onFinishTween});
                    TweenMax.to(this.sp, _loc_6 / 2, {alpha:0.3, ease:Linear.easeNone, onComplete:this.onFinishTweenAlPha, onCompleteParams:[_loc_6 / 2]});
                    break;
                }
                case "explosion_smoke_Wall":
                {
                    _loc_5 = new Point(param2 + this.getRandom(-200, 200), param3 - this.getRandom(30, 50));
                    _loc_12 = this.getRandom(1.2, 2);
                    this.sp.alpha = 0.5;
                    TweenMax.to(this.sp, _loc_6, {scaleX:_loc_12, scaleY:_loc_12, bezier:[{x:(param2 + _loc_5.x) / 2, y:this.getRandom(_loc_5.y - 50, _loc_5.y - 100)}, {x:_loc_5.x, y:_loc_5.y}], ease:Linear.easeNone, onComplete:this.onFinishTween});
                    TweenMax.to(this.sp, _loc_6 / 2, {alpha:0.15, ease:Linear.easeNone, onComplete:this.onFinishTweenAlPha, onCompleteParams:[_loc_6 / 2]});
                    break;
                }
                default:
                {
                    TweenMax.to(this.sp, _loc_6, {bezier:[{x:(param2 + _loc_5.x) / 2, y:this.getRandom(_loc_5.y - 100, _loc_5.y - 150)}, {x:_loc_5.x, y:_loc_5.y}], ease:Linear.easeNone, onComplete:this.onFinishTween});
                    TweenMax.to(this.sp, _loc_6 / 2, {alpha:1, ease:Linear.easeNone, onComplete:this.onFinishTweenAlPha, onCompleteParams:[_loc_6 / 2]});
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onFinishTweenAlPha(param1:Number) : void
        {
            if (this.sp == null)
            {
                return;
            }
            switch(this.type)
            {
                case "explosionElements":
                {
                    TweenMax.to(this.sp, param1 / 2, {alpha:this.getRandom(0.3, 0.5), ease:Linear.easeNone});
                    break;
                }
                case "explosion_smoke":
                case "explosion_smoke_Wall":
                {
                    TweenMax.to(this.sp, param1 / 2, {alpha:0, ease:Linear.easeNone});
                    TweenMax.to(this.sp, param1 / 2, {scaleX:1.2, scaleY:1.2, ease:Linear.easeNone});
                    break;
                }
                default:
                {
                    TweenMax.to(this.sp, param1 / 2, {alpha:this.getRandom(0.3, 0.5), ease:Linear.easeNone});
                    TweenMax.to(this.sp, param1 / 2, {scaleX:1.2, scaleY:1.2, ease:Linear.easeNone});
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function getRandom(param1:Number, param2:Number) : Number
        {
            return param1 + Math.random() * (param2 - param1);
        }// end function

        private function onFinishTween() : void
        {
            if (this.avt)
            {
                this.avt.destroy();
            }
            if (this.sp.parent)
            {
                this.sp.parent.removeChild(this.sp);
                this.sp.visible = false;
                this.sp = null;
            }
            return;
        }// end function

    }
}
