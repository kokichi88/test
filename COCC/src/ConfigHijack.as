package  
{
	/**
	 * ...
	 * @author kokichi88
	 */
	public class ConfigHijack 
	{
		
		static private var s:String = "35&configUrl=http://thoiloan.static.g6.zing.vn/&gameVersion=35&configVersion=1&socketIp=49.213.70.67&socketPort=443&userId=4038647&signed_request=RREO2Ujn6EdmovpnUEVZOX96G5VtPrCq39qMQ4JM9-4=.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjcyMDAsImlzc3VlZF9hdCI6MTM4NDc4ODUwNCwiYWNjZXNzX3Rva2VuIjoiNTU4OGRmOTQyNGUxNGYwMWJjNzgwNmU5YjZiZTc5OGQuTkRsa05qQmxZemc9eU8wUTRLQnRSSk5wanMxT0FWUF9GdkVlVHNITWNYbURaU0NIMjQ2aFU2a1RlSWVESkZxcjFnWjRJWEtHZ0xmRGdQV2Y2R0ZmSXlCeXRIVkNKenY5Z21nbFRfeGEtMDNpRmhMdmJ1Y2xHZlN2dTJnX2RBU0FtSTNGOENSY3VKa005dW5Rb1lPR0FaRzlNQjk2N209PSIsInVpZCI6NDAzODY0N30=&maxWidth=1366&maxHeight=644&main=http://thoiloan.static.g6.zing.vn/protect_cocc1.swf?35&config=true&isFeed=1";
		
		public function ConfigHijack() 
		{
			
		}
		
		
		public static function makeConfig():Object
		{
			var temp:String = "signed_request";
			var ret:Object  = new Object();
			var arr:Array = s.split("&");
			for each(var key:String in arr)
			{
				var arrKey:Array
				if (key.indexOf(temp) > -1)
				{
					ret[temp] = key.substr(key.indexOf(temp) + temp.length + 1); 
				}else
				{					
					arrKey = key.split("=");
					ret[arrKey[0]] = arrKey[1];
				}
				
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