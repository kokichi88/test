package org.as3commons.reflect
{
    import flash.system.*;
    import org.as3commons.lang.*;
    import org.as3commons.reflect.*;

    public class AbstractMember extends MetadataContainer implements IEquals, IMember, INamespaceOwner
    {
        protected var applicationDomain:ApplicationDomain;
        protected var declaringTypeName:String;
        protected var typeName:String;
        private var _isStatic:Boolean;
        private var _name:String;
        private var _qName:QName;
        private var _namespaceURI:String;

        public function AbstractMember(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null)
        {
            super(param6);
            this.initAbstractType(param1, param4, param2, param3, param5);
            return;
        }// end function

        protected function initAbstractType(param1:String, param2:Boolean, param3:String, param4:String, param5:ApplicationDomain) : void
        {
            Assert.hasText(param1, "name argument must have text");
            Assert.hasText(param3, "type argument must have text");
            Assert.notNull(param5, "applicationDomain argument must not be null");
            this._name = param1;
            this._isStatic = param2;
            this.typeName = param3;
            this.declaringTypeName = param4;
            this.applicationDomain = param5;
            return;
        }// end function

        public function get declaringType() : Type
        {
            return StringUtils.hasText(this.declaringTypeName) ? (Type.forName(this.declaringTypeName, this.applicationDomain)) : (null);
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

        public function get type() : Type
        {
            return Type.forName(this.typeName, this.applicationDomain);
        }// end function

        public function equals(param1:Object) : Boolean
        {
            var _loc_2:* = param1 as AbstractMember;
            var _loc_3:Boolean = false;
            if (_loc_2 != null)
            {
                _loc_3 = _loc_2.name == this.name && _loc_2.typeName == this.typeName && _loc_2.declaringTypeName == this.declaringTypeName && _loc_2.isStatic == this.isStatic && _loc_2.applicationDomain === this.applicationDomain;
                if (_loc_3)
                {
                    _loc_3 = this.compareMetadata(_loc_2.metadata);
                }
            }
            return _loc_3;
        }// end function

        protected function compareMetadata(param1:Array) : Boolean
        {
            var _loc_3:Metadata = null;
            var _loc_4:Array = null;
            var _loc_5:Metadata = null;
            var _loc_2:* = param1.length == 0 && this.metadata.length == 0;
            for each (_loc_3 in param1)
            {
                
                _loc_4 = this.getMetadata(_loc_3.name);
                for each (_loc_5 in _loc_4)
                {
                    
                    if (_loc_5 == null || !_loc_5.equals(_loc_3))
                    {
                        _loc_2 = false;
                        break;
                    }
                }
                if (!_loc_2)
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        function setDeclaringType(param1:String) : void
        {
            this.declaringTypeName = param1;
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
            return;
        }// end function

        function setNamespaceURI(param1:String) : void
        {
            this._namespaceURI = param1;
            return;
        }// end function

        function setType(param1:String) : void
        {
            this.typeName = param1;
            return;
        }// end function

    }
}
