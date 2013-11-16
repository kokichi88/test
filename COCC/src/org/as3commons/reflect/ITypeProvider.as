package org.as3commons.reflect
{
    import flash.system.*;

    public interface ITypeProvider
    {

        public function ITypeProvider();

        function clearCache() : void;

        function getType(param1:Class, param2:ApplicationDomain) : Type;

        function getTypeCache() : TypeCache;

    }
}
