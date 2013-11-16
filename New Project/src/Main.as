package
{
	import com.swfwire.decompiler.AsyncSWFReader;
	import com.swfwire.decompiler.data.swf.SWF;
	import com.swfwire.decompiler.data.swf.tags.MetadataTag;
	import com.swfwire.decompiler.data.swf9.tags.DefineBinaryDataTag;
	import com.swfwire.decompiler.events.AsyncSWFReaderEvent;
	import com.swfwire.decompiler.SWFByteArray;
	import com.swfwire.utils.Debug;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * ...
	 * @author kokichi88
	 */
	public class Main
	{
		
		static public function parse(bytes:ByteArray):void
		{
			var reader:AsyncSWFReader = new AsyncSWFReader();
			
			reader.addEventListener(AsyncSWFReaderEvent.TAG_READ, tagReadHandler);
			reader.addEventListener(AsyncSWFReaderEvent.READ_COMPLETE, completeHandler);
			//reader.addEventListener(AsyncSWFReaderEvent., completeHandler);
			
			reader.read(new SWFByteArray(bytes));
		}
		
		static private function tagReadHandler(ev:AsyncSWFReaderEvent):void
		{
			var current:uint = ev.context.bytes.getBytePosition();
			var max:uint = ev.context.bytes.getLength();
			trace('Read ' + current + ' bytes out of ' + max);
		}
		
		static private function completeHandler(ev:AsyncSWFReaderEvent):void
		{
			var swf:SWF = ev.result.swf;
			for (var iter:uint = 0; iter < swf.tags.length; iter++)
			{
				if (swf.tags[iter] is DefineBinaryDataTag)
				{
					var binaryTag:DefineBinaryDataTag = swf.tags[iter] as DefineBinaryDataTag;
					var buffer:ByteArray = new ByteArray();
					buffer.writeBytes(binaryTag.data, 0, binaryTag.data.length);
					buffer.endian = Endian.LITTLE_ENDIAN;
					buffer.position = 0;
					if (iter == 7)
					{
						var hehe:lb = new lb();
						hehe.ba2 = buffer;
						hehe.ba3 = new ByteArray();
						hehe.ba3.writeBytes(hehe.ba2, hehe.ba2.length - 8, 8);
						hehe.func3();
						
						hehe.ba2.position = 0;
						parseLa(hehe.ba2);
					}
				}
			}
		}
		
		public static function parseLa(bytes:ByteArray):void
		{
			var reader:AsyncSWFReader = new AsyncSWFReader();
			
			//reader.addEventListener(AsyncSWFReaderEvent.TAG_READ, tagReadHandler);
			reader.addEventListener(AsyncSWFReaderEvent.READ_COMPLETE, completeHandlerA);
			//reader.addEventListener(AsyncSWFReaderEvent., completeHandler);
			
			reader.read(new SWFByteArray(bytes));
		}
		
		static private function completeHandlerA(ev:AsyncSWFReaderEvent):void 
		{
			var swf:SWF = ev.result.swf;
			for (var iter:uint = 0; iter < swf.tags.length; iter++)
			{
				if (swf.tags[iter] is DefineBinaryDataTag)
				{
					var binaryTag:DefineBinaryDataTag = swf.tags[iter] as DefineBinaryDataTag;
					var buffer:ByteArray = new ByteArray();
					buffer.writeBytes(binaryTag.data, 0, binaryTag.data.length);
					buffer.endian = Endian.LITTLE_ENDIAN;
					buffer.position = 0;
					if (iter == 3)
					{
						var heheA:la = new la();
						heheA.func2(buffer);
						//heheA.func1();
						heheA.func3();
						var buffer2:ByteArray = heheA.arr1.ba2 as ByteArray;
						buffer2.position = 0;
						// save file
						
						var file:FileReference = new FileReference();
						file.save(buffer2, "cocc1.swf");
					}
				}
			}
		}
	
	}

}