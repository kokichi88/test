package component
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import resMgr.*;

    public class Image extends EventDispatcher
    {
        public var img:Sprite;
        public var imgId:String;
        public var imgName:String;
        public var width:int;
        public var height:int;
        public var parent:Object = null;
        protected var _threshold:uint = 0;
        protected var _transparentMode:Boolean = false;
        protected var _interactivePngActive:Boolean = false;
        protected var _bitmapHit:Boolean = false;
        protected var _basePoint:Point;
        protected var _mousePoint:Point;
        protected var _bitmapForHitDetection:Bitmap;
        protected var _buttonModeCache:Number = NaN;

        public function Image()
        {
            this._basePoint = new Point();
            this._mousePoint = new Point();
            return;
        }// end function

        public function setInfo(param1:Object, param2:String, param3:int = 0, param4:int = 0, param5:String = "") : void
        {
            this.parent = param1;
            this.imgName = param2;
            if (param2 != "")
            {
                this.loadRes(param2);
            }
            return;
        }// end function

        private function loadRes(param1:String) : void
        {
            if (this.img != null)
            {
                if (this.parent != null && this.img.parent == this.parent)
                {
                    this.parent.removeChild(this.img);
                }
            }
            this.img = ResMgr.getInstance().getMovieClip(param1) as Sprite;
            this.img.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            this.img.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
            this.img.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            this.img.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
            this.img.addEventListener(MouseEvent.CLICK, this.onClick);
            this.img.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.width = this.img.width;
            this.height = this.img.height;
            this.parent.addChild(this.img);
            return;
        }// end function

        protected function onOver(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function onOut(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function onDown(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function onUp(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function onClick(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function onEnterFrame(event:Event) : void
        {
            return;
        }// end function

        public function clear() : void
        {
            if (this.img != null)
            {
                if (this.parent != null && this.img.parent == this.parent)
                {
                    this.parent.removeChild(this.img);
                }
                this.img.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
                this.img.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
                this.img.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
                this.img.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
                this.img.removeEventListener(MouseEvent.CLICK, this.onClick);
                this.img.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                this.width = 0;
                this.height = 0;
            }
            return;
        }// end function

        public function drawBitmapHitArea(event:Event = null) : void
        {
            var _loc_2:* = this._bitmapForHitDetection != null;
            if (_loc_2)
            {
                try
                {
                    this.img.removeChild(this._bitmapForHitDetection);
                }
                catch (e:Error)
                {
                }
            }
            var _loc_3:* = this.img.getBounds(this.img);
            var _loc_4:* = _loc_3.left;
            var _loc_5:* = _loc_3.top;
            var _loc_6:* = new BitmapData(_loc_3.width, _loc_3.height, true, 0);
            this._bitmapForHitDetection = new Bitmap(_loc_6);
            this._bitmapForHitDetection.name = "interactivePngHitMap";
            this._bitmapForHitDetection.visible = false;
            var _loc_7:* = new Matrix();
           _loc_7.translate(-_loc_4, -_loc_5);
            _loc_6.draw(this.img, _loc_7);
            this.img.addChildAt(this._bitmapForHitDetection, 0);
            this._bitmapForHitDetection.x = _loc_4;
            this._bitmapForHitDetection.y = _loc_5;
            return;
        }// end function

        public function disableInteractivePNG() : void
        {
            this.deactivateMouseTrap();
            this.img.removeEventListener(Event.ENTER_FRAME, this.trackMouseWhileInBounds);
            try
            {
                this.img.removeChild(this._bitmapForHitDetection);
            }
            catch (e:Error)
            {
            }
            this.img.mouseEnabled = true;
            this._transparentMode = false;
            this._bitmapHit = false;
            this._interactivePngActive = false;
            return;
        }// end function

        public function enableInteractivePNG() : void
        {
            this.disableInteractivePNG();
            if (this.img.hitArea != null)
            {
                return;
            }
            this.activateMouseTrap();
            this._interactivePngActive = true;
            return;
        }// end function

        protected function activateMouseTrap() : void
        {
            this.img.addEventListener(MouseEvent.ROLL_OVER, this.captureMouseEvent);
            this.img.addEventListener(MouseEvent.MOUSE_OVER, this.captureMouseEvent);
            this.img.addEventListener(MouseEvent.ROLL_OUT, this.captureMouseEvent);
            this.img.addEventListener(MouseEvent.MOUSE_OUT, this.captureMouseEvent);
            this.img.addEventListener(MouseEvent.MOUSE_MOVE, this.captureMouseEvent);
            return;
        }// end function

        protected function deactivateMouseTrap() : void
        {
            this.img.removeEventListener(MouseEvent.ROLL_OVER, this.captureMouseEvent);
            this.img.removeEventListener(MouseEvent.MOUSE_OVER, this.captureMouseEvent);
            this.img.removeEventListener(MouseEvent.ROLL_OUT, this.captureMouseEvent);
            this.img.removeEventListener(MouseEvent.MOUSE_OUT, this.captureMouseEvent);
            this.img.removeEventListener(MouseEvent.MOUSE_MOVE, this.captureMouseEvent);
            return;
        }// end function

        protected function captureMouseEvent(event:Event) : void
        {
            if (!this._transparentMode)
            {
                if (event.type == MouseEvent.MOUSE_OVER || event.type == MouseEvent.ROLL_OVER)
                {
                    if (this._bitmapHit)
                    {
                        this.onMouseOver();
                    }
                    this._transparentMode = true;
                    this.img.mouseEnabled = false;
                    this.img.addEventListener(Event.ENTER_FRAME, this.trackMouseWhileInBounds);
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
                    this._transparentMode = false;
                    this.img.mouseEnabled = true;
                    this.onMouseOver();
                }
                else if (!this._bitmapHit)
                {
                    this._transparentMode = true;
                    this.img.mouseEnabled = false;
                }
            }
            var _loc_2:* = this._bitmapForHitDetection.localToGlobal(this._mousePoint);
            var _loc_3:* = this.img.hitTestPoint(_loc_2.x, _loc_2.y);
            if (!_loc_3)
            {
                this.img.removeEventListener(Event.ENTER_FRAME, this.trackMouseWhileInBounds);
                this._transparentMode = false;
                this.img.mouseEnabled = true;
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
            var _loc_1:* = this._bitmapForHitDetection.bitmapData.hitTest(this._basePoint, this._threshold, this._mousePoint);
            return _loc_1;
        }// end function

        public function onMouseOver() : void
        {
            return;
        }// end function

        public function onMouseClick() : void
        {
            return;
        }// end function

        public function onMouseOut() : void
        {
            return;
        }// end function

    }
}
