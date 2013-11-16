package org.as3commons.lang
{
    import flash.utils.*;

    public class HashArray extends Object
    {
        private var _lookUpPropertyName:String;
        private var _allowDuplicates:Boolean = false;
        private var _lookup:Dictionary;
        private var _list:Array;
        private static const illegalKeys:Array = ["hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "setPropertyIsEnumerable", "toLocaleString", "toString", "valueOf", "prototype", "constructor"];

        public function HashArray(param1:String, param2:Boolean = false, param3:Array = null)
        {
            this.init(param1, param2, param3);
            return;
        }// end function

        public function set allowDuplicates(param1:Boolean) : void
        {
            this._allowDuplicates = param1;
            return;
        }// end function

        protected function add(param1:Array) : void
        {
            var _loc_2:uint = 0;
            var _loc_3:uint = 0;
            if (param1 != null)
            {
                _loc_2 = param1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    this.pushOne(param1[_loc_3]);
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public function get(param1:String)
        {
            param1 = this.makeValidKey(param1);
            return this._lookup[param1];
        }// end function

        public function get length() : uint
        {
            return this._list.length;
        }// end function

        public function rehash() : void
        {
            var _loc_2:* = undefined;
            var _loc_3:uint = 0;
            this._lookup = new Dictionary();
            var _loc_1:* = this._list.length;
            while (_loc_3 < _loc_1)
            {
                
                _loc_2 = this._list[_loc_3];
                if (_loc_2 != null)
                {
                    this.addToLookup(_loc_2);
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function pop()
        {
            var _loc_1:* = this._list.pop();
            this.removeFromLookup(_loc_1);
            return _loc_1;
        }// end function

        public function splice(... args)
        {
            args = this._list.splice(args);
            this.rehash();
            return args;
        }// end function

        protected function pushOne(param1) : void
        {
            this.addToLookup(param1);
            this._list.push(param1);
            return;
        }// end function

        protected function removeFromLookup(param1) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_2:* = this._lookup[param1[this._lookUpPropertyName]];
            if (_loc_2 is Array && this._allowDuplicates)
            {
                _loc_3 = _loc_2 as Array;
                _loc_4 = ArrayUtils.removeFirstOccurance(_loc_3, param1);
                if (_loc_3.length < 1)
                {
                    delete this._lookup[param1[this._lookUpPropertyName]];
                }
            }
            else
            {
                delete this._lookup[param1[this._lookUpPropertyName]];
            }
            return;
        }// end function

        protected function init(param1:String, param2:Boolean, param3:Array) : void
        {
            this._lookup = new Dictionary();
            this._lookUpPropertyName = this.makeValidKey(param1);
            this._allowDuplicates = param2;
            this._list = [];
            this.add(param3);
            return;
        }// end function

        public function get allowDuplicates() : Boolean
        {
            return this._allowDuplicates;
        }// end function

        protected function addToLookup(param1) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:Array = null;
            var _loc_5:* = undefined;
            var _loc_2:* = this.makeValidKey(param1[this._lookUpPropertyName]);
            if (this._allowDuplicates)
            {
                _loc_3 = this._lookup[_loc_2];
                if (_loc_3 == null)
                {
                    this._lookup[_loc_2] = [param1];
                }
                else if (_loc_3 is Array)
                {
                    _loc_4 = _loc_3 as Array;
                    (_loc_3 as Array)[_loc_4.length] = param1;
                }
                else
                {
                    _loc_4 = [];
                    [][_loc_4.length] = _loc_3;
                    _loc_4[_loc_4.length] = param1;
                    this._lookup[_loc_2] = _loc_4;
                }
            }
            else
            {
                _loc_5 = this._lookup[_loc_2];
                if (_loc_5 != null)
                {
                    ArrayUtils.removeFirstOccurance(this._list, _loc_5);
                }
                this._lookup[_loc_2] = param1;
            }
            return;
        }// end function

        public function getArray() : Array
        {
            return this._list.concat();
        }// end function

        protected function makeValidKey(param1)
        {
            if (!(param1 is String))
            {
                return param1;
            }
            if (illegalKeys.indexOf(String(param1)) > -1)
            {
                return String(param1) + "_";
            }
            return param1;
        }// end function

        public function shift()
        {
            var _loc_1:* = this._list.shift();
            this.removeFromLookup(_loc_1);
            return _loc_1;
        }// end function

        public function push(... args) : uint
        {
            var _loc_3:Array = null;
            var _loc_6:* = undefined;
            args = args.length;
            if (args == 1 && args[0] is Array)
            {
                _loc_3 = args[0] as Array;
                args = _loc_3.length;
            }
            else
            {
                _loc_3 = args;
            }
            var _loc_4:int = 0;
            var _loc_5:uint = 0;
            while (_loc_5 < args)
            {
                
                _loc_6 = _loc_3[_loc_5];
                this.addToLookup(_loc_6);
                _loc_4 = this._list.push(_loc_6);
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }// end function

    }
}
