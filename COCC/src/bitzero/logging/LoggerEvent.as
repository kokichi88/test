package bitzero.logging
{
    import bitzero.core.*;
    import flash.events.*;

    public class LoggerEvent extends BaseEvent
    {
        public static const DEBUG:String = "DEBUG";
        public static const WARNING:String = "WARN";
        public static const INFO:String = "INFO";
        public static const ERROR:String = "ERROR";

        public function LoggerEvent(param1:String, param2:Object = null)
        {
            super(param1, param2);
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("LoggerEvent", "type", "bubbles", "cancelable", "eventPhase", "params");
        }// end function

        override public function clone() : Event
        {
            return new LoggerEvent(this.type, this.params);
        }// end function

    }
}
