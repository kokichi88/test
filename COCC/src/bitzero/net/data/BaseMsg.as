package bitzero.net.data
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class BaseMsg extends Object
    {
        protected var _body:ByteArray;
        protected var err:int = 0;
        public var errorCode:int = 0;

        public function BaseMsg(param1:Object)
        {
            this._body = param1 as ByteArray;
            var _loc_2:* = this._body.position;
            this.err = this.readByte();
            this.parseBody();
            this._body.position = _loc_2;
            return;
        }// end function

        public function parseBody() : Boolean
        {
            return true;
        }// end function

        protected function hasNext() : Boolean
        {
            var result:Boolean;
            try
            {
                result = Boolean(this._body.bytesAvailable);
            }
            catch (e:Error)
            {
                result;
            }
            return result;
        }// end function

        protected function readByte() : int
        {
            try
            {
                return this._body.readByte();
            }
            catch (e:Error)
            {
            }
            return 0;
        }// end function

        protected function readInt() : int
        {
            try
            {
                return this._body.readInt();
            }
            catch (e:Error)
            {
            }
            return 0;
        }// end function

        protected function readShort() : int
        {
            try
            {
                return this._body.readShort();
            }
            catch (e:Error)
            {
            }
            return 0;
        }// end function

        protected function readStr() : String
        {
            try
            {
                return this._body.readUTF();
            }
            catch (e:Error)
            {
            }
            return "";
        }// end function

        protected function readDouble() : Number
        {
            try
            {
                return this._body.readDouble();
            }
            catch (e:Error)
            {
            }
            return 0;
        }// end function

        protected function readBoolean() : Boolean
        {
            try
            {
                return this._body.readBoolean();
            }
            catch (e:Error)
            {
            }
            return false;
        }// end function

        protected function readLong() : Number
        {
            try
            {
                return this._body.readDouble();
            }
            catch (e:Error)
            {
            }
            return 0;
        }// end function

        protected function readFloat() : Number
        {
            try
            {
                return this._body.readFloat();
            }
            catch (e:Error)
            {
            }
            return 0;
        }// end function

        protected function readIntArray() : Vector.<int>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<int> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<int>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readInt();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<int>(0);
        }// end function

        protected function readByteArray() : Vector.<int>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<int> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<int>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readByte();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<int>(0);
        }// end function

        protected function readFloatArray() : Vector.<Number>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<Number> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<Number>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readFloat();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<Number>(0);
        }// end function

        protected function readDoubleArray() : Vector.<Number>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<Number> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<Number>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readDouble();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<Number>(0);
        }// end function

        protected function readLongArray() : Vector.<Number>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<Number> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<Number>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readDouble();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<Number>(0);
        }// end function

        protected function readBooleanArray() : Vector.<Boolean>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<Boolean> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<Boolean>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readBoolean();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<Boolean>(0);
        }// end function

        protected function readShortArray() : Vector.<int>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<int> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<int>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readShort();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<int>(0);
        }// end function

        protected function readStringArray() : Vector.<String>
        {
            var _loc_1:int = 0;
            var _loc_2:Vector.<String> = null;
            var _loc_3:int = 0;
            try
            {
                _loc_1 = this._body.readShort();
                _loc_2 = new Vector.<String>(_loc_1);
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3] = this._body.readUTF();
                    _loc_3++;
                }
                return _loc_2;
            }
            catch (e:Error)
            {
            }
            return new Vector.<String>(0);
        }// end function

        public function get ErrorCode() : int
        {
            return this.err;
        }// end function

        public function getError() : String
        {
            return this.err.toString();
        }// end function

        public function getBody() : ByteArray
        {
            return this._body;
        }// end function

    }
}
