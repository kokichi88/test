package com.flashdynamix.utils
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;

    public class MouseWheelTrap extends Object
    {
        private static var _mouseWheelTrapped:Boolean;

        public function MouseWheelTrap()
        {
            return;
        }// end function

        public static function setup(param1:Stage) : void
        {
            var stage:* = param1;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, function () : void
            {
                allowBrowserScroll(false);
                return;
            }// end function
            );
            stage.addEventListener(Event.MOUSE_LEAVE, function () : void
            {
                allowBrowserScroll(true);
                return;
            }// end function
            );
            return;
        }// end function

        private static function allowBrowserScroll(param1:Boolean) : void
        {
            createMouseWheelTrap();
            if (ExternalInterface.available)
            {
                ExternalInterface.call("allowBrowserScroll", param1);
            }
            return;
        }// end function

        private static function createMouseWheelTrap() : void
        {
            if (_mouseWheelTrapped)
            {
                return;
            }
            _mouseWheelTrapped = true;
            if (ExternalInterface.available)
            {
                ExternalInterface.call("eval", "var browserScrolling;function allowBrowserScroll(value){browserScrolling=value;}" + "function handle(delta){" + "if(!browserScrolling){" + "var flash = document.getElementById(\'myContent\');" + "alert(flash, \'minh\')" + "if (flash){" + "flash.doWheel(delta);" + "}" + "return false;" + "}return true;" + "}" + "function wheel(event){" + "var delta=0;" + "if(!event){event=window.event;}" + "if(event.wheelDelta){delta=event.wheelDelta/120;if(window.opera){delta=-delta;}}" + "else if(event.detail){delta=-event.detail/3;}" + "if(delta){handle(delta);}" + "if(!browserScrolling){" + "if(event.preventDefault){event.preventDefault();}" + "event.returnValue=false;" + "}" + "}" + "if(window.addEventListener){window.addEventListener(\'DOMMouseScroll\',wheel,false);}window.onmousewheel=document.onmousewheel=wheel;allowBrowserScroll(true);");
            }
            return;
        }// end function

    }
}
