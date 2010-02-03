package{
	import flash.events.*;
	
	public class TimeLineEvent extends Event{
		
		//the contstant
		public static const GO:String = "go";
	//	public static const RESET:String = "RESET";
		
	
		/* constructor	*/ 
		public function TimeLineEvent(type:String){
			//super(type, bubbles, cancellable);
			super(type, true, true);
		}
		
		 
		public override function clone():Event{
			return new TimeLineEvent(type);
		}
	
	}
}