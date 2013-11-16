package org.as3commons.reflect
{
    import flash.system.*;
    import flash.utils.*;
    import org.as3commons.lang.*;
    import org.as3commons.logging.*;

    public class Type extends MetadataContainer
    {
        private var _applicationDomain:ApplicationDomain;
        private var _alias:String;
        private var _name:String;
        private var _fullName:String;
        private var _class:Class;
        private var _isDynamic:Boolean;
        private var _isFinal:Boolean;
        private var _isStatic:Boolean;
        private var _isInterface:Boolean;
        private var _parameters:Array;
        private var _interfaces:Array;
        private var _constructor:Constructor;
        private var _accessors:Array;
        private var _methods:HashArray;
        private var _staticConstants:Array;
        private var _constants:Array;
        private var _staticVariables:Array;
        private var _extendsClasses:Array;
        private var _variables:Array;
        private var _fields:HashArray;
        private var _metadataLookup:Dictionary;
        public static const UNTYPED:Type = new Type(ApplicationDomain.currentDomain);
        public static const VOID:Type = new Type(ApplicationDomain.currentDomain);
        public static const PRIVATE:Type = new Type(ApplicationDomain.currentDomain);
        private static const MEMBER_PROPERTY_NAME:String = "name";
        public static const VOID_NAME:String = "void";
        private static const UNTYPED_NAME:String = "*";
        private static const PRIVATE_NAME:String = "private";
        public static var typeProviderKind:TypeProviderKind = TypeProviderKind.JSON;
        private static var logger:ILogger = LoggerFactory.getClassLogger(Type);
        private static var typeProvider:ITypeProvider;

        public function Type(param1:ApplicationDomain)
        {
            this.initType(param1);
            return;
        }// end function

        protected function initType(param1:ApplicationDomain) : void
        {
            this._accessors = [];
            this._staticConstants = [];
            this._constants = [];
            this._staticVariables = [];
            this._variables = [];
            this._extendsClasses = [];
            this._interfaces = [];
            this._parameters = [];
            this._applicationDomain = param1;
            return;
        }// end function

        public function get applicationDomain() : ApplicationDomain
        {
            return this._applicationDomain;
        }// end function

        public function set applicationDomain(param1:ApplicationDomain) : void
        {
            this._applicationDomain = param1;
            return;
        }// end function

        public function get alias() : String
        {
            return this._alias;
        }// end function

        public function set alias(param1:String) : void
        {
            this._alias = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get fullName() : String
        {
            return this._fullName;
        }// end function

        public function set fullName(param1:String) : void
        {
            this._fullName = param1;
            return;
        }// end function

        public function get clazz() : Class
        {
            return this._class;
        }// end function

        public function set clazz(param1:Class) : void
        {
            this._class = param1;
            return;
        }// end function

        public function get isDynamic() : Boolean
        {
            return this._isDynamic;
        }// end function

        public function set isDynamic(param1:Boolean) : void
        {
            this._isDynamic = param1;
            return;
        }// end function

        public function get isFinal() : Boolean
        {
            return this._isFinal;
        }// end function

        public function set isFinal(param1:Boolean) : void
        {
            this._isFinal = param1;
            return;
        }// end function

        public function get isStatic() : Boolean
        {
            return this._isStatic;
        }// end function

        public function set isStatic(param1:Boolean) : void
        {
            this._isStatic = param1;
            return;
        }// end function

        public function get isInterface() : Boolean
        {
            return this._isInterface;
        }// end function

        public function set isInterface(param1:Boolean) : void
        {
            this._isInterface = param1;
            return;
        }// end function

        public function get parameters() : Array
        {
            return this._parameters;
        }// end function

        public function get interfaces() : Array
        {
            return this._interfaces;
        }// end function

        public function set interfaces(param1:Array) : void
        {
            this._interfaces = param1;
            return;
        }// end function

        public function get constructor() : Constructor
        {
            return this._constructor;
        }// end function

        public function set constructor(param1:Constructor) : void
        {
            this._constructor = param1;
            return;
        }// end function

        public function get accessors() : Array
        {
            return this._accessors;
        }// end function

        public function set accessors(param1:Array) : void
        {
            this._accessors = param1;
            this._fields = null;
            return;
        }// end function

        public function get methods() : Array
        {
            return this._methods != null ? (this._methods.getArray()) : ([]);
        }// end function

        public function set methods(param1:Array) : void
        {
            this._methods = new HashArray(MEMBER_PROPERTY_NAME, false, param1);
            return;
        }// end function

        public function get staticConstants() : Array
        {
            return this._staticConstants;
        }// end function

        public function set staticConstants(param1:Array) : void
        {
            this._staticConstants = param1;
            this._fields = null;
            return;
        }// end function

        public function get constants() : Array
        {
            return this._constants;
        }// end function

        public function set constants(param1:Array) : void
        {
            this._constants = param1;
            this._fields = null;
            return;
        }// end function

        public function get staticVariables() : Array
        {
            return this._staticVariables;
        }// end function

        public function set staticVariables(param1:Array) : void
        {
            this._staticVariables = param1;
            this._fields = null;
            return;
        }// end function

        public function get extendsClasses() : Array
        {
            return this._extendsClasses;
        }// end function

        public function set extendsClasses(param1:Array) : void
        {
            this._extendsClasses = param1;
            return;
        }// end function

        public function get variables() : Array
        {
            return this._variables;
        }// end function

        public function set variables(param1:Array) : void
        {
            this._variables = param1;
            this._fields = null;
            return;
        }// end function

        public function get fields() : Array
        {
            if (this._fields == null)
            {
                this.createFieldsHashArray();
            }
            return this._fields.getArray();
        }// end function

        private function createFieldsHashArray() : void
        {
            this._fields = new HashArray(MEMBER_PROPERTY_NAME, false, this.accessors.concat(this.staticConstants).concat(this.constants).concat(this.staticVariables).concat(this.variables));
            return;
        }// end function

        public function get properties() : Array
        {
            return this.accessors.concat(this.variables);
        }// end function

        public function getMethod(param1:String, param2:String = null) : Method
        {
            var _loc_3:Array = null;
            var _loc_4:Method = null;
            if (param2 == null)
            {
                return this._methods.get(param1);
            }
            _loc_3 = this._methods.getArray();
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4.name == param1 && _loc_4.namespaceURI == param2)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public function getField(param1:String, param2:String = null) : Field
        {
            var _loc_3:Array = null;
            var _loc_4:Field = null;
            if (this._fields == null)
            {
                this.createFieldsHashArray();
            }
            if (param2 == null)
            {
                return this._fields.get(param1);
            }
            _loc_3 = this._fields.getArray();
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4.name == param1 && _loc_4.namespaceURI == param2)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public function createMetadataLookup() : void
        {
            this._metadataLookup = new Dictionary();
            this.addToMetadataLookup(this._methods.getArray());
            if (this._fields == null)
            {
                this.createFieldsHashArray();
            }
            this.addToMetadataLookup(this._fields.getArray());
            return;
        }// end function

        public function getMetadataContainers(param1:String) : Array
        {
            if (this._metadataLookup != null)
            {
                return this._metadataLookup[param1] as Array;
            }
            return null;
        }// end function

        private function addToMetadataLookup(param1:Array) : void
        {
            var _loc_2:MetadataContainer = null;
            var _loc_3:Array = null;
            var _loc_4:Metadata = null;
            var _loc_5:Array = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = _loc_2.metadata;
                for each (_loc_4 in _loc_3)
                {
                    
                    _loc_5 = this._metadataLookup[_loc_4.name];
                    if (_loc_5 == null)
                    {
                        _loc_5 = [];
                        this._metadataLookup[_loc_4.name] = _loc_5;
                    }
                    _loc_5[_loc_5.length] = _loc_2;
                }
            }
            return;
        }// end function

        function setParameters(param1:Array) : void
        {
            this._parameters = param1;
            return;
        }// end function

        public static function reset() : void
        {
            if (typeProvider != null)
            {
                typeProvider.clearCache();
            }
            typeProvider = null;
            return;
        }// end function

        public static function forInstance(param1, param2:ApplicationDomain = null) : Type
        {
            var _loc_3:Type = null;
            param2 = param2 == null ? (ApplicationDomain.currentDomain) : (param2);
            var _loc_4:* = ClassUtils.forInstance(param1, param2);
            if (ClassUtils.forInstance(param1, param2) != null)
            {
                _loc_3 = Type.forClass(_loc_4, param2);
            }
            return _loc_3;
        }// end function

        public static function forName(param1:String, param2:ApplicationDomain = null) : Type
        {
            var result:Type;
            var name:* = param1;
            var applicationDomain:* = param2;
            applicationDomain = applicationDomain == null ? (ApplicationDomain.currentDomain) : (applicationDomain);
            switch(name)
            {
                case VOID_NAME:
                {
                    result = Type.VOID;
                    break;
                }
                case UNTYPED_NAME:
                {
                    result = Type.UNTYPED;
                    break;
                }
                default:
                {
                    try
                    {
                        if (getTypeProvider().getTypeCache().contains(name))
                        {
                            result = getTypeProvider().getTypeCache().get(name);
                        }
                        else
                        {
                            result = Type.forClass(ClassUtils.forName(name, applicationDomain), applicationDomain);
                        }
                    }
                    catch (e:ReferenceError)
                    {
                        logger.warn("Type.forName error: " + e.message + " The class \'" + name + "\' is probably an internal class or it may not have been compiled.");
                        ;
                    }
                    catch (e:ClassNotFoundError)
                    {
                        logger.warn("The class with the name \'{0}\' could not be found in the application domain \'{1}\'", name, applicationDomain);
                    }
                    break;
                }
            }
            return result;
        }// end function

        public static function forClass(param1:Class, param2:ApplicationDomain = null) : Type
        {
            var _loc_3:Type = null;
            param2 = param2 == null ? (ApplicationDomain.currentDomain) : (param2);
            var _loc_4:* = ClassUtils.getFullyQualifiedName(param1);
            if (getTypeProvider().getTypeCache().contains(_loc_4))
            {
                _loc_3 = getTypeProvider().getTypeCache().get(_loc_4);
            }
            else
            {
                _loc_3 = getTypeProvider().getType(param1, param2);
            }
            return _loc_3;
        }// end function

        public static function getTypeProvider() : ITypeProvider
        {
            if (typeProvider == null)
            {
                if (typeProviderKind === TypeProviderKind.JSON)
                {
                    try
                    {
                        typeProvider = new JSONTypeProvider();
                    }
                    catch (e)
                    {
                    }
                }
                if (typeProvider == null)
                {
                    typeProvider = new XmlTypeProvider();
                }
            }
            return typeProvider;
        }// end function

        UNTYPED.fullName = UNTYPED_NAME;
        UNTYPED.name = UNTYPED_NAME;
        VOID.fullName = VOID_NAME;
        VOID.name = VOID_NAME;
        PRIVATE.fullName = PRIVATE_NAME;
        PRIVATE.name = PRIVATE_NAME;
    }
}
