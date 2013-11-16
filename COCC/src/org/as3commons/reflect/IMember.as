package org.as3commons.reflect
{
    import org.as3commons.reflect.*;

    public interface IMember extends IMetadataContainer
    {

        public function IMember();

        function get name() : String;

        function get type() : Type;

        function get declaringType() : Type;

    }
}
