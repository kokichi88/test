package package2
{
	import flash.utils.ByteArray;
	import package1.Memory;
	import package3.P3Iterface2;
		// ^_**
        public class P2Class2 implements P2Interface1, P3Iterface2
        {
                public function P2Class2(arg0:flash.utils.ByteArray)
                {
                        i = 0;
                        j = 0;
                        S = new flash.utils.ByteArray();
                        if(arg0)
                        {
                                init(arg0);
                        }
                }
                private const psize:uint = 256;
                private var i:int = 0;
                private var j:int = 0;
                private var S:ByteArray;
                public function func1(arg0:flash.utils.ByteArray):void
                {
                        var uint1:uint = 0;
                        uint1 = 0;
                        while(uint1 < arg0.length)
                        {
                                uint1 = Number(uint1) + 1;
                                var local1:* = Number(uint1);
                                arg0[local1] = (arg0[local1]) ^ (next());
                        }
                }
                public function func2(arg0:flash.utils.ByteArray):void
                {
                        func1(arg0);
                }
                public function dispose():void
                {
                        var uint1:uint = 0;
                        uint1 = 0;
                        if(!(S == null))
                        {
                                uint1 = 0;
                                while(uint1 < S.length)
                                {
                                        S[uint1] = (Math.random()) * 256;
                                        uint1 = uint1 + 1;
                                }
                                S.length = 0;
                                S = null;
                        }
                        this.i = 0;
                        this.j = 0;
                        Memory.gc();
                }
                public function getBlockSize():uint
                {
                        return 1;
                }
                public function getPoolSize():uint
                {
                        return psize;
                }
                public function init(arg0:flash.utils.ByteArray):void
                {
                        var local0:* = 0;
                        var local1:* = 0;
                        var local2:* = 0;
                        local0 = 0;
                        while(local0 < 256)
                        {
                                S[local0] = local0;
                                ++local0;
                        }
                        local1 = 0;
                        local0 = 0;
                        while(local0 < 256)
                        {
                                local1 = ((local1 + (S[local0])) + (arg0[local0 % arg0.length])) & 255;
                                local2 = S[local0];
                                S[local0] = S[local1];
                                S[local1] = local2;
                                ++local0;
                        }
                        this.i = 0;
                        this.j = 0;
                }
                public function next():uint
                {
                        var local0:* = 0;
                        i = (i + 1) & 255;
                        j = (j + (S[i])) & 255;
                        local0 = S[i];
                        S[i] = S[j];
                        S[j] = local0;
                        return S[(local0 + (S[i])) & 255];
                }
                public function toString():String
                {
                        return 'rc4';
                }
        }
}