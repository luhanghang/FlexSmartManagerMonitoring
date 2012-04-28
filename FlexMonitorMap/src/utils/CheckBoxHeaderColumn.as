package utils
{
	import mx.controls.dataGridClasses.DataGridColumn;
	
	[Event(name="headerClick", type="flash.events.Event")]

	public class CheckBoxHeaderColumn extends DataGridColumn
	{
		public function CheckBoxHeaderColumn(columnName:String=null)
		{
			super(columnName);
		}
		
		public var selected:Boolean = false;
		
	}
}