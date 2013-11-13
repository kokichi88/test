package package2
{
		// ^_***;
        public class P2Class1
        {
                public function P2Class1(arg0:Class)
                {
                        var uint1:uint = 0;
                        ready = false;
                        seeded = false;
                        if(!(arg0 != null))
                        {
                                var class1:Class = package2.P2Class2;
                        }
                        state = package2.P2Interface1(new class1());
                        psize = state.package2:P2Interface1.getPoolSize();
                        pool = new flash.utils.ByteArray();
                        pptr = 0;
                        while(pptr < psize)
                        {
                                uint1 = 65536 * (Math.random());
                                var local2:* = pptr;
                                var local3:* = int(<dup>pptr.pptr) + 1;
                                local2.pptr = local3;
                                var local1:* = <dup>pptr.pptr;
                                pool[local1] = uint1 >>> 8;
                                local3 = pptr;
                                var local4:* = int(<dup>pptr.pptr) + 1;
                                local3.pptr = local4;
                                local2 = <dup>pptr.pptr;
                                pool[<dup>pptr.pptr] = uint1 & 255;
                        }
                        pptr = 0;
                        seed();
                }
                private var pool:flash.utils.ByteArray;
                private var pptr:int;
                private var psize:int;
                private var ready:Boolean;
                private var seeded:Boolean;
                private var state:package2.P2Class1
                public function autoSeed():void
                {
                        var byteArray1:flash.utils.ByteArray = null;
                        var array1:Array = null;
                        var font1:flash.text.Font = null;
                        byteArray1 = new flash.utils.ByteArray();
                        byteArray1.writeUnsignedInt(flash.system.System.totalMemory);
                        byteArray1.writeUTF(flash.system.Capabilities.serverString);
                        byteArray1.writeUnsignedInt(flash.utils.getTimer());
                        byteArray1.writeUnsignedInt(new Date().getTime());
                        array1 = flash.text.Font.enumerateFonts(true);
                        var local3:* = 0;
                        var local4:* = array1;
                        while(<hasnext2>(local4))
                        {
                                font1 = <nextvalue>(local3, local4);
                                byteArray1.writeUTF(font1.fontName);
                                byteArray1.writeUTF(font1.fontStyle);
                                byteArray1.writeUTF(font1.fontType);
                        }
                        byteArray1.position = 0;
                        while(byteArray1.bytesAvailable >= 4)
                        {
                                seed(byteArray1.readUnsignedInt());
                        }
                }
                public function dispose():void
                {
                        var uint1:uint = 0;
                        uint1 = 0;
                        while(uint1 < pool.length)
                        {
                                pool[uint1] = (Math.random()) * 256;
                                uint1 = uint1 + 1;
                        }
                        pool.length = 0;
                        pool = null;
                        state.package2:P2Interface1.dispose();
                        state = null;
                        psize = 0;
                        pptr = 0;
                        package1.Memory.gc();
                }
                public function nextByte():int
                {
                        if(!(ready))
                        {
                                if(!(seeded))
                                {
                                        autoSeed();
                                }
                                state.package2:P2Interface1.init(pool);
                                pool.length = 0;
                                pptr = 0;
                                ready = true;
                        }
                        return state.package2:P2Interface1.next();
                }
                public function nextBytes(arg0:flash.utils.ByteArray, arg1:int):void
                {
                        var arg1:* = int(arg1) - 1;
                        while(arg1)
                        {
                                arg0.writeByte(nextByte());
                        }
                }
                public function seed(arg0:int):void
                {
                        if(!(arg0 != 0))
                        {
                                var int1:int = new Date().getTime();
                        }
                        var local1:* = pptr;
                        var local2:* = int(<dup>pptr.pptr) + 1;
                        local1.pptr = local2;
                        var local0:* = <dup>pptr.pptr;
                        pool[local0] = (pool[local0]) ^ (int1 & 255);
                        local2 = pptr;
                        var local3:* = int(<dup>pptr.pptr) + 1;
                        local2.pptr = local3;
                        local1 = <dup>pptr.pptr;
                        pool[local1] = (pool[local1]) ^ ((int1 >> 8) & 255);
                        local3 = pptr;
                        var local4:* = int(<dup>pptr.pptr) + 1;
                        local3.pptr = local4;
                        local2 = <dup>pptr.pptr;
                        pool[<dup>pptr.pptr] = (pool[local2]) ^ ((int1 >> 16) & 255);
                        local4 = pptr;
                        var local5:* = int(<dup>pptr.pptr) + 1;
                        local4.pptr = local5;
                        local3 = <dup>pptr.pptr;
                        pool[<dup>pptr.pptr] = (pool[local3]) ^ ((int1 >> 24) & 255);
                        pptr = pptr % psize;
                        seeded = true;
                }
                public function toString():String
                {
                        return ('random-') + (state.package2:P2Interface1.toString());
                }
        }
}