package org.as3commons.reflect
{
    import flash.utils.*;
    import org.as3commons.reflect.*;

    public class MethodInvoker extends Object implements INamespaceOwner
    {
        private var _target:Object;
        private var _method:String = "";
        private var _arguments:Array;
        private var _namespaceURI:String;

        public function MethodInvoker()
        {
            this._arguments = [];
            return;
        }// end function

        public function get target()
        {
            return this._target;
        }// end function

        public function set target(param1) : void
        {
            this._target = param1;
            return;
        }// end function

        public function get method() : String
        {
            return this._method;
        }// end function

        public function set method(param1:String) : void
        {
            this._method = param1;
            return;
        }// end function

        public function get arguments() : Array
        {
            return this._arguments;
        }// end function

        public function set arguments(param1:Array) : void
        {
            this._arguments = param1;
            return;
        }// end function

        public function get namespaceURI() : String
        {
            return this._namespaceURI;
        }// end function

        public function set namespaceURI(param1:String) : void
        {
            this._namespaceURI = param1;
            return;
        }// end function

        public function invoke()
        {
            arguments = undefined;
            var _loc_3:Function = null;
            var _loc_4:QName = null;
            var _loc_5:Array = null;
            if (this._namespaceURI != null && this._namespaceURI.length > 0)
            {
                _loc_4 = new QName(this._namespaceURI, this.method);
                _loc_3 = this.target[_loc_4];
            }
            else
            {
                _loc_3 = this.target[this.method];
            }
            if (_loc_3 != null)
            {
                arguments = _loc_3.apply(this.target, this.arguments);
            }
            else if (this.target is Proxy)
            {
                _loc_5 = [this.method].concat(this.arguments);
                arguments = flash_proxy::callProperty.apply(this.target, _loc_5);
            }
            return arguments;
        }// end function

    }
}
