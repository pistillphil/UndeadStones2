package;

import flixel.FlxState;

import flixel.FlxG;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	override public function create():Void
	{
		FlxG.camera.fade(FlxColor.WHITE, .66, true);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
