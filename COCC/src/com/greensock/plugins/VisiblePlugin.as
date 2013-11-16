package com.greensock.plugins
{
    import com.greensock.*;

    public class VisiblePlugin extends TweenPlugin
    {
        protected var _target:Object;
        protected var _tween:TweenLite;
        protected var _visible:Boolean;
        protected var _initVal:Boolean;
        protected var _progress:int;
        public static const API:Number = 1;

        public function VisiblePlugin()
        {
            this.propName = "visible";
            this.overwriteProps = ["visible"];
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            this._target = param1;
            this._tween = param3;
            this._progress = this._tween.vars.runBackwards ? (0) : (1);
            this._initVal = this._target.visible;
            this._visible = Boolean(param2);
            return true;
        }// end function

        override public function set changeFactor(param1:Number) : void
        {
            this._target.visible = (param1 == 1 || param1 == 0) && this._tween.cachedTime / this._tween.cachedDuration == this._progress ? (this._visible) : (this._initVal);
            return;
        }// end function

    }
}
