package component
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import modules.city.logic.*;
    import resMgr.*;

    public class InteractivePNG extends MovieClip
    {
        protected var _threshold:uint = 0;
        protected var _transparentMode:Boolean = false;
        protected var _interactivePngActive:Boolean = false;
        protected var _bitmapHit:Boolean = false;
        protected var _basePoint:Point;
        protected var _mousePoint:Point;
        protected var _bitmapForHitDetection:Bitmap;
        protected var _buttonModeCache:Number = NaN;
        public var type:String;
        public var mapObject:MapObject;

        public function InteractivePNG() : void
        {
            this._basePoint = new Point();
            this._mousePoint = new Point();
            return;
        }// end function

        public function get interactivePngActive() : Boolean
        {
            return this._interactivePngActive;
        }// end function

        public function get alphaTolerance() : uint
        {
            return this._threshold;
        }// end function

        public function set alphaTolerance(param1:uint) : void
        {
            this._threshold = Math.min(255, param1);
            return;
        }// end function

        override public function set hitArea(param1:Sprite) : void
        {
            if (param1 != null && super.hitArea == null)
            {
                this.disableInteractivePNG();
            }
            else if (param1 == null && super.hitArea != null)
            {
                this.enableInteractivePNG();
            }
            super.hitArea = param1;
            return;
        }// end function

        override public function set mouseEnabled(param1:Boolean) : void
        {
            if (isNaN(this._buttonModeCache) == false)
            {
                this.disableInteractivePNG();
            }
            super.mouseEnabled = param1;
            return;
        }// end function

        public function setImage(param1:String) : void
        {
            var _loc_2:* = ResMgr.getInstance().getMovieClip(param1) as Sprite;
            addChild(_loc_2);
            return;
        }// end function

        public function drawBitmapHitArea(event:Event = null) : void
        {
            var _loc_2:* = this._bitmapForHitDetection != null;
            if (_loc_2)
            {
                try
                {
                    removeChild(this._bitmapForHitDetection);
                }
                catch (e:Error)
                {
                }
            }
            var _loc_3:* = getBounds(this);
            var _loc_4:* = _loc_3.left;
            var _loc_5:* = _loc_3.top;
            var _loc_6:* = new BitmapData(_loc_3.width, _loc_3.height, true, 0);
            this._bitmapForHitDetection = new Bitmap(_loc_6);
            this._bitmapForHitDetection.name = "interactivePngHitMap";
            this._bitmapForHitDetection.visible = false;
            var _loc_7:* = new Matrix();
            _loc_7.translate(-_loc_4, -_loc_5);
            _loc_6.draw(this, _loc_7);
            addChildAt(this._bitmapForHitDetection, 0);
            this._bitmapForHitDetection.x = _loc_4;
            this._bitmapForHitDetection.y = _loc_5;
            return;
        }// end function

        public function disableInteractivePNG() : void
        {
            this.deactivateMouseTrap();
            removeEventListener(Event.ENTER_FRAME, this.trackMouseWhileInBounds);
            try
            {
                removeChild(this._bitmapForHitDetection);
            }
            catch (e:Error)
            {
            }
            super.mouseEnabled = true;
            this._transparentMode = false;
            this.setButtonModeCache(true);
            this._bitmapHit = false;
            this._interactivePngActive = false;
            return;
        }// end function

        public function enableInteractivePNG() : void
        {
            this.disableInteractivePNG();
            if (hitArea != null)
            {
                return;
            }
            this.activateMouseTrap();
            this._interactivePngActive = true;
            return;
        }// end function

        protected function activateMouseTrap() : void
        {
            addEventListener(MouseEvent.ROLL_OVER, this.captureMouseEvent, false, 10000, true);
            addEventListener(MouseEvent.MOUSE_OVER, this.captureMouseEvent, false, 10000, true);
            addEventListener(MouseEvent.ROLL_OUT, this.captureMouseEvent, false, 10000, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.captureMouseEvent, false, 10000, true);
            return;
        }// end function

        protected function deactivateMouseTrap() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER, this.captureMouseEvent);
            removeEventListener(MouseEvent.MOUSE_OVER, this.captureMouseEvent);
            removeEventListener(MouseEvent.ROLL_OUT, this.captureMouseEvent);
            removeEventListener(MouseEvent.MOUSE_OUT, this.captureMouseEvent);
            return;
        }// end function

        protected function captureMouseEvent(event:Event) : void
        {
            if (!this._transparentMode)
            {
                if (event.type == MouseEvent.MOUSE_OVER || event.type == MouseEvent.ROLL_OVER)
                {
                    this.setButtonModeCache();
                    this._transparentMode = true;
                    super.mouseEnabled = false;
                    addEventListener(Event.ENTER_FRAME, this.trackMouseWhileInBounds, false, 10000, true);
                    this.trackMouseWhileInBounds();
                }
            }
            if (!this._bitmapHit)
            {
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        protected function trackMouseWhileInBounds(event:Event = null) : void
        {
            if (this.bitmapHitTest() != this._bitmapHit)
            {
                this._bitmapHit = !this._bitmapHit;
                if (this._bitmapHit)
                {
                    this.deactivateMouseTrap();
                    this.setButtonModeCache(true, true);
                    this._transparentMode = false;
                    super.mouseEnabled = true;
                    this.mapObject.borderImage.visible = true;
                    this.mapObject.showTooltip();
                }
                else if (!this._bitmapHit)
                {
                    this._transparentMode = true;
                    super.mouseEnabled = false;
                    super.mouseChildren = false;
                    this.mapObject.borderImage.visible = false;
                    ActiveTooltip.getInstance().clearTooltip();
                }
            }
            var _loc_2:* = this._bitmapForHitDetection.localToGlobal(this._mousePoint);
            if (hitTestPoint(_loc_2.x, _loc_2.y) == false)
            {
                removeEventListener(Event.ENTER_FRAME, this.trackMouseWhileInBounds);
                this._transparentMode = false;
                this.setButtonModeCache(true);
                super.mouseEnabled = true;
                this.activateMouseTrap();
            }
            return;
        }// end function

        protected function bitmapHitTest() : Boolean
        {
            if (this._bitmapForHitDetection == null)
            {
                this.drawBitmapHitArea();
            }
            this._mousePoint.x = this._bitmapForHitDetection.mouseX;
            this._mousePoint.y = this._bitmapForHitDetection.mouseY;
            return this._bitmapForHitDetection.bitmapData.hitTest(this._basePoint, this._threshold, this._mousePoint);
        }// end function

        protected function setButtonModeCache(param1:Boolean = false, param2:Boolean = false) : void
        {
            if (param1)
            {
                if (this._buttonModeCache == 1)
                {
                    buttonMode = true;
                }
                if (!param2)
                {
                    this._buttonModeCache = NaN;
                }
                return;
            }
            this._buttonModeCache = buttonMode == true ? (1) : (0);
            buttonMode = false;
            return;
        }// end function

    }
}
