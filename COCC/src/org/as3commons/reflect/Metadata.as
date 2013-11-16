package org.as3commons.reflect
{
    import flash.utils.*;
    import org.as3commons.lang.*;

    public class Metadata extends Object implements IEquals
    {
        private var _name:String;
        private var _arguments:Array;
        public static const TRANSIENT:String = "Transient";
        public static const BINDABLE:String = "Bindable";
        private static const _cache:Dictionary = new Dictionary();

        public function Metadata(param1:String, param2:Array = null)
        {
            this.initMetadata(param1, param2);
            return;
        }// end function

        protected function initMetadata(param1:String, param2:Array) : void
        {
            this._name = param1;
            this._arguments = param2 == null ? ([]) : (param2);
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get arguments() : Array
        {
            return this._arguments;
        }// end function

        public function hasArgumentWithKey(param1:String) : Boolean
        {
            return this.getArgument(param1) != null;
        }// end function

        public function getArgument(param1:String) : MetadataArgument
        {
            var _loc_2:MetadataArgument = null;
            var _loc_3:int = 0;
            while (_loc_3 < this._arguments.length)
            {
                
                if (this._arguments[_loc_3].key == param1)
                {
                    _loc_2 = this._arguments[_loc_3];
                    break;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function equals(param1:Object) : Boolean
        {
            var _loc_4:MetadataArgument = null;
            var _loc_5:MetadataArgument = null;
            Assert.state(param1 is Metadata, "other argument must be of type Metadata");
            arguments = Metadata(param1);
            if (arguments.name == this.name)
            {
                if (arguments.arguments.length != this.arguments.length)
                {
                    return false;
                }
                if (this.arguments.length > 0)
                {
                    for each (_loc_4 in this.arguments)
                    {
                        
                        _loc_5 = arguments.getArgument(_loc_4.key);
                        if (_loc_5 != null)
                        {
                            if (!_loc_4.equals(_loc_5))
                            {
                                return false;
                            }
                            continue;
                        }
                        return false;
                    }
                    return true;
                }
                else
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function toString() : String
        {
            return "[Metadata(" + this.name + ", " + arguments + ")]";
        }// end function

        function setName(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public static function newInstance(param1:String, param2:Array = null) : Metadata
        {
            return getFromCache(param1, param2);
        }// end function

        private static function addToCache(param1:Metadata) : void
        {
            var _loc_2:* = param1.name.toUpperCase();
            var _loc_3:* = _cache[_loc_2];
            if (_loc_3 == null)
            {
                _loc_3 = [];
                _loc_3[0] = param1;
                _cache[_loc_2] = _loc_3;
            }
            else
            {
                _loc_3[_loc_3.length] = param1;
            }
            return;
        }// end function

        private static function getFromCache(param1:String, param2:Array) : Metadata
        {
            var _loc_5:Boolean = false;
            var _loc_6:Metadata = null;
            var _loc_3:* = new Metadata(param1, param2);
            var _loc_4:* = _cache[param1.toUpperCase()];
            if (_cache[param1.toUpperCase()] == null)
            {
                addToCache(_loc_3);
            }
            else
            {
                _loc_5 = false;
                for each (_loc_6 in _loc_4)
                {
                    
                    if (_loc_6.equals(_loc_3))
                    {
                        _loc_3 = _loc_6;
                        _loc_5 = true;
                        break;
                    }
                }
                if (!_loc_5)
                {
                    addToCache(_loc_3);
                }
            }
            return _loc_3;
        }// end function

    }
}
