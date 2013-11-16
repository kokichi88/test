package org.as3commons.reflect
{
    import avmplus.*;
    import flash.errors.*;
    import flash.system.*;
    import org.as3commons.lang.*;

    public class JSONTypeProvider extends AbstractTypeProvider
    {
        private var _describeTypeJSON:Function;
        public static const ALIAS_NOT_AVAILABLE:String = "Alias not available when using JSONTypeProvider";

        public function JSONTypeProvider()
        {
            this.initJSONTypeProvider();
            return;
        }// end function

        protected function initJSONTypeProvider() : void
        {
            this._describeTypeJSON = DescribeType.getJSONFunction();
            if (this._describeTypeJSON == null)
            {
                throw new IllegalOperationError("describeTypeJSON not supported in currently installed flash player");
            }
            return;
        }// end function

        override public function getType(param1:Class, param2:ApplicationDomain) : Type
        {
            var _loc_10:Type = null;
            var _loc_11:Array = null;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_3:* = new Type(param2);
            var _loc_4:* = ClassUtils.getFullyQualifiedName(param1);
            typeCache.put(_loc_4, _loc_3);
            var _loc_5:* = this._describeTypeJSON(param1, DescribeType.GET_INSTANCE_INFO);
            var _loc_6:* = this._describeTypeJSON(param1, DescribeType.GET_CLASS_INFO);
            _loc_3.fullName = _loc_4;
            _loc_3.name = ClassUtils.getNameFromFullyQualifiedName(_loc_4);
            var _loc_7:* = ClassUtils.getClassParameterFromFullyQualifiedName(_loc_5.name, param2);
            if (ClassUtils.getClassParameterFromFullyQualifiedName(_loc_5.name, param2) != null)
            {
                _loc_3.parameters[_loc_3.parameters.length] = _loc_7;
            }
            _loc_3.clazz = param1;
            _loc_3.isDynamic = _loc_5.isDynamic;
            _loc_3.isFinal = _loc_5.isFinal;
            _loc_3.isStatic = _loc_5.isStatic;
            _loc_3.alias = ALIAS_NOT_AVAILABLE;
            _loc_3.isInterface = _loc_5.traits.bases.length == 0;
            _loc_3.constructor = this.parseConstructor(_loc_3, _loc_5.traits.constructor, param2);
            _loc_3.accessors = this.parseAccessors(_loc_3, _loc_5.traits.accessors, param2, false).concat(this.parseAccessors(_loc_3, _loc_6.traits.accessors, param2, true));
            _loc_3.methods = this.parseMethods(_loc_3, _loc_5.traits.methods, param2, false).concat(this.parseMethods(_loc_3, _loc_6.traits.methods, param2, true));
            _loc_3.staticConstants = this.parseMembers(_loc_3, Constant, Constant.doCacheCheck, _loc_6.traits.variables, _loc_4, true, true, param2);
            _loc_3.constants = this.parseMembers(_loc_3, Constant, Constant.doCacheCheck, _loc_5.traits.variables, _loc_4, false, true, param2);
            _loc_3.staticVariables = this.parseMembers(_loc_3, Variable, Variable.doCacheCheck, _loc_6.traits.variables, _loc_4, true, false, param2);
            _loc_3.variables = this.parseMembers(_loc_3, Variable, Variable.doCacheCheck, _loc_5.traits.variables, _loc_4, false, false, param2);
            _loc_3.extendsClasses = _loc_5.traits.bases.concat();
            this.parseMetadata(_loc_5.traits.metadata, _loc_3);
            _loc_3.interfaces = this.parseImplementedInterfaces(_loc_5.traits.interfaces);
            var _loc_8:* = _loc_3.interfaces.length;
            var _loc_9:int = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_10 = Type.forName(_loc_3.interfaces[_loc_9], param2);
                this.concatMetadata(_loc_3, _loc_10.methods, "methods");
                this.concatMetadata(_loc_3, _loc_10.accessors, "accessors");
                _loc_11 = _loc_10.metadata;
                _loc_12 = _loc_11.length;
                _loc_13 = 0;
                while (_loc_13 < _loc_12)
                {
                    
                    if (!_loc_3.hasExactMetadata(_loc_11[_loc_13]))
                    {
                        _loc_3.addMetadata(_loc_11[_loc_13]);
                    }
                    _loc_13++;
                }
                _loc_9++;
            }
            _loc_3.createMetadataLookup();
            return _loc_3;
        }// end function

        protected function parseConstructor(param1:Type, param2:Array, param3:ApplicationDomain) : Constructor
        {
            var _loc_4:Array = null;
            if (param2 != null && param2.length > 0)
            {
                _loc_4 = this.parseParameters(param2, param3);
                return new Constructor(param1.fullName, param3, _loc_4);
            }
            return new Constructor(param1.fullName, param3);
        }// end function

        private function concatMetadata(param1:Type, param2:Array, param3:String) : void
        {
            var container:IMetadataContainer;
            var type:* = param1;
            var metadataContainers:* = param2;
            var propertyName:* = param3;
            var _loc_5:int = 0;
            var _loc_6:* = metadataContainers;
            while (_loc_6 in _loc_5)
            {
                
                container = _loc_6[_loc_5];
                type[propertyName].some(function (param1:MetadataContainer, param2:int, param3:Array) : Boolean
            {
                var _loc_4:Array = null;
                var _loc_5:int = 0;
                var _loc_6:int = 0;
                if (Object(param1).name == Object(container).name)
                {
                    _loc_4 = container.metadata;
                    _loc_5 = _loc_4.length;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_5)
                    {
                        
                        if (!param1.hasExactMetadata(_loc_4[_loc_6]))
                        {
                            param1.addMetadata(_loc_4[_loc_6]);
                        }
                        _loc_6++;
                    }
                    return true;
                }
                return false;
            }// end function
            );
            }
            return;
        }// end function

        private function parseImplementedInterfaces(param1:Array) : Array
        {
            var _loc_3:String = null;
            var _loc_2:Array = [];
            if (param1 != null)
            {
                for each (_loc_3 in param1)
                {
                    
                    _loc_2[_loc_2.length] = ClassUtils.convertFullyQualifiedName(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        private function parseMethods(param1:Type, param2:Array, param3:ApplicationDomain, param4:Boolean) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_8:Method = null;
            var _loc_5:Array = [];
            for each (_loc_6 in param2)
            {
                
                _loc_7 = this.parseParameters(_loc_6.parameters, param3);
                _loc_8 = new Method(param1.fullName, _loc_6.name, param4, _loc_7, _loc_6.returnType, param3);
                var _loc_11:* = _loc_8;
                _loc_11.as3commons_reflect::setNamespaceURI(_loc_6.uri);
                this.parseMetadata(_loc_6.metadata, _loc_8);
                _loc_5[_loc_5.length] = _loc_8;
            }
            return _loc_5;
        }// end function

        private function parseParameters(param1:Array, param2:ApplicationDomain) : Array
        {
            var _loc_5:Object = null;
            var _loc_6:Parameter = null;
            var _loc_3:Array = [];
            var _loc_4:int = 1;
            for each (_loc_5 in param1)
            {
                
                _loc_6 = Parameter.newInstance(_loc_5.type, param2, _loc_5.optional);
                _loc_3[_loc_3.length] = _loc_6;
            }
            return _loc_3;
        }// end function

        private function parseAccessors(param1:Type, param2:Array, param3:ApplicationDomain, param4:Boolean) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:Accessor = null;
            var _loc_5:Array = [];
            for each (_loc_6 in param2)
            {
                
                _loc_7 = new Accessor(_loc_6.name, AccessorAccess.fromString(_loc_6.access), _loc_6.type, _loc_6.declaredBy, param4, param3);
                var _loc_10:* = _loc_7;
                _loc_10.as3commons_reflect::setNamespaceURI(_loc_6.uri);
                this.parseMetadata(_loc_6.metadata, _loc_7);
                _loc_7 = Accessor.doCacheCheck(_loc_7);
                _loc_5[_loc_5.length] = _loc_7;
            }
            return _loc_5;
        }// end function

        private function parseMetadata(param1:Array, param2:IMetadataContainer) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            for each (_loc_3 in param1)
            {
                
                _loc_4 = [];
                for each (_loc_5 in _loc_3.value)
                {
                    
                    _loc_4[_loc_4.length] = MetadataArgument.newInstance(_loc_5.key, _loc_5.value);
                }
                param2.addMetadata(Metadata.newInstance(_loc_3.name, _loc_4));
            }
            return;
        }// end function

        private function parseMembers(param1:Type, param2:Class, param3:Function, param4:Array, param5:String, param6:Boolean, param7:Boolean, param8:ApplicationDomain) : Array
        {
            var _loc_10:Object = null;
            var _loc_11:IMember = null;
            var _loc_9:Array = [];
            for each (_loc_10 in param4)
            {
                
                if (param7 && _loc_10.access != AccessorAccess.READ_ONLY.name)
                {
                    continue;
                }
                else if (!param7 && _loc_10.access == AccessorAccess.READ_ONLY.name)
                {
                    continue;
                }
                _loc_11 = new param2(_loc_10.name, _loc_10.type, param5, param6, param8);
                if (_loc_11 is INamespaceOwner)
                {
                    var _loc_14:* = INamespaceOwner(_loc_11);
                    _loc_14.as3commons_reflect::setNamespaceURI(_loc_10.uri);
                }
                this.parseMetadata(_loc_10.metadata, _loc_11);
                _loc_11 = this.param3(_loc_11);
                _loc_9[_loc_9.length] = _loc_11;
            }
            return _loc_9;
        }// end function

    }
}
