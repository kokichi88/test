package org.as3commons.reflect
{
    import flash.system.*;
    import flash.utils.*;
    import org.as3commons.lang.*;

    public class ReflectionUtils extends Object
    {
        private static var _version:String;
        private static var _isOldPlayer:Boolean = true;

        public function ReflectionUtils()
        {
            return;
        }// end function

        public static function concatTypeMetadata(param1:Type, param2:Array, param3:String) : void
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
                type[propertyName].some(function (param1:Object, param2:int, param3:Array) : Boolean
            {
                var _loc_4:Array = null;
                var _loc_5:int = 0;
                var _loc_6:int = 0;
                if (param1.name == Object(container).name)
                {
                    _loc_4 = container.metadata;
                    _loc_5 = _loc_4.length;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_5)
                    {
                        
                        param1.addMetadata(_loc_4[_loc_6]);
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

        public static function getTypeDescription(param1:Class) : XML
        {
            var parametersXML:XMLList;
            var args:Array;
            var n:int;
            var clazz:* = param1;
            var description:* = describeType(clazz);
            var constructorXML:* = description.factory.constructor;
            if (constructorXML && constructorXML.length() > 0)
            {
                parametersXML = constructorXML[0].parameter;
                if (parametersXML && parametersXML.length() > 0)
                {
                    args;
                    n;
                    while (n < parametersXML.length())
                    {
                        
                        args.push(null);
                        n = (n + 1);
                    }
                    if (playerHasConstructorBug())
                    {
                        try
                        {
                            ClassUtils.newInstance(clazz, args);
                        }
                        catch (e:Error)
                        {
                        }
                    }
                    description = describeType(clazz);
                }
            }
            return description;
        }// end function

        public static function playerHasConstructorBug() : Boolean
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (_version == null)
            {
                _version = Capabilities.version.split(" ")[1];
                _loc_1 = _version.split(",");
                _loc_2 = int(_loc_1[0]);
                _loc_3 = String(_loc_1[1]).length > 0 ? (int(_loc_1[1])) : (0);
                _isOldPlayer = _loc_2 == 10 ? (_loc_3 < 1) : (_loc_2 < 9);
            }
            return _isOldPlayer;
        }// end function

    }
}
