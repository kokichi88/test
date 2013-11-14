package package1
{
	import flash.net.LocalConnection;
	import flash.system.System;
		// *_^;;;
        public class Memory
        {
                public static function gc():void
                {
                        new LocalConnection().connect('foo');
                        new LocalConnection().connect('foo');
                }
                public static function get used():uint
                {
                        return System.totalMemory;
                }
                public function Memory()
                {
                        
                }
        }
}