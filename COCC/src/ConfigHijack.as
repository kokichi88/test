package  
{
	/**
	 * ...
	 * @author kokichi88
	 */
	public class ConfigHijack 
	{
		static private var s:String = "32&configUrl=http://thoiloan.static.g6.zing.vn/&gameVersion=32&configVersion=1&socketIp=49.213.70.67&socketPort=443&userId=4038647&signed_request=vXqvCNVyL3ppNHlS9v1QpXvJFiXdkhghNQ8y_IZT9dc=.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjcyMDAsImlzc3VlZF9hdCI6MTM4NDY2NjYyNSwiYWNjZXNzX3Rva2VuIjoiNTU4OGRmOTQyNGUxNGYwMWJjNzgwNmU5YjZiZTc5OGQuWkRCaE5tSXdPV1E9Rlp6R1ZYMk9WMW15MjJldFV2WFc0NUNLQ1dxQnpXOFlKTnpLT0hwN1BhSFQ3TXphNFA0aEFNWHUzdG5EbktIWVFJSGlTNXdTQ1V5eVUzUWQ0Z3cxM0x1RnYxdWpZQ1hBUVhOZ1RxM1ZZWjVqR0JiVkxUVjJQdEhsaW9PbGFWQ21Tb3A5QVlRRC1jekYyanJORFc9PSIsInVpZCI6NDAzODY0N30=&maxWidth=1366&maxHeight=645&main=http://thoiloan.static.g6.zing.vn/protect_cocc1.swf?32&config=true&isFeed=1";
		
		public function ConfigHijack() 
		{
			
		}
		
		
		public static function makeConfig():Object
		{
			var ret:Object  = new Object();
			var arr:Array = s.split("&");
			for each(var key:String in arr)
			{
				var arrKey:Array = key.split("=");
				ret[arrKey[0]] = arrKey[1];
			}			
			return ret;
		}
		
		public static function modifyConfig(source:Object):void
		{
			var arr:Array = s.split("&");
			for each(var key:String in arr)
			{
				var arrKey:Array = key.split("=");
				source[arrKey[0]] = arrKey[1];
			}
		}
		
	}

}