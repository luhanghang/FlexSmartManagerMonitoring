package utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;

	[Bindable]
	public class FormValidator extends EventDispatcher
	{
        private var _passedCallBack : Function;

        private var _failedCallBack : Function;

        private var validators : ArrayCollection = new ArrayCollection();

        private var voteMap : Object = new Object();


        public function FormValidator( _validatorInitializedValue : Boolean = false ) {
        	validators.removeAll();
        }
        
        private function onChange(event:Event):void{
        	dispatchEvent(new Event(Event.CHANGE));
        }

        public function addValidator( validator : Validator) : void {
        	if(!validators.contains(validator)){
        			validator.trigger=this;
        			validator.triggerEvent=Event.CHANGE;
        			validator.source.addEventListener(FlexEvent.VALUE_COMMIT,onChange);
        			validator.source.addEventListener(Event.CHANGE,onChange);
        		
        			validator.addEventListener(ValidationResultEvent.INVALID,function(event:ValidationResultEvent):void{
        				voteMap[event.target.source]=false;
        				_failedCallBack();
        			});
        			validator.addEventListener(ValidationResultEvent.VALID,function(event:ValidationResultEvent):void{
        				voteMap[event.target.source]=true;        				
			        	refresh();
        			});
        			validators.addItem(validator);
        	}
        }

        public function addValidators( _validators : Array ) : void {
        	if(_validators==null){
        		return;
        	}
        	for each ( var validator : Validator in  _validators){
        		addValidator(validator);
            }
        }

        public function removeValidator(validator:Validator):void{
        	delete voteMap[validator.source];
        	if(validators.contains(validator)){
        		validator.source.removeEventListener(FlexEvent.VALUE_COMMIT,onChange);
        		validator.source.removeEventListener(Event.CHANGE,onChange);
        		validators.removeItemAt(validators.getItemIndex(validator));
        	}
        	refresh();
        }

        public function set passedCallBack( _passedCallBack : Function ) : void {
        	this._passedCallBack = _passedCallBack;
        }

        public function set failedCallBack( _failedCallBack : Function ) : void {
        	this._failedCallBack = _failedCallBack;
        }

        public function refresh():void{
        	for ( var index : String in voteMap ) {
					if ( voteMap[index] == false )
					{
						_failedCallBack();
						return;
					}
				}
				_passedCallBack();
        }
	}
}