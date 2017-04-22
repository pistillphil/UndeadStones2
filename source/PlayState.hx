package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;

import player.Player;

class PlayState extends FlxState
{

	private var _player:Player;

	override public function create():Void
	{
		// Fade the play state from a white screen
		FlxG.camera.fade(FlxColor.WHITE, .66, true);

		// Add the player to the scene
		_player = new Player(100, 100);
		add(_player);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
