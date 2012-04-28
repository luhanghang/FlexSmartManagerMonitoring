package events
{
	import flash.events.Event;

	public class MapEvent extends Event
	{	
		public var map:Object;
		public function MapEvent(map:Object, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.map = map;
		}
		
		public override function clone():Event {
			return new MapEvent(this.map, type);
		}
		
	}
}