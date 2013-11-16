package org.as3commons.reflect
{
    import flash.system.*;
    import org.as3commons.reflect.*;

    public class AbstractTypeProvider extends Object implements ITypeProvider
    {
        protected var typeCache:TypeCache;

        public function AbstractTypeProvider()
        {
            if (this.typeCache == null)
            {
                this.typeCache = new TypeCache();
            }
            return;
        }// end function

        public function getTypeCache() : TypeCache
        {
            return this.typeCache;
        }// end function

        public function clearCache() : void
        {
            this.typeCache.clear();
            return;
        }// end function

        public function getType(param1:Class, param2:ApplicationDomain) : Type
        {
            throw new Error("Not implemented in abstract base class");
        }// end function

    }
}
