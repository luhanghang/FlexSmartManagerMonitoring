package skins
{
	import mx.controls.LinkBar;
	import mx.skins.halo.LinkSeparator;

	public class ArrowLinkBarSeparator extends LinkSeparator
	{
		public function ArrowLinkBarSeparator()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,
                                                       unscaledHeight:Number):void {
     		var parentLinkBar:LinkBar;
     		var myColor:uint;
     
     		if( parent is LinkBar) {
		       // Use the separatorColor if the parent is a LinkBar
		       parentLinkBar= parent as LinkBar;
		       myColor=parentLinkBar.getStyle("separatorColor");
		    } else
    			myColor=0xC4CCCC; // The default separatorColor in a LinkBar
  
		   	graphics.lineStyle(0,0,0);
			graphics.beginFill(myColor);
		    graphics.moveTo(unscaledWidth, unscaledHeight/2 );
		    graphics.lineTo(unscaledWidth/2 - 4 , unscaledHeight/2 + 4);
		    graphics.lineTo(unscaledWidth/2 - 4, unscaledHeight/2 - 5);
		    graphics.lineTo(unscaledWidth, unscaledHeight/2 );
		    graphics.endFill();
		 }
	}
}