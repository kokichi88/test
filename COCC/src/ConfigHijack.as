package  
{
	/**
	 * ...
	 * @author kokichi88
	 */
	public class ConfigHijack 
	{
		static private var s:String = "configUrl=http://thoiloan.static.g6.zing.vn/&gameVersion=31&configVersion=1&socketIp=49.213.70.67&socketPort=443&userId=4038647&signed_request=E5MIt8wUQ1JcrncujysrfMTEE_PqLxELUUlKaAVP3_c=.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjcyMDAsImlzc3VlZF9hdCI6MTM4NDQ0ODExOSwiYWNjZXNzX3Rva2VuIjoiNTU4OGRmOTQyNGUxNGYwMWJjNzgwNmU5YjZiZTc5OGQuTkdaaE5URmtNV0k9VkRzSDA4OGl5N1gtd2tqOXdJeGtTWGh0X05NSUd1MTAxOW9SNk9Mb3YyT0tfZzBTWTJJZklvNlJtMEpLU0NPMDhDVVoyQ1RWdk8xcnhRX0lZempQeVlTaVNWazRfSDJyNHBQX2FrY2dLaXVLT29vd19BOFFjMHJDOWlFNnYybEYyV3pTcG9QVGgyOUxjNmRSS1c9PSIsInVpZCI6NDAzODY0N30=&maxWidth=1366&maxHeight=645&main=http://thoiloan.static.g6.zing.vn/protect_cocc1.swf?31&config=true&isFeed=1";
		
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