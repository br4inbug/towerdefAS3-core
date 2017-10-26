package Model {
import flash.display.*;
import flash.events.*;
import flash.utils.*;
public class Animator extends EventDispatcher {
private var target:DisplayObject;
private var startTime:Number;
private var duration:Number;
private var startX:Number;
private var startY:Number;
private var deltaX:Number;
private var deltaY:Number;
public function Animator (target:DisplayObject) {
this.target = target;
}

public function animateTo (toX:Number, toY:Number,
duration:Number):void {
startX = target.x;
startY = target.y;
deltaX = toX - target.x;
deltaY = toY - target.y;
startTime = getTimer( );
this.duration = duration;
target.addEventListener(Event.ENTER_FRAME, enterFrameListener);
}
private function enterFrameListener (e:Event):void {
var elapsed:Number = getTimer( )-startTime;
var percentDone:Number = elapsed/duration;
if (percentDone < 1) {
updatePosition(percentDone);
} else {

updatePosition(1);
target.removeEventListener(Event.ENTER_FRAME, enterFrameListener);
}
}

private function updatePosition (percentDone:Number):void {
target.x = startX + deltaX*percentDone;
target.y = startY + deltaY*percentDone;
}
}
}