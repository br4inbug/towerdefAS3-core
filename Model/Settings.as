package Model{
import flash.utils.Timer;
import flash.display.*;
import flash.display.*;
import flash.events.*;
import flash.net.*;
public class Settings extends Sprite{
public static const GAME_OVER:String = "gameOver";
public static const LOAD_COMPLETE:String = "loadComplete";
public static const INITIALIZED:String = "Initialized";
public static var beat:Number;
public static var enemy_beat:Number; //enemies per 100 beats
public static var gameOver:Boolean;
public static var beat_count:Number;
//public static var enemy_speed:Number; //movement per 20 ms
public static var bossMode:Number;
public static var cityTiles:Array;
public static var cityCenter:Array;
//public static var enemyTypes:Array;
public static var cityName:String;
//public static var enemy_def:Number;
//public static var enemy_hp:Number;
//public static var enemy_dmg:Number;
public static var base_dmg:Number;
public static var base_cost:Number;
public static var base_speed:Number; //blast speed in ms
public static var base_radius:Number;
//public static var enemy_score:Number; //score per enemy
public static var init_score:Number; //initscore
public static var init_inhabitants:Number;
//public static var shieldTime:Number;
public static var score:Number;
public static var bases:Array;
public static var city:City;
public static var enemy:Enemy;
public static var tm_beat:Timer;
public static var enemy_stack_size:Number;
public static var enemyStack:EnemyStack;
public static var settingsBox:mc_settingsBox;
public static var stageWidth:Number;
public static var stageHeight:Number;
public static var username:String;
public static var bk:bk_highScore;
public static var selectedBase:Number;
public static var rectScale:Number;
public static var highscoreList:HighscoreList;
public static var xmlIn:XML;
public static var initialized:Boolean;
public static var enemyPresented: Array;
private var urlLoader:URLLoader;

        public function Settings() {
            loadXML();
			gameOver=false;
			stageWidth=800;
			stageHeight=600;
			initialized=false;
			//beat=8000;
			enemy_beat=80;
			enemy_stack_size=6;
			bossMode=0;
			cityTiles = new Array(4);
			cityTiles[0]={y:16,x:24};
			cityTiles[1]={y:16,x:25};
			cityTiles[2]={y:17,x:24};
			cityTiles[3]={y:17,x:25};
			cityCenter = new Array(1);
			cityCenter[0]={y:298,x:378}; // noch anpassen
			cityName = "Scion City";
			enemyPresented = new Array(6); //Wenn feinde dazukommen anpassen
			for (k=0;k<enemyPresented.lenght;k++) {
			enemyPresented[k]=false;
			}
			//enemy_def=10;
			//enemy_hp=60;
			//enemy_dmg=40;
			base_dmg=40;
			base_cost=40;
			base_speed=2000; //blast speed in ms
			base_radius=30;
			rectScale=0.8;
			selectedBase=1;
			//enemy_score=20; //score per enemy
			//init_score=100;//init score
			init_inhabitants=200;
			//shieldTime=1000; //in ms
			bases = new Array();
			settingsBox = new (mc_settingsBox);
			addChild(settingsBox);
			settingsBox.x=700;
			settingsBox.txt_inhabitants.text=init_inhabitants;
        }
		private function loadXML():void {
			var urlRequest:URLRequest = new URLRequest("Settings.xml");
			urlLoader = new URLLoader( );
			urlLoader.addEventListener(Event.COMPLETE, completeListener);
			urlLoader.load(urlRequest);
		}
		private function completeListener(e:Event):void {
		xmlIn = new XML(urlLoader.data);
		beat=xmlIn.beat.init;
		beat_count=0;
		init_score=int(xmlIn.initScore);
		settingsBox.txt_score.text=init_score;
		trace("initialisiert!" + init_score);
		//throw LoadedCompleteevent!!
		dispatchEvent(new Event(INITIALIZED));
}
		
    }
}