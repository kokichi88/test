package bitzero.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class FrameTimer extends Object
    {
        private var timer:MovieClip;
        private var timers:Dictionary;
        private var myTimer:Timer;

        public function FrameTimer(param1:Boolean = false, param2:int = 1000)
        {
            this.timers = new Dictionary();
            if (!param1)
            {
                this.timer = new MovieClip();
                this.timer.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            }
            else
            {
                this.myTimer = new Timer(param2);
                this.myTimer.addEventListener(TimerEvent.TIMER, this.onHandler);
                this.myTimer.start();
            }
            return;
        }// end function

        public function add(param1:int, param2:int, param3:Function, param4:Function = null) : void
        {
            var _loc_5:* = new Object();
            _loc_5.delay = param1;
            _loc_5.counter = param1;
            _loc_5.repeat = param2;
            _loc_5.callback = param3;
            if (param4 != null)
            {
                _loc_5.overback = param4;
            }
            this.timers[param3] = _loc_5;
            return;
        }// end function

        public function remove(param1:Function) : void
        {
            delete this.timers[param1];
            return;
        }// end function

        private function enterFrameHandler(event:Event) : void
        {
            if (FrameTimerManager.isActivate)
            {
                this.onHandler();
            }
            return;
        }// end function

        public function onHandler(event:Event = null) : void
        {
            var _loc_2:Object = null;
            for each (_loc_2 in this.timers)
            {
                
                var _loc_5:* = _loc_2;
                var _loc_6:* = _loc_2.counter - 1;
                _loc_5.counter = _loc_6;
                if (_loc_2.counter <= 0)
                {
                    _loc_2.counter = _loc_2.delay;
                    _loc_2.callback();
                    if (_loc_2.repeat > 0)
                    {
                        var _loc_5:* = _loc_2;
                        var _loc_6:* = _loc_2.repeat - 1;
                        _loc_5.repeat = _loc_6;
                        if (_loc_2.repeat == 0)
                        {
                            if (_loc_2.hasOwnProperty("overback"))
                            {
                                _loc_2.overback();
                            }
                            delete this.timers[_loc_2.callback];
                        }
                    }
                }
            }
            return;
        }// end function

    }
}
