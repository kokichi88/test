package com.flashdynamix.utils
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;

    public class SWFProfiler extends Object
    {
        private static var itvTime:int;
        private static var initTime:int;
        private static var currentTime:int;
        private static var frameCount:int;
        private static var totalCount:int;
        public static var minFps:Number;
        public static var maxFps:Number;
        public static var minMem:Number;
        public static var maxMem:Number;
        public static var history:int = 60;
        public static var fpsList:Array = [];
        public static var memList:Array = [];
        private static var displayed:Boolean = false;
        private static var started:Boolean = false;
        private static var inited:Boolean = false;
        private static var frame:Sprite;
        private static var stage:Stage;
        private static var content:ProfilerContent;
        private static var ci:ContextMenuItem;

        public function SWFProfiler()
        {
            return;
        }// end function

        public static function init(param1:Stage, param2:InteractiveObject) : void
        {
            if (inited)
            {
                return;
            }
            inited = true;
            stage = param1;
            content = new ProfilerContent();
            frame = new Sprite();
            minFps = Number.MAX_VALUE;
            maxFps = Number.MIN_VALUE;
            minMem = Number.MAX_VALUE;
            maxMem = Number.MIN_VALUE;
            var _loc_3:* = new ContextMenu();
            _loc_3.hideBuiltInItems();
            ci = new ContextMenuItem("Show Profiler", true);
            addEvent(ci, ContextMenuEvent.MENU_ITEM_SELECT, onSelect);
            _loc_3.customItems = [ci];
            param2.contextMenu = _loc_3;
            start();
            return;
        }// end function

        public static function start() : void
        {
            if (started)
            {
                return;
            }
            started = true;
            var _loc_1:* = getTimer();
            itvTime = getTimer();
            initTime = _loc_1;
            var _loc_1:int = 0;
            frameCount = 0;
            totalCount = _loc_1;
            addEvent(frame, Event.ENTER_FRAME, draw);
            return;
        }// end function

        public static function stop() : void
        {
            if (!started)
            {
                return;
            }
            started = false;
            removeEvent(frame, Event.ENTER_FRAME, draw);
            return;
        }// end function

        public static function gc() : void
        {
            try
            {
                new LocalConnection().connect("foo");
                new LocalConnection().connect("foo");
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function get currentFps() : Number
        {
            return frameCount / intervalTime;
        }// end function

        public static function get currentMem() : Number
        {
            return System.totalMemory / 1024 / 1000;
        }// end function

        public static function get averageFps() : Number
        {
            return totalCount / runningTime;
        }// end function

        private static function get runningTime() : Number
        {
            return (currentTime - initTime) / 1000;
        }// end function

        private static function get intervalTime() : Number
        {
            return (currentTime - itvTime) / 1000;
        }// end function

        private static function onSelect(event:ContextMenuEvent) : void
        {
            if (!displayed)
            {
                show();
            }
            else
            {
                hide();
            }
            return;
        }// end function

        private static function show() : void
        {
            ci.caption = "Hide Profiler";
            displayed = true;
            addEvent(stage, Event.RESIZE, resize);
            stage.addChild(content);
            updateDisplay();
            return;
        }// end function

        private static function hide() : void
        {
            ci.caption = "Show Profiler";
            displayed = false;
            removeEvent(stage, Event.RESIZE, resize);
            stage.removeChild(content);
            return;
        }// end function

        private static function resize(event:Event) : void
        {
            content.update(runningTime, minFps, maxFps, minMem, maxMem, currentFps, currentMem, averageFps, fpsList, memList, history);
            return;
        }// end function

        private static function draw(event:Event) : void
        {
            currentTime = getTimer();
            var _loc_3:* = frameCount + 1;
            frameCount = _loc_3;
            var _loc_3:* = totalCount + 1;
            totalCount = _loc_3;
            if (intervalTime >= 1)
            {
                if (displayed)
                {
                    updateDisplay();
                }
                else
                {
                    updateMinMax();
                }
                fpsList.unshift(currentFps);
                memList.unshift(currentMem);
                if (fpsList.length > history)
                {
                    fpsList.pop();
                }
                if (memList.length > history)
                {
                    memList.pop();
                }
                itvTime = currentTime;
                frameCount = 0;
            }
            return;
        }// end function

        private static function updateDisplay() : void
        {
            updateMinMax();
            content.update(runningTime, minFps, maxFps, minMem, maxMem, currentFps, currentMem, averageFps, fpsList, memList, history);
            return;
        }// end function

        private static function updateMinMax() : void
        {
            minFps = Math.min(currentFps, minFps);
            maxFps = Math.max(currentFps, maxFps);
            minMem = Math.min(currentMem, minMem);
            maxMem = Math.max(currentMem, maxMem);
            return;
        }// end function

        private static function addEvent(param1:EventDispatcher, param2:String, param3:Function) : void
        {
            param1.addEventListener(param2, param3, false, 0, true);
            return;
        }// end function

        private static function removeEvent(param1:EventDispatcher, param2:String, param3:Function) : void
        {
            param1.removeEventListener(param2, param3);
            return;
        }// end function

    }
}
