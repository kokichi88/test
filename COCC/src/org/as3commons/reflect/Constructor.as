package org.as3commons.reflect
{
    import flash.system.*;

    public class Constructor extends Object
    {
        private var _parameters:Array;
        private var _applicationDomain:ApplicationDomain;
        private var _declaringType:String;

        public function Constructor(param1:String, param2:ApplicationDomain, param3:Array = null)
        {
            this._parameters = [];
            if (param3 != null)
            {
                this._parameters = param3;
            }
            this._declaringType = param1;
            this._applicationDomain = param2;
            return;
        }// end function

        public function get parameters() : Array
        {
            return this._parameters;
        }// end function

        public function get declaringType() : Type
        {
            return Type.forName(this._declaringType, this._applicationDomain);
        }// end function

        public function hasNoArguments() : Boolean
        {
            return this._parameters.length == 0 ? (true) : (false);
        }// end function

    }
}
