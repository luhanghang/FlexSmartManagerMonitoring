package utils
{
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	public class Utils
	{
		[Embed(source="assets/trash.png")]
		[Bindable] 
        static public var trash_icon:Class;
		
		static public function get_url(uri:String):String {
			var d:Date = new Date();
			var c:String = "?";
			if(uri.indexOf("?") > 0) c = "&";
			return Config.HOST + uri + c + "postfix=" + d.fullYear + d.month + d.date + d.hours + d.minutes + d.seconds + d.milliseconds.toString();
		}
		
		static public function freeze(ob:Object,flag:Boolean):void {
			if(flag)
				ob.dispatchEvent(new Event("Freeze"));
			else
				ob.dispatchEvent(new Event("UnFreeze")); 
		}
		
		static public function doFreeze(ob:Object, flag:Boolean):void {
			ob.enabled = !flag;
		}
		
		static public function trashGrow(ob:Object, flag:Boolean):void {
			ob.width = flag? 36:32;
			ob.height = flag? 36:32;
		}
		
		static private var gFilter:GlowFilter = new GlowFilter(0x5dd7fe,0.7,20,10);
		static public function neonFilter(color:uint = 0x5dd7fe):GlowFilter {
			if(color == 0x5dd7fe)
				return gFilter;
			return new GlowFilter(color,0.8,20,10);
		}
		
		public static function StringReplaceAll( source:String, find:String, replacement:String ) : String {
    		return source.split( find ).join( replacement );
		}
	}
}