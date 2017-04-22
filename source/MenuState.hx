package;

import flixel.FlxState;

import flixel.ui.FlxButton;

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

	private function start_game():Void
	{
		flixel.FlxG.switchState(new PlayState());
	}
}
