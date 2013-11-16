package bitzero.logging
{

    public class LogLevel extends Object
    {
        public static const DEBUG:int = 100;
        public static const WARN:int = 300;
        public static const ERROR:int = 400;
        public static const INFO:int = 200;

        public function LogLevel()
        {
            return;
        }// end function

        public static function fromString(param1:int) : String
        {
            var _loc_2:String = "Unknown";
            if (param1 != DEBUG)
            {
                if (param1 != INFO)
                {
                    if (param1 != WARN)
                    {
                        if (param1 == ERROR)
                        {
                            _loc_2 = "ERROR";
                        }
                    }
                    else
                    {
                        _loc_2 = "WARN";
                    }
                }
                else
                {
                    _loc_2 = "INFO";
                }
            }
            else
            {
                _loc_2 = "DEBUG";
            }
            return _loc_2;
        }// end function

    }
}
