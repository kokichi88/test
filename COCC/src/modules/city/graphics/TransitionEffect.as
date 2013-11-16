package modules.city.graphics
{
    import com.greensock.*;
    import component.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import map.*;
    import resMgr.*;

    public class TransitionEffect extends BaseGui
    {
        private var curEffOut:int;
        private var curSquare:int = 1;
        private var pauseTime:int = 1;
        private var tempNum:int;
        private var effName:String = "in";
        private var effInTime:Timer;
        private var effOutTime:Timer;
        private var effType:int = 1;
        private var picTrans:Image;
        private var effArr:Array;
        private var squareArr:Array;
        private var func:Function;
        private var arg:Object;
        private var cloudLeft:Sprite;
        private var cloudRight:Sprite;
        private var bird:Sprite;
        private var statusText:TooltipText;
        private var sX:Number = 0;
        private var sY:Number = 0;
        private static const TIMER_DELAY:int = 40;
        private static const EFFECT_IN:String = "in";
        private static const EFFECT_OUT:String = "out";

        public function TransitionEffect()
        {
            this.effArr = [[[10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [11, 10, 9, 8, 7, 6, 5, 4, 3, 2], [12, 11, 10, 9, 8, 7, 6, 5, 4, 3], [13, 12, 11, 10, 9, 8, 7, 6, 5, 4], [14, 13, 12, 11, 10, 9, 8, 7, 6, 5]], [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], [3, 4, 5, 6, 7, 8, 9, 10, 11, 12], [4, 5, 6, 7, 8, 9, 10, 11, 12, 13], [5, 6, 7, 8, 9, 10, 11, 12, 13, 14]], [[14, 13, 12, 11, 10, 9, 8, 7, 6, 5], [13, 12, 11, 10, 9, 8, 7, 6, 5, 4], [12, 11, 10, 9, 8, 7, 6, 5, 4, 3], [11, 10, 9, 8, 7, 6, 5, 4, 3, 2], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]], [[5, 6, 7, 8, 9, 10, 11, 12, 13, 14], [4, 5, 6, 7, 8, 9, 10, 11, 12, 13], [3, 4, 5, 6, 7, 8, 9, 10, 11, 12], [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]]];
            super(ResMgr.getInstance().getMovieClip("GuiNull"));
            autoAlign = AUTO_ALIGN_LEFT;
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING);
            if (!this.cloudLeft)
            {
                this.cloudLeft = ResMgr.getInstance().getMovieClip("cloudLeft");
                _loc_1.addChild(this.cloudLeft);
                this.cloudLeft.width = GlobalVar.SCREEN_WIDTH;
                this.cloudLeft.height = GlobalVar.SCREEN_HEIGHT;
            }
            if (!this.cloudRight)
            {
                this.cloudRight = ResMgr.getInstance().getMovieClip("cloudRight");
                _loc_1.addChild(this.cloudRight);
                this.cloudRight.width = GlobalVar.SCREEN_WIDTH;
                this.cloudRight.height = GlobalVar.SCREEN_HEIGHT;
            }
            this.bird = ResMgr.getInstance().getMovieClip("FindMatch");
            _loc_1.addChild(this.bird);
            this.bird.x = (GlobalVar.SCREEN_WIDTH - this.bird.width) / 2;
            this.bird.y = (GlobalVar.SCREEN_HEIGHT - this.bird.height) / 2;
            this.bird.visible = false;
            show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING));
            return;
        }// end function

        public function showEff(param1:Function = null, ... args) : void
        {
            this.func = param1;
            this.arg = args;
            enableDisableScreen = true;
            show(LayerMgr.getInstance().getLayer(GlobalVar.LAYER_LOADING));
            this.cloudLeft.x = -this.cloudLeft.width;
            this.cloudRight.x = this.cloudRight.width;
            this.bird.visible = true;
            this.bird.alpha = 0;
            TweenMax.to(this.cloudLeft, 1, {x:0, y:0, onComplete:this.pauseFunction});
            TweenMax.to(this.cloudRight, 1, {x:0, y:0});
            TweenMax.to(this.bird, 1, {autoAlpha:1});
            return;
        }// end function

        public function pauseFunction() : void
        {
            if (this.func != null)
            {
                if (this.arg[0].length <= 0)
                {
                    this.func.apply();
                }
                else
                {
                    this.func.apply(null, this.arg[0]);
                }
            }
            this.focusCenterGame();
            return;
        }// end function

        public function hideEff(param1:Number = 1) : void
        {
            TweenMax.to(this.cloudLeft, 2, {x:-this.cloudLeft.width, y:0, delay:1, onComplete:this.hide});
            TweenMax.to(this.cloudRight, 2, {x:this.cloudRight.width, y:0, delay:1});
            if (this.bird && this.bird.visible)
            {
                TweenMax.to(this.bird, 1, {autoAlpha:0});
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            this.bird.visible = false;
            super.hide();
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:Image = null;
            for each (_loc_2 in this.squareArr)
            {
                
                (this.tempNum + 1);
                if (this.effName == EFFECT_IN)
                {
                    if (_loc_2.img.scaleX <= this.sX)
                    {
                        _loc_2.img.scaleX = _loc_2.img.scaleX + this.sX / 5;
                        _loc_2.img.scaleY = _loc_2.img.scaleY + this.sY / 5;
                    }
                    continue;
                }
                if (this.tempNum <= this.curEffOut)
                {
                    if (_loc_2.img.scaleX > 0.2)
                    {
                        _loc_2.img.scaleX = _loc_2.img.scaleX - this.sX / 5;
                        _loc_2.img.scaleY = _loc_2.img.scaleY - this.sY / 5;
                        continue;
                    }
                    if (_loc_2.img.visible)
                    {
                        _loc_2.img.visible = false;
                    }
                }
            }
            this.tempNum = 0;
            return;
        }// end function

        private function effSquareInTimer(event:TimerEvent) : void
        {
            this.effSquareIn(this.effArr[this.effType]);
            (this.curSquare + 1);
            return;
        }// end function

        private function effSquareIn(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:Image = null;
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    if (int(param1[_loc_3][_loc_2]) == this.curSquare)
                    {
                        _loc_4 = this.creatSquare();
                        _loc_4.img.x = _loc_4.img.width / 2 + _loc_2 * _loc_4.img.width;
                        _loc_4.img.y = _loc_4.img.height / 2 + _loc_3 * _loc_4.img.height;
                        var _loc_5:Number = 0.2;
                        _loc_4.img.scaleY = 0.2;
                        _loc_4.img.scaleX = _loc_5;
                        this.squareArr.push(_loc_4);
                    }
                    _loc_3++;
                }
                if (this.squareArr.length == param1[0].length * param1.length)
                {
                    if (this.effInTime)
                    {
                        this.effInTime.removeEventListener(TimerEvent.TIMER, this.effSquareInTimer);
                        this.effInTime.stop();
                        this.effInTime = null;
                    }
                    img.addEventListener(Event.ENTER_FRAME, this.pauseBeetween);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function pauseBeetween(event:Event) : void
        {
            (this.pauseTime + 1);
            if (this.pauseTime == 5)
            {
                if (this.func != null)
                {
                    if (this.arg[0].length <= 0)
                    {
                        this.func.apply();
                    }
                    else
                    {
                        this.func.apply(null, this.arg[0]);
                    }
                }
            }
            if (this.pauseTime == 10)
            {
                this.curSquare = 1;
                this.effName = EFFECT_OUT;
                this.effOutTime = new Timer(TIMER_DELAY);
                this.effOutTime.addEventListener(TimerEvent.TIMER, this.effSquareOutTimer);
                this.effOutTime.start();
                img.removeEventListener(Event.ENTER_FRAME, this.pauseBeetween);
                this.pauseTime = 0;
            }
            this.focusCenterGame();
            return;
        }// end function

        private function focusCenterGame() : void
        {
            hideDisableScreen();
            var _loc_1:* = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_MOVE);
            MapMgr.curScale = GlobalVar.INIT_SCALE;
            MapMgr.getInstance().scaleLevel = MapMgr.curScale;
            var _loc_4:* = MapMgr.curScale;
            _loc_1.scaleY = MapMgr.curScale;
            _loc_1.scaleX = _loc_4;
            var _loc_2:* = (-(GlobalVar.MAP_WIDTH * MapMgr.curScale - GlobalVar.SCREEN_WIDTH)) / 2;
            var _loc_3:* = (-(GlobalVar.MAP_HEIGHT * MapMgr.curScale - GlobalVar.SCREEN_HEIGHT)) / 2;
            MapMgr.getInstance().setMapPos(_loc_2, _loc_3);
            return;
        }// end function

        private function effSquareOutTimer(event:TimerEvent) : void
        {
            this.effSquareOut(this.effArr[this.effType]);
            (this.curSquare + 1);
            return;
        }// end function

        private function effSquareOut(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < param1[0].length)
            {
                
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    if (int(param1[_loc_3][_loc_2]) == this.curSquare)
                    {
                        (this.curEffOut + 1);
                    }
                    _loc_3++;
                }
                if (this.curEffOut == param1[0].length * param1.length)
                {
                    if (this.effOutTime)
                    {
                        this.effOutTime.removeEventListener(TimerEvent.TIMER, this.effSquareOutTimer);
                        this.effOutTime.stop();
                        this.effOutTime = null;
                    }
                    img.addEventListener(Event.ENTER_FRAME, this.removeEff);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function removeEff(event:Event) : void
        {
            (this.pauseTime + 1);
            if (this.pauseTime == 10)
            {
                this.func = null;
                this.pauseTime = 0;
                img.removeEventListener(Event.ENTER_FRAME, this.removeEff);
                img.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
                this.hide();
            }
            return;
        }// end function

        private function creatSquare() : Image
        {
            var _loc_1:* = new Image();
            var _loc_2:* = GlobalVar.SCREEN_WIDTH / 10;
            var _loc_3:* = GlobalVar.SCREEN_HEIGHT / 5;
            _loc_1.setInfo(this.img, "SquareEff", 0, 0);
            if (this.sX == 0)
            {
                this.sX = Math.ceil(_loc_2 / _loc_1.img.width);
                this.sY = Math.ceil(_loc_3 / _loc_1.img.height);
            }
            _loc_1.img.width = _loc_2;
            _loc_1.img.height = _loc_3;
            return _loc_1;
        }// end function

    }
}
