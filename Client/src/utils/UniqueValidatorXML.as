package utils
{
	import mx.utils.StringUtil;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class UniqueValidatorXML extends Validator
	{
		private var results:Array;
		public var selfObj:XML;
		public var list:XMLList;
		public var field:String;
		public var errorMessage:String;
		
		public function UniqueValidatorXML() {
			super();
		}
		
		override protected function doValidation(value:Object):Array {
			var unique:Boolean = true;
			results = [];
			results = super.doValidation(value);
			for each(var obj:Object in list) {
				if((!selfObj || obj.@id != selfObj.@id) && (StringUtil.trim(value.toString()) == obj[field].toString())) {
					unique = false;
					break;
				}
			}
			if(!unique) {
    			results.push(new ValidationResult(true, null, "NonUnique", errorMessage));
			}
			return results;
		}
	}
}