﻿package bitzero.logging
{
    import flash.events.*;

    public class Logger extends EventDispatcher
    {
        private var _loggingLevel:int;
        private var _enableConsoleTrace:Boolean = true;
        private var _enableEventDispatching:Boolean = true;
        private static var _locked:Boolean = true;
        private static var _instance:Logger;

        public function Logger()
        {
            if (_locked)
            {
                throw new Error("Cannot instantiate the Logger using the constructor. Please use the getInstance() method");
            }
            this._loggingLevel = LogLevel.DEBUG;
            return;
        }// end function

        public function set enableConsoleTrace(param1:Boolean) : void
        {
            this._enableConsoleTrace = param1;
            return;
        }// end function

        public function get loggingLevel() : int
        {
            return this._loggingLevel;
        }// end function

        public function warn(... args) : void
        {
            this.log(LogLevel.WARN, args.join(" "));
            return;
        }// end function

        public function set enableEventDispatching(param1:Boolean) : void
        {
            this._enableEventDispatching = param1;
            return;
        }// end function

        public function set loggingLevel(param1:int) : void
        {
            this._loggingLevel = param1;
            return;
        }// end function

        public function debug(... args) : void
        {
            this.log(LogLevel.DEBUG, args.join(" "));
            return;
        }// end function

        public function info(... args) : void
        {
            this.log(LogLevel.INFO, args.join(" "));
            return;
        }// end function

        public function error(... args) : void
        {
            this.log(LogLevel.ERROR, args.join(" "));
            return;
        }// end function

        public function get enableConsoleTrace() : Boolean
        {
            return this._enableConsoleTrace;
        }// end function

        public function get enableEventDispatching() : Boolean
        {
            return this._enableEventDispatching;
        }// end function

        private function log(param1:int, param2:String) : void
        {
            if (param1 < this._loggingLevel)
            {
                return;
            }
            var _loc_3:* = LogLevel.fromString(param1);
            if (this._enableConsoleTrace)
            {
            }
            var _loc_4:Object = { };
            _loc_4.message = param2;
            var _loc_5:LoggerEvent = null;
            if (this._enableEventDispatching)
            {
                _loc_5 = new LoggerEvent(_loc_3, _loc_4);
                dispatchEvent(_loc_5);
            }
            return;
        }// end function

        public static function getInstance() : Logger
        {
            if (_instance == null)
            {
                _locked = false;
                _instance = new Logger;
                _locked = true;
            }
            return _instance;
        }// end function

    }
}
