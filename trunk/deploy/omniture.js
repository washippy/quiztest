s.account = "fmccreditfcdev";
 
 
import com.omniture.ActionSource;
var s:ActionSource;
function configActionSource() {
 
/**** page and the question need to be evaluated */
 
if ("page 3" = true) {
 oscp = "question";
 oscq=": "+"<question title>";
} else if ("page 6" = true) {
 oscp = "thank you";
 oscq="";
} else if ("clicking print_btn on page 6" = true) {
 oscp = "thank you: print";
 oscq="";
} else {
 oscp="start";
 oscq="";
}
 
/**** page and the question need to be evaluated - End */
 
 s = new ActionSource();
 
 /* Specify the Report Suite ID(s) to track here */
 s.account = "fmccreditfcprod";
 
 /* You may add or alter any code config here */
 s.pageName = s.eVar11 = s.prop11 = "flmc: finance tools: wheel game: "+ oscp + ossq;
 s.channel = "tools";
 s.eVar4 = s.prop4 = "eng";
 s.eVar11 = s.prop11 = "flmc: finance tools: wheel game: "+ oscp;
 s.eVar14 = s.prop14 = "fmcc";
 s.eVar15 = s.prop15 = "fordcredit.com";
 s.charSet = "UTF-8";
 s.currencyCode = "USD";
 
 /* Turn on and configure ClickMap tracking here */
 s.trackClickMap = true;
 s.movieID = "";
 
 /* Turn on and configure debugging here */
 s.debugTracking = true;
 s.trackLocal = true;
 
 /* WARNING: Changing any of the below variables will cause drastic changes
 to how your visitor data is collected.  Changes should only be made
 when instructed to do so by your account manager.*/
 s.trackingServer = "metrics.ford.com";
 s.trackingServerSecure = "smetrics.ford.com";
 s.visitorNamespace = "ford";
 
 addChild(s);
}
configActionSource();