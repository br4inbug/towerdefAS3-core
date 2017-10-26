package Model {
import flash.display.*;
import flash.events.*;
import flash.net.*;
// Demonstrates the code required to load external XML
public class HighscoreList extends Sprite {
private var highscore:XML;
private var urlLoader:URLLoader;
public function HighscoreList () {
var urlRequest:URLRequest = new URLRequest("Highscore.xml");
urlLoader = new URLLoader( );
urlLoader.addEventListener(Event.COMPLETE, completeListener);
urlLoader.load(urlRequest);
}
private function completeListener(e:Event):void {
highscore = new XML(urlLoader.data);
trace("geladen!");
//throw LoadedCompleteevent!!
dispatchEvent(new Event(Settings.LOAD_COMPLETE));
//trace(novel.toXMLString( )); // Display the loaded XML, now converted
}

public function getHighscore():XML {
return highscore
}

public function addScore(score:Number, name:String):Number {
var rank:Number;
//score an der richtigen stelle im xml einfügen
var txt:String;
var written:Boolean=false;

for each ( var entry:XML in highscore.elements() ) {
if (!written) {
rank=entry.rank;
var escore:Number=entry.score;
if (escore<=score ) {
txt = "<entry><rank>" + rank.toString() + "</rank><name>" + name + "</name><score>"+ score.toString() + "</score></entry>";
trace("xmlEntry:" + txt);
highscore = highscore.insertChildBefore(entry, txt );//bei "highscore.entry" bin i ma net ganz sicher 
entry.rank++; //auch nicht ganz sicher, ob das so geht
written = true;
}
}
else {
//Nachfolgende nachverschieben
entry.rank++; //auch nicht ganz sicher, ob das so geht

}

}
if (!written) {
rank++;
txt = "<entry><rank>" + rank.toString() + "</rank><name>" + name + "</name><score>"+ score.toString() + "</score></entry>";

highscore.appendChild(txt); //auch noch testen ob des geht
trace (highscore.toString());
}
sendToPHP(); 
return rank;
}

private function sendToPHP(): void {
//var score:int = Settings.score;
      
      var request:URLRequest = new URLRequest( "highscore.php" );
      // Set the data property to the dataToSave XML instance to send the XML
      // data to the server
      request.data = highscore;
      // Set the contentType to signal XML data being sent
      request.contentType = "text/xml";
      // Use the post method to send the data
      request.method = URLRequestMethod.POST;
      
      // Create a URLLoader to handle sending and loading of the XML data
      var loader:URLLoader = new URLLoader(  );
      // When the server response is finished downloading, invoke handleResponse
      loader.addEventListener( Event.COMPLETE, handleResponse );
      // Finally, send off the XML data to the URL
      loader.load( request );

} 

private function handleResponse( event:Event ):void {
      try {
        // Attempt to convert the server's response into XML
        var success:XML = new XML( event.target.data );
        
        // Inspect the value of the success element node
        if (success.toString(  ) == "1") {
          trace("Saved successfully.");    
        } else {
          trace("Error encountered while saving.");
        }
        
      } catch ( e:TypeError ) {
        // Display an error message since the server response was not understood
        trace( "Could not parse XML response from server.");
      }
    }


}
}