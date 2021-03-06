﻿package bitzero.engine
{
    import bitzero.engine.*;
    import flash.utils.*;

    public class Message extends Object implements IMessage
    {
        private var _isEncrypted:Boolean;
        private var _id:int;
        private var _targetController:int;
        private var _content:ByteArray;

        public function Message()
        {
            this.isEncrypted = false;
            return;
        }// end function

        public function get content() : ByteArray
        {
            return this._content;
        }// end function

        public function get isEncrypted() : Boolean
        {
            return this._isEncrypted;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = "{ Message id: " + this._id + " }\n";
            _loc_1 = _loc_1 + "{�Dump: }\n";
            _loc_1 = _loc_1 + this._content.toString();
            return _loc_1;
        }// end function

        public function get targetController() : int
        {
            return this._targetController;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set targetController(param1:int) : void
        {
            this._targetController = param1;
            return;
        }// end function

        public function set content(param1:ByteArray) : void
        {
            this._content = param1;
            return;
        }// end function

        public function set isEncrypted(param1:Boolean) : void
        {
            this._isEncrypted = param1;
            return;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

    }
}
