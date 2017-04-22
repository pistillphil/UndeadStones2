package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

import player.Player;

class PlayState extends FlxState
{

	private var _player:Player;
	private var _ogmo_map:FlxOgmoLoader;
	private var _tilemap:FlxTilemap;

	override public function create():Void
	{
		// Fade the play state from a white screen
		FlxG.camera.fade(FlxColor.WHITE, .66, true);

		// Read tilemap and setup first room
		_ogmo_map = new FlxOgmoLoader(AssetPaths.room_001__oel);
		_tilemap = _ogmo_map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_tilemap.follow();
		_tilemap.setTileProperties(6, FlxObject.NONE);
		add(_tilemap);

		// Add the player to the scene
		_player = new Player();
		_ogmo_map.loadEntities(place_entities, "entities");
		add(_player);

		// Let the camera follow the player
		FlxG.camera.follow(_player, TOPDOWN, 1);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		// Check for player collisions with walls
		FlxG.collide(_player, _tilemap);
	}

	/**
	 *  Places all entities in this state according to their position in the map
	 *  
	 *  @param   entity_name name of the entity contained in the map
	 *  @param   entity_data data of the entity contained in the map
	 */
	private function place_entities(entity_name:String, entity_data:Xml):Void
	{
		var x:Int = Std.parseInt(entity_data.get("x"));
		var y:Int = Std.parseInt(entity_data.get("y"));
		if (entity_name == "player")
		{
			_player.x = x;
			_player.y = y;
		}
	}
}
