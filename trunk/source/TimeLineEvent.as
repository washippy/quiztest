package{
	import flash.events.*;
	
	public class TimeLineEvent extends Event{
		
		//the contstant
		public static const GO:String = "go";
		public static const RESETME:String = "RESETME";
		public static const RESETSPIN:String = "RESETSPIN";
		public static const ANIMDONE:String = "ANIMDONE";
		
		public static const MC:String = "MC";
		public static const TF:String = "TF";
		
	
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