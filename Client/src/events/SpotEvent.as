package events
{
	import flash.events.Event;
	
	public class SpotEvent extends Event
	{
		public var spot:XML;
		public var spotType:Number;
		public static var IS_NULL:Number = 0;
		public static var IS_GROUP:Number = 1;
		public static var IS_SPOT:Number = 2;
		public static var IS_PRESETTING:Number = 3;
		public static var IS_ROOT:Number = 9;
		
		public static var SELECTED:String = "SpotSelected";
		public static var INITED:String = "SpotTreeInited";
		
		public function SpotEvent(spot:XML, spotType:Number, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.spot = spot;
			this.spotType = spotType;
		}
		
		public override function clone():Event {
			return new SpotEvent(this.spot, this.spotType, type);
		}

	}
}