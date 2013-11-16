package bitzero.controllers
{
    import bitzero.*;
    import bitzero.core.*;
    import bitzero.engine.*;

    public class ExtensionController extends BaseController
    {
        private var bz:BitZero;
        private var ezClient:EngineClient;
        public static const KEY_CMD:String = "c";
        public static const KEY_PARAMS:String = "p";

        public function ExtensionController(param1:EngineClient)
        {
            this.ezClient = param1;
            this.bz = param1.bz;
            return;
        }// end function

        override public function handleMessage(param1:IMessage) : void
        {
            if (this.bz.debug)
            {
                log.info(param1);
            }
            this.bz.dispatchEvent(new BZEvent(BZEvent.EXTENSION_RESPONSE, param1));
            return;
        }// end function

    }
}
