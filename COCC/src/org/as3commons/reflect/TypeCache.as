package org.as3commons.reflect
{
    import org.as3commons.lang.*;

    public class TypeCache extends Object
    {
        protected var cache:Object;

        public function TypeCache()
        {
            this.cache = {};
            return;
        }// end function

        public function clear() : void
        {
            this.cache = {};
            return;
        }// end function

        public function contains(param1:String) : Boolean
        {
            Assert.hasText(param1, "argument \'key\' cannot be empty");
            return this.cache[param1] != null;
        }// end function

        public function getKeys() : Array
        {
            var _loc_2:String = null;
            var _loc_1:Array = [];
            if (this.cache != null)
            {
                for (_loc_2 in this.cache)
                {
                    
                    _loc_1[_loc_1.length] = _loc_2;
                }
            }
            return _loc_1;
        }// end function

        public function get(param1:String) : Type
        {
            Assert.hasText(param1, "argument \'key\' cannot be empty");
            return this.cache[param1];
        }// end function

        public function put(param1:String, param2:Type) : void
        {
            Assert.notNull(param1, "argument \'key\' cannot be null");
            Assert.hasText(param1, "argument \'key\' cannot be empty");
            Assert.notNull(param2, "argument \'type\' cannot be null");
            this.cache[param1] = param2;
            return;
        }// end function

        public function size() : int
        {
            var _loc_2:String = null;
            var _loc_1:int = 0;
            for (_loc_2 in this.cache)
            {
                
                _loc_1++;
            }
            return _loc_1;
        }// end function

    }
}
