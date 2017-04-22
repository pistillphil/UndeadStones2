package;

import flixel.FlxState;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState
{

	private var _btn_play:FlxButton;

	override public function create():Void
	{
		_btn_play = new FlxButton(0, 0, "Escape!", start_game);
		_btn_play.screenCenter();
		add(_btn_play);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	/**
	 *  Fades to black and switches the state to PlayState
	 *  
	 */
	private function start_game():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}
}
