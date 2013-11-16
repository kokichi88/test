package org.as3commons.reflect
{
    import flash.system.*;
    import org.as3commons.lang.*;

    public class XmlTypeProvider extends AbstractTypeProvider
    {
        private static const TRUE_VALUE:String = "true";
        private static const METHODS_NAME:String = "methods";
        private static const ACCESSORS_NAME:String = "accessors";

        public function XmlTypeProvider()
        {
            return;
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

        override public function getType(param1:Class, param2:ApplicationDomain) : Type
        {
            var _loc_9:Type = null;
            var _loc_10:Array = null;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_3:* = new Type(param2);
            var _loc_4:* = ClassUtils.getFullyQualifiedName(param1);
            typeCache.put(_loc_4, _loc_3);
            var _loc_5:* = ReflectionUtils.getTypeDescription(param1);
            _loc_3.fullName = _loc_4;
            _loc_3.name = ClassUtils.getNameFromFullyQualifiedName(_loc_4);
            var _loc_6:* = ClassUtils.getClassParameterFromFullyQualifiedName(_loc_5.@name, param2);
            if (ClassUtils.getClassParameterFromFullyQualifiedName(_loc_5.@name, param2) != null)
            {
                _loc_3.parameters[_loc_3.parameters.length] = _loc_6;
            }
            _loc_3.clazz = param1;
            _loc_3.isDynamic = _loc_5.@isDynamic.toString() == TRUE_VALUE;
            _loc_3.isFinal = _loc_5.@isFinal.toString() == TRUE_VALUE;
            _loc_3.isStatic = _loc_5.@isStatic.toString() == TRUE_VALUE;
            _loc_3.alias = _loc_5.@alias;
            _loc_3.isInterface = param1 === Object ? (false) : (_loc_5.factory.extendsClass.length() == 0);
            _loc_3.constructor = this.parseConstructor(_loc_3, _loc_5.factory.constructor, param2);
            _loc_3.accessors = this.parseAccessors(_loc_3, _loc_5, param2);
            _loc_3.methods = this.parseMethods(_loc_3, _loc_5, param2);
            _loc_3.staticConstants = this.parseMembers(Constant, Constant.doCacheCheck, _loc_5.constant, _loc_4, true, param2);
            _loc_3.constants = this.parseMembers(Constant, Constant.doCacheCheck, _loc_5.factory.constant, _loc_4, false, param2);
            _loc_3.staticVariables = this.parseMembers(Variable, Variable.doCacheCheck, _loc_5.variable, _loc_4, true, param2);
            _loc_3.variables = this.parseMembers(Variable, Variable.doCacheCheck, _loc_5.factory.variable, _loc_4, false, param2);
            _loc_3.extendsClasses = this.parseExtendsClasses(_loc_5.factory.extendsClass, _loc_3.applicationDomain);
            this.parseMetadata(_loc_5.factory[0].metadata, _loc_3);
            _loc_3.interfaces = this.parseImplementedInterfaces(_loc_5.factory.implementsInterface);
            var _loc_7:* = _loc_3.interfaces.length;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_9 = Type.forName(_loc_3.interfaces[_loc_8], param2);
                this.concatMetadata(_loc_3, _loc_9.methods, METHODS_NAME);
                this.concatMetadata(_loc_3, _loc_9.accessors, ACCESSORS_NAME);
                _loc_10 = _loc_9.metadata;
                _loc_11 = _loc_10.length;
                _loc_12 = 0;
                while (_loc_12 < _loc_11)
                {
                    
                    if (!_loc_3.hasExactMetadata(_loc_10[_loc_12]))
                    {
                        _loc_3.addMetadata(_loc_10[_loc_12]);
                    }
                    _loc_12++;
                }
                _loc_8++;
            }
            _loc_3.createMetadataLookup();
            return _loc_3;
        }// end function

        private function parseConstructor(param1:Type, param2:XMLList, param3:ApplicationDomain) : Constructor
        {
            var _loc_4:Array = null;
            if (param2.length() > 0)
            {
                _loc_4 = this.parseParameters(param2[0].parameter, param3);
                return new Constructor(param1.fullName, param3, _loc_4);
            }
            return new Constructor(param1.fullName, param3);
        }// end function

        private function parseMethods(param1:Type, param2:XML, param3:ApplicationDomain) : Array
        {
            var _loc_4:* = this.parseMethodsByModifier(param1, param2.method, true, param3);
            var _loc_5:* = this.parseMethodsByModifier(param1, param2.factory.method, false, param3);
            return _loc_4.concat(_loc_5);
        }// end function

        private function parseAccessors(param1:Type, param2:XML, param3:ApplicationDomain) : Array
        {
            var _loc_4:* = this.parseAccessorsByModifier(param1, param2.accessor, true, param3);
            var _loc_5:* = this.parseAccessorsByModifier(param1, param2.factory.accessor, false, param3);
            return _loc_4.concat(_loc_5);
        }// end function

        private function parseMembers(param1:Class, param2:Function, param3:XMLList, param4:String, param5:Boolean, param6:ApplicationDomain) : Array
        {
            var _loc_8:XML = null;
            var _loc_9:IMember = null;
            var _loc_7:Array = [];
            for each (_loc_8 in param3)
            {
                
                _loc_9 = new param1(_loc_8.@name, _loc_8.@type.toString(), param4, param5, param6);
                if (_loc_9 is INamespaceOwner)
                {
                    var _loc_12:* = INamespaceOwner(_loc_9);
                    _loc_12.as3commons_reflect::setNamespaceURI(_loc_8.@uri.toString());
                }
                this.parseMetadata(_loc_8.metadata, _loc_9);
                _loc_9 = this.param2(_loc_9);
                _loc_7[_loc_7.length] = _loc_9;
            }
            return _loc_7;
        }// end function

        private function parseImplementedInterfaces(param1:XMLList) : Array
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_2:Array = [];
            if (param1)
            {
                _loc_3 = param1.length();
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = param1[_loc_4].@type.toString();
                    _loc_5 = ClassUtils.convertFullyQualifiedName(_loc_5);
                    _loc_2[_loc_2.length] = _loc_5;
                    _loc_4++;
                }
            }
            return _loc_2;
        }// end function

        private function parseExtendsClasses(param1:XMLList, param2:ApplicationDomain) : Array
        {
            var _loc_4:XML = null;
            var _loc_3:Array = [];
            for each (_loc_4 in param1)
            {
                
                _loc_3[_loc_3.length] = _loc_4.@type.toString();
            }
            return _loc_3;
        }// end function

        private function parseMethodsByModifier(param1:Type, param2:XMLList, param3:Boolean, param4:ApplicationDomain) : Array
        {
            var _loc_6:XML = null;
            var _loc_7:Array = null;
            var _loc_8:Method = null;
            var _loc_5:Array = [];
            for each (_loc_6 in param2)
            {
                
                _loc_7 = this.parseParameters(_loc_6.parameter, param4);
                _loc_8 = new Method(param1.fullName, _loc_6.@name, param3, _loc_7, _loc_6.@returnType, param4);
                var _loc_11:* = _loc_8;
                _loc_11.as3commons_reflect::setNamespaceURI(_loc_6.@uri);
                this.parseMetadata(_loc_6.metadata, _loc_8);
                _loc_5[_loc_5.length] = _loc_8;
            }
            return _loc_5;
        }// end function

        private function parseParameters(param1:XMLList, param2:ApplicationDomain) : Array
        {
            var _loc_4:XML = null;
            var _loc_5:Parameter = null;
            var _loc_3:Array = [];
            for each (_loc_4 in param1)
            {
                
                _loc_5 = Parameter.newInstance(_loc_4.@type, param2, _loc_4.@optional == TRUE_VALUE ? (true) : (false));
                _loc_3[_loc_3.length] = _loc_5;
            }
            return _loc_3;
        }// end function

        private function parseAccessorsByModifier(param1:Type, param2:XMLList, param3:Boolean, param4:ApplicationDomain) : Array
        {
            var _loc_6:XML = null;
            var _loc_7:Accessor = null;
            var _loc_5:Array = [];
            for each (_loc_6 in param2)
            {
                
                _loc_7 = new Accessor(_loc_6.@name, AccessorAccess.fromString(_loc_6.@access), _loc_6.@type.toString(), _loc_6.@declaredBy.toString(), param3, param4);
                if (StringUtils.hasText(_loc_6.@uri))
                {
                    var _loc_10:* = _loc_7;
                    _loc_10.as3commons_reflect::setNamespaceURI(_loc_6.@uri.toString());
                }
                this.parseMetadata(_loc_6.metadata, _loc_7);
                _loc_7 = Accessor.doCacheCheck(_loc_7);
                _loc_5[_loc_5.length] = _loc_7;
            }
            return _loc_5;
        }// end function

        private function parseMetadata(param1:XMLList, param2:IMetadataContainer) : void
        {
            var _loc_3:XML = null;
            var _loc_4:Array = null;
            var _loc_5:XML = null;
            for each (_loc_3 in param1)
            {
                
                _loc_4 = [];
                for each (_loc_5 in _loc_3.arg)
                {
                    
                    _loc_4[_loc_4.length] = MetadataArgument.newInstance(_loc_5.@key, _loc_5.@value);
                }
                param2.addMetadata(Metadata.newInstance(_loc_3.@name, _loc_4));
            }
            return;
        }// end function

    }
}
