package player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{

    public var speed:Float = 300;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);

        // The graphics of the Player
        makeGraphic(16, 16, FlxColor.BLUE);

        // Set Deceleration of the Player (when not affected by acceleration)
        drag.x = drag.y = 1000;
    }

    override public function update(elapsed:Float):Void
    {
        movement();
        super.update(elapsed);
    }

	/**
	 *  Handles the input and movement of the player
	 *  
	 */
	private function movement():Void
	{
        // Contains information if acceleration in the corresponding direction is currently active
        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;

        // Checks if relevant keys are currently pressed
        _up = FlxG.keys.anyPressed([W]);
        _down = FlxG.keys.anyPressed([S]);
        _left = FlxG.keys.anyPressed([A]);
        _right = FlxG.keys.anyPressed([D]);

        // Cancel opposing directions
        if (_up && _down)
        {
            _up = _down = false;
        }
        if (_left && _right)
        {
            _left = _right = false;
        }

        // Only continue managing movement if movement is actually needed
        if(_up || _down || _left || _right)
        {
            // Determine the angle of the movement
            var movement_angle:Float = 0;   // 0 means right, -90 means up
            if (_up)
            {
                movement_angle = -90;
                if(_left)
                {
                    movement_angle -= 45;
                }
                else if(_right)
                {
                    movement_angle += 45;
                }
            }
            else if(_down)
            {
                movement_angle = 90;
                if(_left)
                {
                    movement_angle += 45;
                }
                else if(_right)
                {
                    movement_angle -= 45;
                }
            }
            else if(_left)
            {
                movement_angle = 180;
            }
            else if(_right)
            {
                movement_angle = 0;
            }

            // Perform the actual movement
            velocity.set(speed, 0); // Set only x-velocity to speed, y-velocity to 0
            velocity.rotate(FlxPoint.weak(0, 0), movement_angle);   // Rotate the velocity to the right angle
        }
	}
}