package component
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ScrollBar extends Object
    {
        private var barBtn:Sprite;
        private var railCtn:Sprite;
        private var _isDown:Boolean = false;
        private var heightRail:Number;
        private var widthRail:Number;
        private var delta:Number;
        private var data:Sprite;
        private var pos:Point = null;
        private var stepMove:Number;
        private var downBtn:Sprite;
        private var upBtn:Sprite;
        private var rootDataY:Number;
        private var mask:Sprite;
        private var heightScroll:Number;
        private var rootTopBarY:Number;

        public function ScrollBar(param1:Sprite, param2:Sprite, param3:Sprite, param4:Sprite, param5:Rectangle)
        {
            this.railCtn = param1;
            this.barBtn = param2;
            this.heightRail = this.railCtn.height;
            this.widthRail = this.railCtn.width;
            this.rootTopBarY = 0;
            this.mask = new Sprite();
            this.mask.graphics.beginFill(0, 0);
            this.mask.graphics.drawRect(param5.x, param5.y, param5.width, param5.height);
            this.mask.graphics.endFill();
            this.upBtn = param4;
            this.downBtn = param3;
            return;
        }// end function

        public function get isDown() : Boolean
        {
            return this._isDown;
        }// end function

        public function set isDown(param1:Boolean) : void
        {
            this._isDown = param1;
            return;
        }// end function

        public function clean() : void
        {
            this.barBtn.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDownBar);
            this.barBtn.removeEventListener(MouseEvent.MOUSE_UP, this.onUpBar);
            this.railCtn.removeEventListener(MouseEvent.CLICK, this.onClickRail);
            this.downBtn.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDownDown);
            this.upBtn.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDownUp);
            this.railCtn.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onScrollWheel);
            if (this.barBtn.stage)
            {
                this.barBtn.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onUpStage);
                this.barBtn.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
            }
            return;
        }// end function

        private function onScrollWheel(event:MouseEvent) : void
        {
            if (event.delta > 0)
            {
                this.onDownUp(event);
            }
            else
            {
                this.onDownDown(event);
            }
            return;
        }// end function

        public function addEvent() : void
        {
            this.clean();
            this.barBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.onDownBar);
            this.barBtn.addEventListener(MouseEvent.MOUSE_UP, this.onUpBar);
            this.railCtn.addEventListener(MouseEvent.CLICK, this.onClickRail);
            this.downBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.onDownDown);
            this.upBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.onDownUp);
            this.railCtn.addEventListener(MouseEvent.MOUSE_WHEEL, this.onScrollWheel);
            if (this.barBtn.stage)
            {
                this.barBtn.stage.addEventListener(MouseEvent.MOUSE_UP, this.onUpStage);
                this.barBtn.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMove);
            }
            return;
        }// end function

        public function onDownUp(event:MouseEvent) : void
        {
            if (this.barBtn.y == this.rootTopBarY)
            {
                return;
            }
            this.barBtn.y = this.barBtn.y - this.stepMove;
            if (this.barBtn.y < this.rootTopBarY)
            {
                this.barBtn.y = this.rootTopBarY;
            }
            this.data.y = this.rootDataY - this.stepMove * (this.barBtn.y - this.rootTopBarY);
            return;
        }// end function

        public function updateData() : void
        {
            if (this.data == null)
            {
                return;
            }
            this.stepMove = (this.data.height - this.heightRail) / this.delta;
            this.data.y = this.rootDataY - this.stepMove * (this.barBtn.y - this.rootTopBarY);
            return;
        }// end function

        public function onDownDown(event:MouseEvent) : void
        {
            if (this.barBtn.y == this.delta + this.rootTopBarY)
            {
                return;
            }
            this.barBtn.y = this.barBtn.y + this.stepMove;
            if (this.barBtn.y - this.rootTopBarY > this.delta)
            {
                this.setEndBar();
            }
            this.data.y = this.rootDataY - this.stepMove * (this.barBtn.y - this.rootTopBarY);
            return;
        }// end function

        public function setEndBar() : void
        {
            this.barBtn.y = this.delta + this.rootTopBarY;
            return;
        }// end function

        public function setData(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = -1) : void
        {
            if (param4 > -1)
            {
                this.heightRail = param4;
            }
            if (param5 > -1)
            {
                this.rootTopBarY = param5;
            }
            if (param6 > -1)
            {
                this.heightScroll = param6;
            }
            else
            {
                this.heightScroll = this.heightRail;
            }
            if (this.data)
            {
                if (this.data.parent)
                {
                    if (this.data.parent.contains(this.mask))
                    {
                        this.data.parent.removeChild(this.mask);
                    }
                }
            }
            param1.x = param2;
            param1.y = param3;
            this.data = param1;
            this.rootDataY = this.data.y;
            if (this.data.height > 0)
            {
                this.barBtn.scaleY = this.heightRail / this.data.height * this.barBtn.scaleY;
            }
            var _loc_7:* = this.barBtn.height;
            if (this.railCtn.height / this.heightRail != 1)
            {
            }
            this.delta = this.heightRail - _loc_7;
            this.stepMove = (this.data.height - this.heightScroll) / this.delta;
            this.data.mask = this.mask;
            this.data.parent.addChild(this.mask);
            this.refresh();
            this.addEvent();
            return;
        }// end function

        public function setMask(param1:Rectangle) : void
        {
            if (this.data == null)
            {
                return;
            }
            this.data.parent.removeChild(this.mask);
            this.mask = new Sprite();
            this.mask.graphics.beginFill(0, 0);
            this.mask.graphics.drawRect(param1.x, param1.y, param1.width, param1.height);
            this.mask.graphics.endFill();
            this.data.parent.addChild(this.mask);
            return;
        }// end function

        public function removeMask() : void
        {
            if (this.mask.parent != null)
            {
                this.mask.parent.removeChild(this.mask);
            }
            return;
        }// end function

        public function refresh() : void
        {
            this.barBtn.y = this.rootTopBarY;
            this.data.y = this.rootDataY;
            this.isDown = false;
            this.pos = null;
            if (-this.mask.height + this.data.height <= 2)
            {
                this.barBtn.visible = false;
                this.upBtn.visible = false;
                this.downBtn.visible = false;
                this.railCtn.visible = false;
            }
            else
            {
                this.barBtn.visible = true;
                this.upBtn.visible = true;
                this.downBtn.visible = true;
                this.railCtn.visible = true;
            }
            return;
        }// end function

        public function clear() : void
        {
            this.clean();
            if (this.data)
            {
                if (this.data.parent)
                {
                    if (this.data.parent.contains(this.mask))
                    {
                        this.data.parent.removeChild(this.mask);
                    }
                }
            }
            this.data = null;
            this.railCtn = null;
            this.barBtn = null;
            this.upBtn = null;
            this.downBtn = null;
            return;
        }// end function

        private function onClickRail(event:MouseEvent) : void
        {
            if (event.target == this.railCtn)
            {
                this.barBtn.y = this.railCtn.y + event.localY;
                if (this.barBtn.y - this.rootTopBarY > this.delta)
                {
                    this.barBtn.y = this.delta + this.rootTopBarY;
                }
                this.data.y = this.rootDataY - (this.barBtn.y - this.rootTopBarY) * this.stepMove;
            }
            return;
        }// end function

        private function onUpStage(event:MouseEvent) : void
        {
            this.onUpBar(event);
            return;
        }// end function

        private function setPosData() : void
        {
            if (this.pos == null)
            {
                this.pos = new Point(this.barBtn.x, this.barBtn.y);
            }
            else
            {
                this.data.y = this.data.y + (this.pos.y - this.barBtn.y) * this.stepMove;
                this.pos.y = this.barBtn.y;
            }
            if (this.barBtn.y < this.rootTopBarY)
            {
                this.barBtn.y = this.rootTopBarY;
            }
            if (this.barBtn.y - this.rootTopBarY > this.delta)
            {
                this.barBtn.y = this.delta + this.rootTopBarY;
            }
            this.data.y = this.rootDataY - (this.barBtn.y - this.rootTopBarY) * this.stepMove;
            return;
        }// end function

        private function onMove(event:MouseEvent) : void
        {
            if (this.isDown)
            {
                this.setPosData();
            }
            return;
        }// end function

        private function onDownBar(event:MouseEvent) : void
        {
            this._isDown = true;
            this.barBtn.startDrag(false, new Rectangle(this.barBtn.x, this.rootTopBarY, 0, this.delta));
            return;
        }// end function

        private function onUpBar(event:MouseEvent) : void
        {
            if (this.barBtn == null)
            {
                return;
            }
            this._isDown = false;
            this.barBtn.stopDrag();
            this.pos = null;
            return;
        }// end function

        public function scrollToChild(param1:DisplayObject) : void
        {
            var _loc_2:Number = NaN;
            if (this.data.contains(param1))
            {
                _loc_2 = param1.y;
                this.data.y = this.rootDataY - _loc_2;
                this.barBtn.y = _loc_2 / this.stepMove + this.rootTopBarY;
                if (this.barBtn.y - this.rootTopBarY > this.delta)
                {
                    this.barBtn.y = this.delta + this.rootTopBarY;
                }
            }
            return;
        }// end function

    }
}
