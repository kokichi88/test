package component.avatar.things
{
    import component.avatar.controls.*;
    import component.avatar.model.animation.*;
    import flash.events.*;

    public class BitmapObj extends EventDispatcher
    {
        private var _isComplete:Boolean;
        private var _name:String;
        private var _reset:Boolean = false;
        private var _data:AnLoadData;
        private var _visible:Boolean = true;
        private var _category:String;
        public static const VISIBLE:String = "visible";
        public static const COMPLETE:String = "complete";
        public static const UNLOAD:String = "unload";

        public function BitmapObj()
        {
            return;
        }// end function

        private function checkComplete() : void
        {
            if (this._data)
            {
                if (this._data.ready)
                {
                    this._isComplete = true;
                    FrameTimerManager.getTimer().remove(this.checkComplete);
                    dispatchEvent(new Event(COMPLETE));
                }
            }
            else
            {
                FrameTimerManager.getTimer().remove(this.checkComplete);
            }
            return;
        }// end function

        public function get defined() : Boolean
        {
            return this._data != null;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            if (param1 == this._visible)
            {
                return;
            }
            this._visible = param1;
            dispatchEvent(new Event(VISIBLE));
            return;
        }// end function

        public function setSource(param1:String, param2:String, param3:int = 0) : void
        {
            if (this._category != param1 || this._name != param2)
            {
                if (this._data)
                {
                    var _loc_4:* = this._data;
                    var _loc_5:* = this._data.ref - 1;
                    _loc_4.ref = _loc_5;
                }
                this._category = param1;
                this._name = param2;
                this._data = GlobalVar.animationManager.getAnimation(param1, param2);
                if (this._data)
                {
                    var _loc_4:* = this._data;
                    var _loc_5:* = this._data.ref + 1;
                    _loc_4.ref = _loc_5;
                }
                if (param3 > this._data.priority)
                {
                    this._data.priority = param3;
                }
                this._reset = true;
            }
            return;
        }// end function

        public function load() : void
        {
            if (!this._data)
            {
                return;
            }
            GlobalVar.animationManager.load(this._data);
            if (this._reset)
            {
                this._reset = false;
                FrameTimerManager.getTimer().add(1, 0, this.checkComplete);
            }
            return;
        }// end function

        public function get data() : AnLoadData
        {
            return this._data;
        }// end function

        public function get visible() : Boolean
        {
            return this._visible;
        }// end function

        public function unload() : void
        {
            if (!this._data)
            {
                return;
            }
            var _loc_1:* = this._data;
            var _loc_2:* = this._data.ref - 1;
            _loc_1.ref = _loc_2;
            this._name = null;
            this._category = null;
            this._data = null;
            this._reset = true;
            if (this._isComplete)
            {
                this._isComplete = false;
            }
            return;
        }// end function

    }
}
