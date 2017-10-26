package Model{
import flash.display.*;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.Dictionary;
import fl.transitions.easing.*;
import fl.transitions.Tween;
import fl.transitions.TweenEvent;
import com.gskinner.motion.GTween;
import fl.motion.easing.*;

public class Enemy extends Sprite{
private var initHp:Number;
private var initLifeLineWidth:Number;
private var shieldTime:Number;
private var shield:Boolean;
private var hp:Number;
private var dmg:Number;
private var def:Number;
private var speed:Number;
private var size:Number;
private var initX:Number;
private var initY:Number;
private var vx:Number;
private var vy:Number;
private var shieldStart:Number;
private var elapsed:Number;
public static const pirate:Number=1;
public static const rockNroll:Number = 3;
public static const wind:Number = 2;
public static const fit:Number = 4;
public static const fex:Number = 5;
public static const arche:Number = 6;
//private var radians:Number;
//private var angle:Number;
private var previewWidth:Number;
private var previewHeight:Number;
private var moveFrameRate:Number;
private var deltaX:Number;
private var deltaY:Number;
private var mc:Sprite;
//private var enemy:mc_enemy;
private var lifeBar:mc_lifeBar;
private var timer:Timer;
private var preview:Sprite;
private var previewEnemy:Sprite;
private var dmgDone:Boolean;
private var hasShield:Boolean;
private var hasLifebar:Boolean;
private var picEnemy:Sprite;
private var tweens:Dictionary;
private var blowParts:Number;
private var count_blowsFinished:Number;
private var dead:Boolean;
private var scoreCounter:Timer;
private var inhabitantsCounter:Timer;
private var weakness:Dictionary;
private var round:Boolean;
private var card:Sprite;
//private var animator:Animator;
//private var shapes:Array;
        public function Enemy(type:Number,x:Number,y:Number) {
            //hp = Settings.enemy_hp;
			
			//dmg= Settings.enemy_dmg; // aus defaults auslesen
			//def=Settings.enemy_def; // aus defaults auslesen
			//speed=Settings.enemy_speed; //aus defaults auslesen 
			moveFrameRate = 25;
			//enemy = new (mc_enemy);
			dmgDone=false;
			tweens = new Dictionary(false);
			//shieldTime=Settings.shieldTime;
			shield=false;
			//positionen automatisch generieren lassen
			initX=x;
			weakness=new Dictionary();
			initY=y;
			dead=false;
			var element:XML;
			switch(type) {
				case pirate:
				hp=int(Settings.xmlIn.pirate.hp);
				score=int(Settings.xmlIn.pirate.score);
				dmg=int(Settings.xmlIn.pirate.dmg);
				def=int(Settings.xmlIn.pirate.def);
				size=int(Settings.xmlIn.pirate.size);
				shieldTime=int(Settings.xmlIn.pirate.shieldTime);
				mc=new(mc_pirate);
				card=new(mc_pirateCard);
				speed=int(Settings.xmlIn.pirate.speed);
				round=true;
				previewEnemy = new (mc_pirate);
				hasShield=true;
				break;
				
				case rockNroll:
				hp=int(Settings.xmlIn.rockNroll.hp);
				score=int(Settings.xmlIn.rockNroll.score);
				dmg=int(Settings.xmlIn.rockNroll.dmg);
				def=int(Settings.xmlIn.rockNroll.def);
				size=int(Settings.xmlIn.rockNroll.size);
				shieldTime=int(Settings.xmlIn.rockNroll.shieldTime);
				mc=new(mc_rockNroll);
				card=new(mc_rockNrollCard);
				speed=int(Settings.xmlIn.rockNroll.speed);
				round=true;
				previewEnemy = new (mc_rockNroll);
				hasShield=true;
				hasLifebar=false;
				for each (element in Settings.xmlIn.rockNroll.weakness) {
				weakness[parseInt(element.@type)]=parseInt(element.toString());
				}
				
				break;
				
				case wind:
				hp=int(Settings.xmlIn.wind.hp);
				score=int(Settings.xmlIn.wind.score);
				dmg=int(Settings.xmlIn.wind.dmg);
				def=int(Settings.xmlIn.wind.def);
				size=int(Settings.xmlIn.wind.size);
				shieldTime=int(Settings.xmlIn.wind.shieldTime);
				mc=new(mc_wind);
				card=new(mc_windCard);
				speed=int(Settings.xmlIn.wind.speed);
				round=true;
				previewEnemy = new (mc_wind);
				hasShield=true;
				hasLifebar=false;
				for each ( element in Settings.xmlIn.wind.weakness) {
				weakness[parseInt(element.@type)]=parseInt(element.toString());
				}
				break;
				
				case fit:
				hp=int(Settings.xmlIn.fit.hp);
				score=int(Settings.xmlIn.fit.score);
				dmg=int(Settings.xmlIn.fit.dmg);
				def=int(Settings.xmlIn.fit.def);
				size=int(Settings.xmlIn.fit.size);
				shieldTime=int(Settings.xmlIn.fit.shieldTime);
				mc=new(mc_fit);
				card=new(mc_fitCard);
				speed=int(Settings.xmlIn.fit.speed);
				round=true;
				previewEnemy = new (mc_fit);
				hasShield=true;
				hasLifebar=false;
				for each ( element in Settings.xmlIn.fit.weakness) {
				weakness[parseInt(element.@type)]=parseInt(element.toString());
				}
				break;
				
				case fex:
				hp=int(Settings.xmlIn.fex.hp);
				score=int(Settings.xmlIn.fex.score);
				dmg=int(Settings.xmlIn.fex.dmg);
				def=int(Settings.xmlIn.fex.def);
				size=int(Settings.xmlIn.fex.size);
				shieldTime=int(Settings.xmlIn.fex.shieldTime);
				mc=new(mc_fex);
				card=new(mc_fexCard);
				speed=int(Settings.xmlIn.fex.speed);
				round=true;
				previewEnemy = new (mc_fex);
				hasShield=false;
				hasLifebar=false;
				break;
				
				case arche:
				hp=int(Settings.xmlIn.arche.hp);
				score=int(Settings.xmlIn.arche.score);
				dmg=int(Settings.xmlIn.arche.dmg);
				def=int(Settings.xmlIn.arche.def);
				size=int(Settings.xmlIn.arche.size);
				shieldTime=int(Settings.xmlIn.arche.shieldTime);
				mc=new(mc_arche);
				card=new(mc_archeCard);
				speed=int(Settings.xmlIn.arche.speed);
				round=false;
				hasLifebar=true;
				previewEnemy = new (mc_arche);
				hasShield=false;
				for each ( element in Settings.xmlIn.arche.weakness) {
				weakness[parseInt(element.@type)]=parseInt(element.toString());
				}
				break;
			}
      		initHp=hp;
			//angle : nach pythagoras berechnen
			//angle=ang;
      		//radians= angle * Math.PI / 180;
			
			deltaX = Settings.cityCenter[0].x - x;
			deltaY = Settings.cityCenter[0].y - y;
			
			//vx = Math.cos(radians) * speed;
            //vy= Math.sin(radians) * speed;
			//trace("vx,vy,ang, rad" + vx + ","+vy+","+angle + "," +radians);
			
			//addChild(Preview(...));
			if (!hasLifebar) {
			lifeBar = new (mc_lifeBar);
			mc.addChild(lifeBar);
			lifeBar.y= -6.5;
			initLifeLineWidth=lifeBar.lifeLine.width;
			}
			
			
			//preview
			previewWidth=52; //von mc.width ableiten
			previewHeight=39;
			preview= new Sprite();
			var previewDirection:Shape=createPreview(previewWidth,previewHeight);
			preview.addChild(previewDirection);
			previewDirection.x=previewWidth;
			
			previewEnemy.width=previewHeight; //wenn height größer width sein sollte --> fehler
			previewEnemy.height=previewHeight;
			previewEnemy.x=(previewEnemy.width-previewEnemy.height)/2;
			preview.addChild(previewEnemy);
			//card presentation
			if(!Settings.enemyPresented[type-1]){
				Settings.enemyPresented[type-1]=true;
				addChild(card);
				//card.width=preview.width*2;
				//card.height=4*preview.height;
				card.x=(Settings.stageWidth/2)-(card.width/2);
				card.y=(Settings.stageHeight/2)-(card.height/2);
				//card.y-=card.height;
				//card.x-=card.width;
				card.alpha=0;
				var cardTween:GTween = new GTween(card, 5, {alpha:1}, {ease:Strong.easeOut, completeListener:PresentationFinished});
			
			}
			if (initY>Settings.stageHeight-Settings.enemyStack.getBox().height-mc.height) {
				initY=Settings.stageHeight-Settings.enemyStack.getBox().height-mc.height;
			}
			if (initX>Settings.stageWidth-Settings.settingsBox.width-mc.width) {
				initX=Settings.stageWidth-Settings.settingsBox.width-mc.width;
			}
			
        }
		
		private function PresentationFinished(e:Event):void {
			removeChild(e.currentTarget.target);
			/*tweens[e.currentTarget] = null; //GC Object
			delete tweens[e.currentTarget]; */
			card=null;
		}
		
        public function move():void {
            
			addChild(mc);
			
			//enemy.prevPic.alpha=0;
			mc.gotoAndPlay(2);
			mc.scaleX=size/100;
			mc.scaleY=size/100;
			/*enemy.x=initX;
			enemy.y=initY;
			animator = new Animator(enemy);
			trace("move:" + Settings.cityCenter.x + "," + Settings.cityCenter.y);
			animator.animateTo(Settings.cityCenter.x, Settings.cityCenter.y, Settings.beat);*/
			
			mc.x=initX;
			mc.y=initY;
			timer = new Timer(moveFrameRate);
            timer.addEventListener("timer", onTimer);
            elapsed=0;
			timer.start( );	
        }
		
		public function onTimer(event:TimerEvent):void {
            //try {
			
            //trace (radians);
			if (hasLifebar && lifeBar==null) {
				lifeBar = mc.picEnemy.lifeBar;
				initLifeLineWidth=lifeBar.lifeLine.width;
			}
			elapsed+=moveFrameRate;
			var percentDone:Number = elapsed/(Settings.beat*(speed/100));
			//trace("percent done:" + percentDone);
			if (percentDone < 1) {
			mc.x = initX + (deltaX*percentDone);
            mc.y = initY + (deltaY*percentDone);
			
			} else {
			timer.stop();
			removeAllChildren();
			}
			
			//shield schalter
			if (shield && ((elapsed-shieldStart)>=(shieldTime))) {
				shield=false;
				if (hasShield) {
					mc.shldPic.alpha=0;
				}
			}
			
			if (!shield) {
			
			//Beschuss feststellen
			var shape:Shape;
			var cityTiles:Array; 
			if (round) {
			for (i=0;i<Settings.bases.length;i++) {
				shape = Base(Settings.bases[i]).getHitarea();
				if (distHitTest(shape, true)) {
				Settings.bases[i].blast();
				takeDmg(Settings.bases[i]);
				}
			}
			
			//Stadt getroffen - feststellen
			cityTiles = City(Settings.city).getTiles();
			for (j=0;j<cityTiles.length;j++) {
				if (distHitTest(cityTiles[j], false)) {
				timer.stop();
				doDmg();
				}
			}
			}
			else
			{
			picEnemy=mc.picEnemy;
			for (i=0;i<Settings.bases.length;i++) {
				//if (enemy.hitTestObject(shapes[i])) { //bei 4eckigen shapes
				shape = Base(Settings.bases[i]).getHitarea();
				//trace ("shape:" + shape.x + "," + enemy.x);
				if (picEnemy.hitTestObject(shape)) {
				//trace ("shape:" + shape.x + "," + enemy.x);
				//trace("hier");
				Settings.bases[i].blast();
				takeDmg(Settings.bases[i]);
				
				}
			}
			
			//Stadt getroffen - feststellen
			cityTiles = City(Settings.city).getTiles();
			for (j=0;j<cityTiles.length;j++) {
				//if (enemy.hitTestObject(shapes[i])) { //bei 4eckigen shapes
				if (picEnemy.hitTestObject(cityTiles[j])){
				timer.stop();
				doDmg();
				
				}
			}
			}
			}
			/*}
			catch (errObject:Error) {
			trace (errObject.message);
			timer.stop();
			}*/
			
        }
		
		private function distHitTest(coll:Object, circle:Boolean):Boolean {
  				var dx:Number;          
				if (circle) {
				dx = mc.x + (mc.width/2) - coll.x;//bei mc_enemy ist 0,0 links oben
				}
				else {
				dx= mc.x + (mc.width/2) - (coll.x + (coll.width/2));//bei mc_enemy ist 0,0 links oben
				}
				var dy:Number = mc.y + (mc.height/2) - coll.y;
				var dist:Number = Math.sqrt(dx * dx + dy * dy);
				var minDist:Number = (mc.width/2)  + (coll.width/2); //collision detection für runde shapes
				//trace(dist < minDist);
				return (dist < minDist);
				
        }
		
		private function takeDmg(base:Base):void {
            //balkenupdate + hpupdate
			if (!Settings.gameOver) {
			var dmgFromWeakness:Number=0;
			if (weakness.hasOwnProperty(base.getType())) {
			dmgFromWeakness += weakness[base.getType()];
			}
			hp -= base.getDmg() - def + dmgFromWeakness;
			lifeBar.lifeLine.width = hp*(initLifeLineWidth / initHp);
			shield= true;
			shieldStart=elapsed;
			if(hasShield){
				mc.shldPic.alpha=1;
			}
			//stirbt
			if (hp<=0 && !dead) {
			die();
			}
			}
        }
		public function die():void {
			dead=true;
			timer.stop();
			//timer=null;
			removeAllChildren();
			var x= mc.x;
			var y= mc.y;
			
			//score bekommen-tween
			
			scoreCounter= new Timer(50,score);
			scoreCounter.addEventListener("timer", onScoreCount);
			scoreCounter.start();
			
			//parent.removeChild(this);
			//blow-tween
			/*
			for(i=0;i<(score/8);i++) {
			var blowCircle:Shape= new Shape();
			blowCircle.graphics.lineStyle(1,0x000000);
			blowCircle.graphics.drawCircle(0, i*8,Math.round((Math.random()*3)+1));
			addChild(blowCircle);
			blowCircle.x=x;
			blowCircle.y=y;
			var tweenBlowX:Tween = new Tween(blowCircle, "x", Regular.easeIn, x, Settings.settingsBox.txt_score.x, 1, true);
  			var tweenBlowY:Tween = new Tween(blowCircle, "y", Regular.easeIn , y, Settings.settingsBox.txt_score.y+8, 1, true);
			tweens[tweenBlowX]=tweenBlowX;
			tweens[tweenBlowY]=tweenBlowY;
			//tweenBlowY.addEventListener(TweenEvent.MOTION_FINISH, BlowFinished);
			}
			var lastBlowCircle:Shape= new Shape();
			lastBlowCircle.graphics.lineStyle(1,0x000000);
			lastBlowCircle.graphics.drawCircle(0, i*8,Math.round((Math.random()*3)+1));
			addChild(lastBlowCircle);
			var lastTweenBlowX:Tween = new Tween(lastBlowCircle, "x", Regular.easeIn, x, Settings.settingsBox.txt_score.x, 1, true);
  			var lastTweenBlowY:Tween = new Tween(lastBlowCircle, "y", Regular.easeIn , y, Settings.settingsBox.txt_score.y+8, 1, true);
			tweens[lastTweenBlowX]=lastTweenBlowX;
			tweens[lastTweenBlowY]=lastTweenBlowY;
			lastTweenBlowY.addEventListener(TweenEvent.MOTION_FINISH, LastBlowFinished);
			*/
			var i:Number;
			var j:Number;
			trace ("score:" + score);
			blowParts=Math.round(score/8);
			count_blowsFinished=0;
			var blowTween:GTween;
			for(i=0;i<blowParts;i++) {
			for(j=0;j<blowParts;j++) {
			var blowCircle:Shape= new Shape();
			var size:Number=Math.random()*2+1;
			blowCircle.graphics.beginFill(0x000000);
			blowCircle.graphics.drawCircle(j*4*Math.random(), i*4*Math.random(),size);
			blowCircle.graphics.endFill();
			addChild(blowCircle);
			blowCircle.x=x;
			blowCircle.y=y;
			blowTween = new GTween(blowCircle, 1+size/6, {x:Settings.settingsBox.x, y:Settings.settingsBox.txt_score.y+8}, {ease:Strong.easeIn, completeListener:BlowFinished});
			}
			}
			
			
		}
		private function BlowFinished(e:Event):void {
			if (contains(e.currentTarget.target)) {
				removeChild(e.currentTarget.target);
			}
			/*tweens[e.currentTarget] = null; //GC Object
			delete tweens[e.currentTarget]; */
			count_blowsFinished++;
			if (count_blowsFinished == blowParts) {
			delete this;
			}
		}
		private function onScoreCount(e:Event):void {
			Settings.settingsBox.txt_score.text = int(Settings.settingsBox.txt_score.text)+ 1;
			
		}
		private function doDmg(  ):void {
            //explosionsani
			//trace("Stadt getroffen");
			if (!dmgDone) {
			var fadeOutTween4 = new GTween(mc, 0.25, {alpha:0}, {ease:None.easeIn,reflect:true,repeat:Math.round(dmg/8)});
			//if (parseInt(Settings.settingsBox.txt_inhabitants.text)-dmg<=0){
			
			//}
			dmgDone=true;
			inhabitantsCounter= new Timer(20,dmg);
			inhabitantsCounter.addEventListener("timer", onInhabitantsCount);
			inhabitantsCounter.addEventListener("timerComplete", onInhabitantsCountFinished);
			inhabitantsCounter.start();
			
			
			}
			
        }
		private function onInhabitantsCount(e:Event):void {
			Settings.settingsBox.txt_inhabitants.text = parseInt(Settings.settingsBox.txt_inhabitants.text)- 1;
			if (parseInt(Settings.settingsBox.txt_inhabitants.text)<=0 && !Settings.gameOver){
			trace("throw gameover");
			Settings.gameOver=true;
			dispatchEvent(new Event(Settings.GAME_OVER));
			}
			
		}
		
		private function onInhabitantsCountFinished(e:Event):void {
			trace("delete enemy");
			removeAllChildren();
			delete this;
		}
		public function getPreview():Sprite {
			return preview;
		}
		
		public function createPreview(w:Number,h:Number):Shape {
      	var canvas:Shape = new Shape( ); 
		var shrinkX:Number = w/(Settings.stageWidth-Settings.settingsBox.width);
		var shrinkY:Number = h/(Settings.stageHeight-Settings.enemyStack.getBox().height);
		canvas.graphics.lineStyle(2, 0x000000, 1, false);
		canvas.graphics.drawRect(0, 0, w, h);
		canvas.graphics.lineStyle(3, 0x000000, 1, false);
		canvas.graphics.moveTo(initX*shrinkX, initY*shrinkY);
		canvas.graphics.lineTo(Settings.cityCenter[0].x*shrinkX,Settings.cityCenter[0].y*shrinkY); // Fraglich, wie das Koordinatensystem bei canvas ausschaut
		canvas.graphics.beginFill(0xFF3049);
		canvas.graphics.drawCircle(Settings.cityCenter[0].x*shrinkX,Settings.cityCenter[0].y*shrinkY, 4.5);
		canvas.graphics.endFill(  );
		/*canvas.x = x;
		canvas.y = y;*/
      	return canvas;
    }
	public function removeAllChildren():void {
      var count:int = this.numChildren;
      
      for ( var i:int = 0; i < count; i++ ) {
        this.removeChildAt( 0 );
      }
    }

		
    }
}