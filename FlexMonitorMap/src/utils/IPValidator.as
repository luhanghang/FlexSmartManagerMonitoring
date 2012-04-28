package utils
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class IPValidator extends Validator
	{
		private var results:Array;
		
		public function IPValidator() {
			super();
		}
		
		override protected function doValidation(value:Object):Array {
			results = [];
			results = super.doValidation(value);
			if(value != null) {
				var pattern:RegExp = /^([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])$/;
    			if(value.search(pattern) == -1) {
    				results.push(new ValidationResult(true, null, "invalidAddress", "请填写有效的IP地址"));
    			}
			}
			return results;
		}
	}
}