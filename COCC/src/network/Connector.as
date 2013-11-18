package network
{
    import bitzero.*;
    import bitzero.core.*;
    import bitzero.logging.*;
    import flash.events.*;

    public class Connector extends EventDispatcher
    {
        private var bzConnector:BZConnector;
        private var logger:Logger;
        private var callAfterConnect:Function;
        private static var instance:Connector;

        public function Connector()
        {
            return;
        }// end function

        public function init(param1:Function) : void
        {
            this.logger = Logger.getInstance();
            this.logger.loggingLevel = LogLevel.DEBUG;
            this.bzConnector = BZConnector.getInstance();
            this.bzConnector.addEventListener(BZEvent.CONNECTION, this.onConnection);
            this.bzConnector.addEventListener(BZEvent.CONNECTION_LOST, this.onConnectionLost);
            this.bzConnector.addEventListener(BZEvent.CONNECTION_RETRY, this.connectionRetry);
            this.bzConnector.addEventListener(BZEvent.CONNECTION_RESUME, this.connectionResume);
            this.bzConnector.addEventListener(BZEvent.PINGPONG, this.onPingPong);
            this.bzConnector.connect(Config.server_ip, Config.server_port);
            this.callAfterConnect = param1;
            return;
        }// end function

        private function onConnection(event:BZEvent) : void
        {
            this.logger.info("Connected to server", event.params["success"]);
            if (BZConnector.getInstance().bzClient.isConnected)
            {
                this.callAfterConnect();
            }
            return;
        }// end function

        private function onConnectionLost(event:BZEvent) : void
        {
            this.logger.info("Disconnected to server. Reason:", event.params["reason"]);
            return;
        }// end function

        private function connectionRetry(event:BZEvent) : void
        {
            this.logger.info("Connection Retry", event.params);
            return;
        }// end function

        private function connectionResume(event:BZEvent) : void
        {
            this.logger.info("Restore connection");
            return;
        }// end function

        private function onPingPong(event:BZEvent) : void
        {
            this.logger.info("on Ping Pong ");
            return;
        }// end function

        public static function getInstance() : Connector
        {
            if (instance == null)
            {
                instance = new Connector;
            }
            return instance;
        }// end function

    }
}
