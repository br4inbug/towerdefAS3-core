package Model{
import flash.display.*;
import com.gskinner.motion.GTween;
import fl.motion.easing.*;
import fl.transitions.easing.*;
public class EnemyStack extends Sprite{
private var enemyStack:Array;
private var box:mc_enemyStack;
        public function EnemyStack() {
            size = Settings.enemy_stack_size;
			enemyStack=new Array();	
			box = new mc_enemyStack();
			addChild(box);
			box.y=Settings.stageHeight - box.height;
			box.width=702;
        }
        public function getEnemyStack ():Array {
			return enemyStack;
		}
		public function getSize(  ):Number {
            return size;
        }
		public function setSize(newSize:Number):void {
            size=newSize;
        }
		 public function getBox(  ):mc_enemyStack {
            return box;
        }
		public function push(item:Object):void {
		 
		   //previews rücken nach
			   for (i=0;i<enemyStack.length;i++) {
				
				if (enemyStack[i] is Enemy) {
					//trace("enemyStackItem"+i+": "+enemyStack[i];
					var prev:Sprite = Enemy(enemyStack[i]).getPreview();
					//trace ("move:" + prev.x + prev.width);
					if (prev.x >= (box.width / size)-(prev.width/2)) { 
					var targetX:Number=prev.x - box.width / size;
					//var prevTween:GTween = new GTween(prev, 0.5, {x:targetX}, {ease:Regular.easeInOut});
					prev.x -= box.width / size;
					}
				}
			   }
		   
		   if (item is Enemy) {
			   var enemyPreview:Sprite=Enemy(item).getPreview();   
			   
			   //neuen Preview anzeigen
			   box.addChild(enemyPreview);
			   enemyPreview.height=Math.round(box.height * 0.7);
			   //enemyPreview.width=box.width / size;
			   enemyPreview.y = Math.round(enemyPreview.height * 0.15);
			   enemyPreview.x = box.width - enemyPreview.width-5;
			   
			   //stack aktualisieren
			   enemyStack.push(item);
		   }
		   else {
		   enemyStack.push(item);
		   }
		   //Enemy herbeirufen
		   //trace("enemyStack-size:" + enemyStack.length);
		   if (enemyStack.length>size) {
			   var moveEnemy:Enemy = enemyStack.shift();
			   //trace("box:" +box.height + "," + box.width);
			   if (moveEnemy is Enemy) {
			   box.removeChild(moveEnemy.getPreview());//2tes child löschen
			   //trace("box:" +box.height + "," + box.width);
			   Settings.enemy=moveEnemy;
			   Settings.enemy.move();
			   }
			   
		   }
		   
        }
		
    }
}