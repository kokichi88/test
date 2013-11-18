package component.avatar.controls
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import component.avatar.things.*;
    import flash.display.*;
    import flash.geom.*;

    public class EffectDraw extends Object
    {

        public function EffectDraw()
        {
            return;
        }// end function

        public static function play(param1:String, param2:Point, param3:DisplayObjectContainer, param4:int = -1, param5:int = -1) : AniEffect
        {
            var _loc_6:* = new AniEffect(param1);
           _loc_6.play(param3, param2, param4, param5);
            _loc_6.mouseChildren = false;
            _loc_6.mouseEnabled = false;
            return _loc_6;
        }// end function

        public static function vibrateLayer(param1:Sprite, param2:int) : void
        {
            TweenMax.to(param1, 0.1, {repeat:param2, y:(param1.y + 1) + 3, x:(param1.y + 1) + 3, ease:Expo.easeInOut, onComplete:onFinish, onCompleteParams:[param1]});
            return;
        }// end function

        private static function onFinish(param1:Sprite) : void
        {
            var _loc_2:int = 0;
            param1.y = 0;
            param1.x = _loc_2;
            return;
        }// end function

        public static function effShowHideAlpha(param1, param2:Number = 1, param3:Number = 0, param4:Number = 1, param5:Function = null, param6:Array = null, param7:Number = 0) : void
        {
            param1.alpha = param3;
            if (param5 != null)
            {
                TweenMax.to(param1, param2, {delay:param7, alpha:param4, onComplete:param5, onCompleteParams:param6});
            }
            else
            {
                TweenMax.to(param1, param2, {delay:param7, alpha:param4});
            }
            return;
        }// end function

    }
}
