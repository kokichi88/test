package  
{
	/**
	 * ...
	 * @author kokichi88
	 */
	public class ConfigHijack 
	{
		
		static private var s:String = "36&configUrl=http://thoiloan.static.g6.zing.vn/&gameVersion=36&configVersion=1&socketIp=49.213.70.67&socketPort=443&userId=4038647&signed_request=LlQw16hyELR3AM64O3xFkYf9HEOMDUvpidxxOb6ICX0=.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjcyMDAsImlzc3VlZF9hdCI6MTM4NDg3NDkwMywiYWNjZXNzX3Rva2VuIjoiNTU4OGRmOTQyNGUxNGYwMWJjNzgwNmU5YjZiZTc5OGQuTjJVMk5tVTBNamM9Y2tVb0x1RF8yWHdPcUNXVXc3NFA0X3gwc0lNSDdOcVh1QWtfSU9PaTZLVm1vT0hDWXRmS0FpTWl2NUpOQlpqWG5GMjdNQ0pYYy0tSEVXWUNZQXVSVEJhbXdhcHpZNThwWkloYTlQM1Y0NFlBVnhTRFhUVE83ZkRHbE5KX2FNYjliMUY3VTJRd25WamFjSmVYRDA9PSIsInVpZCI6NDAzODY0N30=&maxWidth=1366&maxHeight=644&main=http://thoiloan.static.g6.zing.vn/protect_cocc1.swf?36&config=true&isFeed=1";
		
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