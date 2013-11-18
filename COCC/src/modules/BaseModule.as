package modules
{
    import bitzero.*;
    import bitzero.logging.*;

    public class BaseModule extends Object
    {
        protected var priority:int = 0;
        public var bzConnector:BZConnector;
        protected var logger:Logger;
        public static const DEFAULT_PRIORITY:int = 0;

        public function BaseModule()
        {
            this.bzConnector = BZConnector.getInstance();
            this.logger = Logger.getInstance();
            return;
        }// end function

        public function init() : void
        {
            this.onInit();
            return;
        }// end function

        protected function onInit() : void
        {
            return;
        }// end function

    }
}
