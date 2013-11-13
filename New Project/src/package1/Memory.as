package package1
{
		// *_^;;;
        public class Memory
        {
                public static function gc():void
                {
                        new flash.net.LocalConnection().connect('foo');
                        new flash.net.LocalConnection().connect('foo');
                }
                public static function get used():uint
                {
                        return flash.system.System.totalMemory;
                }
                public function Memory()
                {
                        
                }
        }
}