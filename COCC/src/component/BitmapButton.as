package component
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    import modules.sound.*;

    public class BitmapButton extends Object
    {
        private var loader:Loader;
        public var objId:String;
        public var eventHandler:Object;
        public var img:MovieClip;
        public var curState:int = 0;
        private var _enable:Boolean = true;
        public var width:int;
        public var height:int;
        public var tooltip:DisplayObject;
        public var nFrame:int = 4;
        private var _lock:Boolean = false;
        public var objName:String;
        public var id:String;
        private var skillNext:DisplayObject = null;
        public var alwayClickAble:Boolean = false;
        private var isBlink:Boolean = false;
        private var btnDy:int = 0;
        private var pressTimer:Timer;
        private var shakeTimer:Timer;
        private var curRotateImg:Number;
        private var imgX:Number;
        private var imgY:Number;
        private var count:int = 0;
        private var isShaking:Boolean;
        public static const disableFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0]);
        public static const redFilter:ColorMatrixFilter = new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1]);
        public static const downFilter:ColorMatrixFilter = new ColorMatrixFilter([1, 0, 0, 0, -30, 0, 1, 0, 0, -30, 0, 0, 1, 0, -30, 0, 0, 0, 1, 0]);
        public static const overFilter:ColorMatrixFilter = new ColorMatrixFilter([1.28, 0, 0, 0, 0, 0, 1.28, 0, 0, 0, 0, 0, 1.28, 0, 0, 0, 0, 0, 1, 0]);
        private static var urlLoaded:Object = new Object();
        public static const BTN_NORMAL:int = 0;
        public static const BTN_OVER:int = 1;
        public static const BTN_DOWN:int = 2;
        public static const BTN_DISABLE:int = 3;
        public static const BTN_DOWN_2:int = 4;
        private static const blinkFilter:ColorMatrixFilter = new ColorMatrixFilter([0.5, 0.5, 0.5, 0, 0, 0, 0.3, 0.3, 0.3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);

        public function BitmapButton(param1:MovieClip = null, param2:int = 4)
        {
            this.setImage(param1, param2);
            return;
        }// end function

        public function stopShake() : void
        {
            if (this.shakeTimer != null)
            {
                this.img.x = this.imgX;
                this.img.y = this.imgY;
                this.shakeTimer.removeEventListener(TimerEvent.TIMER, this.onShake);
                this.shakeTimer.stop();
                this.shakeTimer = null;
            }
            this.isShaking = false;
            return;
        }// end function

        public function showShake() : void
        {
            this.isShaking = true;
            this.imgX = this.img.x;
            this.imgY = this.img.y;
            this.img.filters = [new BlurFilter(1, 1, 3)];
            if (this.shakeTimer != null)
            {
                this.shakeTimer.removeEventListener(TimerEvent.TIMER, this.onShake);
                this.shakeTimer.stop();
                this.shakeTimer = null;
            }
            this.shakeTimer = new Timer(100);
            this.shakeTimer.addEventListener(TimerEvent.TIMER, this.onShake);
            this.shakeTimer.start();
            return;
        }// end function

        private function onShake(event:TimerEvent) : void
        {
            if (this.curRotateImg == 4)
            {
                this.curRotateImg = -4;
            }
            else
            {
                this.curRotateImg = 4;
            }
            var _loc_2:* = this.img.width / (2 * this.nFrame);
            var _loc_3:* = this.img.height / 2;
            var _loc_4:* = new Matrix();
           _loc_4.translate(-_loc_2, -_loc_3);
            _loc_4.rotate(this.curRotateImg * (Math.PI / 180));
            _loc_4.translate(this.imgX + _loc_2, this.imgY + _loc_3);
            this.img.transform.matrix = _loc_4;
            return;
        }// end function

        private function rotateImg() : void
        {
            return;
        }// end function

        public function showPress() : void
        {
            if (this.curState == BTN_DISABLE)
            {
                return;
            }
            if (this.pressTimer != null)
            {
                this.pressTimer.removeEventListener(TimerEvent.TIMER, this.onPressTimer);
                this.pressTimer.stop();
            }
            this.pressTimer = new Timer(90);
            this.pressTimer.addEventListener(TimerEvent.TIMER, this.onPressTimer);
            this.pressTimer.start();
            this.showState(BTN_DOWN);
            return;
        }// end function

        private function onPressTimer(event:TimerEvent) : void
        {
            if (this.curState == BTN_DISABLE)
            {
                return;
            }
            if (this.pressTimer != null)
            {
                this.pressTimer.removeEventListener(TimerEvent.TIMER, this.onPressTimer);
            }
            this.showState(BTN_NORMAL);
            return;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            if (this.img != null)
            {
                this.img.visible = param1;
            }
            return;
        }// end function

        public function get visible() : Boolean
        {
            if (this.img != null)
            {
                return this.img.visible;
            }
            return false;
        }// end function

        public function setBtnMode(param1:Boolean) : void
        {
            if (this.img != null)
            {
                this.img.buttonMode = param1;
            }
            return;
        }// end function

        public function setTabSelected() : void
        {
            if (!this.enable)
            {
                return;
            }
            this.showState(BTN_DOWN);
            this.lock = true;
            return;
        }// end function

        public function setTabNormal() : void
        {
            if (!this.enable)
            {
                return;
            }
            this.lock = false;
            this.showState(BTN_NORMAL);
            return;
        }// end function

        public function setNumFrame(param1:int) : void
        {
            this.nFrame = param1;
            this.width = this.img.width / this.nFrame;
            this.height = this.img.height;
            this.showState(this.curState);
            return;
        }// end function

        public function setImage(param1:MovieClip, param2:int = 4) : void
        {
            this.nFrame = param2;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:DisplayObjectContainer = null;
            var _loc_6:int = -1;
            if (this.img != null)
            {
                _loc_3 = this.img.x;
                _loc_4 = this.img.y;
                _loc_5 = this.img.parent;
                if (_loc_5 != null)
                {
                    _loc_6 = _loc_5.getChildIndex(this.img);
                }
            }
            this.clearImage();
            this.img = param1;
            if (this.img == null)
            {
                this.img = this.createDefaultContent();
            }
            this.width = this.img.width / this.nFrame;
            this.height = this.img.height;
            this.showState(BTN_NORMAL);
            this.img.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            this.img.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
            this.img.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            this.img.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
            this.img.addEventListener(MouseEvent.CLICK, this.onClick);
            this.img.buttonMode = true;
            if (_loc_5 != null)
            {
                this.img.x = _loc_3;
                this.img.y = _loc_4;
                if (_loc_6 >= 0)
                {
                    _loc_5.addChildAt(this.img, _loc_6);
                }
                else
                {
                    _loc_5.addChild(this.img);
                }
            }
            return;
        }// end function

        public function clearImage() : void
        {
            if (this.img == null)
            {
                return;
            }
            if (this.img.parent != null)
            {
                this.img.parent.removeChild(this.img);
            }
            this.img.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
            this.img.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
            this.img.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
            this.img.removeEventListener(MouseEvent.MOUSE_UP, this.onUp);
            this.img.removeEventListener(MouseEvent.CLICK, this.onClick);
            if (this.img)
            {
                this.img.visible = false;
            }
            return;
        }// end function

        public function setTooltip(param1:String) : void
        {
            var _loc_2:TooltipText = null;
            if (param1 != "")
            {
                _loc_2 = new TooltipText(true);
                _loc_2.text = param1;
                this.tooltip = _loc_2;
            }
            else
            {
                this.tooltip = null;
            }
            return;
        }// end function

        public function setTooltipDisplayObj(param1:DisplayObject = null, param2:DisplayObject = null) : void
        {
            if (param1 != null)
            {
                this.tooltip = param1;
                this.skillNext = param2;
            }
            else
            {
                this.tooltip = null;
            }
            return;
        }// end function

        public function setPos(param1:Number, param2:Number) : void
        {
            this.img.x = param1;
            this.img.y = param2;
            return;
        }// end function

        public function regEventHandler(param1) : void
        {
            this.eventHandler = param1;
            return;
        }// end function

        private function setDy(param1:int) : void
        {
            if (param1 == this.btnDy)
            {
                return;
            }
            this.img.y = this.img.y - this.btnDy;
            this.btnDy = param1;
            this.img.y = this.img.y + this.btnDy;
            return;
        }// end function

        public function showState(param1:int) : void
        {
            var _loc_2:* = this.curState;
            this.curState = param1;
            if (this.img.width <= 0)
            {
                return;
            }
            var _loc_3:* = this.width;
            if (param1 < this.nFrame && this.nFrame > 1)
            {
                this.img.scrollRect = new Rectangle(_loc_3 * param1, 0, this.width, this.height);
            }
            if (param1 == BTN_DISABLE && this.nFrame == 1)
            {
                this.setGrayscaleFilter(true);
            }
            if (_loc_2 == BTN_DISABLE && this.curState != BTN_DISABLE && this.nFrame == 1)
            {
                this.setGrayscaleFilter(false);
            }
            if (this.nFrame == 1)
            {
                switch(param1)
                {
                    case BTN_OVER:
                    {
                        this.img.filters = [overFilter];
                        break;
                    }
                    case BTN_DOWN:
                    {
                        this.img.filters = [downFilter];
                        this.setDy(1);
                        break;
                    }
                    case BTN_NORMAL:
                    {
                        this.img.filters = [];
                        this.setDy(0);
                        break;
                    }
                    case BTN_DISABLE:
                    {
                        this.img.filters = [disableFilter];
                        this.setDy(0);
                        break;
                    }
                    case BTN_DOWN_2:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function onUp(event:MouseEvent) : void
        {
            if (this.curState == BTN_DISABLE || this._lock)
            {
                return;
            }
            this.showState(BTN_OVER);
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            if ((this.curState == BTN_DISABLE || this._lock) && !this.alwayClickAble)
            {
                return;
            }
            if (this.eventHandler != null)
            {
                this.eventHandler.onMouseClick(this.objId, event);
            }
            SoundModule.getInstance().playSound(SoundModule.BUTTON_CLICK);
            this.stopShake();
            return;
        }// end function

        private function onDown(event:MouseEvent) : void
        {
            if (this.curState == BTN_DISABLE || this._lock)
            {
                return;
            }
            this.showState(BTN_DOWN);
            if (this.eventHandler != null)
            {
                this.eventHandler.onMouseDown(this.objId, event);
            }
            return;
        }// end function

        private function onOut(event:MouseEvent) : void
        {
            if (this.tooltip != null)
            {
                ActiveTooltip.getInstance().clearTooltip();
            }
            if (this.curState == BTN_DISABLE || this._lock)
            {
                return;
            }
            this.showState(BTN_NORMAL);
            return;
        }// end function

        private function onOver(event:MouseEvent) : void
        {
            if (this.tooltip != null)
            {
                ActiveTooltip.getInstance().showNewTooltip(this.tooltip, this.img);
            }
            if (this.curState == BTN_DISABLE || this._lock)
            {
                return;
            }
            this.showState(BTN_OVER);
            return;
        }// end function

        public function get enable() : Boolean
        {
            return this._enable;
        }// end function

        public function set enable(param1:Boolean) : void
        {
            if (param1 == this._enable)
            {
                return;
            }
            this._enable = param1;
            if (!param1)
            {
                this.showState(BTN_DISABLE);
            }
            else
            {
                this.showState(BTN_NORMAL);
            }
            return;
        }// end function

        public function get lock() : Boolean
        {
            return this._lock;
        }// end function

        public function set lock(param1:Boolean) : void
        {
            this._lock = param1;
            return;
        }// end function

        public function setGrayscaleFilter(param1:Boolean) : void
        {
            var _loc_2:Array = null;
            var _loc_3:ColorMatrixFilter = null;
            if (param1)
            {
                _loc_2 = [0.33, 0.33, 0.33, 0, 0, 0.33, 0.33, 0.33, 0, 0, 0.33, 0.33, 0.33, 0, 0, 0, 0, 0, 1, 0];
                _loc_3 = new ColorMatrixFilter(_loc_2);
                this.img.filters = [disableFilter];
            }
            else
            {
                this.img.filters = [];
            }
            return;
        }// end function

        public function setImageURL(param1:String, param2:int = 4) : void
        {
            if (this.loader != null)
            {
                this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.contentLoaded);
                this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
                this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.secuerityError);
            }
            var _loc_3:* = urlLoaded[param1];
            if (_loc_3 != null)
            {
                this.updateContent(_loc_3 as Loader, param2);
                return;
            }
            var _loc_4:* = new URLRequest(param1);
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.contentLoaded);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.secuerityError);
            this.loader.load(_loc_4);
            this.setImage(this.createDefaultContent(), param2);
            return;
        }// end function

        private function createDefaultContent() : MovieClip
        {
            var _loc_1:* = new MovieClip();
            _loc_1.graphics.beginFill(16776960);
            _loc_1.graphics.drawRect(0, 0, 100, 25);
            _loc_1.graphics.endFill();
            return _loc_1;
        }// end function

        private function secuerityError(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function ioError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private function updateContent(param1:Loader, param2:int = 4) : void
        {
            var _loc_3:MovieClip = null;
            var _loc_4:Bitmap = null;
            if (param1.contentLoaderInfo.contentType != "application/x-shockwave-flash")
            {
                _loc_3 = new MovieClip();
                _loc_4 = param1.content as Bitmap;
                _loc_3.addChild(new Bitmap(_loc_4.bitmapData.clone()));
                this.setImage(_loc_3, this.nFrame);
            }
            return;
        }// end function

        private function contentLoaded(event:Event) : void
        {
            urlLoaded[this.loader.contentLoaderInfo.url] = this.loader.content;
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.contentLoaded);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.secuerityError);
            this.updateContent(this.loader, this.nFrame);
            this.loader = null;
            return;
        }// end function

        public function blinkButton(param1:Boolean = true) : void
        {
            if (this.isBlink == param1)
            {
                return;
            }
            this.isBlink = param1;
            if (this.isBlink)
            {
                this.img.addEventListener(Event.ENTER_FRAME, this.onBlink);
            }
            else
            {
                this.img.filters = [];
                this.img.removeEventListener(Event.ENTER_FRAME, this.onBlink);
            }
            return;
        }// end function

        private function onBlink(event:Event) : void
        {
            this.count++;
            if (this.count > 30)
            {
                this.img.filters = [blinkFilter];
                this.count = 0;
            }
            if (this.count == 20)
            {
                this.img.filters = [];
            }
            return;
        }// end function

        public function setIdNameMovieClip(param1:String) : void
        {
            if (this.img)
            {
                this.img.name = param1;
            }
            return;
        }// end function

        public function shaking() : Boolean
        {
            return this.isShaking;
        }// end function

    }
}
