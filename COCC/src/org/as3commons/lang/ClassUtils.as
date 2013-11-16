package org.as3commons.lang
{
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    final public class ClassUtils extends Object
    {
        private static const PACKAGE_CLASS_SEPARATOR:String = "::";
        private static const LESS_THAN:String = "<";
        private static var _timer:Timer;
        public static const CLEAR_CACHE_INTERVAL:uint = 60000;
        public static var clearCacheInterval:uint = 60000;
        private static var _describeTypeCache:Object = {};
        private static const AS3VEC_SUFFIX:String = "__AS3__.vec";

        public function ClassUtils()
        {
            return;
        }// end function

        public static function getName(param1:Class) : String
        {
            return getNameFromFullyQualifiedName(getFullyQualifiedName(param1));
        }// end function

        public static function getImplementedInterfaces(param1:Class, param2:ApplicationDomain = null) : Array
        {
            param2 = param2 == null ? (ApplicationDomain.currentDomain) : (param2);
            var _loc_3:* = getFullyQualifiedImplementedInterfaceNames(param1);
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_3[_loc_4] = ClassUtils.forName(_loc_3[_loc_4], param2);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function getNameFromFullyQualifiedName(param1:String) : String
        {
            var _loc_2:String = "";
            var _loc_3:* = param1.indexOf(PACKAGE_CLASS_SEPARATOR);
            if (_loc_3 == -1)
            {
                _loc_2 = param1;
            }
            else
            {
                _loc_2 = param1.substring(_loc_3 + PACKAGE_CLASS_SEPARATOR.length, param1.length);
            }
            return _loc_2;
        }// end function

        public static function clearDescribeTypeCache() : void
        {
            _describeTypeCache = {};
            if (_timer && _timer.running)
            {
                _timer.stop();
            }
            return;
        }// end function

        private static function getFromString(param1:String, param2:ApplicationDomain = null) : XML
        {
            param2 = param2 == null ? (ApplicationDomain.currentDomain) : (param2);
            var _loc_3:* = forName(param1, param2);
            return getFromObject(_loc_3, param2);
        }// end function

        public static function getFullyQualifiedName(param1:Class, param2:Boolean = false) : String
        {
            var _loc_3:* = getQualifiedClassName(param1);
            if (param2)
            {
                _loc_3 = convertFullyQualifiedName(_loc_3);
            }
            return _loc_3;
        }// end function

        public static function newInstance(param1:Class, param2:Array = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = param2 == null ? ([]) : (param2);
            switch(_loc_4.length)
            {
                case 1:
                {
                    _loc_3 = new param1(_loc_4[0]);
                    break;
                }
                case 2:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1]);
                    break;
                }
                case 3:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2]);
                    break;
                }
                case 4:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3]);
                    break;
                }
                case 5:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3], _loc_4[4]);
                    break;
                }
                case 6:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3], _loc_4[4], _loc_4[5]);
                    break;
                }
                case 7:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3], _loc_4[4], _loc_4[5], _loc_4[6]);
                    break;
                }
                case 8:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3], _loc_4[4], _loc_4[5], _loc_4[6], _loc_4[7]);
                    break;
                }
                case 9:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3], _loc_4[4], _loc_4[5], _loc_4[6], _loc_4[7], _loc_4[8]);
                    break;
                }
                case 10:
                {
                    _loc_3 = new param1(_loc_4[0], _loc_4[1], _loc_4[2], _loc_4[3], _loc_4[4], _loc_4[5], _loc_4[6], _loc_4[7], _loc_4[8], _loc_4[9]);
                    break;
                }
                default:
                {
                    _loc_3 = new param1;
                    break;
                }
            }
            return _loc_3;
        }// end function

        private static function getFromObject(param1:Object, param2:ApplicationDomain) : XML
        {
            var _loc_4:XML = null;
            Assert.notNull(param1, "The object argument must not be null");
            var _loc_3:* = getQualifiedClassName(param1);
            if (_describeTypeCache.hasOwnProperty(_loc_3))
            {
                _loc_4 = _describeTypeCache[_loc_3];
            }
            else
            {
                if (!_timer)
                {
                    _timer = new Timer(clearCacheInterval, 1);
                    _timer.addEventListener(TimerEvent.TIMER, timerHandler);
                }
                if (!(param1 is Class))
                {
                    if (param1.hasOwnProperty("constructor"))
                    {
                        param1 = param1.constructor;
                    }
                    else
                    {
                        param1 = forName(_loc_3, param2);
                    }
                }
                _loc_4 = describeType(param1);
                _describeTypeCache[_loc_3] = _loc_4;
                if (!_timer.running)
                {
                    _timer.start();
                }
            }
            return _loc_4;
        }// end function

        public static function isAssignableFrom(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
        {
            param3 = param3 == null ? (ApplicationDomain.currentDomain) : (param3);
            return param1 === param2 || isSubclassOf(param2, param1, param3) || isImplementationOf(param2, param1, param3);
        }// end function

        public static function getSuperClassName(param1:Class) : String
        {
            var _loc_2:* = getFullyQualifiedSuperClassName(param1);
            var _loc_3:* = _loc_2.indexOf(PACKAGE_CLASS_SEPARATOR) + PACKAGE_CLASS_SEPARATOR.length;
            return _loc_2.substring(_loc_3, _loc_2.length);
        }// end function

        public static function getClassParameterFromFullyQualifiedName(param1:String, param2:ApplicationDomain = null) : Class
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            param2 = param2 != null ? (param2) : (ApplicationDomain.currentDomain);
            if (StringUtils.startsWith(param1, AS3VEC_SUFFIX))
            {
                _loc_3 = param1.indexOf(LESS_THAN) + 1;
                _loc_4 = param1.length - _loc_3 - 1;
                _loc_5 = param1.substr(_loc_3, _loc_4);
                return forName(_loc_5, param2);
            }
            return null;
        }// end function

        public static function isInformalImplementationOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
        {
            var classDescription:XML;
            var interfaceDescription:XML;
            var interfaceAccessors:XMLList;
            var interfaceAccessor:XML;
            var interfaceMethods:XMLList;
            var interfaceMethod:XML;
            var accessorMatchesInClass:XMLList;
            var methodMatchesInClass:XMLList;
            var interfaceMethodParameters:XMLList;
            var classMethodParameters:XMLList;
            var interfaceParameter:XML;
            var parameterMatchesInClass:XMLList;
            var clazz:* = param1;
            var interfaze:* = param2;
            var applicationDomain:* = param3;
            applicationDomain = applicationDomain == null ? (ApplicationDomain.currentDomain) : (applicationDomain);
            var result:Boolean;
            if (clazz == null)
            {
                result;
            }
            else
            {
                classDescription = getFromObject(clazz, applicationDomain);
                interfaceDescription = getFromObject(interfaze, applicationDomain);
                interfaceAccessors = interfaceDescription.factory.accessor;
                var _loc_5:int = 0;
                var _loc_6:* = interfaceAccessors;
                while (_loc_6 in _loc_5)
                {
                    
                    interfaceAccessor = _loc_6[_loc_5];
                    var _loc_8:int = 0;
                    var _loc_9:* = classDescription.factory.accessor;
                    var _loc_7:* = new XMLList("");
                    for each (_loc_10 in _loc_9)
                    {
                        
                        var _loc_11:* = _loc_9[_loc_8];
                        with (_loc_9[_loc_8])
                        {
                            if (@name == interfaceAccessor.@name && @access == interfaceAccessor.@access && @type == interfaceAccessor.@type)
                            {
                                _loc_7[_loc_8] = _loc_10;
                            }
                        }
                    }
                    accessorMatchesInClass = _loc_7;
                    if (accessorMatchesInClass.length() < 1)
                    {
                        result;
                        break;
                    }
                }
                interfaceMethods = interfaceDescription.factory.method;
                var _loc_5:int = 0;
                var _loc_6:* = interfaceMethods;
                while (_loc_6 in _loc_5)
                {
                    
                    interfaceMethod = _loc_6[_loc_5];
                    var _loc_8:int = 0;
                    var _loc_9:* = classDescription.factory.method;
                    var _loc_7:* = new XMLList("");
                    for each (_loc_10 in _loc_9)
                    {
                        
                        var _loc_11:* = _loc_9[_loc_8];
                        with (_loc_9[_loc_8])
                        {
                            if (@name == interfaceMethod.@name && @returnType == interfaceMethod.@returnType)
                            {
                                _loc_7[_loc_8] = _loc_10;
                            }
                        }
                    }
                    methodMatchesInClass = _loc_7;
                    if (methodMatchesInClass.length() < 1)
                    {
                        result;
                        break;
                    }
                    interfaceMethodParameters = interfaceMethod.parameter;
                    classMethodParameters = methodMatchesInClass.parameter;
                    if (interfaceMethodParameters.length() != classMethodParameters.length())
                    {
                        result;
                    }
                    var _loc_7:int = 0;
                    var _loc_8:* = interfaceMethodParameters;
                    while (_loc_8 in _loc_7)
                    {
                        
                        interfaceParameter = _loc_8[_loc_7];
                        var _loc_10:int = 0;
                        var _loc_11:* = methodMatchesInClass.parameter;
                        var _loc_9:* = new XMLList("");
                        for each (_loc_12 in _loc_11)
                        {
                            
                            var _loc_13:* = _loc_11[_loc_10];
                            with (_loc_11[_loc_10])
                            {
                                if (@index == interfaceParameter.@index && @type == interfaceParameter.@type && @optional == interfaceParameter.@optional)
                                {
                                    _loc_9[_loc_10] = _loc_12;
                                }
                            }
                        }
                        parameterMatchesInClass = _loc_9;
                        if (parameterMatchesInClass.length() < 1)
                        {
                            result;
                            break;
                        }
                    }
                }
            }
            return result;
        }// end function

        public static function getFullyQualifiedImplementedInterfaceNames(param1:Class, param2:Boolean = false, param3:ApplicationDomain = null) : Array
        {
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            param3 = param3 == null ? (ApplicationDomain.currentDomain) : (param3);
            var _loc_4:Array = [];
            var _loc_5:* = getFromObject(param1, param3);
            var _loc_6:* = getFromObject(param1, param3).factory.implementsInterface;
            if (getFromObject(param1, param3).factory.implementsInterface)
            {
                _loc_7 = _loc_6.length();
                _loc_8 = 0;
                while (_loc_8 < _loc_7)
                {
                    
                    _loc_9 = _loc_6[_loc_8].@type.toString();
                    if (param2)
                    {
                        _loc_9 = convertFullyQualifiedName(_loc_9);
                    }
                    _loc_4[_loc_4.length] = _loc_9;
                    _loc_8++;
                }
            }
            return _loc_4;
        }// end function

        public static function isInterface(param1:Class) : Boolean
        {
            return param1 === Object ? (false) : (describeType(param1).factory.extendsClass.length() == 0);
        }// end function

        public static function getFullyQualifiedSuperClassName(param1:Class, param2:Boolean = false) : String
        {
            var _loc_3:* = getQualifiedSuperclassName(param1);
            if (param2)
            {
                _loc_3 = convertFullyQualifiedName(_loc_3);
            }
            return _loc_3;
        }// end function

        private static function timerHandler(event:TimerEvent) : void
        {
            clearDescribeTypeCache();
            return;
        }// end function

        public static function isImplementationOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
        {
            var result:Boolean;
            var classDescription:XML;
            var clazz:* = param1;
            var interfaze:* = param2;
            var applicationDomain:* = param3;
            applicationDomain = applicationDomain == null ? (ApplicationDomain.currentDomain) : (applicationDomain);
            if (clazz == null)
            {
                result;
            }
            else
            {
                classDescription = getFromObject(clazz, applicationDomain);
                var _loc_6:int = 0;
                var _loc_7:* = classDescription.factory.implementsInterface;
                var _loc_5:* = new XMLList("");
                for each (_loc_8 in _loc_7)
                {
                    
                    var _loc_9:* = _loc_7[_loc_6];
                    with (_loc_7[_loc_6])
                    {
                        if (@type == getQualifiedClassName(interfaze))
                        {
                            _loc_5[_loc_6] = _loc_8;
                        }
                    }
                }
                result = _loc_5.length() != 0;
            }
            return result;
        }// end function

        public static function forName(param1:String, param2:ApplicationDomain = null) : Class
        {
            var result:Class;
            var name:* = param1;
            var applicationDomain:* = param2;
            applicationDomain = applicationDomain == null ? (ApplicationDomain.currentDomain) : (applicationDomain);
            if (!applicationDomain)
            {
                applicationDomain = ApplicationDomain.currentDomain;
            }
            while (!applicationDomain.hasDefinition(name))
            {
                
                if (applicationDomain.parentDomain)
                {
                    applicationDomain = applicationDomain.parentDomain;
                    continue;
                }
                break;
            }
            try
            {
                result = applicationDomain.getDefinition(name) as Class;
            }
            catch (e:ReferenceError)
            {
                throw new ClassNotFoundError("A class with the name \'" + name + "\' could not be found.");
            }
            return result;
        }// end function

        public static function convertFullyQualifiedName(param1:String) : String
        {
            return param1.replace(PACKAGE_CLASS_SEPARATOR, ".");
        }// end function

        public static function isSubclassOf(param1:Class, param2:Class, param3:ApplicationDomain = null) : Boolean
        {
            var clazz:* = param1;
            var parentClass:* = param2;
            var applicationDomain:* = param3;
            applicationDomain = applicationDomain == null ? (ApplicationDomain.currentDomain) : (applicationDomain);
            var classDescription:* = getFromObject(clazz, applicationDomain);
            var parentName:* = getQualifiedClassName(parentClass);
            var _loc_6:int = 0;
            var _loc_7:* = classDescription.factory.extendsClass;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_7[_loc_6];
                with (_loc_7[_loc_6])
                {
                    if (@type == parentName)
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            return _loc_5.length() != 0;
        }// end function

        public static function getSuperClass(param1:Class, param2:ApplicationDomain = null) : Class
        {
            var _loc_3:Class = null;
            param2 = param2 == null ? (ApplicationDomain.currentDomain) : (param2);
            var _loc_4:* = getFromObject(param1, param2);
            var _loc_5:* = getFromObject(param1, param2).factory.extendsClass;
            if (getFromObject(param1, param2).factory.extendsClass.length() > 0)
            {
                _loc_3 = ClassUtils.forName(_loc_5[0].@type);
            }
            return _loc_3;
        }// end function

        public static function getImplementedInterfaceNames(param1:Class) : Array
        {
            var _loc_2:* = getFullyQualifiedImplementedInterfaceNames(param1);
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3] = getNameFromFullyQualifiedName(_loc_2[_loc_3]);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public static function forInstance(param1, param2:ApplicationDomain = null) : Class
        {
            param2 = param2 == null ? (ApplicationDomain.currentDomain) : (param2);
            var _loc_3:* = getQualifiedClassName(param1);
            return forName(_loc_3, param2);
        }// end function

        public static function isPrivateClass(param1) : Boolean
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:int = 0;
            if (param1 is Class)
            {
                _loc_3 = getQualifiedClassName(param1);
                _loc_2 = _loc_3.substr(0, _loc_3.indexOf("::"));
            }
            else if (param1 is String)
            {
                _loc_3 = param1.toString();
                _loc_4 = _loc_3.indexOf("::");
                if (_loc_4 > 0)
                {
                    _loc_2 = _loc_3.substr(0, _loc_4);
                }
                else
                {
                    _loc_2 = _loc_3;
                }
            }
            return _loc_2.indexOf(".as$") > -1;
        }// end function

    }
}
