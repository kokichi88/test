package bitzero.controllers
{
    import bitzero.*;
    import bitzero.controllers.system.*;
    import bitzero.controllers.system.cmd.*;
    import bitzero.core.*;
    import bitzero.engine.*;
    import bitzero.net.data.*;
    import bitzero.util.*;

    public class SystemController extends BaseController
    {
        private var bz:BitZero;
        private var requestHandlers:Object;
        private var ezClient:EngineClient;

        public function SystemController(param1:EngineClient)
        {
            this.ezClient = param1;
            this.bz = param1.bz;
            this.requestHandlers = new Object();
            this.initRequestHandlers();
            return;
        }// end function

        private function initRequestHandlers() : void
        {
            this.requestHandlers[SystemRequest.Handshake] = "fnHandshake";
            this.requestHandlers[SystemRequest.Login] = "fnLogin";
            this.requestHandlers[SystemRequest.Logout] = "fnLogout";
            this.requestHandlers[SystemRequest.Logout] = "fnPingPong";
            this.requestHandlers[SystemRequest.ClientDisconnection] = "fnClientDisconnection";
            this.requestHandlers[SystemRequest.GenericMessage] = "fnGenericMessage";
            this.requestHandlers[SystemRequest.AdminMessage] = "fnAdminMessage";
            this.requestHandlers[SystemRequest.ModeratorMessage] = "fnModeratorMessage";
            this.requestHandlers[SystemRequest.ClientDisconnection] = "fnClientDisconnection";
            return;
        }// end function

        override public function handleMessage(param1:IMessage) : void
        {
            if (this.bz.debug)
            {
                log.info(this.getEvtName(param1.id), param1);
            }
            var _loc_2:* = this.requestHandlers[param1.id];
            if (_loc_2 == null)
            {
                log.warn("Unknown message id: " + param1.id);
            }
            else
            {
               this[_loc_2](param1);
            }
            return;
        }// end function

        private function getEvtName(param1:int) : String
        {
            var _loc_2:* = this.requestHandlers[param1];
            return _loc_2.substr(2);
        }// end function

        private function fnGenericMessage(param1:IMessage) : void
        {
            var _loc_2:* = new GenericMessageMsg(param1.content);
            this.bz.dispatchEvent(new BZEvent(BZEvent.MODERATOR_MESSAGE, _loc_2));
            return;
        }// end function

        private function fnAdminMessage(param1:IMessage) : void
        {
            var _loc_2:* = new ClientDisconnecMsg(param1.content);
            this.bz.handleClientDisconnection(ClientDisconnectionReason.getReason(_loc_2.ErrorCode));
            return;
        }// end function

        private function fnModeratorMessage(param1:IMessage) : void
        {
            var _loc_2:* = new ClientDisconnecMsg(param1.content);
            this.bz.handleClientDisconnection(ClientDisconnectionReason.getReason(_loc_2.ErrorCode));
            return;
        }// end function

        private function fnClientDisconnection(param1:IMessage) : void
        {
            var _loc_2:* = new ClientDisconnecMsg(param1.content);
            this.bz.handleClientDisconnection(ClientDisconnectionReason.getReason(_loc_2.ErrorCode));
            return;
        }// end function

        private function fnPingPong(param1:IMessage) : void
        {
            var _loc_2:* = new BaseMsg(param1.content);
            this.bz.dispatchEvent(new BZEvent(BZEvent.PINGPONG, _loc_2));
            return;
        }// end function

        private function fnHandshake(param1:IMessage) : void
        {
            var _loc_2:* = new HandShakeMsg(param1.content);
            this.bz.dispatchEvent(new BZEvent(BZEvent.HANDSHAKE, _loc_2));
            return;
        }// end function

        private function fnLogin(param1:IMessage) : void
        {
            var _loc_2:* = new HandShakeMsg(param1.content);
            this.ezClient.reconnectionSeconds = 0;
            this.bz.dispatchEvent(new BZEvent(BZEvent.LOGIN_ERROR, _loc_2.token));
            return;
        }// end function

    }
}
