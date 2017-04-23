package player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

import spells.Spell;
import PlayState;

class Player extends FlxSprite
{

    public var speed:Float = 175;

    private var _cooldown_tracker:FlxTimer;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);

        // Load the graphics for the Player
        loadGraphic(AssetPaths.heroes__png, true, 16, 16);
        // Flip the sprites when player faces left
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        // Initialize the timer keeping track of when the last spell was cast
        _cooldown_tracker = new FlxTimer();

        // Set correct sprites to be used, depending on movement direction
        animation.add("lr", [85, 84, 86, 84], 10, false);
        animation.add("u", [101, 100, 102, 100], 10, false);
        animation.add("d", [69, 68, 70, 68], 10, false);

        // Activate animation to display the right frame after spawning
        animation.play("d");

        // Set Deceleration of the Player (when not affected by acceleration)
        drag.x = drag.y = 750;

        // Decrease the hitbox size of the player
        setSize(12, 14);
        offset.set(2, 1);
    }

    override public function update(elapsed:Float):Void
    {
        movement();
        spelling();
        play_animation();
        super.update(elapsed);
    }

	/**
	 *  Handles the movement input of the player
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
            
        }
	}

   /**
    *  Handles the shooting input of the player
    *  
    */
   function spelling():Void
     {
        // Align player according to where he aims, regardless of movement or cooldown
        if(FlxG.keys.pressed.UP)
        {
            facing = FlxObject.UP;
        }
        else if(FlxG.keys.pressed.DOWN)
        {
            facing = FlxObject.DOWN;
        }
        else if(FlxG.keys.pressed.LEFT)
        {
            facing = FlxObject.LEFT;
        }
        else if(FlxG.keys.pressed.RIGHT)
        {
            facing = FlxObject.RIGHT;
        }

         // Check if still on cooldown_tracker_cooldown_tracker
         if(_cooldown_tracker.active)
         {
             return;
         }
        
        // Cast spells, depending on input and cooldown
        if(FlxG.keys.pressed.UP)
        {
            // Get a spell from the spell pool and set position and velocity
            var spell:Spell = PlayState.spells.recycle();
            spell.x = x;
            spell.y = y;
            spell.velocity.set(spell.speed, 0);
            spell.velocity.rotate(FlxPoint.weak(0, 0), -90);
            // Start playing the spell animation
            spell.animation.play("spelled");
            spell.facing = FlxObject.UP;
            // Play the player animation to update facing if standing still
            animation.play("u");
            // Start the timer for checking cooldown_tracker_cooldown_tracker
            _cooldown_tracker.start(spell.cooldown);
            // Start the timer tracking the life-time of the spell
            spell.timer.start(spell.time_to_live, spell.timeout);
        }
        else if(FlxG.keys.pressed.DOWN)
        {
            // Get a spell from the spell pool and set position and velocity
            var spell:Spell = PlayState.spells.recycle();
            spell.x = x;
            spell.y = y;
            spell.velocity.set(spell.speed, 0);
            spell.velocity.rotate(FlxPoint.weak(0, 0), 90);
            // Start playing the spell animation
            spell.animation.play("spelled");
            spell.facing = FlxObject.DOWN;
            // Play the player animation to update facing if standing still
            animation.play("d");
            // Start the timer for checking cooldown_tracker_cooldown_tracker
            _cooldown_tracker.start(spell.cooldown);
            // Start the timer tracking the life-time of the spell
            spell.timer.start(spell.time_to_live, spell.timeout);
        }
        else if(FlxG.keys.pressed.LEFT)
        {
            // Get a spell from the spell pool and set position and velocity
            var spell:Spell = PlayState.spells.recycle();
            spell.x = x;
            spell.y = y;
            spell.velocity.set(spell.speed, 0);
            spell.velocity.rotate(FlxPoint.weak(0, 0), 180);
            // Start playing the spell animation
            spell.animation.play("spelled");
            spell.facing = FlxObject.LEFT;
            // Play the player animation to update facing if standing still
            animation.play("lr");
            // Start the timer for checking cooldown_tracker_cooldown_tracker
            _cooldown_tracker.start(spell.cooldown);
            // Start the timer tracking the life-time of the spell
            spell.timer.start(spell.time_to_live, spell.timeout);
        }
        else if(FlxG.keys.pressed.RIGHT)
        {
            // Get a spell from the spell pool and set position and velocity
            var spell:Spell = PlayState.spells.recycle();
            spell.x = x;
            spell.y = y;
            spell.velocity.set(spell.speed, 0);
            spell.velocity.rotate(FlxPoint.weak(0, 0), 0);
            // Start playing the spell animation
            spell.animation.play("spelled");
            spell.facing = FlxObject.RIGHT;
            // Play the player animation to update facing if standing still
            animation.play("lr");
            // Start the timer for checking cooldown_tracker_cooldown_tracker
            _cooldown_tracker.start(spell.cooldown);
            // Start the timer tracking the life-time of the spell
            spell.timer.start(spell.time_to_live, spell.timeout);
        }
     }

    /**
     *  Update the animation if moving according on the facing of the player
     *  
     */
    private function play_animation():Void
    {
        if(velocity.x != 0 || velocity.y != 0)
        {
            switch(facing)
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