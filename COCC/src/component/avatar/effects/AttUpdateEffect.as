package component.avatar.effects
{
    import com.greensock.easing.*;
    import component.avatar.controls.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import resMgr.*;
    import utility.*;

    public class AttUpdateEffect extends Sprite
    {
        private var start:int;
        private var total:int;
        private var initY:int;
        private var scale:Number = 1;
        private var time:int;
        private var maxTime:int;
        private var grapTxt:GraphicsText;
        public static const M_HP:int = 5;
        public static const LVL:int = 1;
        public static const A_HP:int = 4;
        private static const NULL:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        public static const SKILL_M_HP:int = 10;
        public static const IMMUNO:int = 11;
        public static const SCALE_CRIT:Number = 1;
        public static const SKILL_A_HP:int = 9;
        public static const M_MP:int = 3;
        private static const YELLOW:ColorTransform = new ColorTransform(0, 0, 0, 1, 255, 255, 0, 1);
        private static const VIOLET:ColorTransform = new ColorTransform(0, 0, 0, 1, 255, 0, 255, 1);
        public static const INVALID:int = 6;
        public static const CRIT:int = 7;
        private static const FILTERS:Array = [new DropShadowFilter(1, 90, 0, 1, 2, 2, 4)];
        private static var pool:Array = new Array();
        public static const SCALE_BASE:Number = 0.7;
        public static const A_MP:int = 2;
        private static const GREEN:ColorTransform = new ColorTransform(0, 0, 0, 1, 0, 255, 0, 1);
        public static const SKILL_CRIT:int = 8;
        private static const RED:ColorTransform = new ColorTransform(0, 0, 0, 1, 255, 0, 0, 1);
        private static const BLUE:ColorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 255, 1);
        private static const BLUE_LIGHT:ColorTransform = new ColorTransform(0, 0, 0, 1, 50, 155, 255, 1);
        public static const DODGE:int = 13;
        public static const EXP:int = 12;
        public static const GOLD:int = 14;
        public static const ELIXIR:int = 15;
        public static const COIN:int = 16;

        public function AttUpdateEffect() : void
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this.grapTxt = new GraphicsText();
            this.grapTxt.cacheAsBitmap = true;
            addChild(this.grapTxt);
            return;
        }// end function

        private function onMove() : void
        {
            this.y = this.initY + Back.easeOut(this.time, 0, this.total, this.maxTime, 3);
            var _loc_1:String = this;
            var _loc_2:* = this.time + 1;
            _loc_1.time = _loc_2;
            if (this.time > this.maxTime)
            {
                if (parent)
                {
                    parent.removeChild(this);
                }
                FrameTimerManager.getInstance().remove(this.onMove);
            }
            return;
        }// end function

        public function play(param1:Avatar, param2:int, param3:int, param4:int = 0, param5:String = null) : void
        {
            var _loc_8:Sprite = null;
            this.maxTime = 25;
            var _loc_6:String = null;
            var _loc_7:ColorTransform = null;
            param3 = param3 > 0 ? (param3) : (-param3);
            this.scale = SCALE_BASE;
            switch(param2)
            {
                case GOLD:
                {
                    _loc_6 = Utility.standardNumber(param3);
                    _loc_7 = YELLOW;
                    this.scale = 1;
                    break;
                }
                case ELIXIR:
                {
                    _loc_6 = Utility.standardNumber(param3);
                    _loc_7 = VIOLET;
                    this.scale = 1;
                    break;
                }
                case EXP:
                {
                    _loc_6 = Utility.standardNumber(param3);
                    _loc_7 = BLUE_LIGHT;
                    this.scale = 1;
                    break;
                }
                default:
                {
                    return;
                    break;
                }
            }
            this.grapTxt.text = _loc_6;
            this.grapTxt.transform.colorTransform = _loc_7;
            this.grapTxt.x = (-this.grapTxt.width) / 2;
            this.grapTxt.y = -5;
            this.filters = FILTERS;
            this.x = param1.layerBody.x;
            this.y = param1.layerBody.y - param1.height + 30;
            this.initY = param1.layerBody.y - param1.height + 30;
            this.scaleX = this.scale;
            this.scaleY = this.scale;
            if (param4 <= 1)
            {
                this.y = this.y - 30;
            }
            else if (param4 == 2)
            {
                this.y = this.y - 60;
            }
            else
            {
                this.y = this.y - 90;
            }
            if (param5)
            {
                _loc_8 = ResMgr.getInstance().getMovieClip(param5) as Sprite;
                if (_loc_8)
                {
                    this.addChild(_loc_8);
                    _loc_8.x = this.grapTxt.x + this.grapTxt.width + 3;
                    _loc_8.y = this.grapTxt.y + (this.grapTxt.height - _loc_8.height) / 2;
                }
            }
            this.start = this.y;
            this.time = 0;
            this.total = -50;
            param1.addChild(this);
            FrameTimerManager.getInstance().add(1, 0, this.onMove);
            return;
        }// end function

        public function play2(param1:Sprite, param2:int, param3:int, param4:Point, param5:int = 0) : void
        {
            this.maxTime = 25;
            var _loc_6:String = null;
            var _loc_7:ColorTransform = null;
            param3 = param3 > 0 ? (param3) : (-param3);
            this.scale = SCALE_BASE;
            switch(param2)
            {
                case GOLD:
                {
                    _loc_6 = Utility.standardNumber(param3);
                    _loc_7 = YELLOW;
                    this.scale = 1;
                    break;
                }
                case ELIXIR:
                {
                    _loc_6 = Utility.standardNumber(param3);
                    _loc_7 = VIOLET;
                    this.scale = 1;
                    break;
                }
                case EXP:
                {
                    _loc_6 = Utility.standardNumber(param3);
                    _loc_7 = BLUE_LIGHT;
                    this.scale = 1;
                    break;
                }
                case COIN:
                {
                    _loc_6 = Utility.standardNumber(param3);
                    _loc_7 = GREEN;
                    this.scale = 1;
                    break;
                }
                default:
                {
                    return;
                    break;
                }
            }
            this.grapTxt.text = _loc_6;
            this.grapTxt.transform.colorTransform = _loc_7;
            this.grapTxt.x = (-this.grapTxt.width) / 2;
            this.grapTxt.y = -5;
            this.filters = FILTERS;
            this.x = param4.x;
            this.y = param4.y;
            this.initY = param4.y;
            this.scaleX = this.scale;
            this.scaleY = this.scale;
            if (param5 <= 1)
            {
                this.y = this.y - 30;
            }
            else if (param5 == 2)
            {
                this.y = this.y - 200;
            }
            else
            {
                this.y = this.y - 90;
            }
            this.start = this.y;
            this.time = 0;
            this.total = -100;
            param1.addChild(this);
            FrameTimerManager.getInstance().add(1, 0, this.onMove);
            return;
        }// end function

        public static function play(param1:Avatar, param2:int, param3:int, param4:int = 0, param5:String = null) : void
        {
            if (pool.length > 0)
            {
                pool.pop().play(param1, param2, param3, param4, param5);
            }
            else
            {
                new AttUpdateEffect.play(param1, param2, param3, param4, param5);
            }
            return;
        }// end function

        public static function play2(param1:Sprite, param2:int, param3:int, param4:Point, param5:int = 0) : void
        {
            if (pool.length > 0)
            {
                pool.pop().play2(param1, param2, param3, param4, param5);
            }
            else
            {
                new AttUpdateEffect.play2(param1, param2, param3, param4, param5);
            }
            return;
        }// end function

    }
}
