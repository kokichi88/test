package bitzero.net.data
{
    import __AS3__.vec.*;
    import bitzero.net.utils.*;
    import flash.utils.*;

    public class BaseCmd extends Object
    {
        public var crlID:int;
        public var typeId:int;
        protected var bodys:ByteArray;

        public function BaseCmd(param1:int = 0)
        {
            this.typeId = param1;
            this.crlID = 1;
            this.createBodySegment();
            return;
        }// end function

        public function get TypeId() : int
        {
            return this.typeId;
        }// end function

        public function set TypeId(param1:int) : void
        {
            this.typeId = param1;
            return;
        }// end function

        public function set ControllerId(param1:int) : void
        {
            this.crlID = param1;
            return;
        }// end function

        public function getCmdBodys() : ByteArray
        {
            return this.bodys;
        }// end function

        protected function resetBody() : void
        {
            this.bodys = MsgUtil.creatByteArray();
            return;
        }// end function

        protected function createBodySegment() : ByteArray
        {
            this.bodys = MsgUtil.creatByteArray();
            return this.bodys;
        }// end function

        public function createBody() : Boolean
        {
            return true;
        }// end function

        protected function writeUTF(param1:String) : void
        {
            if (param1 == null)
            {
                param1 = "";
            }
            this.bodys.writeUTF(param1);
            return;
        }// end function

        protected function writeIntArray(param1:Vector.<int>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<int>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeInt(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeBooleanArray(param1:Vector.<Boolean>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<Boolean>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeBoolean(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeByteArray(param1:Vector.<int>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<int>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeByte(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeShortArray(param1:Vector.<int>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<int>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeShort(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeFloatArray(param1:Vector.<Number>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<Number>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeFloat(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeDoubleArray(param1:Vector.<Number>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<Number>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeDouble(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeStringArray(param1:Vector.<String>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<String>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeUTF(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeStringArrayfromArray(param1:Array) : void
        {
            if (param1 == null)
            {
                param1 = new Array();
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeUTF(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeLongArray(param1:Vector.<Number>) : void
        {
            if (param1 == null)
            {
                param1 = new Vector.<Number>(0);
            }
            this.bodys.writeShort(param1.length);
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                this.bodys.writeDouble(param1[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        protected function writeLong(param1:Number) : void
        {
            this.bodys.writeDouble(param1);
            return;
        }// end function

    }
}
