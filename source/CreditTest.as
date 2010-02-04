 package { 
   
    import flash.events.*	
	import flash.display.*
	import flash.filters.ColorMatrixFilter;
	import flash.geom.*;
	import ColorMatrix;
	import flash.display.SimpleButton;
    import XMLParser;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import TimeLineEvent;

    public class CreditTest extends MovieClip{
	
		private var QUIZ:Quiz;
	   	private var FADEBLOCK:fadeblock;
	   	private var SPINNER:spinner;
       	private var BACKGROUND:bkg;
		private var rightMatrix:ColorMatrix;
		private var myTimer:Timer;
		private var XMLparser:XMLParser;
        private var dataChunk:XML;
		private var counter:Number = 1;
        private var counterholder:Number = 1;
		private var rotCounter:Number = 0;
		private var hitters:Array;
		private var BEEP:beep;
        private var shapeOver:Number=1;
		
		private var SPIN_ARRAY:Array= new Array();
		private var QUIZ_ARRAY:Array= new Array();
		
		private var quizNumber:Number = 1; // how many times they take the quiz ... 
		private var spinNumber:Number = 10; // of 12
		private var spinToThis:Number = 0; // actual topic number targeted from spin >> shuffled spin array
		
		private var greenNum:Number =.917; // green
		private var orangeNum:Number = .928; // orange
		private var purpleNum:Number =.937 // purple
		private var redNum:Number = .9445 // red
		private var yellowNum:Number = .95; // yellow
		private var blueNum:Number = .9545; // blue
		
		private var stopHere:Number; 
		
		
		
		
		/* METRIX
		flmc: finance tools: wheel game: start
		flmc: finance tools: wheel game: question: <question>
		flmc: finance tools: wheel game: thank you
		flmc: finance tools: wheel game: thank you: print
		
		*/
        public function CreditTest(){
	
			XMLparser = new XMLParser;
			XMLparser.doIt("xml/credittestdata.xml");  // PULL THIS OUT
			XMLparser.addEventListener(XMLParser.DATA_READY, getDataPlease);
	       // BKG setup
			BACKGROUND = new bkg();
			addChild(BACKGROUND);
			rightMatrix = new ColorMatrix();
			startcounter();	

			BEEP = new beep();
			SPINNER = new spinner();
			QUIZ = new Quiz();
			FADEBLOCK= new fadeblock();
			
			addEventListener(TimeLineEvent.RESETME, resetWheelEvent);
			
		}
		
		private function launchSpinner():void{

			addChild(SPINNER);
			addSpinnerEvents();
			addChild(FADEBLOCK);
			FADEBLOCK.mouseEnabled=false;
			addChild(QUIZ);
			
		}
		
		public function resetWheelEvent(e:Event):void {resetWheel()}
		
		public function resetWheel():void {
					if(spinNumber>=12){
						launchEnd();
						return;
					}
				trace("RESET WHEEL");
				counter = 1;
		        counterholder = 1;
				rotCounter = 0;
				SPINNER.wheel.rotation =0;
				SPINNER.arrow.gotoAndStop("off");
				FADEBLOCK.gotoAndPlay("goaway");
				addSpinnerEvents();
				//spinNumberManager();
				SPINNER.progressbar.gotoAndStop(spinNumber+1);
				
		}
	
		public function launchEnd():void {
			trace("ENDING NOW THANKS");
			
			var endScreen:endscreen = new endscreen();
		//	endScreen.x=101.8;
		//	endScreen.y=29.6;
			endScreen.textHolder.endtitle_tf.text = dataChunk.copy.endtitle;
			endScreen.textHolder.endcopy_tf.htmlText = dataChunk.copy.endcopy;
			
			endScreen.printButton.addEventListener(MouseEvent.CLICK, printHandler);
			endScreen.playagainButton.addEventListener(MouseEvent.CLICK, playagainHandler);

			//endScreen.printButton.mouseChildren = false;
			//en//dScreen.playagainButton.mouseChildren = false;
			
			addChild(endScreen);
			
			}
		
		private function printHandler(e:Event):void{
			trace("PRINT");
		}
		private function playagainHandler(e:Event):void{
			trace("PLAY AGAIN");
		}
		
		
		private function addSpinnerEvents():void {
				SPINNER.wheel.mouseEnabled=false;
				SPINNER.spinbutton.addEventListener(MouseEvent.CLICK, spinHandler);
			    SPINNER.spinbutton.addEventListener(MouseEvent.MOUSE_OUT, spinMouseOutHandler);
			    SPINNER.spinbutton.addEventListener(MouseEvent.MOUSE_OVER, spinMouseOverHandler);
			  	SPINNER.spinbutton.mouseChildren=false;
				SPINNER.spinbutton.buttonMode=true;
			
		}
		
		private function killSpinnerEvents():void {
				SPINNER.spinbutton.removeEventListener(MouseEvent.CLICK, spinHandler);
		    	SPINNER.spinbutton.removeEventListener(MouseEvent.MOUSE_OUT, spinMouseOutHandler);
		    	SPINNER.spinbutton.removeEventListener(MouseEvent.MOUSE_OVER, spinMouseOverHandler);
		}
		
		private function spinHandler(e:Event):void{
			//trace(e.target);
			e.target.parent.gotoAndPlay("out");
			// send in variable 
			spinNumberManager();
			addEventListener(Event.ENTER_FRAME, spinItUp);
			killSpinnerEvents();
		}
	
		private function spinNumberManager():void{
			if(spinNumber>=12){
				spinNumber=0;
				trace("END THE QUIZ NOW PLEEZE")
			}else{
				spinNumber++;
			}	
			trace("NEW SPIN NUMBER IS :: "+spinNumber)
		}
		
		private function spinMouseOutHandler(e:Event):void{
			e.target.gotoAndPlay("out");
		}
	
		private function spinMouseOverHandler(e:Event):void{
			e.target.gotoAndPlay("over");
		}
		
		private function beepHitCheck(e:Event):void{
		//	var hitcheck:Boolean = SPINNER.wheel.hitarea.hitTestPoint(210, 0) 
			
			for(var i=1;i<=12;i++){
				var hitcheck:Boolean = SPINNER.wheel["hitarea"+i].hitTestObject(SPINNER.arrow.hitarea);
					if(hitcheck){
						SPINNER.arrow.gotoAndPlay("on");
						//trace("HIT CHECK "+i +" :: "+hitcheck);
					}
			}
		}
		
		private function spinItUp(e:Event):void{
			addEventListener(Event.ENTER_FRAME, beepHitCheck);
			
			if(counter<15){
				counter = counterholder * 1.05;
			}else{
				counter = 15;
					rotCounter++;
			}
			e.target.SPINNER.wheel.rotation += counter;
			counterholder = counter;
			if(rotCounter>30){
				removeEventListener(Event.ENTER_FRAME, spinItUp);
				rotCounter=0;
				EFspinIt();
			}
		}
		
		private function EFspinIt():void{		
			addEventListener(Event.ENTER_FRAME, spinIt);
			rotCounter=0;
		}
		
		
		private function spinIt(e:Event):void{		
			e.target.SPINNER.wheel.rotation += 15;
			rotCounter++;
			if(rotCounter>=4){
				removeEventListener(Event.ENTER_FRAME, spinIt);
				counter=15;
				counterholder=15;
				addEventListener(Event.ENTER_FRAME, spinItDown);
	            
			}
		}

		private function spinItDown(e:Event):void{
			trace("SPIN # "+ spinNumber);
			
			spinToThis = SPIN_ARRAY[(spinNumber-1)].num;
			// force a color
			 //spinToThis =10;
			
			trace("SPIN TO THIS "+ spinToThis);
			switch(spinToThis){
			
				case 1 :
				case 7 :
					stopHere = orangeNum;
				break;
				
				case 2 :
				case 8 :
					stopHere = blueNum;
				break;
				
				case 3 :
				case 9 :
					stopHere = redNum;
				break;
				
				case 4 :
				case 10 :
					stopHere = yellowNum;
				break;
				
				case 5 :
				case 11 :
					stopHere = purpleNum;
				break;
				
				case 6 :
				case 12 :
					stopHere = greenNum;
				break;
			}
			if(counter>0.04){
			
					counter = counterholder * stopHere; 
	
				
 			}else{
				// SPIN IS DONE ... FLIP IT 
				counter = 0;
				killSpinEvents();
				SPINNER.arrow.gotoAndStop("on");

				FADEBLOCK.gotoAndPlay("go");
				startQuiz();
				
			}
			e.target.SPINNER.wheel.rotation += counter;
			counterholder = counter;
			//trace("spindown counter"+counter)
			
		}
		
		private function killSpinEvents():void{
			//trace("kill");
			removeEventListener(Event.ENTER_FRAME, spinItDown);
			removeEventListener(Event.ENTER_FRAME, beepHitCheck);
		}
		
		private function getDataPlease(e:Event):void{

			dataChunk = e.target.getIt();
			//trace("GETTING DATA ");//+dataChunk)
			buildQuiz();
			fireUpIntro();
		}
		
		private function fireUpIntro():void{
			// bring in intro clip
			var intro:introclip = new introclip();
			intro.x=101.8;
			intro.y=29.6;
			intro.startbutton.textHolder.introtitle_tf.text = dataChunk.copy.title;
			intro.startbutton.textHolder.introcopy_tf.htmlText = dataChunk.copy.body;
			intro.startbutton.textHolder.introcta_tf.text = dataChunk.copy.cta;
			intro.startbutton.buttonMode=true;
			
			intro.startbutton.addEventListener(MouseEvent.CLICK, clickHandler);
		    intro.startbutton.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		    intro.startbutton.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			intro.startbutton.mouseChildren = false;
			addChild(intro);
		}
		
		
		private function clickHandler(e:Event):void{
			//trace(e.target);
			e.target.parent.gotoAndPlay("OUT");
			launchSpinner();
		}
	
		private function mouseOutHandler(e:Event):void{
			e.target.gotoAndPlay("off");
		}
	
		private function mouseOverHandler(e:Event):void{
			e.target.gotoAndPlay("over");
		}
		
		private function startcounter():void{
			myTimer = new Timer(50, 360);
			myTimer.addEventListener("timer", timerHandler);
			myTimer.start();
		}
		
		private function timerHandler(event:TimerEvent):void {
			rightMatrix.rotateHue(5);
			BACKGROUND.filters = [ rightMatrix.filter ];
		}
	
		private function startQuiz():void{
			QUIZ.fireitUP(quizNumber, spinNumber, spinToThis);
		}
		
		private function traceEM(element:*, index:int, arr:Array):void {
            trace(index + " TRACEEM ::"+element);
        }
	
		private function traceMe(obj:Object):void {
			for (var item in obj) { 
				for (var stuff in obj[item]) { 
					for (var junk in obj[item][stuff]) { 
					
			    	trace("OBJ TRACE >>> "+item +"::"+stuff + "::"+junk+  "::"+obj[item][stuff][junk]); 
					}
				}
			}
        }

		private function traceArr(Arr:Array):void {
			for (var aa=0;aa<Arr.length;aa++) { 
				for (var bb=0;bb<Arr[aa].length;bb++) { 
			    		trace("QUIZ ARR > topic:"+aa +"   question[shuffled]:"+bb + " value:" +Arr[aa][bb]); 
				}
			}
        }


		private function buildQuiz():void{
			
			//trace("BUILD QUIZ");
			
			// SPIN_ARRAY is a shuffled array of 12 spins, 2 each color
			
			var topicLen:int = dataChunk.child("topic").length();
			trace(topicLen+"  <> "+dataChunk.topic[0].@title)
		 	for (var i = 0; i < topicLen; i++) {
				SPIN_ARRAY.push({title:dataChunk.topic[i].@title, num:i+1});
			}	
			for (var k = 0; k < topicLen; k++) {
				SPIN_ARRAY.push({title:dataChunk.topic[k].@title, num:(k+topicLen+1)}); // HARD CODED VALUE ****  ALERT ALERT *****
			}
			// trace("SPIN ARR--------------");
				trace(SPIN_ARRAY[0].num);
				SPIN_ARRAY.shuffle();
				trace(SPIN_ARRAY[0].num);

			//QUIZ is a shuffled array of question numbers :: a map of quiz choices if you will
		
		 	trace("TOPICLEN "+topicLen)
			var choiceArr:Array = new Array();
			var questionArr:Array = new Array();										
			for (var j = 0; j < topicLen; j++) {										
				//var qItems:XMLList = dataChunk.topic[j].question;
				var qLen = dataChunk.topic[j].child("question").length();//qItems.length;   												
				trace("QLEN     "+qLen)
				questionArr = [];	
			 	for (var l = 0; l< qLen; l++) {	
					//var cItems:XMLList = dataChunk.topic[j].question[l].choice;
					//var cLen = dataChunk.topic[j].question[l].child("choice").length()//cItems.length;											
				//	trace("CLEN          "+cLen)
				//	choiceArr = [];
				//		for(var m = 0; m< cLen; m++){											
				//			choiceArr[m] = m+1;
				//		}
					questionArr[l]=l+1;//choiceArr;
			 	}
				questionArr.shuffle();
				QUIZ_ARRAY[j] = questionArr;
				trace("HUH")
				
			}
			traceArr(QUIZ_ARRAY)
			QUIZ.dataObj=dataChunk;
			QUIZ.QUIZ_ARRAY = QUIZ_ARRAY;
		}
						
    
		Array.prototype.shuffle = function(){
			trace("SHUFFLE")
			
			for(var i = 0; i < this.length; i++){
				var a = this[i];
				var b = Math.floor(Math.random() * this.length);
				this[i] = this[b];
				this[b] = a;
			}
		}
		
	
		
	}
}