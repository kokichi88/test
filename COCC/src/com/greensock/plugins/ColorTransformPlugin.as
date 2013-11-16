package com.greensock.plugins
{
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;

    public class ColorTransformPlugin extends TintPlugin
    {
        public static const API:Number = 1;

        public function ColorTransformPlugin()
        {
            this.propName = "colorTransform";
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            var _loc_4:ColorTransform = null;
            var _loc_6:String = null;
            var _loc_7:Number = NaN;
            var _loc_5:* = new ColorTransform();
            if (param1 is DisplayObject)
            {
                _transform = DisplayObject(param1).transform;
                _loc_4 = _transform.colorTransform;
            }
            else if (param1 is ColorTransform)
            {
                _loc_4 = param1 as ColorTransform;
            }
            else
            {
                return false;
            }
            _loc_5.concat(_loc_4);
            for (_loc_6 in param2)
            {
                
                if (_loc_6 == "tint" || _loc_6 == "color")
                {
                    if (param2[_loc_6] != null)
                    {
                        _loc_5.color = int(param2[_loc_6]);
                    }
                    continue;
                }
                if (_loc_6 == "tintAmount" || _loc_6 == "exposure" || _loc_6 == "brightness")
                {
                    continue;
                }
                _loc_5[_loc_6] = param2[_loc_6];
            }
            if (!isNaN(param2.tintAmount))
            {
                _loc_7 = param2.tintAmount / (1 - (_loc_5.redMultiplier + _loc_5.greenMultiplier + _loc_5.blueMultiplier) / 3);
                _loc_5.redOffset = _loc_5.redOffset * _loc_7;
                _loc_5.greenOffset = _loc_5.greenOffset * _loc_7;
                _loc_5.blueOffset = _loc_5.blueOffset * _loc_7;
                var _loc_8:* = 1 - param2.tintAmount;
                _loc_5.blueMultiplier = 1 - param2.tintAmount;
                var _loc_8:* = _loc_8;
                _loc_5.greenMultiplier = _loc_8;
                _loc_5.redMultiplier = _loc_8;
            }
            else if (!isNaN(param2.exposure))
            {
                var _loc_8:* = 255 * (param2.exposure - 1);
                _loc_5.blueOffset = 255 * (param2.exposure - 1);
                var _loc_8:* = _loc_8;
                _loc_5.greenOffset = _loc_8;
                _loc_5.redOffset = _loc_8;
                var _loc_8:int = 1;
                _loc_5.blueMultiplier = 1;
                var _loc_8:* = _loc_8;
                _loc_5.greenMultiplier = _loc_8;
                _loc_5.redMultiplier = _loc_8;
            }
            else if (!isNaN(param2.brightness))
            {
                var _loc_8:* = Math.max(0, (param2.brightness - 1) * 255);
                _loc_5.blueOffset = Math.max(0, (param2.brightness - 1) * 255);
                var _loc_8:* = _loc_8;
                _loc_5.greenOffset = _loc_8;
                _loc_5.redOffset = _loc_8;
                var _loc_8:* = 1 - Math.abs((param2.brightness - 1));
                _loc_5.blueMultiplier = 1 - Math.abs((param2.brightness - 1));
                var _loc_8:* = _loc_8;
                _loc_5.greenMultiplier = _loc_8;
                _loc_5.redMultiplier = _loc_8;
            }
            init(_loc_4, _loc_5);
            return true;
        }// end function

    }
}
