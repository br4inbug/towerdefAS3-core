package Model{
import flash.display.*;
public class City extends Sprite{
private var lv:Number;
private var city_name:String;
//private var inhabitants:Number;
private var tiles:Array;
//private var city:btn_city;
        public function City() {
            lv = 1;
			city_name = Settings.cityName;
			//inhabitants= Settings.inhabitants;
			/*tiles = new Array(4);
			tiles[0]={y:16,x:24};
			tiles[1]={y:16,x:25};
			tiles[2]={y:17,x:24};
			tiles[3]={y:17,x:25};*/
			//tiles = Settings.cityTiles;
			tiles = new Array();
			
        }
		public function addTile(x:Number, y:Number):String {
            var tile:btn_city;
			tile = new (btn_city);
			tile.x=x;
			tile.y=y;
			addChild(tile);
			tiles.push(tile);
        }
        public function getCityName(  ):String {
            return city_name;
        }
		public function getLv(  ):Number {
            return lv;
        }
		public function getInhabitants(  ):Number {
            return inhabitants;
        }
		public function getTiles(  ):Array {
            return tiles;
        }
    }
}