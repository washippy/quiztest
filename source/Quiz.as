﻿ package {        import flash.events.*		import flash.display.*	import flash.display.SimpleButton;	import com.greensock.*; 	    dynamic public class Quiz extends MovieClip{			private var ORANGE:slice1flip;		private var BLUE:slice2flip;		private var RED:slice3flip;		private var YELLOW:slice4flip;		private var PURPLE:slice5flip;		private var GREEN:slice6flip;				private var TF_Q:tf_question;		private var MC_Q:mc_question;		private var container:Sprite;		private var sNum:Number;  // which spin 1-12		private var qNum:Number;  // quiz number >> first time thru the quiz =1		private var SPINTOTHIS:Number;// spin / topic number / spin #1 gets SPIN_ARRAY[0] (shuffled)				private var _quizObject:XML;		private var _QUIZ_ARRAY:Array;				public static const GO:String = "go";				private var QUESTIONTYPE:String;		private var HOLD_CLICKED_ANSWER:String;		private var HOLD_CORRECT_ANSWER:String;				private var getNextQFromTopicMap:Number; // value from shuffled list of questions				private var HOTCLIP:MovieClip;		// container.removeChild(DisplayObject(event.target)); 		/* METRIX			flmc: finance tools: wheel game: start			flmc: finance tools: wheel game: question: <question>			flmc: finance tools: wheel game: thank you			flmc: finance tools: wheel game: thank you: print				*/				public function set dataObj(yup:XML) {  _quizObject = yup  }		public function get dataObj() { return _quizObject }				public function set QUIZ_ARRAY(QA:Array) { _QUIZ_ARRAY = QA }		public function get QUIZ_ARRAY() { return _QUIZ_ARRAY }	        public function Quiz(){			trace("HEEEYY QUIZ ME " );			ORANGE = new slice1flip();			BLUE = new slice2flip();			RED = new slice3flip();			YELLOW = new slice4flip();			PURPLE = new slice5flip();			GREEN = new slice6flip();			TF_Q = new tf_question();			MC_Q = new mc_question();	  		container = new Sprite();			addChild(container);						this.addEventListener(TimeLineEvent.GO, onListener);						OverwriteManager.init(2);		}			public function fireitUP(_qN:Number,_sN:Number, _sTT:Number):void{			qNum = _qN;			sNum = _sN;         // 1 - 12 			SPINTOTHIS = _sTT; // 1 - 12 shuffled			trace("FIRED UP" + sNum);			if(container.numChildren>0){				container.removeChildAt(0);			}		//	container.x = 90;		//	container.y = 147;			switch(SPINTOTHIS){				case 1 :				case 7 :					container.addChild(ORANGE);					ORANGE.gotoAndPlay(3);					//ORANGE.alpha=.5				break;								case 2 :				case 8 :					container.addChild(BLUE)					BLUE.gotoAndPlay(3);					//BLUE.alpha=.5				break;								case 3 :				case 9 :					container.addChild(RED)					RED.gotoAndPlay(3);					//RED.alpha=.5				break;								case 4 :				case 10 :					container.addChild(YELLOW)					YELLOW.gotoAndPlay(3);				//	YELLOW.alpha=.5				break;								case 5 :				case 11 :					container.addChild(PURPLE)					PURPLE.gotoAndPlay(3);				//	PURPLE.alpha=.5				break;								case 6 :				case 12 :					container.addChild(GREEN)					GREEN.gotoAndPlay(3);				//	GREEN.alpha=.5				break;			}						if(SPINTOTHIS>6){SPINTOTHIS-=6}					getAQuestion();		}			/* 			FIRED UP7		getAQuestion 1 1		getAQuestion 2 5		TypeError: Error #1010: A term is undefined and has no properties.			at Quiz/getAQuestion()[/Users/bshippy/Desktop/FORDCREDIT wheel/trunk/source/Quiz.as:161]	*/						public function getAQuestion():void{			// _QUIZ_ARRAY[].questionArr[]			trace("getAQuestion 1 " + SPINTOTHIS);			//trace(_QUIZ_ARRAY)						SPINTOTHIS = SPINTOTHIS-1; // ARRAY ZEROED			//	qNum = qNum-1; // ARRAY ZEROED			trace("getAQuestion 1.5 " +  _QUIZ_ARRAY[SPINTOTHIS]);						getNextQFromTopicMap = _QUIZ_ARRAY[SPINTOTHIS].shift(); /// should remove the first question from the array			getNextQFromTopicMap -=1;			trace("getAQuestion 2 " + getNextQFromTopicMap);			 				//trace(_QUIZ_ARRAY);			var sendme:String = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].@type;			trace("SEND ME "+sendme)			switch(sendme){				case "TF" :				trace("GET A Q MC 1");					QUESTIONTYPE ="TF";					addTFQuestion();				break;				case "MC" :				trace("GET A Q MC 2");					QUESTIONTYPE="MC";					addMCQuestion();				break;			}										}				private function addTFQuestion():void{			trace("ADD TF 1 "+getNextQFromTopicMap);			if(container.contains(MC_Q)){				container.removeChild(MC_Q);								}			if(contains(TF_Q)){				container.removeChild(TF_Q);			}			container.addChild(TF_Q);			HOTCLIP= TF_Q;			TF_Q.alpha=0;			TF_Q.x = 90;			TF_Q.y = 147;			TF_Q.question_tf.text =  _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].@text;					 	TF_Q.true_b.CORRECT = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[0].@correct;			TF_Q.false_b.CORRECT = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[1].@correct;			TF_Q.true_b.buttonMode = true;			TF_Q.false_b.buttonMode = true;			setEvents(TF_Q.true_b);			setEvents(TF_Q.false_b);						// run through all choices and grab CORRECT VERSION				for(var v=0;v<2;v++){					if(_quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[v].@correct == "true"){						HOLD_CORRECT_ANSWER = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[v].@text;						trace("THIS IS THE CORRECT ONE >> "+HOLD_CORRECT_ANSWER)					}				}					}						function onListener(e:TimeLineEvent):void {			trace("ANIMATION FINISHED");			trace(container.getChildAt(0));			trace(container.getChildAt(1));			//trace(container.getChildAt(2));									var fadeMeIn:DisplayObject = container.getChildAt(1);		//	fadeMeIn.alpha=1;			TweenLite.to(fadeMeIn, 1.5, {alpha:1}); 		}													private function addMCQuestion():void{			 				trace("GET A Q MC 3 :: "+ SPINTOTHIS +" :: "+getNextQFromTopicMap);				if(container.contains(MC_Q)){					container.removeChild(MC_Q);									}				if(container.contains(TF_Q)){					container.removeChild(TF_Q);				}										container.addChild(MC_Q);				HOTCLIP= MC_Q;								MC_Q.alpha=0;				MC_Q.x = 90;				MC_Q.y = 147;				// set the question				MC_Q.question_tf.text =  _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].@text;								// get number of answers				var aLen = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].child("choice").length();				trace("ANSWERS LEN " +aLen)				MC_Q.ans_a_b.visible=true;				MC_Q.ans_b_b.visible=true;				MC_Q.ans_c_b.visible=true;				MC_Q.ans_d_b.visible=true;								MC_Q.ans_a_b.buttonMode=true;				MC_Q.ans_b_b.buttonMode=true;				MC_Q.ans_c_b.buttonMode=true;				MC_Q.ans_d_b.buttonMode=true;															//	trace("HEY "+MC_Q.ans_a_b.answer_tf);				// set the answers				// set the answer events				// set correct status													MC_Q.ans_a_b.answer_tf.htmlText = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[0].@text;					MC_Q.ans_a_b.CORRECT = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[0].@correct;											setEvents(MC_Q.ans_a_b);					trace(_quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[1].@text)					MC_Q.ans_b_b.answer_tf.htmlText = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[1].@text;					MC_Q.ans_b_b.CORRECT = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[1].@correct;					setEvents(MC_Q.ans_b_b);						if(aLen >2){								MC_Q.ans_c_b.answer_tf.htmlText = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[2].@text;								MC_Q.ans_c_b.CORRECT = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[2].@correct;								setEvents(MC_Q.ans_c_b);						}else{							MC_Q.ans_c_b.visible=false;							MC_Q.ans_d_b.visible=false;						}						if(aLen >3){							MC_Q.ans_d_b.answer_tf.htmlText =  _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[3].@text;							MC_Q.ans_d_b.CORRECT = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[3].@correct;							setEvents(MC_Q.ans_d_b);						}else{							MC_Q.ans_d_b.visible=false;						}									// run through all choices and grab CORRECT VERSION				for(var v=0;v<aLen;v++){					if(_quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[v].@correct == "true"){						HOLD_CORRECT_ANSWER = _quizObject.topic[SPINTOTHIS].question[getNextQFromTopicMap].choice[v].@text;						trace("THIS IS THE CORRECT ONE >> "+HOLD_CORRECT_ANSWER)					}				}		}						private function setEvents(clip):void{			clip.addEventListener(MouseEvent.CLICK, aHandler);		 	clip.addEventListener(MouseEvent.MOUSE_OUT, aMouseOutHandler);		 	clip.addEventListener(MouseEvent.MOUSE_OVER, aMouseOverHandler);			clip.mouseChildren = false;		}				private function aHandler(e:Event):void{			if(QUESTIONTYPE=="MC"){				trace(e.target.answer_tf.text);				HOLD_CLICKED_ANSWER = e.target.answer_tf.text;				removeEvents(MC_Q.ans_a_b);							}else if(QUESTIONTYPE=="TF"){				trace( e.target.CORRECT.toString());				HOLD_CLICKED_ANSWER =  e.target.CORRECT.toString();			}			checkTruth(e.target);					}	 		private function aMouseOutHandler(e:Event):void{		trace(e.target)				//e.target.bkg.alpha=0;								TweenLite.to(e.target.bkg, 0.2, {alpha:0, overwrite:2}); 							}			private function aMouseOverHandler(e:Event):void{				//e.target.gotoAndPlay("out");				TweenLite.to(e.target.bkg, 0.2, {alpha:1, overwrite:2}); 			}					private function removeEvents(clip):void{			clip.removeEventListener(MouseEvent.CLICK, aHandler);		 	clip.removeEventListener(MouseEvent.MOUSE_OUT, aMouseOutHandler);			clip.removeEventListener(MouseEvent.MOUSE_OVER, aMouseOverHandler);		}								private function checkTruth(clip):void{			trace("CHECK TRUTH PLEASE :: "+typeof clip);						if(clip.CORRECT =="true"){				trace("TRUE DUDE");					correctResult();			}else if(clip.CORRECT =="false"){				trace("FALSE DUDE");					incorrectResult();			}else{				trace("WHAT HAPPENED??");			}		}					private function correctResult():void{			trace(HOTCLIP.chosen_answer_tf+""+HOLD_CLICKED_ANSWER) 	 	 switch(QUESTIONTYPE){				case "MC" :						HOTCLIP.gotoAndStop("correct");						HOTCLIP.chosen_answer.chosen_answer_tf.htmlText = HOLD_CLICKED_ANSWER;						HOTCLIP.chosen_answer.alpha=1;									break;							case "TF" :						HOTCLIP.gotoAndStop("correct");								break;							default:					trace("ERROR :: TF OR MC ??")				break;						}						HOTCLIP.continue_button.alpha=1;			HOTCLIP.continue_button.buttonMode=true;			//HOTCLIP.continue_button.useHandCursor=true;			HOTCLIP.continue_button.addEventListener(MouseEvent.CLICK, cHandler);			HOTCLIP.continue_button.mouseChildren = false;		}			private function incorrectResult():void{			//var clip = container.getChildAt(0);					switch(QUESTIONTYPE){				case "MC" :					HOTCLIP.gotoAndStop("incorrect");					HOTCLIP.chosen_answer.chosen_answer_tf.htmlText = HOLD_CLICKED_ANSWER;					HOTCLIP.chosen_answer.alpha=1;					HOTCLIP.wrongheader.alpha=1;					HOTCLIP.correct_answer.c_answer_tf.htmlText = HOLD_CORRECT_ANSWER;					HOTCLIP.correct_answer.alpha=1;				break;							case "TF" :					//TF_correction					HOTCLIP.gotoAndStop("incorrect");					HOTCLIP.wrongresponse.trueanswer.alpha=0;					HOTCLIP.wrongresponse.falseanswer.alpha=0;					HOTCLIP.wrongresponse.alpha=1;					trace("CORRECT ANSWER IS :: :: :: :"+HOLD_CORRECT_ANSWER);					if(HOLD_CORRECT_ANSWER=="TRUE"){						HOTCLIP.wrongresponse.trueanswer.alpha=1;						HOTCLIP.wrongresponse.falseanswer.alpha=0;											}else if(HOLD_CORRECT_ANSWER=="FALSE"){						HOTCLIP.wrongresponse.trueanswer.alpha=0;						HOTCLIP.wrongresponse.falseanswer.alpha=1;					}				break;							default:					trace("ERROR :: TF OR MC ??")				break;						}			HOTCLIP.continue_button.alpha=1;			HOTCLIP.continue_button.buttonMode=true;			//HOTCLIP.continue_button.useHandCursor=true;			HOTCLIP.continue_button.addEventListener(MouseEvent.CLICK, cHandler);			HOTCLIP.continue_button.mouseChildren = false;							}				private function cHandler(e:Event):void{  /// CONTINUE BUTTON HANDLER			trace(e.target);			dispatchEvent(new TimeLineEvent(TimeLineEvent.RESETSPIN));			NEXTQUESTIONPLEASE();		}				private function NEXTQUESTIONPLEASE():void{			trace("NEXTQUESTIONPLEASE")			// alpha resets; 							switch(QUESTIONTYPE){					case "MC" :						HOTCLIP.chosen_answer.alpha=0;						HOTCLIP.wrongheader.alpha=0;						HOTCLIP.correct_answer.alpha=0;					break;					case "TF" :						HOTCLIP.wrongresponse.trueanswer.alpha=0;						HOTCLIP.wrongresponse.falseanswer.alpha=0;						HOTCLIP.wrongresponse.alpha=0;					break;				}						HOTCLIP.gotoAndStop(1);			HOTCLIP.continue_button.alpha=0;			HOTCLIP.continue_button.removeEventListener(MouseEvent.CLICK, cHandler);							while(container.numChildren>0){						container.removeChildAt(0);				}						dispatchEvent(new TimeLineEvent(TimeLineEvent.RESETME));		}			} // end class} // end package