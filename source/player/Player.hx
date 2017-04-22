package player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{

    public var speed:Float = 200;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);

        // Load the graphics for the Player
        loadGraphic(AssetPaths.heroes__png, true, 16, 16);
        // Flip the sprites when player faces left
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        // Set correct sprites to be used, depending on movement direction
        animation.add("lr", [85, 84, 86, 84], 10, false);
        animation.add("u", [101, 100, 102, 100], 10, false);
        animation.add("d", [69, 68, 70, 68], 10, false);

        // Activate animation to display the right frame after spawning
        animation.play("d");

        // Set Deceleration of the Player (when not affected by acceleration)
        drag.x = drag.y = 750;
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
                facing = FlxObject.UP;
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
                facing = FlxObject.DOWN;
            }
            else if(_left)
            {
                movement_angle = 180;
                facing = FlxObject.LEFT;
            }
            else if(_right)
            {
                movement_angle = 0;
                facing = FlxObject.RIGHT;
            }

            // Perform the actual movement
            velocity.set(speed, 0); // Set only x-velocity to speed, y-velocity to 0
            velocity.rotate(FlxPoint.weak(0, 0), movement_angle);   // Rotate the velocity to the right angle

            // Update the animation if moving according on the facing of the player
            if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
            {
                switch (facing)
                {
                    case FlxObject.LEFT, FlxObject.RIGHT:
                        animation.play("lr");
                    case FlxObject.UP:
                        animation.play("u");
                    case FlxObject.DOWN:
                        animation.play("d");
                }
            }
        }
	}
}