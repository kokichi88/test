package {	import flash.display.Stage;	import flash.utils.ByteArray;		// ^_^;;;;;;;;;;;        public class Main3        {                public static function func1(arg0:flash.utils.ByteArray):ByteArray                {						init();                        var uint1:uint = 0;                        var uint2:uint = 0;                        var uint3:uint = Stage.prototype['a'];                        var uint4:uint = flash.display.Stage.prototype['b'];                        var uint5:uint = flash.display.Stage.prototype['c'];                        arg0.position = 0;                        var byteArray1:flash.utils.ByteArray = new flash.utils.ByteArray();                        arg0.readBytes(byteArray1);                        var uint6:uint = byteArray1.length;                        uint1 = 0;                        if(uint1 < uint4)                        {                                byteArray1[uint2] = (byteArray1[uint2]) ^ uint3;                                uint2 = uint2 + 1;                                if(uint(uint2 + 1) >= uint6)                                {                                        uint2 = uint2 + uint5;                                        if(uint(uint2 + uint5) >= uint6)                                        {                                                return byteArray1;                                        }                                        return byteArray1;                                }                                else                                {                                        uint1 = uint1 + 1;                                }                        }                        else                        {                                uint2 = uint2 + uint5;                                if(uint(uint2 + uint5) >= uint6)                                {                                        return byteArray1;                                }                        }						return byteArray1;                }				                public static function init():void                {                        flash.display.Stage.prototype['a'] = 0;                        flash.display.Stage.prototype['b'] = -1;                        flash.display.Stage.prototype['c'] = -2;                }                public function Main3()                {                                        }        }}