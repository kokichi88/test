package org.as3commons.reflect
{
    import org.as3commons.lang.*;
    import org.as3commons.reflect.*;

    public class MetadataContainer extends Object implements IMetadataContainer
    {
        private var _metadata:HashArray;
        private static const METADATA_NAME_PROPERTY:String = "name";

        public function MetadataContainer(param1:HashArray = null)
        {
            this._metadata = param1 == null ? (new HashArray(METADATA_NAME_PROPERTY, true)) : (param1);
            return;
        }// end function

        public function get metadata() : Array
        {
            return this._metadata.getArray();
        }// end function

        public function addMetadata(param1:Metadata) : void
        {
            this._metadata.push(param1);
            return;
        }// end function

        public function getMetadata(param1:String) : Array
        {
            var _loc_2:* = this._metadata.get(param1);
            return _loc_2 is Array ? (_loc_2) : (_loc_2 != null ? ([_loc_2]) : (_loc_2));
        }// end function

        public function hasMetadata(param1:String) : Boolean
        {
            return this.getMetadata(param1) != null;
        }// end function

        public function hasExactMetadata(param1:Metadata) : Boolean
        {
            var _loc_3:Metadata = null;
            var _loc_2:* = this.getMetadata(param1.name);
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.equals(param1))
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
