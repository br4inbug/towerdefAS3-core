package Model{
import flash.display.*;
import flash.events.*;
import fl.transitions.easing.*;
import fl.transitions.Tween;
import fl.transitions.TweenEvent;
import flash.utils.Dictionary;
import com.gskinner.motion.GTween;
import fl.motion.easing.*;

public class Base extends Sprite{
private var lv:Number;
private var dmg:Number;
private var cost:Number;
private var speed:Number;
private var base:Sprite;
private var type:Number;
private var hitarea:Shape;
private var radius:Number;
private var rotator:Number;
private var blastCircle:Shape;
public var energyLine:Shape;
private var alignmentType2:Number;
private var tweens:Dictionary;
        public function Base(x:Number,y:Number, tpe:Number) {
            lv = 1;
			// aus defaults auslesen
			speed=2000; //aus defaults auslesen 
			type=tpe;
			tweens = new Dictionary(false);
			alignmentType2=1.35; //Wie weit verschoben is der 2te turm
			//Animierte Base erstellen:
			switch (type) {
				case 1:
				base = new (mc_base);
				dmg=Settings.xmlIn.bases.base1.dmg; // aus defaults auslesen
				cost=Settings.xmlIn.bases.base1.cost;
				radius=Settings.xmlIn.bases.base1.radius;
				base.addEventListener(MouseEvent.CLICK,OnClick1);
				base.buttonMode=true;
				break;
				
				case 2:
				base = new (mc_base);
				dmg=Settings.xmlIn.bases.base2.dmg;
				cost=Settings.xmlIn.bases.base2.cost;
				radius=Settings.xmlIn.bases.base2.radius;
				base.addEventListener(MouseEvent.CLICK,OnClick2);
				base.buttonMode=true;
				rotator=0;
				break;
				
				case 3:
				base = new (mc_base2);
				dmg=Settings.xmlIn.bases.base3.dmg;
				cost=Settings.xmlIn.bases.base3.cost;
				radius=Settings.xmlIn.bases.base3.radius;
				base.alpha=0.5;
				base.addEventListener(MouseEvent.CLICK,OnClick3);
				base.buttonMode=true;
				break;
				
				case 4:
				base = new (mc_base3);
				dmg=Settings.xmlIn.bases.base4.dmg;
				cost=Settings.xmlIn.bases.base4.cost;
				radius=Settings.xmlIn.bases.base4.radius;
				base.alpha=0.5;
				base.addEventListener(MouseEvent.CLICK,OnClick3);
				base.buttonMode=true;
				break;
				
				case 5:
				base = new (mc_base4);
				dmg=Settings.xmlIn.bases.base5.dmg;
				cost=Settings.xmlIn.bases.base5.cost;
				radius=Settings.xmlIn.bases.base5.radius;
				base.alpha=0.5;
				base.addEventListener(MouseEvent.CLICK,OnClick3);
				base.buttonMode=true;
				break;
				
				case 6:
				base = new (mc_base5);
				dmg=Settings.xmlIn.bases.base6.dmg;
				cost=Settings.xmlIn.bases.base6.cost;
				radius=Settings.xmlIn.bases.base6.radius;
				base.alpha=0.5;
				base.addEventListener(MouseEvent.CLICK,OnClick3);
				base.buttonMode=true;
				break;
			}
			
			base.x=x;
			base.y=y;
			addChild(base);
			
			
			
			//hitarea erstellen:
			hitarea = createHitarea( x, y);
      		
			
        }
        private function OnClick1(e:Event):void {
			parent.removeChild(this);
			Settings.settingsBox.txt_score.text = parseInt(Settings.settingsBox.txt_score.text) + Math.round(cost * 0.75);
		}
		private function OnClick2(e:Event):void {
			rotateHitarea();
		}
		private function OnClick3(e:Event):void {
			deEnergizeAllOtherBases();
			energizeBase();
			
		}
		public function getDmg(  ):Number {
            return dmg;
        }
		public function getLv(  ):Number {
            return lv;
        }
			public function getType(  ):Number {
            return type;
        }
		public function getCost(  ):Number {
            return cost;
        }
		public function getSpeed(  ):Number {
            return speed;
        }
		
		public function energizeBase():void {
		energyLine= new Shape();
		energyLine.graphics.beginFill(0xCCCCCC,0.7);
		energyLine.graphics.lineStyle(1.4,0x000000);
		energyLine.graphics.drawCircle(0,0,5);
		energyLine.graphics.moveTo(0,0);

		energyLine.graphics.lineTo(Settings.cityCenter[0].x-hitarea.x,Settings.cityCenter[0].y-hitarea.y);
		energyLine.graphics.drawCircle(Settings.cityCenter[0].x-hitarea.x, Settings.cityCenter[0].y-hitarea.y, 5);
		energyLine.graphics.endFill();
		addChild(energyLine);
		energyLine.x=hitarea.x;
		energyLine.y=hitarea.y;
		Settings.bases.push(this); 
		base.alpha=1;
		base.buttonMode=false;
		}		
		public function deEnergizeAllOtherBases():void {
		for (i=0;i<Settings.bases.length;i++) {
		var b:Base=Settings.bases[i];
		if (b.getType()>=3) {
		b.removeChild(b.energyLine);
		b.energyLine=null;
		Settings.bases.splice(i,1);
		b.alpha=0.5;
		b.buttonMode=true;
		}
		}
		}
		public function blast(  ):void {
            //hitarea leuchtet auf
			blastCircle= new Shape();
			blastCircle.graphics.lineStyle(1,0x000000);
			if (type==2) {
				switch (rotator) {
		case 0:
		blastCircle.graphics.drawCircle( radius - (alignmentType2*base.width), 0, radius );
		blastCircle.graphics.lineStyle(2,0xCCCCCC);
			blastCircle.graphics.drawCircle(radius - (alignmentType2*base.width), 0,radius-3);
		break;
		case 1:
		blastCircle.graphics.drawCircle( 0, radius - (alignmentType2*base.width), radius );
		blastCircle.graphics.lineStyle(2,0xCCCCCC);
		blastCircle.graphics.drawCircle( 0, radius - (alignmentType2*base.width), radius-3 );
		break;
		case 2:
		blastCircle.graphics.drawCircle( (alignmentType2*base.width) - radius, 0, radius );
		blastCircle.graphics.lineStyle(2,0xCCCCCC);
		blastCircle.graphics.drawCircle( (alignmentType2*base.width) - radius, 0, radius -3 );
		break;
		case 3:
		blastCircle.graphics.drawCircle( 0, (alignmentType2*base.width) - radius, radius );
		blastCircle.graphics.lineStyle(2,0xCCCCCC);
		blastCircle.graphics.drawCircle( 0, (alignmentType2*base.width) - radius, radius-3 );
		break;
		}
			}
			else
			{
			blastCircle.graphics.drawCircle(0,0,radius);
			blastCircle.graphics.lineStyle(2,0xCCCCCC);
			blastCircle.graphics.drawCircle(0,0,radius-3);
			}
			
			addChild(blastCircle);
			blastCircle.x=hitarea.x;
			blastCircle.y=hitarea.y;
			/* tween class:
			var tweenGrowX:Tween = new Tween(blastCircle, "scaleX", Regular.easeOut, 0, 1, 1, true);
  			var tweenGrowY:Tween = new Tween(blastCircle, "scaleY", Regular.easeOut , 0, 1, 1, true);
			tweens[tweenGrowX]=tweenGrowX;
			tweens[tweenGrowY]=tweenGrowY;
			tweenGrowY.addEventListener(TweenEvent.MOTION_FINISH, GrowFinished); */
			//trace ("blast"+Settings.enemy);
			blastCircle.scaleX=0;
			blastCircle.scaleY=0;
			var growTween:GTween = new GTween(blastCircle, 1, {scaleX:1, scaleY:1}, {ease:Quadratic.easeOut, completeListener:GrowFinished});
			//growTween.addEventListener(GTween.COMPLETE, GrowFinished);
        }
		private function GrowFinished(e:Event):void {
			removeChild(e.currentTarget.target);
			/*tweens[e.currentTarget].removeEventListener(TweenEvent.MOTION_FINISH, GrowFinished);
			tweens[e.currentTarget] = null; //GC Object
			delete tweens[e.currentTarget];*/ 
			
		}
		public function createHitarea(x: Number, y:Number ):Shape {
      	
		var shape:Shape = new Shape(  );
      	switch (type) {
		case 1:
		shape.graphics.beginFill(0x000000, 0.2);
      	shape.graphics.drawCircle( 0, 0, radius );
      	shape.graphics.endFill(  );
		break;
		
		case 2:
		shape.graphics.beginFill(0x000000, 0.2);
      	switch (rotator) {
		case 0:
		shape.graphics.drawCircle( radius - (alignmentType2*base.width), 0, radius );
		break;
		case 1:
		shape.graphics.drawCircle( 0, radius - (alignmentType2*base.width), radius );
		break;
		case 2:
		shape.graphics.drawCircle( (alignmentType2*base.width) - radius, 0, radius );
		break;
		case 3:
		shape.graphics.drawCircle( 0, (alignmentType2*base.width) - radius, radius );
		break;
		}
      	shape.graphics.endFill(  );
		break;
		
		case 3:
		shape.graphics.beginFill(0xFF0503, 0.2);
      	shape.graphics.drawCircle( 0, 0, radius );
      	shape.graphics.endFill(  );
		break;
		
		case 4:
		shape.graphics.beginFill(0x3E03FF, 0.2);
      	shape.graphics.drawCircle( 0, 0, radius );
      	shape.graphics.endFill(  );
		break;
		
		case 5:
		shape.graphics.beginFill(0xE85909, 0.2);
      	shape.graphics.drawCircle( 0, 0, radius );
      	shape.graphics.endFill(  );
		break;
		
		case 6:
		shape.graphics.beginFill(0xD40AEB, 0.2);
      	shape.graphics.drawCircle( 0, 0, radius);
      	shape.graphics.endFill(  );
		break;
		
		
		}
		hitarea=shape;
		hitarea.x = x + (base.width / 2);
      	hitarea.y = y + (base.height / 2);
		
		addChild(hitarea);
		return shape;
    }

	private function rotateHitarea():void {
	rotator++;
	if (rotator>3) {
		rotator=0;
	}
	removeChild(hitarea);
	hitarea=createHitarea(base.x, base.y);
	}
		public function getHitarea(  ):Shape {
            return hitarea;
        }
    }
}