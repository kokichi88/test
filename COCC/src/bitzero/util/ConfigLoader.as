package bitzero.util
{
    import bitzero.core.*;
    import flash.events.*;
    import flash.net.*;

    public class ConfigLoader extends EventDispatcher
    {

        public function ConfigLoader()
        {
            return;
        }// end function

        public function loadConfig(param1:String) : void
        {
            var _loc_2:* = new URLLoader();
            _loc_2.addEventListener(Event.COMPLETE, this.onConfigLoadSuccess);
            _loc_2.addEventListener(IOErrorEvent.IO_ERROR, this.onConfigLoadFailure);
            _loc_2.load(new URLRequest(param1));
            return;
        }// end function

        private function onConfigLoadFailure(event:IOErrorEvent) : void
        {
            var _loc_2:Object = {message:event.text};
            var _loc_3:* = new BZEvent(BZEvent.CONFIG_LOAD_FAILURE, _loc_2);
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function onConfigLoadSuccess(event:Event) : void
        {
            var _loc_2:* = event.target as URLLoader;
            var _loc_3:* = new XML(_loc_2.data);
            var _loc_4:* = new ConfigData();
            new ConfigData().bboxHost = _loc_3.ip;
            _loc_4.host = _loc_3.ip;
            _loc_4.port = int(_loc_3.port);
            _loc_4.zone = _loc_3.zone;
            if (_loc_3.blueBoxAddress != undefined)
            {
                _loc_4.bboxHost = _loc_3.blueBoxAddress;
            }
            if (_loc_3.blueBoxPort != undefined)
            {
                _loc_4.bboxPort = _loc_3.blueBoxPort;
            }
            if (_loc_3.debug != undefined)
            {
                _loc_4.debug = _loc_3.debug.toLowerCase() != "true" ? (false) : (true);
            }
            if (_loc_3.useBlueBox != undefined)
            {
                _loc_4.useBBox = _loc_3.useBlueBox.toLowerCase() != "true" ? (false) : (true);
            }
            if (_loc_3.httpPort != undefined)
            {
                _loc_4.httpPort = int(_loc_3.httpPort);
            }
            if (_loc_3.blueBoxPollingRate != undefined)
            {
                _loc_4.bboxPollingRate = int(_loc_3.blueBoxPollingRate);
            }
            var _loc_5:* = new BZEvent(BZEvent.CONFIG_LOAD_SUCCESS, {cfg:_loc_4});
            dispatchEvent(_loc_5);
            return;
        }// end function

    }
}
