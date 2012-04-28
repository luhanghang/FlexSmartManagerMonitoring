package utils
{
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.Application;

	public class Alert extends mx.controls.Alert
	{
		[Embed(source="assets/info.gif")]
		public static var ic:Class;
		
		public static function show(text:String = "", title:String = "",
                                flags:uint = 0x4 /* Alert.OK */, 
                                parent:Sprite = null, 
                                closeHandler:Function = null, 
                                iconClass:Class = null, 
                                defaultButtonFlag:uint = 0x4 /* Alert.OK */):mx.controls.Alert {
            var p:Sprite = Application.application as Sprite;
        	var a:mx.controls.Alert = mx.controls.Alert.show(text,"  " + title,flags,p,closeHandler,iconClass, defaultButtonFlag);                       	
			a.titleIcon = ic;
			for each(var item:Object in a.getChildren()) {
				item.filters = [Utils.neonFilter()];
			}
			return a;
        }
	}
}