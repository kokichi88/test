package org.as3commons.reflect
{
    import flash.system.*;
    import org.as3commons.lang.*;
    import org.as3commons.reflect.*;

    public class Method extends MetadataContainer implements INamespaceOwner
    {
        protected var applicationDomain:ApplicationDomain;
        private var updateFullName:Boolean = true;
        protected var declaringTypeName:String;
        private var _fullName:String;
        private var _isStatic:Boolean;
        private var _name:String;
        private var _qName:QName;
        private var _namespaceURI:String;
        private var _parameters:Array;
        private var _returnTypeName:String;

        public function Method(param1:String, param2:String, param3:Boolean, param4:Array, param5:String, param6:ApplicationDomain, param7:HashArray = null)
        {
            super(param7);
            this.initMethod(param1, param2, param3, param4, param5, param6, param7);
            return;
        }// end function

        protected function initMethod(param1:String, param2:String, param3:Boolean, param4:Array, param5:String, param6:ApplicationDomain, param7:HashArray) : void
        {
            this.declaringTypeName = param1;
            this._name = param2;
            this._isStatic = param3;
            this._parameters = param4;
            this._returnTypeName = param5;
            this.applicationDomain = param6;
            return;
        }// end function

        public function get declaringType() : Type
        {
            return Type.forName(this.declaringTypeName, this.applicationDomain);
        }// end function

        public function get fullName() : String
        {
            var _loc_1:int = 0;
            var _loc_2:Parameter = null;
            if (this.updateFullName)
            {
                this._fullName = "public ";
                if (this.isStatic)
                {
                    this._fullName = this._fullName + "static ";
                }
                this._fullName = this._fullName + (this.name + "(");
                _loc_1 = 0;
                while (_loc_1 < this.parameters.length)
                {
                    
                    _loc_2 = this.parameters[_loc_1] as Parameter;
                    this._fullName = this._fullName + _loc_2.type.name;
                    this._fullName = this._fullName + (_loc_1 < (this.parameters.length - 1) ? (", ") : (""));
                    _loc_1++;
                }
                this._fullName = this._fullName + ("):" + this.returnType.name);
                this.updateFullName = false;
            }
            return this._fullName;
        }// end function

        public function get isStatic() : Boolean
        {
            return this._isStatic;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get qName() : QName
        {
            return new QName(this._namespaceURI, this._name);
        }// end function

        public function get namespaceURI() : String
        {
            return this._namespaceURI;
        }// end function

        public function get parameters() : Array
        {
            return this._parameters;
        }// end function

        public function get returnType() : Type
        {
            return Type.forName(this._returnTypeName, this.applicationDomain);
        }// end function

        function get returnTypeName() : String
        {
            return this._returnTypeName;
        }// end function

        public function invoke(param1, param2:Array)
        {
            arguments = new MethodInvoker();
            arguments.target = param1;
            arguments.method = this.name;
            arguments.arguments = param2;
            return arguments.invoke();
        }// end function

        public function toString() : String
        {
            return "[Method(name:\'" + this.name + "\', isStatic:" + this.isStatic + ")]";
        }// end function

        function setDeclaringType(param1:String) : void
        {
            this.declaringTypeName = param1;
            return;
        }// end function

        function setFullName(param1:String) : void
        {
            this._fullName = param1;
            this.updateFullName = false;
            return;
        }// end function

        function setIsStatic(param1:Boolean) : void
        {
            this._isStatic = param1;
            return;
        }// end function

        function setName(param1:String) : void
        {
            this._name = param1;
            this.updateFullName = true;
            return;
        }// end function

        function setNamespaceURI(param1:String) : void
        {
            this._namespaceURI = param1;
            return;
        }// end function

        function setParameters(param1:Array) : void
        {
            this._parameters = param1;
            this.updateFullName = true;
            return;
        }// end function

        function setReturnType(param1:String) : void
        {
            this._returnTypeName = param1;
            this.updateFullName = true;
            return;
        }// end function

    }
}
